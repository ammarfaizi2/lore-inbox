Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267365AbTBFT4Q>; Thu, 6 Feb 2003 14:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267573AbTBFT4Q>; Thu, 6 Feb 2003 14:56:16 -0500
Received: from hera.cwi.nl ([192.16.191.8]:62116 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267365AbTBFT4P>;
	Thu, 6 Feb 2003 14:56:15 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 6 Feb 2003 21:05:52 +0100 (MET)
Message-Id: <UTC200302062005.h16K5qn23586.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: syscall documentation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The note with the above title last week was very successful -
several people sent man pages. The copyright situation for
the *xattr pages is not entirely clear yet, but there is
good hope that it will be soon.

Let me send five new pages to l-k - maybe someone has
additions, corrections or comments.

The first one is alloc_hugepages.2. Below.
Probably more can be said about hugetlbfs.

Andries
aeb@cwi.nl

---------
NAME
       alloc_hugepages,  free_hugepages  -  allocate or free huge
       pages

SYNOPSIS
       void *alloc_hugepages(int key, void *addr, size_t len, int
       prot, int flag);

       int free_hugepages (void *addr);

DESCRIPTION
       The  system  calls alloc_hugepages and free_hugepages were
       introduced in Linux 2.5.36 and removed  again  in  2.5.54.
       They  existed  only on i386 and ia64 (when built with CON­
       FIG_HUGETLB_PAGE).  In Linux 2.4.20  the  syscall  numbers
       exist, but the calls return ENOSYS.

       On  i386  the memory management hardware knows about ordi­
       nary pages (4 KiB) and huge pages (2 or 4 MiB).  Similarly
       ia64 knows about huge pages of several sizes. These system
       calls serve to map huge pages into the process' memory  or
       to  free  them  again.  Huge pages are locked into memory,
       and are not swapped.

       The key parameter is an identifier. When  zero  the  pages
       are private, and not inherited by children.  When positive
       the pages are shared with  other  applications  using  the
       same key, and inherited by child processes.

       The addr parameter of free_hugepages() tells which page is
       being freed - it  was  the  return  value  of  a  call  to
       alloc_hugepages().   (The  memory  is first actually freed
       when all users have released it.)  The addr  parameter  of
       alloc_hugepages()  is  a  hint, that the kernel may or may
       not follow.  Addresses must be properly aligned.

       The len parameter is the length of the  required  segment.
       It must be a multiple of the huge page size.

       The  prot parameter specifies the memory protection of the
       segment.  It is one of PROT_READ, PROT_WRITE, PROT_EXEC.

       The flag parameter is ignored, unless key is positive.  In
       that case, if flag is IPC_CREAT, then a new huge page seg­
       ment is created when none with the given key  existed.  If
       this flag is not set, then ENOENT is returned when no seg­
       ment with the given key exists.

RETURN VALUE
       On success, alloc_hugepages returns the allocated  virtual
       address,  and free_hugepages returns zero. On error, -1 is
       returned, and errno is set appropriately.

ERRORS
       ENOSYS The system call is not supported on this kernel.

CONFORMING TO
       This call is specific to Linux on  Intel  processors,  and
       should  not  be  used in programs intended to be portable.
       Indeed, the system call numbers are marked for  reuse,  so
       programs  using  these may do something random on a future
       kernel.

FILES
       /proc/sys/vm/nr_hugepages  Number  of  configured  hugetlb
       pages.  This can be read and written.

       /proc/meminfo  Gives  info  on  the  number  of configured
       hugetlb pages and on their size  in  the  three  variables
       HugePages_Total, HugePages_Free, Hugepagesize.

NOTES
       The  system  calls  are gone. Now the hugetlbfs filesystem
       can be used instead.  Memory backed by huge pages (if  the
       CPU  supports  them) is obtained by mmap'ing files in this
       virtual filesystem.

       The maximal number of huge pages can  be  specified  using
       the hugepages= boot parameter.

Linux 2.5.36                2003-02-02         ALLOC_HUGEPAGES(2)
