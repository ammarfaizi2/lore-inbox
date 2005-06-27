Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVF0Kpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVF0Kpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 06:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVF0Koj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 06:44:39 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51467 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261649AbVF0Kmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 06:42:33 -0400
Date: Mon, 27 Jun 2005 11:42:25 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linux Serial List <linux-serial@vger.kernel.org>
Subject: Re: [RFC/CFT] Split 8250 port table (part 2)
Message-ID: <20050627114225.D10822@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux Serial List <linux-serial@vger.kernel.org>
References: <20050623110337.A31259@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050623110337.A31259@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Thu, Jun 23, 2005 at 11:03:37AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 11:03:37AM +0100, Russell King wrote:
> Add separate files for the different 8250 ISA-based serial boards.

Ok, I've now committed this to my git tree.  Here's the second part
to this.

What this change means is that you must set SERIAL_8250_NR_UARTS to
the total number of 8250-based UARTs you want to support, not the
number of _extra_ ports.  Hopefully, I've correctly updated those
defconfig files which have been impacted by this change.

The only ports which remain in asm-*/serial.h are the platform specific
entries.  These should really be converted by platform maintainers to
use a platform device, such as can be found in
arch/arm/mach-footbridge/isa.c

Index: arch/parisc/configs/712_defconfig
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/arch/parisc/configs/712_defconfig  (mode:100644)
+++ uncommitted/arch/parisc/configs/712_defconfig  (mode:100644)
@@ -506,7 +506,7 @@
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=8
+CONFIG_SERIAL_8250_NR_UARTS=17
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
Index: arch/parisc/configs/a500_defconfig
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/arch/parisc/configs/a500_defconfig  (mode:100644)
+++ uncommitted/arch/parisc/configs/a500_defconfig  (mode:100644)
@@ -662,7 +662,7 @@
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_CS=m
-CONFIG_SERIAL_8250_NR_UARTS=8
+CONFIG_SERIAL_8250_NR_UARTS=17
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
Index: arch/parisc/configs/b180_defconfig
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/arch/parisc/configs/b180_defconfig  (mode:100644)
+++ uncommitted/arch/parisc/configs/b180_defconfig  (mode:100644)
@@ -514,7 +514,7 @@
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_NR_UARTS=13
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
Index: arch/parisc/configs/c3000_defconfig
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/arch/parisc/configs/c3000_defconfig  (mode:100644)
+++ uncommitted/arch/parisc/configs/c3000_defconfig  (mode:100644)
@@ -661,7 +661,7 @@
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_NR_UARTS=13
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
Index: arch/parisc/defconfig
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/arch/parisc/defconfig  (mode:100644)
+++ uncommitted/arch/parisc/defconfig  (mode:100644)
@@ -517,7 +517,7 @@
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_NR_UARTS=13
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
Index: drivers/serial/8250.c
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/drivers/serial/8250.c  (mode:100644)
+++ uncommitted/drivers/serial/8250.c  (mode:100644)
@@ -105,7 +105,7 @@
 	SERIAL_PORT_DFNS /* defined in asm/serial.h */
 };
 
-#define UART_NR	(ARRAY_SIZE(old_serial_port) + CONFIG_SERIAL_8250_NR_UARTS)
+#define UART_NR	CONFIG_SERIAL_8250_NR_UARTS
 
 #ifdef CONFIG_SERIAL_8250_RSA
 
Index: drivers/serial/Kconfig
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/drivers/serial/Kconfig  (mode:100644)
+++ uncommitted/drivers/serial/Kconfig  (mode:100644)
@@ -86,7 +86,7 @@
 	  namespace, say Y here.  If unsure, say N.
 
 config SERIAL_8250_NR_UARTS
-	int "Maximum number of non-legacy 8250/16550 serial ports"
+	int "Maximum number of 8250/16550 serial ports"
 	depends on SERIAL_8250
 	default "4"
 	help
Index: include/asm-alpha/serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-alpha/serial.h  (mode:100644)
+++ uncommitted/include/asm-alpha/serial.h  (mode:100644)
@@ -22,54 +22,9 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#endif
-	
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS
Index: include/asm-arm26/serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-arm26/serial.h  (mode:100644)
+++ uncommitted/include/asm-arm26/serial.h  (mode:100644)
@@ -30,34 +30,16 @@
 #if defined(CONFIG_ARCH_A5K)
      /* UART CLK        PORT  IRQ     FLAGS        */
 
