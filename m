Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264830AbSJVTza>; Tue, 22 Oct 2002 15:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264833AbSJVTza>; Tue, 22 Oct 2002 15:55:30 -0400
Received: from pacman.mweb.co.za ([196.2.45.77]:25287 "EHLO pacman.mweb.co.za")
	by vger.kernel.org with ESMTP id <S264830AbSJVTz0>;
	Tue, 22 Oct 2002 15:55:26 -0400
From: Bongani <bhlope@mweb.co.za>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [Patch] 2.5.44 Stop bttv_driver.c from flooding /var/log/messages
Date: Tue, 22 Oct 2002 22:02:22 +0200
User-Agent: KMail/1.4.7
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_O7at9uFUAOZsNAx"
Message-Id: <200210222202.22801.bhlope@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_O7at9uFUAOZsNAx
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi Alan

I have sent this patch to Gerd and I did not get any reply from him, so...
The bttv drivers are/were filling up my /var/log/messages file with the
following output

Oct 20 04:03:01 localhost kernel: bttv0: amux: mode=-1 audio=1 signal=no 
mux=4/1 irq=yes
Oct 20 04:03:01 localhost kernel: bttv0: amux: mode=-1 audio=1 signal=yes 
mux=1/1 irq=yes
Oct 20 04:03:08 localhost kernel: bttv0: amux: mode=-1 audio=1 signal=no 
mux=4/1 irq=yes

(Which seems to repeat three times a second for three seconds and waits 7 
second before printing the message again)

The following patch quites them down.

Thanx

--Boundary-00=_O7at9uFUAOZsNAx
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bttv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="bttv.patch"

--- linux-2.5/drivers/media/video/bttv-driver.c.old	2002-10-21 00:08:50.000000000 +0200
+++ linux-2.5/drivers/media/video/bttv-driver.c	2002-10-21 00:09:17.000000000 +0200
@@ -813,7 +813,7 @@
 	i2c_mux = mux = (btv->audio & AUDIO_MUTE) ? AUDIO_OFF : btv->audio;
 	if (btv->opt_automute && !signal && !btv->radio_user)
 		mux = AUDIO_OFF;
-	printk("bttv%d: amux: mode=%d audio=%d signal=%s mux=%d/%d irq=%s\n",
+	dprintk(KERN_DEBUG "bttv%d: amux: mode=%d audio=%d signal=%s mux=%d/%d irq=%s\n",
 	       btv->nr, mode, btv->audio, signal ? "yes" : "no",
 	       mux, i2c_mux, in_interrupt() ? "yes" : "no");
 

--Boundary-00=_O7at9uFUAOZsNAx--

