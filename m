Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVFKI3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVFKI3J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVFKI20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:28:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:4036 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261657AbVFKHsv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:51 -0400
Subject: [PATCH] Remove the uart_driver devfs_name field as it's no longer needed
In-Reply-To: <11184761113549@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:32 -0700
Message-Id: <1118476112920@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/serial/21285.c        |    1 -
 drivers/serial/8250.c         |    1 -
 drivers/serial/au1x00_uart.c  |    1 -
 drivers/serial/imx.c          |    1 -
 drivers/serial/ip22zilog.c    |    1 -
 drivers/serial/m32r_sio.c     |    1 -
 drivers/serial/mcfserial.c    |    1 -
 drivers/serial/mpc52xx_uart.c |    1 -
 drivers/serial/mpsc.c         |    2 --
 drivers/serial/pmac_zilog.c   |    1 -
 drivers/serial/pxa.c          |    1 -
 drivers/serial/s3c2410.c      |    2 --
 drivers/serial/sa1100.c       |    1 -
 drivers/serial/serial_core.c  |    1 -
 drivers/serial/serial_txx9.c  |    3 ---
 drivers/serial/sh-sci.c       |    3 ---
 drivers/serial/sunsab.c       |    1 -
 drivers/serial/sunsu.c        |    1 -
 drivers/serial/sunzilog.c     |    1 -
 drivers/serial/v850e_uart.c   |    1 -
 drivers/serial/vr41xx_siu.c   |    1 -
 include/linux/serial_core.h   |    1 -
 22 files changed, 28 deletions(-)

--- gregkh-2.6.orig/include/linux/serial_core.h	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/include/linux/serial_core.h	2005-06-10 23:37:22.000000000 -0700
@@ -317,7 +317,6 @@
 	struct module		*owner;
 	const char		*driver_name;
 	const char		*dev_name;
-	const char		*devfs_name;
 	int			 major;
 	int			 minor;
 	int			 nr;
--- gregkh-2.6.orig/drivers/serial/21285.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/21285.c	2005-06-10 23:37:22.000000000 -0700
@@ -495,7 +495,6 @@
 	.owner			= THIS_MODULE,
 	.driver_name		= "ttyFB",
 	.dev_name		= "ttyFB",
-	.devfs_name             = "ttyFB",
 	.major			= SERIAL_21285_MAJOR,
 	.minor			= SERIAL_21285_MINOR,
 	.nr			= 1,
--- gregkh-2.6.orig/drivers/serial/imx.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/imx.c	2005-06-10 23:37:22.000000000 -0700
@@ -870,7 +870,6 @@
 	.owner          = THIS_MODULE,
 	.driver_name    = DRIVER_NAME,
 	.dev_name       = "ttySMX",
-	.devfs_name	= "ttsmx/",
 	.major          = SERIAL_IMX_MAJOR,
 	.minor          = MINOR_START,
 	.nr             = ARRAY_SIZE(imx_ports),
--- gregkh-2.6.orig/drivers/serial/ip22zilog.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/ip22zilog.c	2005-06-10 23:37:22.000000000 -0700
@@ -1105,7 +1105,6 @@
 static struct uart_driver ip22zilog_reg = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "serial",
-	.devfs_name	= "tts/",
 	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
--- gregkh-2.6.orig/drivers/serial/m32r_sio.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/m32r_sio.c	2005-06-10 23:37:22.000000000 -0700
@@ -1152,7 +1152,6 @@
 static struct uart_driver m32r_sio_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "sio",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
--- gregkh-2.6.orig/drivers/serial/mcfserial.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/mcfserial.c	2005-06-10 23:37:22.000000000 -0700
@@ -1670,7 +1670,6 @@
 	/* Initialize the tty_driver structure */
 	mcfrs_serial_driver->owner = THIS_MODULE;
 	mcfrs_serial_driver->name = "ttyS";
-	mcfrs_serial_driver->devfs_name = "ttys/";
 	mcfrs_serial_driver->driver_name = "serial";
 	mcfrs_serial_driver->major = TTY_MAJOR;
 	mcfrs_serial_driver->minor_start = 64;
