Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVLCP5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVLCP5m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVLCP51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:57:27 -0500
Received: from aveiro.procergs.com.br ([200.198.128.42]:47030 "EHLO
	aveiro.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751287AbVLCP5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:57:17 -0500
Cc: Otavio Salvador <otavio@debian.org>
Subject: [PATCH 1/11] OSS: replace all uses of pci_module_init with pci_register_driver
In-Reply-To: 
X-Mailer: git-send-email
Date: Sat, 3 Dec 2005 13:57:10 -0200
Message-Id: <11336254302237-git-send-email-otavio@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Otavio Salvador <otavio@debian.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Otavio Salvador <otavio@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace all calls to pci_module_init, that's deprecated and
will be removed in future, with pci_register_driver that should be
the used function now.

Signed-off-by: Otavio Salvador <otavio@debian.org>


---

 sound/oss/ad1889.c         |    2 +-
 sound/oss/btaudio.c        |    2 +-
 sound/oss/cmpci.c          |    2 +-
 sound/oss/cs4281/cs4281m.c |    2 +-
 sound/oss/cs46xx.c         |    2 +-
 sound/oss/emu10k1/main.c   |    2 +-
 sound/oss/es1370.c         |    2 +-
 sound/oss/es1371.c         |    4 ++--
 sound/oss/ite8172.c        |    2 +-
 sound/oss/kahlua.c         |    2 +-
 sound/oss/maestro.c        |    2 +-
 sound/oss/nec_vrc5477.c    |    2 +-
 sound/oss/nm256_audio.c    |    2 +-
 sound/oss/rme96xx.c        |    2 +-
 sound/oss/sonicvibes.c     |    2 +-
 sound/oss/ymfpci.c         |    2 +-
 16 files changed, 17 insertions(+), 17 deletions(-)

applies-to: 06378a021f5873003a07f0388aa0cb6e81a32c19
d9850fb29c5e82534c4c6a93b18cb56bcbc28025
diff --git a/sound/oss/ad1889.c b/sound/oss/ad1889.c
index 2cfd214..a0d73f3 100644
--- a/sound/oss/ad1889.c
+++ b/sound/oss/ad1889.c
@@ -1089,7 +1089,7 @@ static struct pci_driver ad1889_driver =
 
 static int __init ad1889_init_module(void)
 {
-	return pci_module_init(&ad1889_driver);
+	return pci_register_driver(&ad1889_driver);
 }
 
 static void ad1889_exit_module(void)
diff --git a/sound/oss/btaudio.c b/sound/oss/btaudio.c
index a85093f..4007a56 100644
--- a/sound/oss/btaudio.c
+++ b/sound/oss/btaudio.c
@@ -1101,7 +1101,7 @@ static int btaudio_init_module(void)
 	       digital ? "digital" : "",
 	       analog && digital ? "+" : "",
 	       analog ? "analog" : "");
-	return pci_module_init(&btaudio_pci_driver);
+	return pci_register_driver(&btaudio_pci_driver);
 }
 
 static void btaudio_cleanup_module(void)
