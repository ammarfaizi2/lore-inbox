Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSHCW2N>; Sat, 3 Aug 2002 18:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318013AbSHCW2N>; Sat, 3 Aug 2002 18:28:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59921 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318009AbSHCW2L>; Sat, 3 Aug 2002 18:28:11 -0400
To: Linus Torvalds <torvalds@transmeta.com>,
       Paul Gortmaker <p_gortmaker@yahoo.com>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 11: 2.5.29-8390
Message-Id: <E17b7Qz-0007a7-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 23:31:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

Unfortunately, someone changed the inb and friends definitions and
broke ARM.  This patch allows ARM to build NE2000 based drivers
again.

 drivers/net/8390.h |    5 +++--
 1 files changed, 3 insertions, 2 deletions

diff -urN orig/drivers/net/8390.h linux/drivers/net/8390.h
--- orig/drivers/net/8390.h	Thu Jul 25 20:13:31 2002
+++ linux/drivers/net/8390.h	Sat Jul 27 14:57:02 2002
@@ -111,8 +111,7 @@
  
 #if defined(CONFIG_MAC) ||  \
     defined(CONFIG_ARIADNE2) || defined(CONFIG_ARIADNE2_MODULE) || \
-    defined(CONFIG_HYDRA) || defined(CONFIG_HYDRA_MODULE) || \
-    defined(CONFIG_ARM_ETHERH) || defined(CONFIG_ARM_ETHERH_MODULE)
+    defined(CONFIG_HYDRA) || defined(CONFIG_HYDRA_MODULE)
 #define EI_SHIFT(x)	(ei_local->reg_offset[x])
 #undef inb
 #undef inb_p
@@ -124,6 +123,8 @@
 #define inb_p(port)   in_8(port)
 #define outb_p(val,port)  out_8(port,val)
 
+#elif defined(CONFIG_ARM_ETHERH) || defined(CONFIG_ARM_ETHERH_MODULE)
+#define EI_SHIFT(x)	(ei_local->reg_offset[x])
 #else
 #define EI_SHIFT(x)	(x)
 #endif

