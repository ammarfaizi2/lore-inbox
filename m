Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVFUHxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVFUHxc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVFUHvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:51:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:44771 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261974AbVFUGaq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:46 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove the uart_driver devfs_name field as it's no longer needed
In-Reply-To: <11193354432387@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:43 -0700
Message-Id: <11193354432079@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove the uart_driver devfs_name field as it's no longer needed

Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 87656ce7a691bebc4ed9fb68cdd931ff9223fc9f
tree f0599f484e5a781839e16f6f0ede5d2fed28ef63
parent b29ae24548f3d572399f72a6ac46b7ef3c13b2df
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:37 -0700

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
 22 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/drivers/serial/21285.c b/drivers/serial/21285.c
--- a/drivers/serial/21285.c
+++ b/drivers/serial/21285.c
@@ -495,7 +495,6 @@ static struct uart_driver serial21285_re
 	.owner			= THIS_MODULE,
 	.driver_name		= "ttyFB",
 	.dev_name		= "ttyFB",
-	.devfs_name             = "ttyFB",
 	.major			= SERIAL_21285_MAJOR,
 	.minor			= SERIAL_21285_MINOR,
 	.nr			= 1,
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2237,7 +2237,6 @@ int __init serial8250_start_console(stru
 static struct uart_driver serial8250_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
diff --git a/drivers/serial/au1x00_uart.c b/drivers/serial/au1x00_uart.c
--- a/drivers/serial/au1x00_uart.c
+++ b/drivers/serial/au1x00_uart.c
@@ -1236,7 +1236,6 @@ console_initcall(serial8250_console_init
 static struct uart_driver serial8250_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -870,7 +870,6 @@ static struct uart_driver imx_reg = {
 	.owner          = THIS_MODULE,
 	.driver_name    = DRIVER_NAME,
 	.dev_name       = "ttySMX",
-	.devfs_name	= "ttsmx/",
 	.major          = SERIAL_IMX_MAJOR,
 	.minor          = MINOR_START,
 	.nr             = ARRAY_SIZE(imx_ports),
diff --git a/drivers/serial/ip22zilog.c b/drivers/serial/ip22zilog.c
--- a/drivers/serial/ip22zilog.c
+++ b/drivers/serial/ip22zilog.c
@@ -1105,7 +1105,6 @@ static struct console ip22zilog_console 
 static struct uart_driver ip22zilog_reg = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "serial",
-	.devfs_name	= "tts/",
 	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
diff --git a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
--- a/drivers/serial/m32r_sio.c
+++ b/drivers/serial/m32r_sio.c
@@ -1152,7 +1152,6 @@ console_initcall(m32r_sio_console_init);
 static struct uart_driver m32r_sio_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "sio",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= 64,
diff --git a/drivers/serial/mcfserial.c b/drivers/serial/mcfserial.c
--- a/drivers/serial/mcfserial.c
+++ b/drivers/serial/mcfserial.c
@@ -1670,7 +1670,6 @@ mcfrs_init(void)
 	/* Initialize the tty_driver structure */
 	mcfrs_serial_driver->owner = THIS_MODULE;
 	mcfrs_serial_driver->name = "ttyS";
-	mcfrs_serial_driver->devfs_name = "ttys/";
 	mcfrs_serial_driver->driver_name = "serial";
 	mcfrs_serial_driver->major = TTY_MAJOR;
 	mcfrs_serial_driver->minor_start = 64;
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -704,7 +704,6 @@ static struct uart_driver mpc52xx_uart_d
 	.owner		= THIS_MODULE,
 	.driver_name	= "mpc52xx_psc_uart",
 	.dev_name	= "ttyS",
-	.devfs_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
 	.nr		= MPC52xx_PSC_MAXNUM,
diff --git a/drivers/serial/mpsc.c b/drivers/serial/mpsc.c
--- a/drivers/serial/mpsc.c
+++ b/drivers/serial/mpsc.c
@@ -61,7 +61,6 @@
 #define MPSC_MAJOR		204
 #define MPSC_MINOR_START	44
 #define	MPSC_DRIVER_NAME	"MPSC"
-#define	MPSC_DEVFS_NAME		"ttymm/"
 #define	MPSC_DEV_NAME		"ttyMM"
 #define	MPSC_VERSION		"1.00"
 
@@ -1611,7 +1610,6 @@ static struct device_driver mpsc_shared_
 static struct uart_driver mpsc_reg = {
 	.owner       = THIS_MODULE,
 	.driver_name = MPSC_DRIVER_NAME,
-	.devfs_name  = MPSC_DEVFS_NAME,
 	.dev_name    = MPSC_DEV_NAME,
 	.major       = MPSC_MAJOR,
 	.minor       = MPSC_MINOR_START,
diff --git a/drivers/serial/pmac_zilog.c b/drivers/serial/pmac_zilog.c
--- a/drivers/serial/pmac_zilog.c
+++ b/drivers/serial/pmac_zilog.c
@@ -101,7 +101,6 @@ static DECLARE_MUTEX(pmz_irq_sem);
 static struct uart_driver pmz_uart_reg = {
 	.owner		=	THIS_MODULE,
 	.driver_name	=	"ttyS",
-	.devfs_name	=	"tts/",
 	.dev_name	=	"ttyS",
 	.major		=	TTY_MAJOR,
 };
diff --git a/drivers/serial/pxa.c b/drivers/serial/pxa.c
--- a/drivers/serial/pxa.c
+++ b/drivers/serial/pxa.c
@@ -781,7 +781,6 @@ static struct uart_pxa_port serial_pxa_p
 static struct uart_driver serial_pxa_reg = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "PXA serial",
-	.devfs_name	= "tts/",
 	.dev_name	= "ttyS",
 	.major		= TTY_MAJOR,
 	.minor		= 64,
diff --git a/drivers/serial/s3c2410.c b/drivers/serial/s3c2410.c
--- a/drivers/serial/s3c2410.c
+++ b/drivers/serial/s3c2410.c
@@ -151,7 +151,6 @@ s3c24xx_serial_dbg(const char *fmt, ...)
 /* UART name and device definitions */
 
 #define S3C24XX_SERIAL_NAME	"ttySAC"
-#define S3C24XX_SERIAL_DEVFS    "tts/"
 #define S3C24XX_SERIAL_MAJOR	204
 #define S3C24XX_SERIAL_MINOR	64
 
@@ -967,7 +966,6 @@ static struct uart_driver s3c24xx_uart_d
 	.nr		= 3,
 	.cons		= S3C24XX_SERIAL_CONSOLE,
 	.driver_name	= S3C24XX_SERIAL_NAME,
-	.devfs_name	= S3C24XX_SERIAL_DEVFS,
 	.major		= S3C24XX_SERIAL_MAJOR,
 	.minor		= S3C24XX_SERIAL_MINOR,
 };
diff --git a/drivers/serial/sa1100.c b/drivers/serial/sa1100.c
--- a/drivers/serial/sa1100.c
+++ b/drivers/serial/sa1100.c
@@ -827,7 +827,6 @@ static struct uart_driver sa1100_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "ttySA",
 	.dev_name		= "ttySA",
-	.devfs_name		= "ttySA",
 	.major			= SERIAL_SA1100_MAJOR,
 	.minor			= MINOR_START,
 	.nr			= NR_PORTS,
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2082,7 +2082,6 @@ int uart_register_driver(struct uart_dri
 
 	normal->owner		= drv->owner;
 	normal->driver_name	= drv->driver_name;
-	normal->devfs_name	= drv->devfs_name;
 	normal->name		= drv->dev_name;
 	normal->major		= drv->major;
 	normal->minor_start	= drv->minor;
diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -62,12 +62,10 @@ static char *serial_name = "TX39/49 Seri
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
@@ -998,7 +996,6 @@ late_initcall(serial_txx9_late_console_i
 static struct uart_driver serial_txx9_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial_txx9",
-	.devfs_name		= TXX9_TTY_DEVFS_NAME,
 	.dev_name		= TXX9_TTY_NAME,
 	.major			= TXX9_TTY_MAJOR,
 	.minor			= TXX9_TTY_MINOR_START,
diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -1632,9 +1632,6 @@ static char banner[] __initdata =
 static struct uart_driver sci_uart_driver = {
 	.owner		= THIS_MODULE,
 	.driver_name	= "sci",
-#ifdef CONFIG_DEVFS_FS
-	.devfs_name	= "ttsc/",
-#endif
 	.dev_name	= "ttySC",
 	.major		= SCI_MAJOR,
 	.minor		= SCI_MINOR_START,
diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -877,7 +877,6 @@ static struct uart_ops sunsab_pops = {
 static struct uart_driver sunsab_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 };
diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1278,7 +1278,6 @@ out:
 static struct uart_driver sunsu_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 };
diff --git a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
--- a/drivers/serial/sunzilog.c
+++ b/drivers/serial/sunzilog.c
@@ -1035,7 +1035,6 @@ static int zilog_irq = -1;
 static struct uart_driver sunzilog_reg = {
 	.owner		=	THIS_MODULE,
 	.driver_name	=	"ttyS",
-	.devfs_name	=	"tts/",
 	.dev_name	=	"ttyS",
 	.major		=	TTY_MAJOR,
 };
diff --git a/drivers/serial/v850e_uart.c b/drivers/serial/v850e_uart.c
--- a/drivers/serial/v850e_uart.c
+++ b/drivers/serial/v850e_uart.c
@@ -468,7 +468,6 @@ static struct uart_ops v850e_uart_ops = 
 static struct uart_driver v850e_uart_driver = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "v850e_uart",
-	.devfs_name		= "tts/",
 	.dev_name		= "ttyS",
 	.major			= TTY_MAJOR,
 	.minor			= V850E_UART_MINOR_BASE,
diff --git a/drivers/serial/vr41xx_siu.c b/drivers/serial/vr41xx_siu.c
--- a/drivers/serial/vr41xx_siu.c
+++ b/drivers/serial/vr41xx_siu.c
@@ -918,7 +918,6 @@ static struct uart_driver siu_uart_drive
 	.owner		= THIS_MODULE,
 	.driver_name	= "SIU",
 	.dev_name	= "ttyVR",
-	.devfs_name	= "ttvr/",
 	.major		= SIU_MAJOR,
 	.minor		= SIU_MINOR_BASE,
 	.cons		= SERIAL_VR41XX_CONSOLE,
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -317,7 +317,6 @@ struct uart_driver {
 	struct module		*owner;
 	const char		*driver_name;
 	const char		*dev_name;
-	const char		*devfs_name;
 	int			 major;
 	int			 minor;
 	int			 nr;

