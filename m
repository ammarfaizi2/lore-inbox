Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbTI3Wkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbTI3Wkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:40:46 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:61138 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261803AbTI3WkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:40:08 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: rmk@arm.linux.org.uk
Subject: [PATCH] remove unused RS_TABLE definitions
Date: Tue, 30 Sep 2003 16:40:05 -0600
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309301640.06008.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

RS_TABLE is defined by lots of architectures, but only referenced
in arch/{mips,ppc}:

	$ grep -r RS_TABLE * | grep -v '#define RS_TABLE'
	arch/mips/mips-boards/generic/gdb_hook.c:static struct serial_state rs_table[RS_TABLE_SIZE] = {
	arch/ppc/boot/common/ns16550.c:static struct serial_state rs_table[RS_TABLE_SIZE] = {
	arch/ppc/platforms/4xx/ebony.c:static struct serial_state rs_table[RS_TABLE_SIZE] = {
	arch/ppc/platforms/4xx/ocotea.c:struct serial_state rs_table[RS_TABLE_SIZE] = {
	arch/ppc/platforms/ev64260_setup.c:static struct serial_state rs_table[RS_TABLE_SIZE] = {
	arch/ppc/platforms/lopec_setup.c:static struct serial_state rs_table[RS_TABLE_SIZE] = {
	arch/ppc/platforms/pplus_setup.c:static struct serial_state rs_table[RS_TABLE_SIZE] = {
	arch/ppc/platforms/prpmc800_setup.c:static struct serial_state rs_table[RS_TABLE_SIZE] = {
	arch/ppc/syslib/gen550_dbg.c:static struct serial_state rs_table[RS_TABLE_SIZE] = {

This patch removes most of the unused definitions from 2.6.

diff -Nru a/include/asm-alpha/serial.h b/include/asm-alpha/serial.h
--- a/include/asm-alpha/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-alpha/serial.h	Tue Sep 30 19:10:34 2003
@@ -26,9 +26,6 @@
 #define FOURPORT_FLAGS ASYNC_FOURPORT
 #define ACCENT_FLAGS 0
 #define BOCA_FLAGS 0
-#define RS_TABLE_SIZE  64
-#else
-#define RS_TABLE_SIZE  4
 #endif
 	
 #define STD_SERIAL_PORT_DEFNS			\
diff -Nru a/include/asm-arm/arch-adifcc/serial.h b/include/asm-arm/arch-adifcc/serial.h
--- a/include/asm-arm/arch-adifcc/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-adifcc/serial.h	Tue Sep 30 19:10:34 2003
@@ -21,8 +21,6 @@
 
 #ifdef CONFIG_ARCH_ADI_EVB
 
-#define RS_TABLE_SIZE 1
-
 /*
  * One serial port, int goes to FIQ, so we run in polled mode
  */
diff -Nru a/include/asm-arm/arch-anakin/serial.h b/include/asm-arm/arch-anakin/serial.h
--- a/include/asm-arm/arch-anakin/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-anakin/serial.h	Tue Sep 30 19:10:34 2003
@@ -20,7 +20,6 @@
 /*
  * UART3 and UART4 are not supported yet
  */
-#define RS_TABLE_SIZE		3
 #define STD_SERIAL_PORT_DEFNS	\
 	{ 0, 0, IO_BASE + UART0, IRQ_UART0, 0 }, \
 	{ 0, 0, IO_BASE + UART1, IRQ_UART1, 0 }, \
diff -Nru a/include/asm-arm/arch-cl7500/serial.h b/include/asm-arm/arch-cl7500/serial.h
--- a/include/asm-arm/arch-cl7500/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-cl7500/serial.h	Tue Sep 30 19:10:34 2003
@@ -22,8 +22,6 @@
  */
 #define BASE_BAUD (1843200 / 16)
 
-#define RS_TABLE_SIZE	16
-
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
      /* UART CLK        PORT  IRQ     FLAGS        */
diff -Nru a/include/asm-arm/arch-ebsa110/serial.h b/include/asm-arm/arch-ebsa110/serial.h
--- a/include/asm-arm/arch-ebsa110/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-ebsa110/serial.h	Tue Sep 30 19:10:34 2003
@@ -24,8 +24,6 @@
 
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
-#define RS_TABLE_SIZE	2
-
      /* UART CLK        PORT  IRQ     FLAGS        */
 #define STD_SERIAL_PORT_DEFNS \
 	{ 0, BASE_BAUD, 0x3F8,  1, STD_COM_FLAGS },	/* ttyS0 */	\
diff -Nru a/include/asm-arm/arch-ebsa285/serial.h b/include/asm-arm/arch-ebsa285/serial.h
--- a/include/asm-arm/arch-ebsa285/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-ebsa285/serial.h	Tue Sep 30 19:10:34 2003
@@ -28,8 +28,6 @@
 #define _SER_IRQ0	IRQ_ISA_UART
 #define _SER_IRQ1	IRQ_ISA_UART2
 
-#define RS_TABLE_SIZE	16
-
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
      /* UART CLK        PORT  IRQ     FLAGS        */
diff -Nru a/include/asm-arm/arch-epxa10db/serial.h b/include/asm-arm/arch-epxa10db/serial.h
--- a/include/asm-arm/arch-epxa10db/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-epxa10db/serial.h	Tue Sep 30 19:10:34 2003
@@ -36,8 +36,6 @@
 #define _SER_IRQ0	IRQ_UARTINT0
 #define _SER_IRQ1	IRQ_UARTINT1
 
-#define RS_TABLE_SIZE	2
-
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
      /* UART CLK        PORT  IRQ     FLAGS        */
diff -Nru a/include/asm-arm/arch-integrator/serial.h b/include/asm-arm/arch-integrator/serial.h
--- a/include/asm-arm/arch-integrator/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-integrator/serial.h	Tue Sep 30 19:10:34 2003
@@ -35,8 +35,6 @@
 #define _SER_IRQ0	IRQ_UARTINT0
 #define _SER_IRQ1	IRQ_UARTINT1
 
-#define RS_TABLE_SIZE	2
-
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
      /* UART CLK        PORT  IRQ     FLAGS        */
diff -Nru a/include/asm-arm/arch-iop3xx/serial.h b/include/asm-arm/arch-iop3xx/serial.h
--- a/include/asm-arm/arch-iop3xx/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-iop3xx/serial.h	Tue Sep 30 19:10:34 2003
@@ -20,8 +20,6 @@
 #define IRQ_UART1	IRQ_IQ80310_UART1
 #define IRQ_UART2	IRQ_IQ80310_UART2
 
-#define RS_TABLE_SIZE 2
-
 #define STD_SERIAL_PORT_DEFNS			\
        /* UART CLK      PORT        IRQ        FLAGS        */			\
 	{ 0, BASE_BAUD, IQ80310_UART2, IRQ_UART2, STD_COM_FLAGS },  /* ttyS0 */	\
@@ -32,8 +30,6 @@
 #ifdef CONFIG_ARCH_IQ80321
 
 #define IRQ_UART1	IRQ_IQ80321_UART
-
-#define RS_TABLE_SIZE 1
 
 #define STD_SERIAL_PORT_DEFNS			\
        /* UART CLK      PORT        IRQ        FLAGS        */			\
diff -Nru a/include/asm-arm/arch-l7200/serial.h b/include/asm-arm/arch-l7200/serial.h
--- a/include/asm-arm/arch-l7200/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-l7200/serial.h	Tue Sep 30 19:10:34 2003
@@ -27,8 +27,6 @@
  */
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
-#define RS_TABLE_SIZE 2
-
 #define STD_SERIAL_PORT_DEFNS		\
 	/* MAGIC UART CLK   PORT       IRQ     FLAGS */			\
 	{ 0, BASE_BAUD, UART1_BASE, IRQ_UART_1, STD_COM_FLAGS },  /* ttyLU0 */ \
diff -Nru a/include/asm-arm/arch-pxa/serial.h b/include/asm-arm/arch-pxa/serial.h
--- a/include/asm-arm/arch-pxa/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-pxa/serial.h	Tue Sep 30 19:10:34 2003
@@ -15,8 +15,6 @@
 /* Standard COM flags */
 #define STD_COM_FLAGS (ASYNC_SKIP_TEST)
 
-#define RS_TABLE_SIZE	5
-
 #define STD_SERIAL_PORT_DEFNS	\
 	{	\
 		type:			PORT_PXA,	\
diff -Nru a/include/asm-arm/arch-rpc/serial.h b/include/asm-arm/arch-rpc/serial.h
--- a/include/asm-arm/arch-rpc/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-rpc/serial.h	Tue Sep 30 19:10:34 2003
@@ -24,8 +24,6 @@
 
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
-#define RS_TABLE_SIZE	16
-
      /* UART CLK        PORT  IRQ     FLAGS        */
 #define STD_SERIAL_PORT_DEFNS \
 	{ 0, BASE_BAUD, 0x3F8, 10, STD_COM_FLAGS },	/* ttyS0 */	\
diff -Nru a/include/asm-arm/arch-sa1100/serial.h b/include/asm-arm/arch-sa1100/serial.h
--- a/include/asm-arm/arch-sa1100/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-sa1100/serial.h	Tue Sep 30 19:10:34 2003
@@ -19,16 +19,12 @@
  */
 #ifdef CONFIG_SA1100_TRIZEPS
 
-#define RS_TABLE_SIZE 2
-
 #define STD_SERIAL_PORT_DEFNS	\
        /* UART	CLK     	PORT		IRQ		FLAGS		*/ \
 	{ 0,	1500000,	TRIZEPS_UART5,	IRQ_GPIO16,	STD_COM_FLAGS },   \
 	{ 0,	1500000,	TRIZEPS_UART6,	IRQ_GPIO17,	STD_COM_FLAGS }
 
 #else
-
-#define RS_TABLE_SIZE 4
 
 /*
  * This assumes you have a 1.8432 MHz clock for your UART.
diff -Nru a/include/asm-arm/arch-shark/serial.h b/include/asm-arm/arch-shark/serial.h
--- a/include/asm-arm/arch-shark/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-shark/serial.h	Tue Sep 30 19:10:34 2003
@@ -20,8 +20,6 @@
 
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
-#define RS_TABLE_SIZE 2
-
      /* UART CLK        PORT  IRQ     FLAGS        */
 #define STD_SERIAL_PORT_DEFNS \
 	{ 0, BASE_BAUD, 0x3F8,  4, STD_COM_FLAGS },	/* ttyS0 */	\
diff -Nru a/include/asm-arm/arch-tbox/serial.h b/include/asm-arm/arch-tbox/serial.h
--- a/include/asm-arm/arch-tbox/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm/arch-tbox/serial.h	Tue Sep 30 19:10:34 2003
@@ -20,8 +20,6 @@
  */
 #define BASE_BAUD (1843200 / 16)
 
-#define RS_TABLE_SIZE	2
-
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
      /* UART CLK        PORT  IRQ     FLAGS        */
diff -Nru a/include/asm-arm26/serial.h b/include/asm-arm26/serial.h
--- a/include/asm-arm26/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-arm26/serial.h	Tue Sep 30 19:10:34 2003
@@ -27,8 +27,6 @@
 
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
-#define RS_TABLE_SIZE   16
-
 #if defined(CONFIG_ARCH_A5K)
      /* UART CLK        PORT  IRQ     FLAGS        */
 
diff -Nru a/include/asm-i386/serial.h b/include/asm-i386/serial.h
--- a/include/asm-i386/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-i386/serial.h	Tue Sep 30 19:10:34 2003
@@ -27,9 +27,6 @@
 #define ACCENT_FLAGS 0
 #define BOCA_FLAGS 0
 #define HUB6_FLAGS 0
-#define RS_TABLE_SIZE	64
-#else
-#define RS_TABLE_SIZE
 #endif
 
 #define MCA_COM_FLAGS	(STD_COM_FLAGS|ASYNC_BOOT_ONLYMCA)
diff -Nru a/include/asm-m68k/serial.h b/include/asm-m68k/serial.h
--- a/include/asm-m68k/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-m68k/serial.h	Tue Sep 30 19:10:34 2003
@@ -30,9 +30,6 @@
 #define FOURPORT_FLAGS ASYNC_FOURPORT
 #define ACCENT_FLAGS 0
 #define BOCA_FLAGS 0
-#define RS_TABLE_SIZE  64
-#else
-#define RS_TABLE_SIZE  4
 #endif
 	
 #define STD_SERIAL_PORT_DEFNS			\
diff -Nru a/include/asm-sh/bigsur/serial.h b/include/asm-sh/bigsur/serial.h
--- a/include/asm-sh/bigsur/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-sh/bigsur/serial.h	Tue Sep 30 19:10:34 2003
@@ -11,9 +11,6 @@
 
 #define BASE_BAUD (3379200 / 16)
 
-/* Leave 2 spare for possible PCMCIA serial cards */
-#define RS_TABLE_SIZE  3
-
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
 
diff -Nru a/include/asm-sh/ec3104/serial.h b/include/asm-sh/ec3104/serial.h
--- a/include/asm-sh/ec3104/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-sh/ec3104/serial.h	Tue Sep 30 19:10:34 2003
@@ -4,8 +4,6 @@
  * guess.  */
 #define BASE_BAUD (16800000 / 16)
 
-#define RS_TABLE_SIZE  3
-
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
 /* there is a fourth serial port with the expected values as well, but
diff -Nru a/include/asm-sh/serial-bigsur.h b/include/asm-sh/serial-bigsur.h
--- a/include/asm-sh/serial-bigsur.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-sh/serial-bigsur.h	Tue Sep 30 19:10:34 2003
@@ -11,9 +11,6 @@
 
 #define BASE_BAUD (3379200 / 16)
 
-/* Leave 2 spare for possible PCMCIA serial cards */
-#define RS_TABLE_SIZE  3
-
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
 
diff -Nru a/include/asm-sh/serial-ec3104.h b/include/asm-sh/serial-ec3104.h
--- a/include/asm-sh/serial-ec3104.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-sh/serial-ec3104.h	Tue Sep 30 19:10:34 2003
@@ -4,8 +4,6 @@
  * guess.  */
 #define BASE_BAUD (16800000 / 16)
 
-#define RS_TABLE_SIZE  3
-
 #define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
 
 /* there is a fourth serial port with the expected values as well, but
diff -Nru a/include/asm-sh/serial.h b/include/asm-sh/serial.h
--- a/include/asm-sh/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-sh/serial.h	Tue Sep 30 19:10:34 2003
@@ -29,15 +29,11 @@
 #ifdef CONFIG_HD64465
 #include <asm/hd64465.h>
 
-#define RS_TABLE_SIZE  1
-
 #define STD_SERIAL_PORT_DEFNS                   \
         /* UART CLK   PORT IRQ     FLAGS        */                      \
         { 0, BASE_BAUD, 0x3F8, HD64465_IRQ_UART, STD_COM_FLAGS }  /* ttyS0 */
 
 #else
-
-#define RS_TABLE_SIZE  2
 
 #define STD_SERIAL_PORT_DEFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
diff -Nru a/include/asm-v850/serial.h b/include/asm-v850/serial.h
--- a/include/asm-v850/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-v850/serial.h	Tue Sep 30 19:10:34 2003
@@ -16,7 +16,6 @@
 
 #define irq_cannonicalize(x) (x)
 #define BASE_BAUD	250000	/* (16MHz / (16 * 38400)) * 9600 */
-#define RS_TABLE_SIZE	1
 #define SERIAL_PORT_DFNS \
    { 0, BASE_BAUD, CB_UART_BASE, IRQ_CB_EXTSIO, STD_COM_FLAGS },
 
diff -Nru a/include/asm-x86_64/serial.h b/include/asm-x86_64/serial.h
--- a/include/asm-x86_64/serial.h	Tue Sep 30 19:10:34 2003
+++ b/include/asm-x86_64/serial.h	Tue Sep 30 19:10:34 2003
@@ -27,9 +27,6 @@
 #define ACCENT_FLAGS 0
 #define BOCA_FLAGS 0
 #define HUB6_FLAGS 0
-#define RS_TABLE_SIZE	64
-#else
-#define RS_TABLE_SIZE
 #endif
 
 #define MCA_COM_FLAGS	(STD_COM_FLAGS|ASYNC_BOOT_ONLYMCA)

