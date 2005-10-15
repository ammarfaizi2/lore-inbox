Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVJOH7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVJOH7w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 03:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVJOH7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 03:59:52 -0400
Received: from mail.renesas.com ([202.234.163.13]:53431 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751129AbVJOH7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 03:59:51 -0400
Date: Sat, 15 Oct 2005 16:59:47 +0900 (JST)
Message-Id: <20051015.165947.74745228.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org,
       fujiwara@linux-m32r.org
Subject: [PATCH 2.6.14-rc4] m32r: NONCACHE_OFFSET in _port2addr
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change _port2addr() not to add NONCACHE_OFFSET.
Adding NONCACHE_OFFSET requires needless address adjusting by a driver
using ioremap() like a SMC91x driver.

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

Index: linux-2.6.14-rc3/arch/m32r/kernel/io_mappi.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/m32r/kernel/io_mappi.c	2005-10-01 06:17:35.000000000 +0900
+++ linux-2.6.14-rc3/arch/m32r/kernel/io_mappi.c	2005-10-05 20:49:00.782707112 +0900
@@ -31,7 +31,7 @@
 
 static inline void *_port2addr(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET);
+	return (void *)(port | (NONCACHE_OFFSET));
 }
 
 static inline void *_port2addr_ne(unsigned long port)
Index: linux-2.6.14-rc3/arch/m32r/kernel/io_mappi2.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/m32r/kernel/io_mappi2.c	2005-10-01 06:17:35.000000000 +0900
+++ linux-2.6.14-rc3/arch/m32r/kernel/io_mappi2.c	2005-10-05 20:49:00.782707112 +0900
@@ -33,7 +33,7 @@
 
 static inline void *_port2addr(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET);
+	return (void *)(port | (NONCACHE_OFFSET));
 }
 
 #define LAN_IOSTART	0x300
Index: linux-2.6.14-rc3/arch/m32r/kernel/io_opsput.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/m32r/kernel/io_opsput.c	2005-10-01 06:17:35.000000000 +0900
+++ linux-2.6.14-rc3/arch/m32r/kernel/io_opsput.c	2005-10-05 20:49:00.783706960 +0900
@@ -36,7 +36,7 @@
 
 static inline void *_port2addr(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET);
+	return (void *)(port | (NONCACHE_OFFSET));
 }
 
 /*
Index: linux-2.6.14-rc3/arch/m32r/kernel/io_usrv.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/m32r/kernel/io_usrv.c	2005-10-01 06:17:35.000000000 +0900
+++ linux-2.6.14-rc3/arch/m32r/kernel/io_usrv.c	2005-10-05 20:49:00.783706960 +0900
@@ -47,7 +47,7 @@
 	else if (port >= UART1_IOSTART && port <= UART1_IOEND)
 		port = ((port - UART1_IOSTART) << 1) + UART1_REGSTART;
 #endif	/* CONFIG_SERIAL_8250 || CONFIG_SERIAL_8250_MODULE */
-	return (void *)(port + NONCACHE_OFFSET);
+	return (void *)(port | (NONCACHE_OFFSET));
 }
 
 static inline void delay(void)
Index: linux-2.6.14-rc3/arch/m32r/kernel/io_oaks32r.c
===================================================================
--- linux-2.6.14-rc3.orig/arch/m32r/kernel/io_oaks32r.c	2005-10-01 06:17:35.000000000 +0900
+++ linux-2.6.14-rc3/arch/m32r/kernel/io_oaks32r.c	2005-10-05 20:49:00.783706960 +0900
@@ -16,7 +16,7 @@
 
 static inline void *_port2addr(unsigned long port)
 {
-	return (void *)(port + NONCACHE_OFFSET);
+	return (void *)(port | (NONCACHE_OFFSET));
 }
 
 static inline  void *_port2addr_ne(unsigned long port)

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

