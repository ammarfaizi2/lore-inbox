Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbUKDDLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUKDDLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 22:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbUKDDLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 22:11:39 -0500
Received: from mail.renesas.com ([202.234.163.13]:19426 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261542AbUKDDGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 22:06:02 -0500
Date: Thu, 04 Nov 2004 12:05:48 +0900 (JST)
Message-Id: <20041104.120548.466671754.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc1] [m32r] Fix for use of Mappi PCC
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to fix compile errors for an Mappi evaluation board.
- Just change from CONFIG_M32RPCC to CONFIG_M32R_PCC.

Please apply.

Thanks to Naoto Sugai for reporting.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/io_mappi.c    |   32 ++++++++++++++++----------------
 arch/m32r/kernel/setup_mappi.c |    2 +-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff -ruNp a/arch/m32r/kernel/io_mappi.c b/arch/m32r/kernel/io_mappi.c
--- a/arch/m32r/kernel/io_mappi.c	2004-10-19 06:53:44.000000000 +0900
+++ b/arch/m32r/kernel/io_mappi.c	2004-11-04 10:17:31.000000000 +0900
@@ -15,7 +15,7 @@
 #include <asm/io.h>
 #include <asm/byteorder.h>
 
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 #include <linux/types.h>
 
 #define M32R_PCC_IOMAP_SIZE 0x1000
@@ -27,7 +27,7 @@
 
 extern void pcc_ioread(int, unsigned long, void *, size_t, size_t, int);
 extern void pcc_iowrite(int, unsigned long, void *, size_t, size_t, int);
-#endif /* CONFIG_PCMCIA && CONFIG_M32RPCC */
+#endif /* CONFIG_PCMCIA && CONFIG_M32R_PCC */
 
 #define PORT2ADDR(port)  _port2addr(port)
 
@@ -80,7 +80,7 @@ unsigned char _inb(unsigned long port)
 	if (port >= 0x300 && port < 0x320)
 		return _ne_inb(PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
         if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   unsigned char b;
 	   pcc_ioread(0, port, &b, sizeof(b), 1, 0);
@@ -100,7 +100,7 @@ unsigned short _inw(unsigned long port)
 	if (port >= 0x300 && port < 0x320)
 		return _ne_inw(PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   unsigned short w;
 	   pcc_ioread(0, port, &w, sizeof(w), 1, 0);
@@ -116,7 +116,7 @@ unsigned short _inw(unsigned long port)
 
 unsigned long _inl(unsigned long port)
 {
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   unsigned long l;
 	   pcc_ioread(0, port, &l, sizeof(l), 1, 0);
@@ -137,7 +137,7 @@ unsigned char _inb_p(unsigned long port)
 	if (port >= 0x300 && port < 0x320)
 		v = _ne_inb(PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   unsigned char b;
 	   pcc_ioread(0, port, &b, sizeof(b), 1, 0);
@@ -161,7 +161,7 @@ unsigned short _inw_p(unsigned long port
 	if (port >= 0x300 && port < 0x320)
 		v = _ne_inw(PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   unsigned short w;
 	   pcc_ioread(0, port, &w, sizeof(w), 1, 0);
@@ -192,7 +192,7 @@ void _outb(unsigned char b, unsigned lon
 	if (port >= 0x300 && port < 0x320)
 		_ne_outb(b, PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite(0, port, &b, sizeof(b), 1, 0);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
@@ -207,7 +207,7 @@ void _outw(unsigned short w, unsigned lo
 	if (port >= 0x300 && port < 0x320)
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite(0, port, &w, sizeof(w), 1, 0);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
@@ -219,7 +219,7 @@ void _outw(unsigned short w, unsigned lo
 
 void _outl(unsigned long l, unsigned long port)
 {
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite(0, port, &l, sizeof(l), 1, 0);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
@@ -234,7 +234,7 @@ void _outb_p(unsigned char b, unsigned l
 	if (port >= 0x300 && port < 0x320)
 		_ne_outb(b, PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite(0, port, &b, sizeof(b), 1, 0);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
@@ -251,7 +251,7 @@ void _outw_p(unsigned short w, unsigned 
 	if (port >= 0x300 && port < 0x320)
 		_ne_outw(w, PORT2ADDR_NE(port));
 	else
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite(0, port, &w, sizeof(w), 1, 0);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
@@ -277,7 +277,7 @@ void _insb(unsigned int port, void * add
 	if (port >= 0x300 && port < 0x320){
 		portp = PORT2ADDR_NE(port);
 		while(count--) *buf++ = *(volatile unsigned char *)portp;
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_ioread(0, port, (void *)addr, sizeof(unsigned char), count, 1);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
@@ -297,7 +297,7 @@ void _insw(unsigned int port, void * add
 	if (port >= 0x300 && port < 0x320) {
 		portp = PORT2ADDR_NE(port);
 		while (count--) *buf++ = _ne_inw(portp);
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_ioread(0, port, (void *)addr, sizeof(unsigned short), count, 1);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
@@ -326,7 +326,7 @@ void _outsb(unsigned int port, const voi
 	if (port >= 0x300 && port < 0x320) {
 		portp = PORT2ADDR_NE(port);
 		while (count--) _ne_outb(*buf++, portp);
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite(0, port, (void *)addr, sizeof(unsigned char), count, 1);
 	} else if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
@@ -346,7 +346,7 @@ void _outsw(unsigned int port, const voi
 	if (port >= 0x300 && port < 0x320) {
 		portp = PORT2ADDR_NE(port);
 		while (count--) _ne_outw(*buf++, portp);
-#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32RPCC)
+#if defined(CONFIG_PCMCIA) && defined(CONFIG_M32R_PCC)
 	} else if (port >= M32R_PCC_IOSTART0 && port <= M32R_PCC_IOEND0) {
 	   pcc_iowrite(0, port, (void *)addr, sizeof(unsigned short), count, 1);
 	} else 	if (port >= M32R_PCC_IOSTART1 && port <= M32R_PCC_IOEND1) {
diff -ruNp a/arch/m32r/kernel/setup_mappi.c b/arch/m32r/kernel/setup_mappi.c
--- a/arch/m32r/kernel/setup_mappi.c	2004-10-19 06:54:37.000000000 +0900
+++ b/arch/m32r/kernel/setup_mappi.c	2004-11-04 10:17:31.000000000 +0900
@@ -140,7 +140,7 @@ void __init init_IRQ(void)
 	disable_mappi_irq(M32R_IRQ_SIO1_S);
 #endif /* CONFIG_SERIAL_M32R_SIO */
 
-#if defined(CONFIG_M32RPCC)
+#if defined(CONFIG_M32R_PCC)
 	/* INT1 : pccard0 interrupt */
 	irq_desc[M32R_IRQ_INT1].status = IRQ_DISABLED;
 	irq_desc[M32R_IRQ_INT1].handler = &mappi_irq_type;

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