-#define STD_SERIAL_PORT_DEFNS                                           \
+#define SERIAL_PORT_DFNS                                                \
         { 0, BASE_BAUD, 0x3F8, 10, STD_COM_FLAGS },     /* ttyS0 */     \
         { 0, BASE_BAUD, 0x2F8, 10, STD_COM_FLAGS },     /* ttyS1 */
 
 #else
 
-#define STD_SERIAL_PORT_DEFNS                                           \
+#define SERIAL_PORT_DFNS                                                \
         { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS0 */     \
         { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS1 */
 
 #endif
 
-#define EXTRA_SERIAL_PORT_DEFNS \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS2 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS3 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS4 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS5 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS6 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS7 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS8 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS9 */     \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS10 */    \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS11 */    \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS12 */    \
-        { 0, BASE_BAUD, 0    ,  0, STD_COM_FLAGS },     /* ttyS13 */
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS
-
 #endif
Index: include/asm-i386/serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-i386/serial.h  (mode:100644)
+++ uncommitted/include/asm-i386/serial.h  (mode:100644)
@@ -22,109 +22,9 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#define HUB6_FLAGS 0
-#endif
-
-#define MCA_COM_FLAGS	(STD_COM_FLAGS|ASYNC_BOOT_ONLYMCA)
-
-/*
- * The following define the access methods for the HUB6 card. All
- * access is through two ports for all 24 possible chips. The card is
- * selected through the high 2 bits, the port on that card with the
- * "middle" 3 bits, and the register on that port with the bottom
- * 3 bits.
- *
- * While the access port and interrupt is configurable, the default
- * port locations are 0x302 for the port control register, and 0x303
- * for the data read/write register. Normally, the interrupt is at irq3
- * but can be anything from 3 to 7 inclusive. Note that using 3 will
- * require disabling com2.
- */
-
-#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
-
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-/* You can have up to four HUB6's in the system, but I've only
- * included two cards here for a total of twelve ports.
- */
-#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
-#define HUB6_SERIAL_PORT_DFNS		\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
-#else
-#define HUB6_SERIAL_PORT_DFNS
-#endif
-
-#ifdef CONFIG_MCA
-#define MCA_SERIAL_PORT_DFNS			\
-	{ 0, BASE_BAUD, 0x3220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x3228, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x4220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x4228, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x5220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x5228, 3, MCA_COM_FLAGS },
-#else
-#define MCA_SERIAL_PORT_DFNS
-#endif
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS		\
-	HUB6_SERIAL_PORT_DFNS		\
-	MCA_SERIAL_PORT_DFNS
-
Index: include/asm-m68k/serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-m68k/serial.h  (mode:100644)
+++ uncommitted/include/asm-m68k/serial.h  (mode:100644)
@@ -26,54 +26,9 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#endif
-
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS },	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS
Index: include/asm-mips/serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-mips/serial.h  (mode:100644)
+++ uncommitted/include/asm-mips/serial.h  (mode:100644)
@@ -29,32 +29,6 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#define HUB6_FLAGS 0
-#define RS_TABLE_SIZE	64
-#else
-#define RS_TABLE_SIZE
-#endif
-
-/*
- * The following define the access methods for the HUB6 card. All
- * access is through two ports for all 24 possible chips. The card is
- * selected through the high 2 bits, the port on that card with the
- * "middle" 3 bits, and the register on that port with the bottom
- * 3 bits.
- *
- * While the access port and interrupt is configurable, the default
- * port locations are 0x302 for the port control register, and 0x303
- * for the data read/write register. Normally, the interrupt is at irq3
- * but can be anything from 3 to 7 inclusive. Note that using 3 will
- * require disabling com2.
- */
-
-#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
-
 #ifdef CONFIG_MACH_JAZZ
 #include <asm/jazz.h>
 
@@ -240,66 +214,10 @@
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },			/* ttyS14 (spare) */ \
-	{ 0, BASE_BAUD, 0x000, 0, 0 },			/* ttyS15 (spare) */ \
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else /* CONFIG_SERIAL_MANY_PORTS */
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif /* CONFIG_SERIAL_MANY_PORTS */
-
 #else /* CONFIG_HAVE_STD_PC_SERIAL_PORTS */
 #define STD_SERIAL_PORT_DEFNS
