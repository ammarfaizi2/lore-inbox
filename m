Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbVKESVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbVKESVE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVKESVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:21:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33041 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932177AbVKESUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:20:04 -0500
Date: Sat, 5 Nov 2005 18:19:59 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Convert ALSA
Message-ID: <20051105181959.GT14419@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105181122.GD12228@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105181122.GD12228@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform drivers to use struct platform_driver

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

unchanged:
--- b/sound/core/init.c
+++ b/sound/core/init.c
@@ -683,13 +683,14 @@
 #endif
 
 /* initialized in sound.c */
-struct device_driver snd_generic_driver = {
-	.name		= SND_GENERIC_NAME,
-	.bus		= &platform_bus_type,
+struct platform_driver snd_generic_driver = {
 #ifdef CONFIG_PM
 	.suspend	= snd_generic_suspend,
 	.resume		= snd_generic_resume,
 #endif
+	.driver		= {
+		.name	= SND_GENERIC_NAME,
+	},
 };
 
 void snd_generic_device_release(struct device *dev)
unchanged:
--- b/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -329,7 +329,7 @@ int __exit snd_minor_info_done(void)
  */
 
 #ifdef CONFIG_SND_GENERIC_DRIVER
-extern struct device_driver snd_generic_driver;
+extern struct platform_driver snd_generic_driver;
 #endif
 
 static int __init alsa_sound_init(void)
@@ -359,7 +359,7 @@ static int __init alsa_sound_init(void)
 	}
 	snd_info_minor_register();
 #ifdef CONFIG_SND_GENERIC_DRIVER
-	driver_register(&snd_generic_driver);
+	platform_driver_register(&snd_generic_driver);
 #endif
 	for (controlnum = 0; controlnum < cards_limit; controlnum++)
 		devfs_mk_cdev(MKDEV(major, controlnum<<5), S_IFCHR | device_mode, "snd/controlC%d", controlnum);
@@ -377,7 +377,7 @@ static void __exit alsa_sound_exit(void)
 		devfs_remove("snd/controlC%d", controlnum);
 
 #ifdef CONFIG_SND_GENERIC_DRIVER
-	driver_unregister(&snd_generic_driver);
+	platform_driver_unregister(&snd_generic_driver);
 #endif
 	snd_info_minor_unregister();
 	snd_info_done();


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