diff --git a/sound/oss/cmpci.c b/sound/oss/cmpci.c
index 74dcca7..7cfbb08 100644
--- a/sound/oss/cmpci.c
+++ b/sound/oss/cmpci.c
@@ -3366,7 +3366,7 @@ static struct pci_driver cm_driver = {
 static int __init init_cmpci(void)
 {
 	printk(KERN_INFO "cmpci: version $Revision: 6.82 $ time " __TIME__ " " __DATE__ "\n");
-	return pci_module_init(&cm_driver);
+	return pci_register_driver(&cm_driver);
 }
 
 static void __exit cleanup_cmpci(void)
diff --git a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
index adc6896..872f0f4 100644
--- a/sound/oss/cs4281/cs4281m.c
+++ b/sound/oss/cs4281/cs4281m.c
@@ -4477,7 +4477,7 @@ static int __init cs4281_init_module(voi
 	printk(KERN_INFO "cs4281: version v%d.%02d.%d time " __TIME__ " "
 	       __DATE__ "\n", CS4281_MAJOR_VERSION, CS4281_MINOR_VERSION,
 	       CS4281_ARCH);
-	rtn = pci_module_init(&cs4281_pci_driver);
+	rtn = pci_register_driver(&cs4281_pci_driver);
 
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2,
 		  printk(KERN_INFO "cs4281: cs4281_init_module()- (%d)\n",rtn));
diff --git a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
index cb998e8..b36a52d 100644
--- a/sound/oss/cs46xx.c
+++ b/sound/oss/cs46xx.c
@@ -5711,7 +5711,7 @@ static int __init cs46xx_init_module(voi
 	int rtn = 0;
 	CS_DBGOUT(CS_INIT | CS_FUNCTION, 2, printk(KERN_INFO 
 		"cs46xx: cs46xx_init_module()+ \n"));
-	rtn = pci_module_init(&cs46xx_pci_driver);
+	rtn = pci_register_driver(&cs46xx_pci_driver);
 
 	if(rtn == -ENODEV)
 	{
diff --git a/sound/oss/emu10k1/main.c b/sound/oss/emu10k1/main.c
index 9b905ba..23241cb 100644
--- a/sound/oss/emu10k1/main.c
+++ b/sound/oss/emu10k1/main.c
@@ -1428,7 +1428,7 @@ static int __init emu10k1_init_module(vo
 {
 	printk(KERN_INFO "Creative EMU10K1 PCI Audio Driver, version " DRIVER_VERSION ", " __TIME__ " " __DATE__ "\n");
 
-	return pci_module_init(&emu10k1_pci_driver);
+	return pci_register_driver(&emu10k1_pci_driver);
 }
 
 static void __exit emu10k1_cleanup_module(void)
diff --git a/sound/oss/es1370.c b/sound/oss/es1370.c
index 8538085..ae55c53 100644
--- a/sound/oss/es1370.c
+++ b/sound/oss/es1370.c
@@ -2779,7 +2779,7 @@ static struct pci_driver es1370_driver =
 static int __init init_es1370(void)
 {
 	printk(KERN_INFO "es1370: version v0.38 time " __TIME__ " " __DATE__ "\n");
-	return pci_module_init(&es1370_driver);
+	return pci_register_driver(&es1370_driver);
 }
 
 static void __exit cleanup_es1370(void)
diff --git a/sound/oss/es1371.c b/sound/oss/es1371.c
index 12a56d5..f770df8 100644
--- a/sound/oss/es1371.c
+++ b/sound/oss/es1371.c
@@ -94,7 +94,7 @@
  *    07.02.2000   0.24  Use pci_alloc_consistent and pci_register_driver
  *    07.02.2000   0.25  Use ac97_codec
  *    01.03.2000   0.26  SPDIF patch by Mikael Bouillot <mikael.bouillot@bigfoot.com>
- *                       Use pci_module_init
+ *                       Use pci_register_driver
  *    21.11.2000   0.27  Initialize dma buffers in poll, otherwise poll may return a bogus mask
  *    12.12.2000   0.28  More dma buffer initializations, patch from
  *                       Tjeerd Mulder <tjeerd.mulder@fujitsu-siemens.com>
@@ -3090,7 +3090,7 @@ static struct pci_driver es1371_driver =
 static int __init init_es1371(void)
 {
 	printk(KERN_INFO PFX "version v0.32 time " __TIME__ " " __DATE__ "\n");
-	return pci_module_init(&es1371_driver);
+	return pci_register_driver(&es1371_driver);
 }
 
 static void __exit cleanup_es1371(void)
diff --git a/sound/oss/ite8172.c b/sound/oss/ite8172.c
index 26e5944..8fd2f9a 100644
--- a/sound/oss/ite8172.c
+++ b/sound/oss/ite8172.c
@@ -2206,7 +2206,7 @@ static struct pci_driver it8172_driver =
 static int __init init_it8172(void)
 {
 	info("version v0.5 time " __TIME__ " " __DATE__);
-	return pci_module_init(&it8172_driver);
+	return pci_register_driver(&it8172_driver);
 }
 
 static void __exit cleanup_it8172(void)
diff --git a/sound/oss/kahlua.c b/sound/oss/kahlua.c
index 808c5ef..2835a7c 100644
--- a/sound/oss/kahlua.c
+++ b/sound/oss/kahlua.c
@@ -218,7 +218,7 @@ static struct pci_driver kahlua_driver =
 static int __init kahlua_init_module(void)
 {
 	printk(KERN_INFO "Cyrix Kahlua VSA1 XpressAudio support (c) Copyright 2003 Red Hat Inc\n");
-	return pci_module_init(&kahlua_driver);
+	return pci_register_driver(&kahlua_driver);
 }
 
 static void __devexit kahlua_cleanup_module(void)
diff --git a/sound/oss/maestro.c b/sound/oss/maestro.c
index 3abd354..af63ebe 100644
--- a/sound/oss/maestro.c
+++ b/sound/oss/maestro.c
@@ -3634,7 +3634,7 @@ static int __init init_maestro(void)
 {
 	int rc;
 
-	rc = pci_module_init(&maestro_pci_driver);
+	rc = pci_register_driver(&maestro_pci_driver);
 	if (rc < 0)
 		return rc;
 
diff --git a/sound/oss/nec_vrc5477.c b/sound/oss/nec_vrc5477.c
index 9ac4bf7..fbb9170 100644
--- a/sound/oss/nec_vrc5477.c
+++ b/sound/oss/nec_vrc5477.c
@@ -2045,7 +2045,7 @@ static struct pci_driver vrc5477_ac97_dr
 static int __init init_vrc5477_ac97(void)
 {
 	printk("Vrc5477 AC97 driver: version v0.2 time " __TIME__ " " __DATE__ " by Jun Sun\n");
-	return pci_module_init(&vrc5477_ac97_driver);
+	return pci_register_driver(&vrc5477_ac97_driver);
 }
 
 static void __exit cleanup_vrc5477_ac97(void)
diff --git a/sound/oss/nm256_audio.c b/sound/oss/nm256_audio.c
index 0ce2c40..dcb1d1f 100644
--- a/sound/oss/nm256_audio.c
+++ b/sound/oss/nm256_audio.c
@@ -1690,7 +1690,7 @@ module_param(force_load, bool, 0);
 static int __init do_init_nm256(void)
 {
     printk (KERN_INFO "NeoMagic 256AV/256ZX audio driver, version 1.1p\n");
-    return pci_module_init(&nm256_pci_driver);
+    return pci_register_driver(&nm256_pci_driver);
 }
 
 static void __exit cleanup_nm256 (void)
diff --git a/sound/oss/rme96xx.c b/sound/oss/rme96xx.c
index 318dc51..faa0b79 100644
--- a/sound/oss/rme96xx.c
+++ b/sound/oss/rme96xx.c
@@ -1095,7 +1095,7 @@ static int __init init_rme96xx(void)
 	devices = ((devices-1) & RME96xx_MASK_DEVS) + 1;
 	printk(KERN_INFO RME_MESS" reserving %d dsp device(s)\n",devices);
         numcards = 0;
-	return pci_module_init(&rme96xx_driver);
+	return pci_register_driver(&rme96xx_driver);
 }
 
 static void __exit cleanup_rme96xx(void)
diff --git a/sound/oss/sonicvibes.c b/sound/oss/sonicvibes.c
index 17d0e46..71b05e2 100644
--- a/sound/oss/sonicvibes.c
+++ b/sound/oss/sonicvibes.c
@@ -2765,7 +2765,7 @@ static int __init init_sonicvibes(void)
 	if (!(wavetable_mem = __get_free_pages(GFP_KERNEL, 20-PAGE_SHIFT)))
 		printk(KERN_INFO "sv: cannot allocate 1MB of contiguous nonpageable memory for wavetable data\n");
 #endif
-	return pci_module_init(&sv_driver);
+	return pci_register_driver(&sv_driver);
 }
 
 static void __exit cleanup_sonicvibes(void)
diff --git a/sound/oss/ymfpci.c b/sound/oss/ymfpci.c
index 8dae59b..f8bd72e 100644
--- a/sound/oss/ymfpci.c
+++ b/sound/oss/ymfpci.c
@@ -2680,7 +2680,7 @@ static struct pci_driver ymfpci_driver =
 
 static int __init ymf_init_module(void)
 {
-	return pci_module_init(&ymfpci_driver);
+	return pci_register_driver(&ymfpci_driver);
 }
 
 static void __exit ymf_cleanup_module (void)
---
0.99.9k