-#define EXTRA_SERIAL_PORT_DEFNS
 #endif /* CONFIG_HAVE_STD_PC_SERIAL_PORTS */
 
-/* You can have up to four HUB6's in the system, but I've only
- * included two cards here for a total of twelve ports.
- */
-#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
-#define HUB6_SERIAL_PORT_DFNS		\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
-#else
-#define HUB6_SERIAL_PORT_DFNS
-#endif
-
 #ifdef CONFIG_MOMENCO_JAGUAR_ATX
 /* Ordinary NS16552 duart with a 20MHz crystal.  */
 #define JAGUAR_ATX_UART_CLK	20000000
@@ -427,8 +345,6 @@
 	COBALT_SERIAL_PORT_DEFNS			\
 	DDB5477_SERIAL_PORT_DEFNS			\
 	EV96100_SERIAL_PORT_DEFNS			\
-	EXTRA_SERIAL_PORT_DEFNS				\
-	HUB6_SERIAL_PORT_DFNS				\
 	IP32_SERIAL_PORT_DEFNS                          \
 	ITE_SERIAL_PORT_DEFNS           		\
 	IVR_SERIAL_PORT_DEFNS           		\
Index: include/asm-parisc/serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-parisc/serial.h  (mode:100644)
+++ uncommitted/include/asm-parisc/serial.h  (mode:100644)
@@ -19,18 +19,4 @@
  * A500 w/ PCI serial cards: 5 + 4 * card ~= 17
  */
  
-#define STD_SERIAL_PORT_DEFNS			\
-	{ 0, },		/* ttyS0 */	\
-	{ 0, },		/* ttyS1 */	\
-	{ 0, },		/* ttyS2 */	\
-	{ 0, },		/* ttyS3 */	\
-	{ 0, },		/* ttyS4 */	\
-	{ 0, },		/* ttyS5 */	\
-	{ 0, },		/* ttyS6 */	\
-	{ 0, },		/* ttyS7 */	\
-	{ 0, },		/* ttyS8 */
-
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS
-
+#define SERIAL_PORT_DFNS
Index: include/asm-ppc/pc_serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-ppc/pc_serial.h  (mode:100644)
+++ uncommitted/include/asm-ppc/pc_serial.h  (mode:100644)
@@ -35,93 +35,9 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#define HUB6_FLAGS 0
-#endif
-	
-/*
- * The following define the access methods for the HUB6 card. All
- * access is through two ports for all 24 possible chips. The card is
- * selected through the high 2 bits, the port on that card with the
- * "middle" 3 bits, and the register on that port with the bottom
- * 3 bits.
- *
- * While the access port and interrupt is configurable, the default
- * port locations are 0x302 for the port control register, and 0x303
- * for the data read/write register. Normally, the interrupt is at irq3
- * but can be anything from 3 to 7 inclusive. Note that using 3 will
- * require disabling com2.
- */
-
-#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
-
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-/* You can have up to four HUB6's in the system, but I've only
- * included two cards here for a total of twelve ports.
- */
-#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
-#define HUB6_SERIAL_PORT_DFNS		\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
-#else
-#define HUB6_SERIAL_PORT_DFNS
-#endif
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS		\
-	HUB6_SERIAL_PORT_DFNS
Index: include/asm-sh/bigsur/serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-sh/bigsur/serial.h  (mode:100644)
+++ uncommitted/include/asm-sh/bigsur/serial.h  (mode:100644)
@@ -14,13 +14,10 @@
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
 
-#define STD_SERIAL_PORT_DEFNS                   \
+#define SERIAL_PORT_DFNS                   \
         /* UART CLK   PORT IRQ     FLAGS        */                      \
         { 0, BASE_BAUD, 0x3F8, HD64465_IRQ_UART, STD_COM_FLAGS } /* ttyS0 */ 
 
-
-#define SERIAL_PORT_DFNS STD_SERIAL_PORT_DEFNS
-
 /* XXX: This should be moved ino irq.h */
 #define irq_cannonicalize(x) (x)
 
