Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbTB0HaI>; Thu, 27 Feb 2003 02:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbTB0HaI>; Thu, 27 Feb 2003 02:30:08 -0500
Received: from angband.namesys.com ([212.16.7.85]:27027 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261523AbTB0HaH>; Thu, 27 Feb 2003 02:30:07 -0500
Date: Thu, 27 Feb 2003 10:40:17 +0300
From: Oleg Drokin <green@namesys.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: uml-patch-2.5.62-1
Message-ID: <20030227104017.A29863@namesys.com>
References: <200302261905.h1QJ5m221192@uml.karaya.com> <20030226225413.ACF29EAF62@mx12.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226225413.ACF29EAF62@mx12.arcor-online.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Feb 27, 2003 at 06:45:27AM +0100, Daniel Phillips wrote:
> > This patch updates UML to 2.5.63...
> Built and booted.  However, without CONFIG_MODULES=y it doesn't build:
> gcc -Wp,-MD,arch/um/sys-i386/.module.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -U__i386__ -Ui386 -g -D__arch_um__ -DSUBARCH=\"i386\" -D_LARGEFILE64_SOURCE 
> -Iarch/um/include -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask 
> -I/m/src/uml.2.5.63/arch/um/kernel/tt/include 
> -I/m/src/uml.2.5.63/arch/um/kernel/skas/include -nostdinc -iwithprefix 
> include    -DKBUILD_BASENAME=module -DKBUILD_MODNAME=module -c -o 
> arch/um/sys-i386/module.o arch/um/sys-i386/module.c
> arch/um/sys-i386/module.c: In function `apply_relocate':
> arch/um/sys-i386/module.c:89: dereferencing pointer to incomplete type
> arch/um/sys-i386/module.c: In function `apply_relocate_add':
> arch/um/sys-i386/module.c:103: dereferencing pointer to incomplete type
> make[1]: *** [arch/um/sys-i386/module.o] Error 1
> make: *** [arch/um/sys-i386] Error 2
> Native 2.5.63 (i386) is ok with or without CONFIG_MODULES=y.

Patch below (that Jeff have not picked up yet) fixes that.

Bye,
    Oleg

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.949   -> 1.950  
#	arch/um/sys-i386/Makefile	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/13	green@angband.namesys.com	1.950
# Only build module.c if we have modules support selected
# --------------------------------------------
#
diff -Nru a/arch/um/sys-i386/Makefile b/arch/um/sys-i386/Makefile
--- a/arch/um/sys-i386/Makefile	Thu Feb 27 10:38:20 2003
+++ b/arch/um/sys-i386/Makefile	Thu Feb 27 10:38:20 2003
@@ -1,7 +1,8 @@
-obj-y = bugs.o checksum.o extable.o fault.o ksyms.o ldt.o module.o \
+obj-y = bugs.o checksum.o extable.o fault.o ksyms.o ldt.o \
 	ptrace.o ptrace_user.o semaphore.o sigcontext.o syscalls.o sysrq.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
+obj-$(CONFIG_MODULES) += module.o
 
 USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
