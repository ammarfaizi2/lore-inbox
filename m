Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264645AbSJTWQU>; Sun, 20 Oct 2002 18:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbSJTWQU>; Sun, 20 Oct 2002 18:16:20 -0400
Received: from pacman.mweb.co.za ([196.2.45.77]:25793 "EHLO pacman.mweb.co.za")
	by vger.kernel.org with ESMTP id <S264645AbSJTWQS>;
	Sun, 20 Oct 2002 18:16:18 -0400
From: Bongani <bhlope@mweb.co.za>
To: kraxel@bytesex.org
Subject: [PATCH] 2.5.44 bttv-driver.c
Date: Mon, 21 Oct 2002 00:23:10 +0200
User-Agent: KMail/1.4.7
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200210210023.10640.bhlope@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd

You are listing as the maintainer of the bttv driver, so I hope I'm sending
this to the correct person. The bttv drivers are printing the following
following "debug" information, which is filling up my messages file the patch
bellow seems to fix it.

Oct 20 04:03:01 localhost kernel: bttv0: amux: mode=-1 audio=1 signal=no 
mux=4/1 irq=yes
Oct 20 04:03:01 localhost kernel: bttv0: amux: mode=-1 audio=1 signal=yes 
mux=1/1 irq=yes
Oct 20 04:03:08 localhost kernel: bttv0: amux: mode=-1 audio=1 signal=no 
mux=4/1 irq=yes
Oct 20 04:03:08 localhost kernel: bttv0: amux: mode=-1 audio=1 signal=yes 
mux=1/1 irq=yes
Oct 20 04:03:09 localhost kernel: bttv0: amux: mode=-1 audio=1 signal=no 
mux=4/1 irq=yes
Oct 20 04:03:09 localhost kernel: bttv0: amux: mode=-1 audio=1 signal=yes 
mux=1/1 irq=yes
Oct 20 04:03:10 localhost kernel: bttv0: amux: mode=-1 audio=1 signal=no 
mux=4/1 irq=yes

Could you please foward the patch to Linus.(If you think its correct that is 
;)

Thanx

--- linux-2.5/drivers/media/video/bttv-driver.c.old     2002-10-21 
00:08:50.000000000 +0200
+++ linux-2.5/drivers/media/video/bttv-driver.c 2002-10-21 00:09:17.000000000 
+0200
@@ -813,7 +813,7 @@
        i2c_mux = mux = (btv->audio & AUDIO_MUTE) ? AUDIO_OFF : btv->audio;
        if (btv->opt_automute && !signal && !btv->radio_user)
                mux = AUDIO_OFF;
-       printk("bttv%d: amux: mode=%d audio=%d signal=%s mux=%d/%d irq=%s\n",
+       dprintk(KERN_DEBUG "bttv%d: amux: mode=%d audio=%d signal=%s mux=%d/%d 
irq=%s\n",
               btv->nr, mode, btv->audio, signal ? "yes" : "no",
               mux, i2c_mux, in_interrupt() ? "yes" : "no");