Index: include/asm-sh/ec3104/serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-sh/ec3104/serial.h  (mode:100644)
+++ uncommitted/include/asm-sh/ec3104/serial.h  (mode:100644)
@@ -10,13 +10,11 @@
  * it's got the keyboard controller behind it so we can't really use it
  * (without moving the keyboard driver to userspace, which doesn't sound
  * like a very good idea) */
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x11C00, EC3104_IRQBASE+7, STD_COM_FLAGS }, /* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x12000, EC3104_IRQBASE+8, STD_COM_FLAGS }, /* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x12400, EC3104_IRQBASE+9, STD_COM_FLAGS }, /* ttyS2 */
 
-#define SERIAL_PORT_DFNS STD_SERIAL_PORT_DEFNS
-
 /* XXX: This should be moved ino irq.h */
 #define irq_cannonicalize(x) (x)
Index: include/asm-sh/serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-sh/serial.h  (mode:100644)
+++ uncommitted/include/asm-sh/serial.h  (mode:100644)
@@ -29,20 +29,18 @@
 #ifdef CONFIG_HD64465
 #include <asm/hd64465.h>
 
-#define STD_SERIAL_PORT_DEFNS                   \
+#define SERIAL_PORT_DFNS                   \
         /* UART CLK   PORT IRQ     FLAGS        */                      \
         { 0, BASE_BAUD, 0x3F8, HD64465_IRQ_UART, STD_COM_FLAGS }  /* ttyS0 */
 
 #else
 
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS }	/* ttyS1 */
 
 #endif
 
-#define SERIAL_PORT_DFNS STD_SERIAL_PORT_DEFNS
-
 #endif
 #endif /* _ASM_SERIAL_H */
Index: include/asm-sh64/serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-sh64/serial.h  (mode:100644)
+++ uncommitted/include/asm-sh64/serial.h  (mode:100644)
@@ -20,13 +20,11 @@
 
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS }	/* ttyS1 */
 
-#define SERIAL_PORT_DFNS STD_SERIAL_PORT_DEFNS
-
 /* XXX: This should be moved ino irq.h */
 #define irq_cannonicalize(x) (x)
 
