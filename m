Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbTANPYS>; Tue, 14 Jan 2003 10:24:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTANPYS>; Tue, 14 Jan 2003 10:24:18 -0500
Received: from exzh001.alcatel.ch ([212.243.156.171]:11789 "HELO
	exzh001.alcatel.ch") by vger.kernel.org with SMTP
	id <S263899AbTANPYP> convert rfc822-to-8bit; Tue, 14 Jan 2003 10:24:15 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Daniel Ritz <daniel.ritz@gmx.ch>
Subject: [PATCH 2.5] sound/isa/opl3sa2.c compile fix
Date: Tue, 14 Jan 2003 16:30:57 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Message-Id: <200301141630.57978.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

patch to fix the broken compile of sound/isa/opl3sa2.c sound driver.
against 2.5.58. please apply...

rgds,
-daniel



--- 2558/sound/isa/opl3sa2.c_	2003-01-14 11:38:59.000000000 +0100
+++ 2558/sound/isa/opl3sa2.c	2003-01-14 15:09:53.000000000 +0100
@@ -162,9 +162,9 @@
 #ifdef CONFIG_PNP
 
 static struct pnp_card *snd_opl3sa2_isapnp_cards[SNDRV_CARDS] = 
SNDRV_DEFAULT_PTR;
-static const struct pnp_card_id *snd_opl3sa2_isapnp_id[SNDRV_CARDS] = 
SNDRV_DEFAULT_PTR;
+static const struct pnp_card_device_id *snd_opl3sa2_isapnp_id[SNDRV_CARDS] = 
SNDRV_DEFAULT_PTR;
 
-static struct pnp_card_id snd_opl3sa2_pnpids[] = {
+static struct pnp_card_device_id snd_opl3sa2_pnpids[] = {
 	/* Yamaha YMF719E-S (Genius Sound Maker 3DX) */
 	{.id = "YMH0020", .driver_data = 0, devs : { {.id="YMH0021"}, } },
 	/* Yamaha OPL3-SA3 (integrated on Intel's Pentium II AL440LX motherboard) */
@@ -627,7 +627,7 @@
 #ifdef CONFIG_PNP
 static int __init snd_opl3sa2_isapnp(int dev, opl3sa2_t *chip)
 {
-        const struct pnp_card_id *id = snd_opl3sa2_isapnp_id[dev];
+        const struct pnp_card_device_id *id = snd_opl3sa2_isapnp_id[dev];
         struct pnp_card *card = snd_opl3sa2_isapnp_cards[dev];
 	struct pnp_dev *pdev;
 
@@ -637,14 +637,14 @@
 		snd_printdd("isapnp OPL3-SA: a card was found but it did not contain the 
needed devices\n");
 		return -ENODEV;
 	}
-	sb_port[dev] = pdev->resource[0].start;
-	wss_port[dev] = pdev->resource[1].start;
-	fm_port[dev] = pdev->resource[2].start;
-	midi_port[dev] = pdev->resource[3].start;
-	port[dev] = pdev->resource[4].start;
-	dma1[dev] = pdev->dma_resource[0].start;
-	dma2[dev] = pdev->dma_resource[1].start;
-	irq[dev] = pdev->irq_resource[0].start;
+	sb_port[dev] = pnp_port_start(pdev, 0);
+	wss_port[dev] = pnp_port_start(pdev, 1);
+	fm_port[dev] = pnp_port_start(pdev, 2);
+	midi_port[dev] = pnp_port_start(pdev, 3);
+	port[dev] = pnp_port_start(pdev, 4);
+	dma1[dev] = pnp_dma(pdev, 0);
+	dma2[dev] = pnp_dma(pdev, 1);
+	irq[dev] = pnp_irq(pdev, 0);
 	snd_printdd("isapnp OPL3-SA: sb port=0x%lx, wss port=0x%lx, fm port=0x%lx, 
midi port=0x%lx\n",
 		sb_port[dev], wss_port[dev], fm_port[dev], midi_port[dev]);
 	snd_printdd("isapnp OPL3-SA: control port=0x%lx, dma1=%i, dma2=%i, 
irq=%i\n",
@@ -816,7 +816,7 @@
 
 #ifdef CONFIG_PNP
 static int __init snd_opl3sa2_isapnp_detect(struct pnp_card *card,
-					    const struct pnp_card_id *id)
+					    const struct pnp_card_device_id *id)
 {
         static int dev;
         int res;

