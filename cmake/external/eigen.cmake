INCLUDE(ExternalProject)

SET(EIGEN_SOURCE_DIR ${THIRD_PARTY_PATH}/eigen3)
SET(EIGEN_INCLUDE_DIR ${EIGEN_SOURCE_DIR}/src/extern_eigen3)
INCLUDE_DIRECTORIES(${EIGEN_INCLUDE_DIR})

if(WITH_AMD_GPU)
    ExternalProject_Add(
        extern_eigen3
        ${EXTERNAL_PROJECT_LOG_ARGS}
        GIT_REPOSITORY  "https://github.com/sabreshao/hipeigen.git"
        GIT_TAG         0cba03ff9f8f9f70bbd92ac5857b031aa8fed6f9
        PREFIX          ${EIGEN_SOURCE_DIR}
        UPDATE_COMMAND  ""
        CONFIGURE_COMMAND ""
        BUILD_COMMAND     ""
        INSTALL_COMMAND   ""
        TEST_COMMAND      ""
    )
else()
    ExternalProject_Add(
        extern_eigen3
        ${EXTERNAL_PROJECT_LOG_ARGS}
        GIT_REPOSITORY  "https://github.com/RLovelett/eigen.git"
        GIT_TAG         70661066beef694cadf6c304d0d07e0758825c10
        PREFIX          ${EIGEN_SOURCE_DIR}
        UPDATE_COMMAND  ""
        CONFIGURE_COMMAND ""
        BUILD_COMMAND     ""
        INSTALL_COMMAND   ""
        TEST_COMMAND      ""
    )
endif()

if (${CMAKE_VERSION} VERSION_LESS "3.3.0")
    set(dummyfile ${CMAKE_CURRENT_BINARY_DIR}/eigen3_dummy.c)
    file(WRITE ${dummyfile} "const char *dummy_eigen3 = \"${dummyfile}\";")
    add_library(eigen3 STATIC ${dummyfile})
else()
    add_library(eigen3 INTERFACE)
endif()

add_dependencies(eigen3 extern_eigen3)

LIST(APPEND external_project_dependencies eigen3)
