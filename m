Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVHOW6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVHOW6e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVHOW6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:58:33 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:28932 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751096AbVHOW6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:58:32 -0400
Date: Mon, 15 Aug 2005 15:58:39 -0700
From: zach@vmware.com
Message-Id: <200508152258.j7FMwdAb005304@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org, hpa@zytor.com,
       jdike@addtoit.com, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       pratap@vmware.com, virtualization@lists.osdl.org, zach@vmware.com,
       zwane@arm.linux.org.uk
Subject: [PATCH 1/6] i386 virtualization - Fix uml build
X-OriginalArrivalTime: 15 Aug 2005 22:58:30.0960 (UTC) FILETIME=[DB10EB00:01C5A1EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to fix the UML build by assuming the default i386 subarchitecture
(mach-default).

I can't fully test this because spinlock breakage is still happening in
my tree, but it gets rid of the mach_xxx.h missing file warnings.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/um/Makefile-i386
===================================================================
--- linux-2.6.13.orig/arch/um/Makefile-i386	2005-08-12 11:57:45.000000000 -0700
+++ linux-2.6.13/arch/um/Makefile-i386	2005-08-12 12:28:09.000000000 -0700
@@ -27,7 +27,9 @@
 endif
 endif
 
-CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH) $(STUB_CFLAGS)
+CFLAGS += -U__$(SUBARCH)__ -U$(SUBARCH) $(STUB_CFLAGS) \
+	  -Iinclude/asm-i386/mach-default \
+          $(if $(KBUILD_SRC),-Iinclude2/asm-i386/mach-default -I$(srctree)/include/asm-i386/mach-default)
 
 ifneq ($(CONFIG_GPROF),y)
 ARCH_CFLAGS += -DUM_FASTCALL
