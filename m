Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266021AbSKFSts>; Wed, 6 Nov 2002 13:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266022AbSKFStr>; Wed, 6 Nov 2002 13:49:47 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:51072 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266021AbSKFStp>; Wed, 6 Nov 2002 13:49:45 -0500
Message-ID: <3DC965D3.268DB60A@cinet.co.jp>
Date: Thu, 07 Nov 2002 03:56:19 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.45-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCHSET 16/17] support PC-9800 against 2.5.45-ac1 (serial)
References: <3DC94C7B.79DE5EBC@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------992AAC97D3E637F70A44D850"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------992AAC97D3E637F70A44D850
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This patch adds serial and modem card support for PC-9800.

diffstat:
 drivers/serial/8250_pnp.c |    7 +++++++
 include/asm-i386/serial.h |    7 +++++++
 2 files changed, 14 insertions(+)

-- 
Osamu Tomita
--------------992AAC97D3E637F70A44D850
Content-Type: text/plain; charset=iso-2022-jp;
 name="serial.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial.patch"

diff -urN linux/drivers/serial/8250_pnp.c linux98/drivers/serial/8250_pnp.c
--- linux/drivers/serial/8250_pnp.c	Sat Oct 19 13:01:08 2002
+++ linux98/drivers/serial/8250_pnp.c	Sat Oct 19 16:20:53 2002
@@ -193,6 +193,8 @@
 	{	"MVX00A1",		0	},
 	/* PC Rider K56 Phone System PnP */
 	{	"MVX00F2",		0	},
+	/* NEC 98NOTE SPEAKER PHONE FAX MODEM(33600bps) */
+	{	"nEC8241",		0	},
 	/* Pace 56 Voice Internal Plug & Play Modem */
 	{	"PMC2430",		0	},
 	/* Generic */
@@ -376,7 +378,12 @@
 			    ((port->min == 0x2f8) ||
 			     (port->min == 0x3f8) ||
 			     (port->min == 0x2e8) ||
+#ifndef CONFIG_PC9800
 			     (port->min == 0x3e8)))
+#else
+			     (port->min == 0x3e8) ||
+			     (port->min == 0x8b0)))
+#endif
 				return 0;
 	}
 
diff -urN linux/include/asm-i386/serial.h linux98/include/asm-i386/serial.h
--- linux/include/asm-i386/serial.h	Wed Oct 16 12:27:56 2002
+++ linux98/include/asm-i386/serial.h	Fri Oct 18 10:12:09 2002
@@ -50,12 +50,19 @@
 
 #define C_P(card,port) (((card)<<6|(port)<<3) + 1)
 
+#ifndef CONFIG_PC9800
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
+#else
+#define STD_SERIAL_PORT_DEFNS			\
+	/* UART CLK   PORT IRQ     FLAGS        */			\
+	{ 0, BASE_BAUD, 0x30, 4, STD_COM_FLAGS },	/* ttyS0 */	\
+	{ 0, BASE_BAUD, 0x238, 5, STD_COM_FLAGS },	/* ttyS1 */
+#endif /* CONFIG_PC9800 */
 
 
 #ifdef CONFIG_SERIAL_MANY_PORTS

--------------992AAC97D3E637F70A44D850--

