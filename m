Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143914AbRAHOrr>; Mon, 8 Jan 2001 09:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144108AbRAHOri>; Mon, 8 Jan 2001 09:47:38 -0500
Received: from monsoon.mail.pipex.net ([158.43.128.69]:58315 "HELO
	monsoon.mail.pipex.net") by vger.kernel.org with SMTP
	id <S143914AbRAHOrU>; Mon, 8 Jan 2001 09:47:20 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101081441.f08EfvP02088@wittsend.ukgateway.net>
Subject: Revised patch: Linux 2.4.0 ad1848 mixer ownership
To: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 8 Jan 2001 14:41:56 +0000 (GMT)
Reply-To: rankinc@zip.com.au
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="%--multipart-mixed-boundary-1.2077.978964916--%"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--%--multipart-mixed-boundary-1.2077.978964916--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This is a revised version of my ad1848 patch; instead of modifying the
static structures, update the "owner" fields in the audio_devs[] and
mixer_devs[] structures instead.

Chris

--%--multipart-mixed-boundary-1.2077.978964916--%
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Description: ASCII text
Content-Disposition: attachment; filename="ad1848-2.diff"

--- linux-vanilla/drivers/sound/ad1848.c	Fri Aug 11 16:26:43 2000
+++ linux-2.4.0-ac3/drivers/sound/ad1848.c	Mon Jan  8 14:32:39 2001
@@ -1900,9 +1900,6 @@
 	if(portc==NULL)
 		return -1;
 
-	if (owner)
-		ad1848_audio_driver.owner = owner;
-	
 	if ((my_dev = sound_install_audiodrv(AUDIO_DRIVER_VERSION,
 					     dev_name,
 					     &ad1848_audio_driver,
@@ -1920,6 +1917,8 @@
 	
 	audio_devs[my_dev]->portc = portc;
 	audio_devs[my_dev]->mixer_dev = -1;
+	if (owner)
+		audio_devs[my_dev]->d->owner = owner;
 	memset((char *) portc, 0, sizeof(*portc));
 
 	nr_ad1848_devs++;
@@ -1986,6 +1985,7 @@
 			if (sound_alloc_dma(dma_capture, devc->name))
 				printk(KERN_WARNING "ad1848.c: Can't allocate DMA%d\n", dma_capture);
 	}
+
 	if ((e = sound_install_mixer(MIXER_DRIVER_VERSION,
 				     dev_name,
 				     &ad1848_mixer_operations,
@@ -1993,6 +1993,8 @@
 				     devc)) >= 0)
 	{
 		audio_devs[my_dev]->mixer_dev = e;
+		if (owner)
+			mixer_devs[e]->owner = owner;
 	}
 	return my_dev;
 }

--%--multipart-mixed-boundary-1.2077.978964916--%--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
