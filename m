Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbTBFUCf>; Thu, 6 Feb 2003 15:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267618AbTBFUCf>; Thu, 6 Feb 2003 15:02:35 -0500
Received: from hera.cwi.nl ([192.16.191.8]:62885 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267616AbTBFUC3>;
	Thu, 6 Feb 2003 15:02:29 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 6 Feb 2003 21:12:06 +0100 (MET)
Message-Id: <UTC200302062012.h16KC6Z23622.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: syscall documentation (5 and last)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The fifth new page is arch_prctl.2.

Comments welcome.
Andries
aeb@cwi.nl

----------------------------------- 
NAME
       arch_prctl - Set architecture specific thread state.

SYNOPSIS
       #include <asm/prctl.h>

       #include <sys/prctl.h>

       int arch_prctl(int code, unsigned long addr)

DESCRIPTION
       The arch_prctl function sets architecture specific process
       or thread state.  code selects a  subfunction  and  passes
       argument addr to it.

       Sub functions for x86-64 are:

       ARCH_SET_FS
              Set the 64bit base for the FS register to addr.

       ARCH_GET_FS
              Return  the 64bit base value for the FS register of
              the current thread in the unsigned long pointed  to
              by the address parameter

       ARCH_SET_GS
              Set the 64bit base for the FS register to addr.

       ARCH_GET_GS
              Return  the 64bit base value for the GS register of
              the current thread in the unsigned long pointed  to
              by the address parameter.

NOTES
       arch_prctl  is  only  supported  on Linux/x86-64 for 64bit
       programs currently.

       The 64bit base changes when a new 32bit  segment  selector
       is loaded.

       ARCH_SET_GS is disabled in some kernels.

       Context switches for 64bit segment bases are rather expen­
       sive. It may be a faster alternative to set a  32bit  base
       using  a  segment  selector by setting up an LDT with mod­
       ify_ldt(2) or using the set_thread_area(2) system call  in
       a  2.5 kernel.  arch_prctl is only needed when you want to
       set bases that are larger than 4GB.  Memory in  the  first
       2GB  of  address  space  can be allocated by using mmap(2)
       with the MAP_32BIT flag.

       No prototype for arch_prctl in  glibc  2.2.  You  have  to
       declare it yourself for now.  This will be fixed in future
       glibc versions.

       FS may be already used by the threading library.

ERRORS
       EINVAL code is not a valid subcommand.

       EPERM  addr is outside the process address space.

       EFAULT addr points to an unmapped address  or  is  outside
              the process address space.

AUTHOR
       Man page written by Andi Kleen.

CONFORMANCE
       arch_prctl  is  a Linux/x86-64 extension and should not be
       used in programs intended to be portable.

SEE ALSO
       mmap(2), modify_ldt(2), prctl(2), set_thread_area(2)

       AMD X86-64 Programmer's manual

Linux 2.4.20                2003-02-02              ARCH_PRCTL(2)
