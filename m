Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWANCIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWANCIT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbWANCIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:08:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12818 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030380AbWANCIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:08:17 -0500
Date: Sat, 14 Jan 2006 03:08:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: torvalds@osdl.org, akpm@osdl.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       R.E.Wolff@BitWizard.nl, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [2.6 patch] remove unused tmp_buf_sem's
Message-ID: <20060114020816.GW29663@stusta.de>
References: <17348.61824.49889.569928@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17348.61824.49889.569928@jaguar.mkp.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 06:52:32AM -0500, Jes Sorensen wrote:
> 
> Remove unsued semaphore declaration.
> 
> Signed-off-by: Jes Sorensen <jes@sgi.com>
> 
> ----
> 
>  arch/ia64/hp/sim/simserial.c |    1 -
>  1 files changed, 1 deletion(-)
> 
> Index: linux-2.6.15-rc7-quilt/arch/ia64/hp/sim/simserial.c
> ===================================================================
> --- linux-2.6.15-rc7-quilt.orig/arch/ia64/hp/sim/simserial.c
> +++ linux-2.6.15-rc7-quilt/arch/ia64/hp/sim/simserial.c
> @@ -107,7 +107,6 @@
>  static struct console *console;
>  
>  static unsigned char *tmp_buf;
> -static DECLARE_MUTEX(tmp_buf_sem);
>...

There are even more of them...

Patch below.

cu
Adrian


<--  snip  -->


tmp_buf_sem sems to be a common name for something completely unused...


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/ia64/hp/sim/simserial.c  |    1 -
 arch/ppc/4xx_io/serial_sicc.c |    1 -
 drivers/char/amiserial.c      |    1 -
 drivers/char/esp.c            |    1 -
 drivers/char/generic_serial.c |    1 -
 drivers/char/riscom8.c        |    1 -
 drivers/char/serial167.c      |    1 -
 drivers/char/specialix.c      |    3 ---
 drivers/char/synclink.c       |    1 -
 drivers/sbus/char/aurora.c    |    1 -
 drivers/serial/68328serial.c  |    1 -
 drivers/usb/serial/pl2303.c   |    2 --
 12 files changed, 15 deletions(-)

--- linux-2.6.15-mm3-full/arch/ia64/hp/sim/simserial.c.old	2006-01-13 15:22:27.000000000 +0100
+++ linux-2.6.15-mm3-full/arch/ia64/hp/sim/simserial.c	2006-01-13 15:22:47.000000000 +0100
@@ -103,7 +103,6 @@
 static struct console *console;
 
 static unsigned char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
 
 extern struct console *console_drivers; /* from kernel/printk.c */
 
--- linux-2.6.15-mm3-full/arch/ppc/4xx_io/serial_sicc.c.old	2006-01-13 15:22:56.000000000 +0100
+++ linux-2.6.15-mm3-full/arch/ppc/4xx_io/serial_sicc.c	2006-01-13 15:23:02.000000000 +0100
@@ -215,7 +215,6 @@
  * memory if large numbers of serial ports are open.
  */
 static u_char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
 
 #define HIGH_BITS_OFFSET    ((sizeof(long)-sizeof(int))*8)
 
--- linux-2.6.15-mm3-full/drivers/char/amiserial.c.old	2006-01-13 15:23:14.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/char/amiserial.c	2006-01-13 15:23:16.000000000 +0100
@@ -123,7 +123,6 @@
  * memory if large numbers of serial ports are open.
  */
 static unsigned char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
 
 #include <asm/uaccess.h>
 
--- linux-2.6.15-mm3-full/drivers/char/esp.c.old	2006-01-13 15:23:25.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/char/esp.c	2006-01-13 15:23:28.000000000 +0100
@@ -160,7 +160,6 @@
  * memory if large numbers of serial ports are open.
  */
 static unsigned char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
 
 static inline int serial_paranoia_check(struct esp_struct *info,
 					char *name, const char *routine)
--- linux-2.6.15-mm3-full/drivers/char/generic_serial.c.old	2006-01-13 15:23:36.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/char/generic_serial.c	2006-01-13 15:23:39.000000000 +0100
@@ -34,7 +34,6 @@
 #define DEBUG 
 
 static char *                  tmp_buf; 