--- gregkh-2.6.orig/drivers/serial/mpc52xx_uart.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/mpc52xx_uart.c	2005-06-10 23:37:22.000000000 -0700
@@ -704,7 +704,6 @@
 	.owner		= THIS_MODULE,
 	.driver_name	= "mpc52xx_psc_uart",
 	.dev_name	= "ttyS",
-	.devfs_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
 	.nr		= MPC52xx_PSC_MAXNUM,
--- gregkh-2.6.orig/drivers/serial/mpsc.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/mpsc.c	2005-06-10 23:37:22.000000000 -0700
@@ -61,7 +61,6 @@
 #define MPSC_MAJOR		204
 #define MPSC_MINOR_START	44
 #define	MPSC_DRIVER_NAME	"MPSC"
-#define	MPSC_DEVFS_NAME		"ttymm/"
 #define	MPSC_DEV_NAME		"ttyMM"
 #define	MPSC_VERSION		"1.00"
 
@@ -1611,7 +1610,6 @@
 static struct uart_driver mpsc_reg = {
 	.owner       = THIS_MODULE,
 	.driver_name = MPSC_DRIVER_NAME,
-	.devfs_name  = MPSC_DEVFS_NAME,
 	.dev_name    = MPSC_DEV_NAME,
 	.major       = MPSC_MAJOR,
 	.minor       = MPSC_MINOR_START,
--- gregkh-2.6.orig/drivers/serial/pxa.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/pxa.c	2005-06-10 23:37:22.000000000 -0700
@@ -781,7 +781,6 @@
 static struct uart_driver serial_pxa_reg = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "PXA serial",
-	.devfs_name	= "tts/",
 	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
--- gregkh-2.6.orig/drivers/serial/s3c2410.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/s3c2410.c	2005-06-10 23:37:22.000000000 -0700
@@ -151,7 +151,6 @@
 /* UART name and device definitions */
 
 #define S3C24XX_SERIAL_NAME	"ttySAC"
-#define S3C24XX_SERIAL_DEVFS    "tts/"
 #define S3C24XX_SERIAL_MAJOR	204
 #define S3C24XX_SERIAL_MINOR	64
 
@@ -967,7 +966,6 @@
 	.nr		= 3,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
 	.driver_name	= S3C24XX_SERIAL_NAME,
-	.devfs_name	= S3C24XX_SERIAL_DEVFS,
 	.major		= S3C24XX_SERIAL_MAJOR,
 	.minor		= S3C24XX_SERIAL_MINOR,
 };
--- gregkh-2.6.orig/drivers/serial/serial_core.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/serial_core.c	2005-06-10 23:37:36.000000000 -0700
@@ -2082,7 +2082,6 @@
 
 	normal->owner		= drv->owner;
 	normal->driver_name	= drv->driver_name;
-	normal->devfs_name	= drv->devfs_name;
 	normal->name		= drv->dev_name;
 	normal->major		= drv->major;
 	normal->minor_start	= drv->minor;
--- gregkh-2.6.orig/drivers/serial/serial_txx9.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/serial_txx9.c	2005-06-10 23:37:22.000000000 -0700
@@ -62,12 +62,10 @@
 #if !defined(CONFIG_SERIAL_TXX9_STDSERIAL)
 /* "ttyS" is used for standard serial driver */
 #define TXX9_TTY_NAME "ttyTX"
-#define TXX9_TTY_DEVFS_NAME "tttx/"
 #define TXX9_TTY_MINOR_START	(64 + 64)	/* ttyTX0(128), ttyTX1(129) */
 #else
 /* acts like standard serial driver */
 #define TXX9_TTY_NAME "ttyS"
-#define TXX9_TTY_DEVFS_NAME "tts/"
 #define TXX9_TTY_MINOR_START	64
 #endif
 #define TXX9_TTY_MAJOR	TTY_MAJOR
@@ -998,7 +996,6 @@
 static struct uart_driver serial_txx9_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial_txx9",
