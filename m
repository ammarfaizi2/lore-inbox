Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWDUEsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWDUEsv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWDUEoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:18562 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932254AbWDUEoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:20 -0400
Date: Thu, 20 Apr 2006 21:38:30 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       benh@kernel.crashing.org, Guido Guenther <agx@sigxcpu.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 08/22] PPC: fix oops in alsa powermac driver
Message-ID: <20060421043830.GI12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="re-ppc-fix-oops-in-alsa-powermac-driver.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this fixes an oops in 2.6.16.X when loading the snd_powermac module. The
name of the requested module changed during the 2.6.16 development cycle
from i2c-keylargo to i2c-powermac:

Signed-off-by: Guido Guenther <agx@sigxcpu.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/macintosh/therm_adt746x.c |    4 ++--
 sound/oss/dmasound/tas_common.c   |    4 ++--
 sound/ppc/daca.c                  |    2 +-
 sound/ppc/tumbler.c               |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.16.9.orig/drivers/macintosh/therm_adt746x.c
+++ linux-2.6.16.9/drivers/macintosh/therm_adt746x.c
@@ -627,8 +627,8 @@ thermostat_init(void)
 	if(therm_type == ADT7460)
 		device_create_file(&of_dev->dev, &dev_attr_sensor2_fan_speed);
 
-#ifndef CONFIG_I2C_KEYWEST
-	request_module("i2c-keywest");
+#ifndef CONFIG_I2C_POWERMAC
+	request_module("i2c-powermac");
 #endif
 
 	return i2c_add_driver(&thermostat_driver);
--- linux-2.6.16.9.orig/sound/oss/dmasound/tas_common.c
+++ linux-2.6.16.9/sound/oss/dmasound/tas_common.c
@@ -195,8 +195,8 @@ tas_init(int driver_id, const char *driv
 
 	printk(KERN_INFO "tas driver [%s])\n", driver_name);
 
-#ifndef CONFIG_I2C_KEYWEST
-	request_module("i2c-keywest");
+#ifndef CONFIG_I2C_POWERMAC
+	request_module("i2c-powermac");
 #endif
 	tas_node = find_devices("deq");
 	if (tas_node == NULL)
--- linux-2.6.16.9.orig/sound/ppc/daca.c
+++ linux-2.6.16.9/sound/ppc/daca.c
@@ -256,7 +256,7 @@ int __init snd_pmac_daca_init(struct snd
 
 #ifdef CONFIG_KMOD
 	if (current->fs->root)
-		request_module("i2c-keywest");
+		request_module("i2c-powermac");
 #endif /* CONFIG_KMOD */	
 
 	mix = kmalloc(sizeof(*mix), GFP_KERNEL);
--- linux-2.6.16.9.orig/sound/ppc/tumbler.c
+++ linux-2.6.16.9/sound/ppc/tumbler.c
@@ -1314,7 +1314,7 @@ int __init snd_pmac_tumbler_init(struct 
 
 #ifdef CONFIG_KMOD
 	if (current->fs->root)
-		request_module("i2c-keywest");
+		request_module("i2c-powermac");
 #endif /* CONFIG_KMOD */	
 
 	mix = kmalloc(sizeof(*mix), GFP_KERNEL);

--
