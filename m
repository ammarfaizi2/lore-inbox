Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbTCLP6f>; Wed, 12 Mar 2003 10:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbTCLP6f>; Wed, 12 Mar 2003 10:58:35 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:56949 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261767AbTCLP5I>; Wed, 12 Mar 2003 10:57:08 -0500
Date: Wed, 12 Mar 2003 11:07:48 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux390@de.ibm.com
Subject: "Cross" compilation for s390x
Message-ID: <20030312110748.A9773@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

when I build s390x on s390 box, it fails without the
attached patch. Thought you might want to consder it.
If you support truly ancient compilers (2.7.2), it cannot
go in without some conditional compilation as sparc64 does.
Otherwise, it should be ok at least for 2.5.

Yours,
-- Pete

diff -urN -X dontdiff linux-2.4.20-2.1.14.s.1/arch/s390x/Makefile linux-2.4.20-2.1.14.s.2/arch/s390x/Makefile
--- linux-2.4.20-2.1.14.s.1/arch/s390x/Makefile	2002-08-02 20:39:43.000000000 -0400
+++ linux-2.4.20-2.1.14.s.2/arch/s390x/Makefile	2003-03-10 21:07:49.000000000 -0500
@@ -23,10 +23,11 @@
 LINKFLAGS =-T $(TOPDIR)/arch/s390x/vmlinux.lds $(LDFLAGS)
 endif
 MODFLAGS += -fpic
+AFLAGS += -m64
 
 CFLAGS_PIPE := -pipe
 CFLAGS_NSR  := -fno-strength-reduce
-CFLAGS := $(CFLAGS) $(CFLAGS_PIPE) $(CFLAGS_NSR)
+CFLAGS := $(CFLAGS) $(CFLAGS_PIPE) $(CFLAGS_NSR) -m64
 
 HEAD := arch/s390x/kernel/head.o arch/s390x/kernel/init_task.o
 
diff -urN -X dontdiff linux-2.4.20-2.1.14.s.1/arch/s390x/vmlinux.lds linux-2.4.20-2.1.14.s.2/arch/s390x/vmlinux.lds
--- linux-2.4.20-2.1.14.s.1/arch/s390x/vmlinux.lds	2002-02-25 14:37:56.000000000 -0500
+++ linux-2.4.20-2.1.14.s.2/arch/s390x/vmlinux.lds	2003-03-10 21:07:49.000000000 -0500
@@ -1,8 +1,8 @@
-/* ld script to make s390 Linux kernel
+/* ld script to make s390x Linux kernel
  * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
-OUTPUT_ARCH(s390)
+OUTPUT_ARCH(s390:64-bit)
 ENTRY(_start)
 SECTIONS
 {
