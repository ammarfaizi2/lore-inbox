Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263309AbTC0REy>; Thu, 27 Mar 2003 12:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263308AbTC0REo>; Thu, 27 Mar 2003 12:04:44 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53381
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263307AbTC0RET>; Thu, 27 Mar 2003 12:04:19 -0500
Date: Thu, 27 Mar 2003 18:21:48 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303271821.h2RILmE1019678@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: DRIVERNAME SUPPRESSED DUE TO KERNEL.ORG FILTER BUGS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merge the serial config entries for PC9800
(Osamu Tomita)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/drivers/serial/Kconfig linux-2.5.66-ac1/drivers/serial/Kconfig
--- linux-2.5.66-bk3/drivers/serial/Kconfig	2003-03-27 17:13:06.000000000 +0000
+++ linux-2.5.66-ac1/drivers/serial/Kconfig	2003-03-18 17:05:10.000000000 +0000
@@ -372,14 +372,25 @@
 	bool "Use NEC V850E on-chip UART for console"
 	depends on V850E_NB85E_UART
 
+config SERIAL98
+	tristate "PC-9800 8251-based primary serial port support"
+	depends on X86_PC9800
+	help
+	  If you want to use standard primary serial ports on PC-9800, 
+	  say Y.  Otherwise, say N.
+
+config SERIAL98_CONSOLE
+        bool "Support for console on PC-9800 standard serial port"
+        depends on SERIAL98=y
+
 config SERIAL_CORE
 	tristate
-	default m if SERIAL_AMBA!=y && SERIAL_CLPS711X!=y && SERIAL_21285!=y && !SERIAL_SA1100 && !SERIAL_ANAKIN && !SERIAL_UART00 && SERIAL_8250!=y && SERIAL_MUX!=y && !SERIAL_ROCKETPORT && !SERIAL_SUNCORE && !V850E_NB85E_UART && (SERIAL_AMBA=m || SERIAL_CLPS711X=m || SERIAL_21285=m || SERIAL_8250=m || SERIAL_MUX=m)
-	default y if SERIAL_AMBA=y || SERIAL_CLPS711X=y || SERIAL_21285=y || SERIAL_SA1100 || SERIAL_ANAKIN || SERIAL_UART00 || SERIAL_8250=y || SERIAL_MUX=y || SERIAL_ROCKETPORT || SERIAL_SUNCORE || V850E_NB85E_UART
+	default m if SERIAL_AMBA!=y && SERIAL_CLPS711X!=y && SERIAL_21285!=y && !SERIAL_SA1100 && !SERIAL_ANAKIN && !SERIAL_UART00 && SERIAL_8250!=y && SERIAL_MUX!=y && !SERIAL_ROCKETPORT && !SERIAL_SUNCORE && !V850E_NB85E_UART && (SERIAL_AMBA=m || SERIAL_CLPS711X=m || SERIAL_21285=m || SERIAL_8250=m || SERIAL_MUX=m || SERIAL98=m)
+	default y if SERIAL_AMBA=y || SERIAL_CLPS711X=y || SERIAL_21285=y || SERIAL_SA1100 || SERIAL_ANAKIN || SERIAL_UART00 || SERIAL_8250=y || SERIAL_MUX=y || SERIAL_ROCKETPORT || SERIAL_SUNCORE || V850E_NB85E_UART || SERIAL98=y
 
 config SERIAL_CORE_CONSOLE
 	bool
-	depends on SERIAL_AMBA_CONSOLE || SERIAL_CLPS711X_CONSOLE || SERIAL_21285_CONSOLE || SERIAL_SA1100_CONSOLE || SERIAL_ANAKIN_CONSOLE || SERIAL_UART00_CONSOLE || SERIAL_8250_CONSOLE || SERIAL_MUX_CONSOLE || SERIAL_SUNCORE || V850E_NB85E_UART_CONSOLE
+	depends on SERIAL_AMBA_CONSOLE || SERIAL_CLPS711X_CONSOLE || SERIAL_21285_CONSOLE || SERIAL_SA1100_CONSOLE || SERIAL_ANAKIN_CONSOLE || SERIAL_UART00_CONSOLE || SERIAL_8250_CONSOLE || SERIAL_MUX_CONSOLE || SERIAL_SUNCORE || V850E_NB85E_UART_CONSOLE || SERIAL98_CONSOLE
 	default y
 
 config SERIAL_68328
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.66-bk3/drivers/serial/Makefile linux-2.5.66-ac1/drivers/serial/Makefile
--- linux-2.5.66-bk3/drivers/serial/Makefile	2003-03-27 17:13:06.000000000 +0000
+++ linux-2.5.66-ac1/drivers/serial/Makefile	2003-03-14 01:07:59.000000000 +0000
@@ -27,3 +27,4 @@
 obj-$(CONFIG_SERIAL_68360) += 68360serial.o
 obj-$(CONFIG_SERIAL_COLDFIRE) += mcfserial.o
 obj-$(CONFIG_V850E_NB85E_UART) += nb85e_uart.o
+obj-$(CONFIG_SERIAL98) += serial98.o
