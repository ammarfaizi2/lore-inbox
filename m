Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277182AbRJDSRr>; Thu, 4 Oct 2001 14:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273724AbRJDSRi>; Thu, 4 Oct 2001 14:17:38 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:32774 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S277182AbRJDSR3>; Thu, 4 Oct 2001 14:17:29 -0400
Date: Thu, 4 Oct 2001 19:17:56 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: mmap(2) man page
Message-ID: <20011004191755.A28030@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: Truant - Neither Work Nor Leisure
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a ham-fisted attempt to expand the rather sparse mmap(2) man page a little :

http://www.movement.uklinux.net/mmap.2

Can someone point out the errors and unclear bits, and missing stuff please ?

Shown in text here :

thanks
john


MMAP(2)             Linux Programmer's Manual             MMAP(2)
 
NAME
       mmap, munmap - map or unmap files or devices into memory
 
SYNOPSIS
       #include <unistd.h>
       #include <sys/mman.h>
 
       #ifdef _POSIX_MAPPED_FILES
 
       void * mmap(void *start, size_t length, int prot , int flags, int fd, off_t offset);
 
       int munmap(void *start, size_t length);
 
       #endif
 
DESCRIPTION
       The  mmap function asks to map length bytes starting at offset offset from the file (or
       other object) specified by the file descriptor fd into memory,  preferably  at  address
       start.   This latter address is a hint only, and is usually specified as 0.  The actual
       place where the object is mapped is returned by mmap.  The prot argument describes  the
       desired  memory  protection  (and must not conflict with the open mode of the file). It
       has bits
 
       PROT_EXEC  Pages may be executed.
 
       PROT_READ  Pages may be read.
 
       PROT_WRITE Pages may be written.
 
       PROT_NONE  Pages may not be accessed.
 
       The flags parameter specifies the type  of  the  mapped  object,  mapping  options  and
       whether modifications made to the mapped copy of the page are private to the process or
       are to be shared with other references.  It has bits

       MAP_FIXED  Do not select a different address than the one specified.  If the  specified
                  address  cannot  be  used, mmap will fail.  If MAP_FIXED is specified, start
                  must be a multiple of the pagesize.  Use of this option is discouraged,  and
                  it  may  make  the  behaviour of future system calls affecting the process's
                  mappings unspecified.
 
       MAP_SHARED Share this mapping with all other processes that map this  object.   Storing
                  to  the region is equivalent to writing to the file.  The file may not actu­
                  ally be updated until msync(2) or munmap(2) are called.
 
       MAP_PRIVATE
                  Create a private copy-on-write mapping.  Stores to the region do not  affect
                  the original file.
 
       You must specify exactly one of MAP_SHARED and MAP_PRIVATE.
 
       The  above  three flags are described in POSIX.1b (formerly POSIX.4).  Linux also knows
       about the following non-standard flags :
 
       MAP_DENYWRITE
                  Consequent attempts to open the backing file for writing fail with the error
                  ETXTBSY. This flag is ignored and has no effect.
 
       MAP_EXECUTABLE
                  The  mapping  is  tagged as a mapping of an executable. This flag is ignored
                  and has no effect.
 
       MAP_NORESERVE
                  Indicates to the kernel VM system that availability of free pages in  memory
                  and swap should not be checked before accepting the mapping request. On some
                  systems this reserves the necessary number of swap pages.
 
       MAP_LOCKED If set, the mapped pages will not be swapped out.
 
       MAP_GROWSDOWN
                  Indicates to the kernel VM system that the mapping should  extend  downwards
                  in memory.

       MAP_ANONYMOUS
                  The  fd  argument is ignored; the mapping is not backed by any file.  Imple­
                  mented only in 2.4 kernels and above.
 
       MAP_ANON   Alias for MAP_ANONYMOUS. Deprecated.
 
       MAP_FILE   Compatibility flag. Ignored.
 
       Some systems document the additional flags MAP_AUTOGROW, MAP_AUTORESRV,  MAP_COPY,  and
       MAP_LOCAL.
 
       fd  should  be  a valid file descriptor, unless MAP_ANONYMOUS is set, in which case the
       argument is ignored.
 
       offset should ordinarily be a multiple of the page size returned by getpagesize(2).
 
       Memory mapped by mmap is preserved across fork(2), with the same attributes.
 
       A file is mapped in multiples of the page size. For a file that is not  a  multiple  of
       the  page  size,  the remaining memory is zeroed when mapped, and writes to that region
       are ignored. The effect of changing the size of the underlying file  of  a  mapping  is
       unspecified.
 
       The munmap system call deletes the mappings for the specified address range, and causes
       further references to addresses within the range to generate invalid memory references.
       Consecutive  mapped  pages from more than one mmap call may be unmapped with one munmap
       system call.  The region is also automatically unmapped when the process is terminated.
       On the other hand, closing the file descriptor does not unmap the region.
 
RETURN VALUE
       On  success,  mmap  returns a pointer to the mapped area.  On error, MAP_FAILED (-1) is
       returned, and errno is set appropriately.  On success, munmap returns 0, on failure -1,
       and errno is set (probably to EINVAL).
 
ERRORS
       EBADF  fd is not a valid file descriptor (and MAP_ANONYMOUS was not set).
 
       EACCES A  file  descriptor refers to a non-regular file; MAP_PRIVATE was requested, but
              fd is not open for reading; MAP_SHARED was requested and PROT_WRITE is set,  but
              fd  is  not open in read/write (O_RDWR) mode; PROT_WRITE is set, but the file is
              append-only.
 
       EINVAL We don't like start or length or offset.  (E.g., they  are  too  large,  or  not
              aligned on a PAGESIZE boundary.)
 
       ENOEXEC
              A file could not be mapped for reading.
 
       ETXTBSY
              MAP_DENYWRITE was set but the object specified by fd is open for writing.
 
       EAGAIN The file has been locked, or too much memory has been locked.
 
       ENOMEM No  memory  is available, or the process's maximum number of mappings would have
              been exceeded.
 
       ENODEV The underlying filesystem of the specified file does not support memory mapping.
 
       Use of a mapped region can result in these signals:
 
       SIGSEGV
              Attempted write into a region specified to mmap as read-only.
 
       SIGBUS Attempted access to a portion of the buffer that does not correspond to the file
              (for example, beyond the end of the file, including the case where another  pro­
              cess has truncated the file).
 
CONFORMING TO
       SVr4, POSIX.1b (formerly POSIX.4), 4.4BSD.  Svr4 documents additional error codes ENXIO
       and ENODEV. Some systems document additional error codes EMFILE and EOVERFLOW.
 
SEE ALSO
       getpagesize(2), mremap(2), msync(2), shm_open(2), B.O. Gallmeister, POSIX.4,  O'Reilly,
       pp. 128-129 and 389-391.
