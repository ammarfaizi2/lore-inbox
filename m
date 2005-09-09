Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbVIISL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbVIISL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 14:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbVIISL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 14:11:58 -0400
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:12227 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030313AbVIISL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 14:11:57 -0400
Date: Fri, 9 Sep 2005 14:09:17 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Brand-new notebook useless with Linux...
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       alsa-devel <alsa-devel@alsa-project.org>
Message-ID: <200509091411_MC3-1-A9B0-1C0C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1126207905.12697.20.camel@mindpipe>

On Thu, 08 Sep 2005 at 15:31:44 -0400, Lee Revell wrote:

> Wait, that sounds like the modem, not the AC97 audio codec.
>
> You might be able to get the modem to work with the (proprietary)
> slmodem software modem, or something.  I wouldn't count on it though.
> 
> Does your sound work?


 Well I'll be...

 I'd assumed from the (confusing) messages that the sound card was
not working, but it seems fine.  Shouldn't the error messages from
atiixp-modem be prefixed with that name instead of "atiixp"?

Untested patch follows.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 sound/pci/atiixp_modem.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

--- 2.6.13a.orig/sound/pci/atiixp_modem.c
+++ 2.6.13a/sound/pci/atiixp_modem.c
@@ -405,7 +405,7 @@ static int snd_atiixp_acquire_codec(atii
 
 	while (atiixp_read(chip, PHYS_OUT_ADDR) & ATI_REG_PHYS_OUT_ADDR_EN) {
 		if (! timeout--) {
-			snd_printk(KERN_WARNING "atiixp: codec acquire timeout\n");
+			snd_printk(KERN_WARNING "atiixp-modem: codec acquire timeout\n");
 			return -EBUSY;
 		}
 		udelay(1);
@@ -436,7 +436,7 @@ static unsigned short snd_atiixp_codec_r
 	} while (--timeout);
 	/* time out may happen during reset */
 	if (reg < 0x7c)
-		snd_printk(KERN_WARNING "atiixp: codec read timeout (reg %x)\n", reg);
+		snd_printk(KERN_WARNING "atiixp-modem: codec read timeout (reg %x)\n", reg);
 	return 0xffff;
 }
 
@@ -498,7 +498,7 @@ static int snd_atiixp_aclink_reset(atiix
 		do_delay();
 		atiixp_update(chip, CMD, ATI_REG_CMD_AC_RESET, ATI_REG_CMD_AC_RESET);
 		if (--timeout) {
-			snd_printk(KERN_ERR "atiixp: codec reset timeout\n");
+			snd_printk(KERN_ERR "atiixp-modem: codec reset timeout\n");
 			break;
 		}
 	}
@@ -552,7 +552,7 @@ static int snd_atiixp_codec_detect(atiix
 	atiixp_write(chip, IER, 0); /* disable irqs */
 
 	if ((chip->codec_not_ready_bits & ALL_CODEC_NOT_READY) == ALL_CODEC_NOT_READY) {
-		snd_printk(KERN_ERR "atiixp: no codec detected!\n");
+		snd_printk(KERN_ERR "atiixp-modem: no codec detected!\n");
 		return -ENXIO;
 	}
 	return 0;
@@ -635,7 +635,7 @@ static void snd_atiixp_xrun_dma(atiixp_t
 {
 	if (! dma->substream || ! dma->running)
 		return;
-	snd_printdd("atiixp: XRUN detected (DMA %d)\n", dma->ops->type);
+	snd_printdd("atiixp-modem: XRUN detected (DMA %d)\n", dma->ops->type);
 	snd_pcm_stop(dma->substream, SNDRV_PCM_STATE_XRUN);
 }
 
@@ -1081,14 +1081,14 @@ static int __devinit snd_atiixp_mixer_ne
 		ac97.scaps = AC97_SCAP_SKIP_AUDIO;
 		if ((err = snd_ac97_mixer(pbus, &ac97, &chip->ac97[i])) < 0) {
 			chip->ac97[i] = NULL; /* to be sure */
-			snd_printdd("atiixp: codec %d not available for modem\n", i);
+			snd_printdd("atiixp-modem: codec %d not available for modem\n", i);
 			continue;
 		}
 		codec_count++;
 	}
 
 	if (! codec_count) {
-		snd_printk(KERN_ERR "atiixp: no codec available\n");
+		snd_printk(KERN_ERR "atiixp-modem: no codec available\n");
 		return -ENODEV;
 	}
 
@@ -1159,7 +1159,7 @@ static void __devinit snd_atiixp_proc_in
 {
 	snd_info_entry_t *entry;
 
-	if (! snd_card_proc_new(chip->card, "atiixp", &entry))
+	if (! snd_card_proc_new(chip->card, "atiixp-modem", &entry))
 		snd_info_set_text_ops(entry, chip, 1024, snd_atiixp_proc_read);
 }
 
__
Chuck
Subliminal URL: www.sluggy.com/daily.php?date=050905
