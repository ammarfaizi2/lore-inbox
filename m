Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263497AbRFKIkm>; Mon, 11 Jun 2001 04:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263495AbRFKIkc>; Mon, 11 Jun 2001 04:40:32 -0400
Received: from hera.cwi.nl ([192.16.191.8]:55172 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263497AbRFKIk0>;
	Mon, 11 Jun 2001 04:40:26 -0400
Date: Mon, 11 Jun 2001 10:40:24 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106110840.KAA241979.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: [OT] madvise.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that I asked in public for manpages for the not-yet-documented
system calls, I suppose I should report on received pages in order
to avoid duplication. Yesterday or so I got an madvise.2 page
and polished it a bit. Current version below. Comments are welcome.
Note that comments in mm/filemap.c and what this code does in reality
differ quite a lot.

Andries

------------------------------------------------------------------
MADVISE(2)          Linux Programmer's Manual          MADVISE(2)


NAME
       madvise - give advice about use of memory

SYNOPSIS
       #include <sys/mman.h>

       int madvise(void *start, size_t length, int advice );

DESCRIPTION
       The  madvise  system  call advises the kernel about how to
       handle paging input/output in the address range  beginning
       at  address start and with size length bytes. It allows an
       application to tell the kernel how it expects to use  some
       mapped  or  shared  memory  areas,  so that the kernel can
       choose  appropriate  read-ahead  and  caching  techniques.
       This call does not influence the semantics of the applica­
       tion, but may influence its  performance.  The  kernel  is
       free to ignore the advice.

       For  Linux,  the  address start must be page-aligned.  For
       Linux, if there are some parts of  the  specified  address
       range  that  are  not  mapped,  madvise  ignores  them and
       applies the call to the rest, but returns ENOMEM from  the
       system call.  For Linux, zero length is permitted.

       The  advice is indicated in the advice parameter which can
       be

       MADV_NORMAL
              No special treatment. This is the default.

       MADV_RANDOM
              Expect page references in  random  order.   (Hence,
              read ahead may be less useful than normally.)

       MADV_SEQUENTIAL
              Expect   page   references   in  sequential  order.
              (Hence, pages in the given  range  can  be  aggres­
              sively read ahead, and may be freed soon after they
              are accessed.)

       MADV_WILLNEED
              Expect access in the near future.  (Hence, it might
              be a good idea to read some pages ahead.)

       MADV_DONTNEED
              Do  not expect access in the near future.  (For the
              time being, the application is  finished  with  the
              given range, so the kernel can free resources asso­
              ciated with it.)

RETURN VALUE
       On success madvise returns zero. On error, it  returns  -1
       and errno is set appropiately.

ERRORS
       EINVAL the  value  len  is  negative,  start  is not page-
              aligned, advice is not a valid value, or the appli­
              cation  is  attempting  to release locked or shared
              pages (with MADV_DONTNEED).

       ENOMEM addresses in the specified range are not  currently
              mapped,  or  are  outside  the address space of the
              process.

       ENOMEM (for MADV_WILLNEED) Not enough memory -  paging  in
              failed.

       EIO    (for  MADV_WILLNEED)  Paging  in  this  area  would
              exceed the process's maximum resident set size.

       EBADF  the map exists, but the area  maps  something  that
              isn't a file.

       EAGAIN a kernel resource was temporarily unavailable.


HISTORY
       The madvise function first appeared in 4.4BSD.

CONFORMING TO
       POSIX.1b (POSIX.4).  The Austin draft describes posix_mad­
       vise with  constants  POSIX_MADV_NORMAL,  etc.,  with  the
       behaviour described here. There is a similar posix_fadvise
       for file access.

SEE ALSO
       getrlimit(2), mmap(2), mincore(2), mprotect(2),  msync(2),
       munmap(2)

Linux 2.4.5                 2001-06-10                          1
