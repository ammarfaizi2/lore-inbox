Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUIFNOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUIFNOK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 09:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUIFNOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 09:14:09 -0400
Received: from mail.renesas.com ([202.234.163.13]:34497 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S267538AbUIFNM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 09:12:28 -0400
Date: Mon, 06 Sep 2004 22:12:18 +0900 (JST)
Message-Id: <20040906.221218.278728446.takata.hirokazu@renesas.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.9-rc1-mm3] [m32r] Modify IO routines for m32700ut CF
 access
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

Here is a patch for M3T-M32700UT board.
- Enable CF access through card-service if CONFIG_M32R_CFC is not defined.

P.S.  Sorry, there are many ugly indentations in arch/m32r/io_*.c.
      I hope to rearrange them and send patches soon.


Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>

 io_m32700ut.c |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)


--- linux-2.6.9-rc1-mm3.orig/arch/m32r/kernel/io_m32700ut.c	2004-09-03 20:46:13.000000000 +0900
+++ linux-2.6.9-rc1-mm3/arch/m32r/kernel/io_m32700ut.c	2004-09-06 21:04:17.000000000 +0900
@@ -40,7 +40,7 @@ static __inline__ void *_port2addr(unsig
 	return (void *)(port + NONCACHE_OFFSET);
 }
 
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 static __inline__ void *__port2addr_ata(unsigned long port)
 {
 	static int	dummy_reg;
@@ -119,7 +119,7 @@ unsigned char _inb(unsigned long port)
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		return _ne_inb(PORT2ADDR_NE(port));
 
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		return *(volatile unsigned char *)__port2addr_ata(port);
 	}
@@ -139,7 +139,7 @@ unsigned short _inw(unsigned long port)
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		return _ne_inw(PORT2ADDR_NE(port));
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		return *(volatile unsigned short *)__port2addr_ata(port);
 	}
@@ -177,7 +177,7 @@ unsigned char _inb_p(unsigned long port)
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		v = _ne_inb(PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		return *(volatile unsigned char *)__port2addr_ata(port);
 	} else
@@ -202,7 +202,7 @@ unsigned short _inw_p(unsigned long port
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		v = _ne_inw(PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		return *(volatile unsigned short *)__port2addr_ata(port);
 	} else
@@ -239,7 +239,7 @@ void _outb(unsigned char b, unsigned lon
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outb(b, PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		*(volatile unsigned char *)__port2addr_ata(port) = b;
 	} else
@@ -257,7 +257,7 @@ void _outw(unsigned short w, unsigned lo
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		*(volatile unsigned short *)__port2addr_ata(port) = w;
 	} else
@@ -290,7 +290,7 @@ void _outb_p(unsigned char b, unsigned l
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outb(b, PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		*(volatile unsigned char *)__port2addr_ata(port) = b;
 	} else
@@ -310,7 +310,7 @@ void _outw_p(unsigned short w, unsigned 
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		*(volatile unsigned short *)__port2addr_ata(port) = w;
 	} else
@@ -340,7 +340,7 @@ void _insb(unsigned int port, void * add
 {
 	if (port >= LAN_IOSTART && port < LAN_IOEND)
 		_ne_insb(PORT2ADDR_NE(port), addr, count);
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		unsigned char *buf = addr;
 		unsigned char *portp = __port2addr_ata(port);
@@ -375,7 +375,7 @@ void _insw(unsigned int port, void * add
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_ioread_word(9, port, (void *)addr, sizeof(unsigned short), count, 1);
 #endif
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		portp = __port2addr_ata(port);
 		while (count--) *buf++ = *(volatile unsigned short *)portp;
@@ -403,7 +403,7 @@ void _outsb(unsigned int port, const voi
 	if (port >= LAN_IOSTART && port < LAN_IOEND) {
 		portp = PORT2ADDR_NE(port);
 		while (count--) _ne_outb(*buf++, portp);
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		portp = __port2addr_ata(port);
 		while(count--) *(volatile unsigned char *)portp = *buf++;
@@ -430,7 +430,7 @@ void _outsw(unsigned int port, const voi
 		 */
 		portp = PORT2ADDR_NE(port);
 		while(count--) *(volatile unsigned short *)portp = *buf++;
-#if defined(CONFIG_IDE)
+#if defined(CONFIG_IDE) && !defined(CONFIG_M32R_CFC)
 	} else if ((port >= 0x1f0 && port <=0x1f7) || port == 0x3f6) {
 		portp = __port2addr_ata(port);
 		while(count--) *(volatile unsigned short *)portp = *buf++;
