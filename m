Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261397AbSKBSRL>; Sat, 2 Nov 2002 13:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261360AbSKBSRK>; Sat, 2 Nov 2002 13:17:10 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:1364 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261397AbSKBSPt>; Sat, 2 Nov 2002 13:15:49 -0500
Date: Sun, 3 Nov 2002 03:21:58 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [RFC][Patchset 18/20] Support for PC-9800 (serial)
Message-ID: <20021103032158.K1536@precia.cinet.co.jp>
References: <20021103023345.A1536@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: =?iso-8859-1?Q?=3C20021103023345=2EA1536?=
	=?iso-8859-1?B?QHByZWNpYS5jaW5ldC5jby5qcD47IGZyb20gdG9taXRhQGNpbmV0LmNv?=
	=?iso-8859-1?B?LmpwIG9uIMb8LCAxMbfu?= 03, 2002 at 02:33:45 +0900
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 18/20 of patchset for add support NEC PC-9800 architecture,
against 2.5.45.

Summary:
  serial driver related modules.
   - change IO port address and IRQ number.
   - add new PNP device entry.

diffstat:
  drivers/serial/8250_pnp.c |    7 +++++++
  include/asm-i386/serial.h |    7 +++++++
  2 files changed, 14 insertions(+)

patch:
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