-static DECLARE_MUTEX(tmp_buf_sem);
 
 static int gs_debug;
 
--- linux-2.6.15-mm3-full/drivers/char/riscom8.c.old	2006-01-13 15:23:47.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/char/riscom8.c	2006-01-13 15:24:04.000000000 +0100
@@ -82,7 +82,6 @@
 static struct riscom_board * IRQ_to_board[16];
 static struct tty_driver *riscom_driver;
 static unsigned char * tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
 
 static unsigned long baud_table[] =  {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
--- linux-2.6.15-mm3-full/drivers/char/serial167.c.old	2006-01-13 15:24:42.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/char/serial167.c	2006-01-13 15:24:45.000000000 +0100
@@ -129,7 +129,6 @@
  * memory if large numbers of serial ports are open.
  */
 static unsigned char *tmp_buf = 0;
-DECLARE_MUTEX(tmp_buf_sem);
 
 /*
  * This is used to look up the divisor speeds and the timeouts
--- linux-2.6.15-mm3-full/drivers/char/specialix.c.old	2006-01-13 15:24:53.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/char/specialix.c	2006-01-13 15:24:58.000000000 +0100
@@ -184,7 +184,6 @@
 
 static struct tty_driver *specialix_driver;
 static unsigned char * tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
 
 static unsigned long baud_table[] =  {
 	0, 50, 75, 110, 134, 150, 200, 300, 600, 1200, 1800, 2400, 4800,
@@ -2556,8 +2555,6 @@
 
 	func_enter();
 
-	init_MUTEX(&tmp_buf_sem); /* Init de the semaphore - pvdl */
-
 	if (iobase[0] || iobase[1] || iobase[2] || iobase[3]) {
 		for(i = 0; i < SX_NBOARD; i++) {
 			sx_board[i].base = iobase[i];
--- linux-2.6.15-mm3-full/drivers/char/synclink.c.old	2006-01-13 15:25:05.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/char/synclink.c	2006-01-13 15:25:18.000000000 +0100
@@ -951,7 +951,6 @@
  * memory if large numbers of serial ports are open.
  */
 static unsigned char *tmp_buf;
-static DECLARE_MUTEX(tmp_buf_sem);
 
 static inline int mgsl_paranoia_check(struct mgsl_struct *info,
 					char *name, const char *routine)
--- linux-2.6.15-mm3-full/drivers/sbus/char/aurora.c.old	2006-01-13 15:25:33.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/sbus/char/aurora.c	2006-01-13 15:25:39.000000000 +0100
@@ -92,7 +92,6 @@
 
 /* no longer used. static struct Aurora_board * IRQ_to_board[16] = { NULL, } ;*/
 static unsigned char * tmp_buf = NULL;
-static DECLARE_MUTEX(tmp_buf_sem);
 
 DECLARE_TASK_QUEUE(tq_aurora);
 
--- linux-2.6.15-mm3-full/drivers/serial/68328serial.c.old	2006-01-13 15:25:50.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/serial/68328serial.c	2006-01-13 15:25:59.000000000 +0100
@@ -141,7 +141,6 @@
  * memory if large numbers of serial ports are open.
  */
 static unsigned char tmp_buf[SERIAL_XMIT_SIZE]; /* This is cheating */
-DECLARE_MUTEX(tmp_buf_sem);
 
 static inline int serial_paranoia_check(struct m68k_serial *info,
 					char *name, const char *routine)
--- linux-2.6.15-mm3-full/drivers/usb/serial/pl2303.c.old	2006-01-13 15:26:10.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/usb/serial/pl2303.c	2006-01-13 15:26:17.000000000 +0100
@@ -43,8 +43,6 @@
 #define PL2303_BUF_SIZE		1024
 #define PL2303_TMP_BUF_SIZE	1024
 
-static DECLARE_MUTEX(pl2303_tmp_buf_sem);
-
 struct pl2303_buf {
 	unsigned int	buf_size;
 	char		*buf_buf;