Index: include/asm-x86_64/serial.h
===================================================================
--- 61f26f0bd348c6ddac8b3b1105e00fa790ea3ea6/include/asm-x86_64/serial.h  (mode:100644)
+++ uncommitted/include/asm-x86_64/serial.h  (mode:100644)
@@ -22,109 +22,9 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define FOURPORT_FLAGS ASYNC_FOURPORT
-#define ACCENT_FLAGS 0
-#define BOCA_FLAGS 0
-#define HUB6_FLAGS 0
-#endif
-
-#define MCA_COM_FLAGS	(STD_COM_FLAGS|ASYNC_BOOT_ONLYMCA)
-
-/*
- * The following define the access methods for the HUB6 card. All
- * access is through two ports for all 24 possible chips. The card is
- * selected through the high 2 bits, the port on that card with the
- * "middle" 3 bits, and the register on that port with the bottom
- * 3 bits.
- *
- * While the access port and interrupt is configurable, the default
- * port locations are 0x302 for the port control register, and 0x303
- * for the data read/write register. Normally, the interrupt is at irq3
- * but can be anything from 3 to 7 inclusive. Note that using 3 will
- * require disabling com2.
- */
-
-#define C_P(card,port) (((card)<<6|(port)<<3) + 1)
-
-#define STD_SERIAL_PORT_DEFNS			\
+#define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
-
-
-#ifdef CONFIG_SERIAL_MANY_PORTS
-#define EXTRA_SERIAL_PORT_DEFNS			\
-	{ 0, BASE_BAUD, 0x1A0, 9, FOURPORT_FLAGS }, 	/* ttyS4 */	\
-	{ 0, BASE_BAUD, 0x1A8, 9, FOURPORT_FLAGS },	/* ttyS5 */	\
-	{ 0, BASE_BAUD, 0x1B0, 9, FOURPORT_FLAGS },	/* ttyS6 */	\
-	{ 0, BASE_BAUD, 0x1B8, 9, FOURPORT_FLAGS },	/* ttyS7 */	\
-	{ 0, BASE_BAUD, 0x2A0, 5, FOURPORT_FLAGS },	/* ttyS8 */	\
-	{ 0, BASE_BAUD, 0x2A8, 5, FOURPORT_FLAGS },	/* ttyS9 */	\
-	{ 0, BASE_BAUD, 0x2B0, 5, FOURPORT_FLAGS },	/* ttyS10 */	\
-	{ 0, BASE_BAUD, 0x2B8, 5, FOURPORT_FLAGS },	/* ttyS11 */	\
-	{ 0, BASE_BAUD, 0x330, 4, ACCENT_FLAGS },	/* ttyS12 */	\
-	{ 0, BASE_BAUD, 0x338, 4, ACCENT_FLAGS },	/* ttyS13 */	\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS14 (spare) */		\
-	{ 0, BASE_BAUD, 0x000, 0, 0 },	/* ttyS15 (spare) */		\
-	{ 0, BASE_BAUD, 0x100, 12, BOCA_FLAGS },	/* ttyS16 */	\
-	{ 0, BASE_BAUD, 0x108, 12, BOCA_FLAGS },	/* ttyS17 */	\
-	{ 0, BASE_BAUD, 0x110, 12, BOCA_FLAGS },	/* ttyS18 */	\
-	{ 0, BASE_BAUD, 0x118, 12, BOCA_FLAGS },	/* ttyS19 */	\
-	{ 0, BASE_BAUD, 0x120, 12, BOCA_FLAGS },	/* ttyS20 */	\
-	{ 0, BASE_BAUD, 0x128, 12, BOCA_FLAGS },	/* ttyS21 */	\
-	{ 0, BASE_BAUD, 0x130, 12, BOCA_FLAGS },	/* ttyS22 */	\
-	{ 0, BASE_BAUD, 0x138, 12, BOCA_FLAGS },	/* ttyS23 */	\
-	{ 0, BASE_BAUD, 0x140, 12, BOCA_FLAGS },	/* ttyS24 */	\
-	{ 0, BASE_BAUD, 0x148, 12, BOCA_FLAGS },	/* ttyS25 */	\
-	{ 0, BASE_BAUD, 0x150, 12, BOCA_FLAGS },	/* ttyS26 */	\
-	{ 0, BASE_BAUD, 0x158, 12, BOCA_FLAGS },	/* ttyS27 */	\
-	{ 0, BASE_BAUD, 0x160, 12, BOCA_FLAGS },	/* ttyS28 */	\
-	{ 0, BASE_BAUD, 0x168, 12, BOCA_FLAGS },	/* ttyS29 */	\
-	{ 0, BASE_BAUD, 0x170, 12, BOCA_FLAGS },	/* ttyS30 */	\
-	{ 0, BASE_BAUD, 0x178, 12, BOCA_FLAGS },	/* ttyS31 */
-#else
-#define EXTRA_SERIAL_PORT_DEFNS
-#endif
-
-/* You can have up to four HUB6's in the system, but I've only
- * included two cards here for a total of twelve ports.
- */
-#if (defined(CONFIG_HUB6) && defined(CONFIG_SERIAL_MANY_PORTS))
-#define HUB6_SERIAL_PORT_DFNS		\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,0) },  /* ttyS32 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,1) },  /* ttyS33 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,2) },  /* ttyS34 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,3) },  /* ttyS35 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,4) },  /* ttyS36 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(0,5) },  /* ttyS37 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,0) },  /* ttyS38 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,1) },  /* ttyS39 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,2) },  /* ttyS40 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,3) },  /* ttyS41 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,4) },  /* ttyS42 */	\
-	{ 0, BASE_BAUD, 0x302, 3, HUB6_FLAGS, C_P(1,5) },  /* ttyS43 */
-#else
-#define HUB6_SERIAL_PORT_DFNS
-#endif
-
-#ifdef CONFIG_MCA
-#define MCA_SERIAL_PORT_DFNS			\
-	{ 0, BASE_BAUD, 0x3220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x3228, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x4220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x4228, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x5220, 3, MCA_COM_FLAGS },	\
-	{ 0, BASE_BAUD, 0x5228, 3, MCA_COM_FLAGS },
-#else
-#define MCA_SERIAL_PORT_DFNS
-#endif
-
-#define SERIAL_PORT_DFNS		\
-	STD_SERIAL_PORT_DEFNS		\
-	EXTRA_SERIAL_PORT_DEFNS		\
-	HUB6_SERIAL_PORT_DFNS		\
-	MCA_SERIAL_PORT_DFNS
-



-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
