Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWDMBnX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWDMBnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 21:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbWDMBnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 21:43:22 -0400
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:64910 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932421AbWDMBnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 21:43:21 -0400
Message-ID: <443DAD1F.3070802@keyaccess.nl>
Date: Thu, 13 Apr 2006 03:45:03 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: ALSA devel <alsa-devel@alsa-project.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [ALSA STABLE 2/3] a few more -- continue on IS_ERR from platform
 device registration
Content-Type: multipart/mixed;
 boundary="------------000105060902020304040909"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000105060902020304040909
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

And continue-on-iserr for sound/drivers...

   sound/drivers/dummy.c         |   14 ++++----------
   sound/drivers/mpu401/mpu401.c |   14 ++++----------
   sound/drivers/serial-u16550.c |   14 ++++----------
   sound/drivers/virmidi.c       |   14 ++++----------
   4 files changed, 16 insertions(+), 40 deletions(-)

Signed-off-by: Rene Herman <rene.herman@keyaccess.nl>


--------------000105060902020304040909
Content-Type: text/plain;
 name="alsa_platform_iserr_remainder.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_iserr_remainder.diff"

Index: local/sound/drivers/mpu401/mpu401.c
===================================================================
--- local.orig/sound/drivers/mpu401/mpu401.c	2006-04-13 03:03:18.000000000 +0200
+++ local/sound/drivers/mpu401/mpu401.c	2006-04-13 03:11:35.000000000 +0200
@@ -250,10 +250,8 @@ static int __init alsa_card_mpu401_init(
 #endif
 		device = platform_device_register_simple(SND_MPU401_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		devices++;
 	}
@@ -266,14 +264,10 @@ static int __init alsa_card_mpu401_init(
 #ifdef MODULE
 		printk(KERN_ERR "MPU-401 device not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_mpu401_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_mpu401_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_mpu401_exit(void)
Index: local/sound/drivers/serial-u16550.c
===================================================================
--- local.orig/sound/drivers/serial-u16550.c	2006-04-13 03:03:50.000000000 +0200
+++ local/sound/drivers/serial-u16550.c	2006-04-13 03:11:35.000000000 +0200
@@ -995,10 +995,8 @@ static int __init alsa_card_serial_init(
 			continue;
 		device = platform_device_register_simple(SND_SERIAL_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -1006,14 +1004,10 @@ static int __init alsa_card_serial_init(
 #ifdef MODULE
 		printk(KERN_ERR "serial midi soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_serial_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_serial_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_serial_exit(void)
Index: local/sound/drivers/virmidi.c
===================================================================
--- local.orig/sound/drivers/virmidi.c	2006-04-13 03:04:17.000000000 +0200
+++ local/sound/drivers/virmidi.c	2006-04-13 03:11:35.000000000 +0200
@@ -169,10 +169,8 @@ static int __init alsa_card_virmidi_init
 			continue;
 		device = platform_device_register_simple(SND_VIRMIDI_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -180,14 +178,10 @@ static int __init alsa_card_virmidi_init
 #ifdef MODULE
 		printk(KERN_ERR "Card-VirMIDI soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_virmidi_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_virmidi_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_virmidi_exit(void)
Index: local/sound/drivers/dummy.c
===================================================================
--- local.orig/sound/drivers/dummy.c	2006-04-13 03:02:43.000000000 +0200
+++ local/sound/drivers/dummy.c	2006-04-13 03:11:35.000000000 +0200
@@ -675,10 +675,8 @@ static int __init alsa_card_dummy_init(v
 			continue;
 		device = platform_device_register_simple(SND_DUMMY_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -686,14 +684,10 @@ static int __init alsa_card_dummy_init(v
 #ifdef MODULE
 		printk(KERN_ERR "Dummy soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_dummy_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_dummy_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_dummy_exit(void)


--------------000105060902020304040909--
