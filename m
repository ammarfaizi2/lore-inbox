Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263046AbVGIBLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbVGIBLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbVGIAqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 20:46:55 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:35974 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S263046AbVGIApl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 20:45:41 -0400
Message-ID: <42CF1E32.4030601@brturbo.com.br>
Date: Fri, 08 Jul 2005 21:45:38 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: [PATCH 8/14 2.6.13-rc2-mm1] V4L I2C Miscelaneous
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------050206050606080202050501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050206050606080202050501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------050206050606080202050501
Content-Type: text/x-patch;
 name="v4l_i2c_misc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v4l_i2c_misc.diff"

- Removed unused structures.
- CodingStyle rules applied to comments.

Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>

 linux/drivers/media/video/msp3400.c |   30 +++-------------------------
 linux/drivers/media/video/tda7432.c |   13 ------------
 linux/drivers/media/video/tda9875.c |   13 ------------
 linux/drivers/media/video/tvaudio.c |    5 ----
 linux/include/media/audiochip.h     |    3 --
 5 files changed, 5 insertions(+), 59 deletions(-)

diff -u linux-2.6.13/include/media/audiochip.h linux/include/media/audiochip.h
--- linux-2.6.13/include/media/audiochip.h	2005-07-06 00:46:33.000000000 -0300
+++ linux/include/media/audiochip.h	2005-07-07 20:00:14.000000000 -0300
@@ -1,5 +1,5 @@
 /*
- * $Id: audiochip.h,v 1.3 2005/06/12 04:19:19 mchehab Exp $
+ * $Id: audiochip.h,v 1.5 2005/06/16 22:59:16 hhackmann Exp $
  */
 
 #ifndef AUDIOCHIP_H
@@ -35,5 +35,4 @@
 
 /* misc stuff to pass around config info to i2c chips */
 #define AUDC_CONFIG_PINNACLE  _IOW('m',32,int)
-
 #endif /* AUDIOCHIP_H */
diff -u linux-2.6.13/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.13/drivers/media/video/msp3400.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/msp3400.c	2005-07-07 20:00:15.000000000 -0300
@@ -567,10 +567,6 @@
 	switch (audmode) {
 	case V4L2_TUNER_MODE_STEREO:
 		src = 0x0020 | nicam;
-#if 0
-		/* spatial effect */
-		msp3400c_write(client,I2C_MSP3400C_DFP, 0x0005,0x4000);
-#endif
 		break;
 	case V4L2_TUNER_MODE_MONO:
 		if (msp->mode == MSP_MODE_AM_NICAM) {
@@ -741,16 +737,14 @@
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
 		} else {
-#if 0
-			/* hmm, that one doesn't return on wakeup ... */
-			msleep_interruptible(timeout);
-#else
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(msecs_to_jiffies(timeout));
-#endif
 		}
 	}
-	try_to_freeze();
+	if (current->flags & PF_FREEZE) {
+		refrigerator ();
+	}
+
 	remove_wait_queue(&msp->wq, &wait);
 	return msp->restart;
 }
@@ -1154,17 +1143,10 @@
 					    MSP_CARRIER(10.7));
 			/* scart routing */
 			msp3400c_set_scart(client,SCART_IN2,0);
-#if 0
-			/* radio from SCART_IN2 */
-			msp3400c_write(client,I2C_MSP3400C_DFP, 0x08, 0x0220);
-			msp3400c_write(client,I2C_MSP3400C_DFP, 0x09, 0x0220);
-			msp3400c_write(client,I2C_MSP3400C_DFP, 0x0b, 0x0220);
-#else
 			/* msp34xx does radio decoding */
 			msp3400c_write(client,I2C_MSP3400C_DFP, 0x08, 0x0020);
 			msp3400c_write(client,I2C_MSP3400C_DFP, 0x09, 0x0020);
 			msp3400c_write(client,I2C_MSP3400C_DFP, 0x0b, 0x0020);
-#endif
 			break;
 		case 0x0003:
 		case 0x0004:
@@ -1507,10 +1489,6 @@
 		return -1;
 	}
 
-#if 0
-	/* this will turn on a 1kHz beep - might be useful for debugging... */
-	msp3400c_write(c,I2C_MSP3400C_DFP, 0x0014, 0x1040);
-#endif
 	msp3400c_setvolume(c, msp->muted, msp->volume, msp->balance);
 
 	snprintf(c->name, sizeof(c->name), "MSP34%02d%c-%c%d",
diff -u linux-2.6.13/drivers/media/video/tda7432.c linux/drivers/media/video/tda7432.c
--- linux-2.6.13/drivers/media/video/tda7432.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/tda7432.c	2005-07-07 20:00:15.000000000 -0300
@@ -243,19 +243,6 @@
 }
 
 /* I don't think we ever actually _read_ the chip... */
-#if 0
-static int tda7432_read(struct i2c_client *client)
-{
-	unsigned char buffer;
-	d2printk("tda7432: In tda7432_read\n");
-	if (1 != i2c_master_recv(client,&buffer,1)) {
-		printk(KERN_WARNING "tda7432: I/O error, trying (read)\n");
-		return -1;
-	}
-	dprintk("tda7432: Read 0x%02x\n", buffer);
-	return buffer;
-}
-#endif
 
 static int tda7432_set(struct i2c_client *client)
 {
diff -u linux-2.6.13/drivers/media/video/tda9875.c linux/drivers/media/video/tda9875.c
--- linux-2.6.13/drivers/media/video/tda9875.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/tda9875.c	2005-07-07 20:00:15.000000000 -0300
@@ -123,19 +123,6 @@
 	return 0;
 }
 
-#if 0
-static int tda9875_read(struct i2c_client *client)
-{
-	unsigned char buffer;
-	dprintk("In tda9875_read\n");
-	if (1 != i2c_master_recv(client,&buffer,1)) {
-		printk(KERN_WARNING "tda9875: I/O error, trying (read)\n");
-		return -1;
-	}
-	dprintk("Read 0x%02x\n", buffer);
-	return buffer;
-}
-#endif
 
 static int i2c_read_register(struct i2c_adapter *adap, int addr, int reg)
 {
diff -u linux-2.6.13/drivers/media/video/tvaudio.c linux/drivers/media/video/tvaudio.c
--- linux-2.6.13/drivers/media/video/tvaudio.c	2005-07-06 00:46:33.000000000 -0300
+++ linux/drivers/media/video/tvaudio.c	2005-07-07 20:00:15.000000000 -0300
@@ -864,13 +864,8 @@
 		 * But changing the mode to VIDEO_SOUND_MONO would switch
 		 * external 4052 multiplexer in audio_hook().
 		 */
-#if 0
-		if((nsr & 0x02) && !(dsr & 0x10)) /* NSR.S/MB=1 and DSR.AMSTAT=0 */
-			mode |= VIDEO_SOUND_STEREO;
-#else
 		if(nsr & 0x02) /* NSR.S/MB=1 */
 			mode |= VIDEO_SOUND_STEREO;
-#endif
 		if(nsr & 0x01) /* NSR.D/SB=1 */
 			mode |= VIDEO_SOUND_LANG1 | VIDEO_SOUND_LANG2;
 	} else {

--------------050206050606080202050501--
