Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbULHBOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbULHBOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 20:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbULHBOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 20:14:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13074 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261983AbULHBOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 20:14:22 -0500
Date: Wed, 8 Dec 2004 02:14:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] OSS: remove unused functions (fwd)
Message-ID: <20041208011416.GC5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:24:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] OSS: remove unused functions

The patch below removes some unused functions from OSS.


diffstat output:
 sound/oss/ad1889.c |   14 --------------
 sound/oss/cmpci.c  |    9 ---------
 sound/oss/cs46xx.c |   25 -------------------------
 sound/oss/ymfpci.c |    5 -----
 4 files changed, 53 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/sound/oss/ad1889.c.old	2004-10-28 23:45:24.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/sound/oss/ad1889.c	2004-10-28 23:44:59.000000000 +0200
@@ -82,20 +82,6 @@
 	ac97_codec->codec_write(dev->ac97_codec, AC97_POWER_CONTROL, 0);
 }
 
-static inline void ad1889_set_adc_rate(ad1889_dev_t *dev, int rate)
-{
-	struct ac97_codec *ac97_codec = dev->ac97_codec;
-
-	DBG("Setting ADC rate to %d\n", rate);
-	dev->state[AD_ADC_STATE].dmabuf.rate = rate;
-	AD1889_WRITEW(dev, AD_DSRES, rate);
-
-	/* Cycle the ADC to enable the new rate */
-	ac97_codec->codec_write(dev->ac97_codec, AC97_POWER_CONTROL, 0x0100);
-	WAIT_10MS();
-	ac97_codec->codec_write(dev->ac97_codec, AC97_POWER_CONTROL, 0);
-}
-
 static inline void ad1889_set_wav_fmt(ad1889_dev_t *dev, int fmt)
 {
 	u16 tmp;
--- linux-2.6.10-rc1-mm1-full/sound/oss/ymfpci.c.old	2004-10-28 23:45:45.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/sound/oss/ymfpci.c	2004-10-28 23:46:01.000000000 +0200
@@ -124,11 +124,6 @@
  *  common I/O routines
  */
 
-static inline u8 ymfpci_readb(ymfpci_t *codec, u32 offset)
-{
-	return readb(codec->reg_area_virt + offset);
-}
-
 static inline void ymfpci_writeb(ymfpci_t *codec, u32 offset, u8 val)
 {
 	writeb(val, codec->reg_area_virt + offset);
--- linux-2.6.10-rc1-mm1-full/sound/oss/cmpci.c.old	2004-10-28 23:46:25.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/sound/oss/cmpci.c	2004-10-28 23:46:41.000000000 +0200
@@ -1162,15 +1162,6 @@
 		enable_adc(s);
 }
 
-static inline void enable_dac(struct cm_state *s)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&s->lock, flags);
-	enable_dac_unlocked(s);
-	spin_unlock_irqrestore(&s->lock, flags);
-}
-
 static inline void stop_adc_unlocked(struct cm_state *s)
 {
 	if (s->enable & ENADC) {
--- linux-2.6.10-rc1-mm1-full/sound/oss/cs46xx.c.old	2004-10-28 23:47:27.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/sound/oss/cs46xx.c	2004-10-28 23:47:37.000000000 +0200
@@ -391,31 +391,6 @@
 static int cs46xx_suspend_tbl(struct pci_dev *pcidev, u32 state);
 static int cs46xx_resume_tbl(struct pci_dev *pcidev);
 
-static inline unsigned ld2(unsigned int x)
-{
-	unsigned r = 0;
-	
-	if (x >= 0x10000) {
-		x >>= 16;
-		r += 16;
-	}
-	if (x >= 0x100) {
-		x >>= 8;
-		r += 8;
-	}
-	if (x >= 0x10) {
-		x >>= 4;
-		r += 4;
-	}
-	if (x >= 4) {
-		x >>= 2;
-		r += 2;
-	}
-	if (x >= 2)
-		r++;
-	return r;
-}
-
 #if CSDEBUG
 
 /* DEBUG ROUTINES */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

