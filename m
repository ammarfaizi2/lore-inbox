Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132387AbRDWWRc>; Mon, 23 Apr 2001 18:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132413AbRDWWR1>; Mon, 23 Apr 2001 18:17:27 -0400
Received: from wire.cadcamlab.org ([156.26.20.181]:38150 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132421AbRDWWQ0>; Mon, 23 Apr 2001 18:16:26 -0400
Date: Mon, 23 Apr 2001 17:16:24 -0500
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: [upatch] lib/Makefile
Message-ID: <20010423171624.B1690@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Introduced in 2.4.4pre4, I believe.  $(export-objs) need not be
conditional, and the if statement was not really correct either,
although in this case it probably worked.

Peter


--- 2.4.4pre6/lib/Makefile~	Mon Apr 23 09:51:17 2001
+++ 2.4.4pre6/lib/Makefile	Mon Apr 23 17:11:04 2001
@@ -8,14 +8,12 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o
+export-objs := cmdline.o rwsem.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o
 
-ifneq ($(CONFIG_RWSEM_GENERIC_SPINLOCK)$(CONFIG_RWSEM_XCHGADD_ALGORITHM),nn)
-export-objs += rwsem.o
-obj-y += rwsem.o
-endif
+obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK)	+= rwsem.o
+obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM)	+= rwsem.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y) 
   obj-y += dec_and_lock.o
