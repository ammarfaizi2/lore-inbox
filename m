Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265334AbUFHVal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265334AbUFHVal (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265348AbUFHV3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:29:55 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:51938 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S265334AbUFHVZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:25:05 -0400
Date: Wed, 9 Jun 2004 00:25:04 +0300
From: Pekka J Enberg <penberg@cs.helsinki.fi>
Message-Id: <200406082125.i58LP4Nm016207@melkki.cs.helsinki.fi>
Subject: [PATCH] ALSA: Remove subsystem-specific malloc (5/8)
To: linux-kernel@vger.kernel.org, tiwai@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace magic allocator in linux/sound/isa/ with kcalloc() and kfree().

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

 ad1816a/ad1816a_lib.c    |    4 ++--
 ad1848/ad1848_lib.c      |    4 ++--
 cs423x/cs4231_lib.c      |    4 ++--
 es1688/es1688_lib.c      |    4 ++--
 es18xx.c                 |    4 ++--
 gus/gus_main.c           |    4 ++--
 gus/gus_mem_proc.c       |    6 +++---
 gus/gus_pcm.c            |    4 ++--
 opl3sa2.c                |    4 ++--
 opti9xx/opti92x-ad1848.c |    4 ++--
 sb/emu8000.c             |    4 ++--
 sb/emu8000_pcm.c         |    2 +-
 sb/sb16_csp.c            |    4 ++--
 sb/sb_common.c           |    4 ++--
 14 files changed, 28 insertions(+), 28 deletions(-)

diff -X dontdiff -purN linux-2.6.6/sound/isa/ad1816a/ad1816a_lib.c alsa-2.6.6/sound/isa/ad1816a/ad1816a_lib.c
--- linux-2.6.6/sound/isa/ad1816a/ad1816a_lib.c	2004-06-08 23:57:24.521718264 +0300
+++ alsa-2.6.6/sound/isa/ad1816a/ad1816a_lib.c	2004-06-05 21:04:56.000000000 +0300
@@ -550,7 +550,7 @@ static int snd_ad1816a_free(ad1816a_t *c
 		snd_dma_disable(chip->dma2);
 		free_dma(chip->dma2);
 	}
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -585,7 +585,7 @@ int snd_ad1816a_create(snd_card_t *card,
 
 	*rchip = NULL;
 
-	chip = snd_magic_kcalloc(ad1816a_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	chip->irq = -1;
diff -X dontdiff -purN linux-2.6.6/sound/isa/ad1848/ad1848_lib.c alsa-2.6.6/sound/isa/ad1848/ad1848_lib.c
--- linux-2.6.6/sound/isa/ad1848/ad1848_lib.c	2004-06-08 23:57:24.613704280 +0300
+++ alsa-2.6.6/sound/isa/ad1848/ad1848_lib.c	2004-06-05 21:04:26.000000000 +0300
@@ -905,7 +905,7 @@ static int snd_ad1848_free(ad1848_t *chi
 		snd_dma_disable(chip->dma);
 		free_dma(chip->dma);
 	}
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -939,7 +939,7 @@ int snd_ad1848_create(snd_card_t * card,
 	int err;
 
 	*rchip = NULL;
-	chip = snd_magic_kcalloc(ad1848_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/isa/cs423x/cs4231_lib.c alsa-2.6.6/sound/isa/cs423x/cs4231_lib.c
--- linux-2.6.6/sound/isa/cs423x/cs4231_lib.c	2004-06-08 23:57:23.641852024 +0300
+++ alsa-2.6.6/sound/isa/cs423x/cs4231_lib.c	2004-06-05 21:07:30.000000000 +0300
@@ -1447,7 +1447,7 @@ static int snd_cs4231_free(cs4231_t *chi
 #endif
 	if (chip->timer)
 		snd_device_free(chip->card, chip->timer);
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -1487,7 +1487,7 @@ static int snd_cs4231_new(snd_card_t * c
 	cs4231_t *chip;
 
 	*rchip = NULL;
-	chip = snd_magic_kcalloc(cs4231_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	chip->hardware = hardware;
diff -X dontdiff -purN linux-2.6.6/sound/isa/es1688/es1688_lib.c alsa-2.6.6/sound/isa/es1688/es1688_lib.c
--- linux-2.6.6/sound/isa/es1688/es1688_lib.c	2004-06-08 23:57:24.565711576 +0300
+++ alsa-2.6.6/sound/isa/es1688/es1688_lib.c	2004-06-05 21:04:41.000000000 +0300
@@ -616,7 +616,7 @@ static int snd_es1688_free(es1688_t *chi
 		disable_dma(chip->dma8);
 		free_dma(chip->dma8);
 	}
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -650,7 +650,7 @@ int snd_es1688_create(snd_card_t * card,
 	int err;
 
 	*rchip = NULL;
-	chip = snd_magic_kcalloc(es1688_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	chip->irq = -1;
diff -X dontdiff -purN linux-2.6.6/sound/isa/es18xx.c alsa-2.6.6/sound/isa/es18xx.c
--- linux-2.6.6/sound/isa/es18xx.c	2004-06-08 23:57:24.690692576 +0300
+++ alsa-2.6.6/sound/isa/es18xx.c	2004-06-05 21:04:11.000000000 +0300
@@ -1705,7 +1705,7 @@ static int snd_es18xx_free(es18xx_t *chi
 		disable_dma(chip->dma2);
 		free_dma(chip->dma2);
 	}
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -1729,7 +1729,7 @@ static int __devinit snd_es18xx_new_devi
 	int err;
 
 	*rchip = NULL;
-        chip = snd_magic_kcalloc(es18xx_t, 0, GFP_KERNEL);
+        chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/isa/gus/gus_main.c alsa-2.6.6/sound/isa/gus/gus_main.c
--- linux-2.6.6/sound/isa/gus/gus_main.c	2004-06-08 23:57:23.728838800 +0300
+++ alsa-2.6.6/sound/isa/gus/gus_main.c	2004-06-05 21:07:06.000000000 +0300
@@ -133,7 +133,7 @@ static int snd_gus_free(snd_gus_card_t *
 		disable_dma(gus->gf1.dma2);
 		free_dma(gus->gf1.dma2);
 	}
-	snd_magic_kfree(gus);
+	kfree(gus);
 	return 0;
 }
 
@@ -159,7 +159,7 @@ int snd_gus_create(snd_card_t * card,
 	};
 
 	*rgus = NULL;
-	gus = snd_magic_kcalloc(snd_gus_card_t, 0, GFP_KERNEL);
+	gus = kcalloc(sizeof(*gus), GFP_KERNEL);
 	if (gus == NULL)
 		return -ENOMEM;
 	gus->gf1.irq = -1;
diff -X dontdiff -purN linux-2.6.6/sound/isa/gus/gus_mem_proc.c alsa-2.6.6/sound/isa/gus/gus_mem_proc.c
--- linux-2.6.6/sound/isa/gus/gus_mem_proc.c	2004-06-08 23:57:23.990798976 +0300
+++ alsa-2.6.6/sound/isa/gus/gus_mem_proc.c	2004-06-05 21:06:31.000000000 +0300
@@ -81,7 +81,7 @@ static long long snd_gf1_mem_proc_llseek
 static void snd_gf1_mem_proc_free(snd_info_entry_t *entry)
 {
 	gus_proc_private_t *priv = snd_magic_cast(gus_proc_private_t, entry->private_data, return);
-	snd_magic_kfree(priv);
+	kfree(priv);
 }
 
 static struct snd_info_entry_ops snd_gf1_mem_proc_ops = {
@@ -98,7 +98,7 @@ int snd_gf1_mem_proc_init(snd_gus_card_t
 
 	for (idx = 0; idx < 4; idx++) {
 		if (gus->gf1.mem_alloc.banks_8[idx].size > 0) {
-			priv = snd_magic_kcalloc(gus_proc_private_t, 0, GFP_KERNEL);
+			priv = kcalloc(sizeof(*priv), GFP_KERNEL);
 			if (priv == NULL)
 				return -ENOMEM;
 			priv->gus = gus;
@@ -115,7 +115,7 @@ int snd_gf1_mem_proc_init(snd_gus_card_t
 	}
 	for (idx = 0; idx < 4; idx++) {
 		if (gus->gf1.rom_present & (1 << idx)) {
-			priv = snd_magic_kcalloc(gus_proc_private_t, 0, GFP_KERNEL);
+			priv = kcalloc(sizeof(*priv), GFP_KERNEL);
 			if (priv == NULL)
 				return -ENOMEM;
 			priv->rom = 1;
diff -X dontdiff -purN linux-2.6.6/sound/isa/gus/gus_pcm.c alsa-2.6.6/sound/isa/gus/gus_pcm.c
--- linux-2.6.6/sound/isa/gus/gus_pcm.c	2004-06-08 23:57:23.857819192 +0300
+++ alsa-2.6.6/sound/isa/gus/gus_pcm.c	2004-06-05 21:06:50.000000000 +0300
@@ -658,7 +658,7 @@ static snd_pcm_hardware_t snd_gf1_pcm_ca
 static void snd_gf1_pcm_playback_free(snd_pcm_runtime_t *runtime)
 {
 	gus_pcm_private_t * pcmp = snd_magic_cast(gus_pcm_private_t, runtime->private_data, return);
-	snd_magic_kfree(pcmp);
+	kfree(pcmp);
 }
 
 static int snd_gf1_pcm_playback_open(snd_pcm_substream_t *substream)
@@ -668,7 +668,7 @@ static int snd_gf1_pcm_playback_open(snd
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	int err;
 
-	pcmp = snd_magic_kcalloc(gus_pcm_private_t, 0, GFP_KERNEL);
+	pcmp = kcalloc(sizeof(*pcmp), GFP_KERNEL);
 	if (pcmp == NULL)
 		return -ENOMEM;
 	pcmp->gus = gus;
diff -X dontdiff -purN linux-2.6.6/sound/isa/opl3sa2.c alsa-2.6.6/sound/isa/opl3sa2.c
--- linux-2.6.6/sound/isa/opl3sa2.c	2004-06-08 23:57:24.812674032 +0300
+++ alsa-2.6.6/sound/isa/opl3sa2.c	2004-06-05 21:03:59.000000000 +0300
@@ -698,7 +698,7 @@ static int snd_opl3sa2_free(opl3sa2_t *c
 		release_resource(chip->res_port);
 		kfree_nocheck(chip->res_port);
 	}
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -749,7 +749,7 @@ static int __devinit snd_opl3sa2_probe(i
 		return -ENOMEM;
 	strcpy(card->driver, "OPL3SA2");
 	strcpy(card->shortname, "Yamaha OPL3-SA2");
-	chip = snd_magic_kcalloc(opl3sa2_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		err = -ENOMEM;
 		goto __error;
diff -X dontdiff -purN linux-2.6.6/sound/isa/opti9xx/opti92x-ad1848.c alsa-2.6.6/sound/isa/opti9xx/opti92x-ad1848.c
--- linux-2.6.6/sound/isa/opti9xx/opti92x-ad1848.c	2004-06-08 23:57:24.453728600 +0300
+++ alsa-2.6.6/sound/isa/opti9xx/opti92x-ad1848.c	2004-06-05 21:05:24.000000000 +0300
@@ -1270,7 +1270,7 @@ static int snd_opti93x_free(opti93x_t *c
 	if (chip->irq >= 0) {
 	  free_irq(chip->irq, chip);
 	}
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -1301,7 +1301,7 @@ int snd_opti93x_create(snd_card_t *card,
 	opti93x_t *codec;
 
 	*rcodec = NULL;
-	codec = snd_magic_kcalloc(opti93x_t, 0, GFP_KERNEL);
+	codec = kcalloc(sizeof(*codec), GFP_KERNEL);
 	if (codec == NULL)
 		return -ENOMEM;
 	codec->irq = -1;
diff -X dontdiff -purN linux-2.6.6/sound/isa/sb/emu8000.c alsa-2.6.6/sound/isa/sb/emu8000.c
--- linux-2.6.6/sound/isa/sb/emu8000.c	2004-06-08 23:57:24.174771008 +0300
+++ alsa-2.6.6/sound/isa/sb/emu8000.c	2004-06-05 21:06:04.000000000 +0300
@@ -1070,7 +1070,7 @@ static int snd_emu8000_free(emu8000_t *h
 		release_resource(hw->res_port3);
 		kfree_nocheck(hw->res_port3);
 	}
-	snd_magic_kfree(hw);
+	kfree(hw);
 	return 0;
 }
 
@@ -1101,7 +1101,7 @@ snd_emu8000_new(snd_card_t *card, int in
 	if (seq_ports <= 0)
 		return 0;
 
-	hw = snd_magic_kcalloc(emu8000_t, 0, GFP_KERNEL);
+	hw = kcalloc(sizeof(*hw), GFP_KERNEL);
 	if (hw == NULL)
 		return -ENOMEM;
 	spin_lock_init(&hw->reg_lock);
diff -X dontdiff -purN linux-2.6.6/sound/isa/sb/emu8000_pcm.c alsa-2.6.6/sound/isa/sb/emu8000_pcm.c
--- linux-2.6.6/sound/isa/sb/emu8000_pcm.c	2004-06-08 23:57:24.263757480 +0300
+++ alsa-2.6.6/sound/isa/sb/emu8000_pcm.c	2004-06-05 20:41:10.000000000 +0300
@@ -235,7 +235,7 @@ static int emu8k_pcm_open(snd_pcm_substr
 	emu8k_pcm_t *rec;
 	snd_pcm_runtime_t *runtime = subs->runtime;
 
-	rec = snd_kcalloc(sizeof(*rec), GFP_KERNEL);
+	rec = kcalloc(sizeof(*rec), GFP_KERNEL);
 	if (! rec)
 		return -ENOMEM;
 
diff -X dontdiff -purN linux-2.6.6/sound/isa/sb/sb16_csp.c alsa-2.6.6/sound/isa/sb/sb16_csp.c
--- linux-2.6.6/sound/isa/sb/sb16_csp.c	2004-06-08 23:57:24.264757328 +0300
+++ alsa-2.6.6/sound/isa/sb/sb16_csp.c	2004-06-05 21:05:51.000000000 +0300
@@ -127,7 +127,7 @@ int snd_sb_csp_new(sb_t *chip, int devic
 	if ((err = snd_hwdep_new(chip->card, "SB16-CSP", device, &hw)) < 0)
 		return err;
 
-	if ((p = snd_magic_kcalloc(snd_sb_csp_t, 0, GFP_KERNEL)) == NULL) {
+	if ((p = kcalloc(sizeof(*p), GFP_KERNEL)) == NULL) {
 		snd_device_free(chip->card, hw);
 		return -ENOMEM;
 	}
@@ -169,7 +169,7 @@ static void snd_sb_csp_free(snd_hwdep_t 
 	if (p) {
 		if (p->running & SNDRV_SB_CSP_ST_RUNNING)
 			snd_sb_csp_stop(p);
-		snd_magic_kfree(p);
+		kfree(p);
 	}
 }
 
diff -X dontdiff -purN linux-2.6.6/sound/isa/sb/sb_common.c alsa-2.6.6/sound/isa/sb/sb_common.c
--- linux-2.6.6/sound/isa/sb/sb_common.c	2004-06-08 23:57:24.287753832 +0300
+++ alsa-2.6.6/sound/isa/sb/sb_common.c	2004-06-05 21:05:36.000000000 +0300
@@ -197,7 +197,7 @@ static int snd_sbdsp_free(sb_t *chip)
 		free_dma(chip->dma16);
 	}
 #endif
-	snd_magic_kfree(chip);
+	kfree(chip);
 	return 0;
 }
 
@@ -224,7 +224,7 @@ int snd_sbdsp_create(snd_card_t *card,
 
 	snd_assert(r_chip != NULL, return -EINVAL);
 	*r_chip = NULL;
-	chip = snd_magic_kcalloc(sb_t, 0, GFP_KERNEL);
+	chip = kcalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
