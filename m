Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbUKXX0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbUKXX0M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbUKXXXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:23:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:38411 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262930AbUKXXKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:10:45 -0500
Date: Thu, 25 Nov 2004 00:10:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small drivers/media/radio/ cleanups (fwd)
Message-ID: <20041124231038.GM19873@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm3.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 7 Nov 2004 18:46:09 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small drivers/media/radio/ cleanups

the patch below makes the following cleanups under drivers/media/radio/ :
- remove two unused global variables
- make some needlessly global code static


diffstat output:
 drivers/media/radio/radio-aimslab.c   |    4 ++--
 drivers/media/radio/radio-cadet.c     |    4 ++--
 drivers/media/radio/radio-gemtek.c    |    2 +-
 drivers/media/radio/radio-maestro.c   |    4 ++--
 drivers/media/radio/radio-maxiradio.c |    4 ++--
 drivers/media/radio/radio-terratec.c  |    2 +-
 drivers/media/radio/radio-zoltrix.c   |    4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-aimslab.c.old	2004-11-07 16:12:57.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-aimslab.c	2004-11-07 16:13:14.000000000 +0100
@@ -130,7 +130,7 @@
  * and bit 4 (+16) is to keep the signal strength meter enabled
  */
 
-void send_0_byte(int port, struct rt_device *dev)
+static void send_0_byte(int port, struct rt_device *dev)
 {
 	if ((dev->curvol == 0) || (dev->muted)) {
 		outb_p(128+64+16+  1, port);   /* wr-enable + data low */
@@ -143,7 +143,7 @@
 	sleep_delay(1000); 
 }
 
-void send_1_byte(int port, struct rt_device *dev)
+static void send_1_byte(int port, struct rt_device *dev)
 {
 	if ((dev->curvol == 0) || (dev->muted)) {
 		outb_p(128+64+16+4  +1, port);   /* wr-enable+data high */
--- linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-cadet.c.old	2004-11-07 16:13:42.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-cadet.c	2004-11-07 16:25:30.000000000 +0100
@@ -46,7 +46,7 @@
 static int tunestat=0;
 static int sigstrength=0;
 static wait_queue_head_t read_queue;
-struct timer_list tunertimer,rdstimer,readtimer;
+static struct timer_list readtimer;
 static __u8 rdsin=0,rdsout=0,rdsstat=0;
 static unsigned char rdsbuf[RDS_BUFFER];
 static spinlock_t cadet_io_lock;
@@ -280,7 +280,7 @@
 	spin_unlock(&cadet_io_lock);
 }  
 
-void cadet_handler(unsigned long data)
+static void cadet_handler(unsigned long data)
 {
 	/*
 	 * Service the RDS fifo
--- linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-gemtek.c.old	2004-11-07 16:14:26.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-gemtek.c	2004-11-07 16:14:43.000000000 +0100
@@ -127,7 +127,7 @@
 	return 0;
 }
 
-int gemtek_getsigstr(struct gemtek_device *dev)
+static int gemtek_getsigstr(struct gemtek_device *dev)
 {
 	spin_lock(&lock);
 	inb(io);
--- linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-maestro.c.old	2004-11-07 16:14:52.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-maestro.c	2004-11-07 16:15:08.000000000 +0100
@@ -256,12 +256,12 @@
 MODULE_DESCRIPTION("Radio driver for the Maestro PCI sound card radio.");
 MODULE_LICENSE("GPL");
 
-void __exit maestro_radio_exit(void)
+static void __exit maestro_radio_exit(void)
 {
 	video_unregister_device(&maestro_radio);
 }
 
-int __init maestro_radio_init(void)
+static int __init maestro_radio_init(void)
 {
 	register __u16 found=0;
 	struct pci_dev *pcidev = NULL;
--- linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-maxiradio.c.old	2004-11-07 16:15:17.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-maxiradio.c	2004-11-07 16:15:30.000000000 +0100
@@ -335,12 +335,12 @@
 	.remove		= __devexit_p(maxiradio_remove_one),
 };
 
-int __init maxiradio_radio_init(void)
+static int __init maxiradio_radio_init(void)
 {
 	return pci_module_init(&maxiradio_driver);
 }
 
-void __exit maxiradio_radio_exit(void)
+static void __exit maxiradio_radio_exit(void)
 {
 	pci_unregister_driver(&maxiradio_driver);
 }
--- linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-terratec.c.old	2004-11-07 16:15:43.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-terratec.c	2004-11-07 16:15:57.000000000 +0100
@@ -175,7 +175,7 @@
   	return 0;
 }
 
-int tt_getsigstr(struct tt_device *dev)		/* TODO */
+static int tt_getsigstr(struct tt_device *dev)		/* TODO */
 {
 	if (inb(io) & 2)	/* bit set = no signal present	*/
 		return 0;
--- linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-zoltrix.c.old	2004-11-07 16:16:18.000000000 +0100
+++ linux-2.6.10-rc1-mm3-full/drivers/media/radio/radio-zoltrix.c	2004-11-07 16:16:34.000000000 +0100
@@ -169,7 +169,7 @@
 
 /* Get signal strength */
 
-int zol_getsigstr(struct zol_device *dev)
+static int zol_getsigstr(struct zol_device *dev)
 {
 	int a, b;
 
@@ -194,7 +194,7 @@
  	return (0);
 }
 
-int zol_is_stereo (struct zol_device *dev)
+static int zol_is_stereo (struct zol_device *dev)
 {
 	int x1, x2;
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