-	.devfs_name		= TXX9_TTY_DEVFS_NAME,
 	.dev_name		= TXX9_TTY_NAME,
 	.major			= TXX9_TTY_MAJOR,
 	.minor			= TXX9_TTY_MINOR_START,
--- gregkh-2.6.orig/drivers/serial/sh-sci.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/sh-sci.c	2005-06-10 23:37:22.000000000 -0700
@@ -1632,9 +1632,6 @@
 static struct uart_driver sci_uart_driver = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "sci",
-#ifdef CONFIG_DEVFS_FS
-	.devfs_name	= "ttsc/",
-#endif
 	.dev_name	= "ttySC",
 	.major		= SCI_MAJOR,
 	.minor		= SCI_MINOR_START,
--- gregkh-2.6.orig/drivers/serial/sunsab.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/sunsab.c	2005-06-10 23:37:22.000000000 -0700
@@ -877,7 +877,6 @@
 static struct uart_driver sunsab_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 };
--- gregkh-2.6.orig/drivers/serial/sunzilog.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/sunzilog.c	2005-06-10 23:37:22.000000000 -0700
@@ -1035,7 +1035,6 @@
 static struct uart_driver sunzilog_reg = {
 	.owner		=	THIS_MODULE,
 	.driver_name	=	"ttyS",
-	.devfs_name	=	"tts/",
 	.dev_name	=	"ttyS",
 	.major		=	TTY_MAJOR,
 };
--- gregkh-2.6.orig/drivers/serial/v850e_uart.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/v850e_uart.c	2005-06-10 23:37:22.000000000 -0700
@@ -468,7 +468,6 @@
 static struct uart_driver v850e_uart_driver = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "v850e_uart",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= V850E_UART_MINOR_BASE,
--- gregkh-2.6.orig/drivers/serial/vr41xx_siu.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/vr41xx_siu.c	2005-06-10 23:37:22.000000000 -0700
@@ -918,7 +918,6 @@
 	.owner		= THIS_MODULE,
 	.driver_name	= "SIU",
 	.dev_name	= "ttyVR",
-	.devfs_name	= "ttvr/",
 	.major		= SIU_MAJOR,
 	.minor		= SIU_MINOR_BASE,
 	.cons		= SERIAL_VR41XX_CONSOLE,
--- gregkh-2.6.orig/drivers/serial/8250.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/8250.c	2005-06-10 23:37:22.000000000 -0700
@@ -2237,7 +2237,6 @@
 static struct uart_driver serial8250_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
--- gregkh-2.6.orig/drivers/serial/au1x00_uart.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/au1x00_uart.c	2005-06-10 23:37:22.000000000 -0700
@@ -1236,7 +1236,6 @@
 static struct uart_driver serial8250_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
--- gregkh-2.6.orig/drivers/serial/pmac_zilog.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/pmac_zilog.c	2005-06-10 23:37:22.000000000 -0700
@@ -101,7 +101,6 @@
 static struct uart_driver pmz_uart_reg = {
 	.owner		=	THIS_MODULE,
 	.driver_name	=	"ttyS",
-	.devfs_name	=	"tts/",
 	.dev_name	=	"ttyS",
 	.major		=	TTY_MAJOR,
 };
--- gregkh-2.6.orig/drivers/serial/sa1100.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/sa1100.c	2005-06-10 23:37:22.000000000 -0700
@@ -827,7 +827,6 @@
 	.owner			= THIS_MODULE,
 	.driver_name		= "ttySA",
 	.dev_name		= "ttySA",
-	.devfs_name		= "ttySA",
 	.major			= SERIAL_SA1100_MAJOR,
 	.minor			= MINOR_START,
 	.nr			= NR_PORTS,
--- gregkh-2.6.orig/drivers/serial/sunsu.c	2005-06-10 23:28:59.000000000 -0700
+++ gregkh-2.6/drivers/serial/sunsu.c	2005-06-10 23:37:22.000000000 -0700
@@ -1278,7 +1278,6 @@
 static struct uart_driver sunsu_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 };

