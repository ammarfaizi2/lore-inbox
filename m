Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSGFI2G>; Sat, 6 Jul 2002 04:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317623AbSGFI2F>; Sat, 6 Jul 2002 04:28:05 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:57096 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315463AbSGFI2E>;
	Sat, 6 Jul 2002 04:28:04 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [patch] 2.5.25 net/core/Makefile
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Jul 2002 18:30:29 +1000
Message-ID: <29446.1025944229@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The valid combination of CONFIG_NET=n, CONFIG_LLC undefined incorrectly
builds ext8022.o and gets unresolved references because there is no
network code.  Detected by kbuild 2.5, not detected by the existing
build system.

Index: 25.1/net/core/Makefile
--- 25.1/net/core/Makefile Wed, 19 Jun 2002 14:11:35 +1000 kaos (linux-2.5/p/c/50_Makefile 1.4 444)
+++ 25.1(w)/net/core/Makefile Sat, 06 Jul 2002 18:27:16 +1000 kaos (linux-2.5/p/c/50_Makefile 1.4 444)
@@ -16,7 +16,7 @@ obj-$(CONFIG_FILTER) += filter.o
 
 obj-$(CONFIG_NET) += dev.o dev_mcast.o dst.o neighbour.o rtnetlink.o utils.o
 
-ifneq ($(CONFIG_LLC),n)
+ifneq ($(subst n,,$(CONFIG_LLC)),)
 obj-y += ext8022.o
 endif
 

