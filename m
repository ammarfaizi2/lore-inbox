Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292527AbSB0O3F>; Wed, 27 Feb 2002 09:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292516AbSB0O3A>; Wed, 27 Feb 2002 09:29:00 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:30670 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S292522AbSB0O2n>; Wed, 27 Feb 2002 09:28:43 -0500
Date: Wed, 27 Feb 2002 16:16:11 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, Nathan <wfilardo@fuse.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Dave Jones <davej@suse.de>, Jaroslav Kysela <perex@perex.cz>
Subject: Re: 2.5.5-dj2 compile failures
In-Reply-To: <3C7CEA75.3040805@drugphish.ch>
Message-ID: <Pine.LNX.4.44.0202271614450.16294-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Feb 2002, Roberto Nibali wrote:

> >>RTC Timer support failed - but maybe I don't need that
> >>
> >>Generic ESS ES18xx driver also failed to compile, - so no sound here.
> >>
> > 
> > Aargh i think thats me too! I'll have a look.
> 
> I sent in patches for the RTC Timer compile fix (interrupt.h was 
> missing) last night [1] but I only cc'd to dj and the ALSA maintainer. I 
> haven't fixed the ESS driver though.

Heres the es18xx fix, few ALSA API changes it seems.

	Zwane

Diffed against 2.5.5-dj2

--- linux-2.5.5-pre1/sound/isa/es18xx.c.orig	Wed Feb 27 16:04:15 2002
+++ linux-2.5.5-pre1/sound/isa/es18xx.c	Wed Feb 27 16:13:11 2002
@@ -1603,7 +1603,7 @@
 	sprintf(pcm->name, "ESS AudioDrive ES%x", chip->version);
         chip->pcm = pcm;
 
-	snd_pcm_lib_preallocate_isa_pages_for_all(pcm, 64*1024, chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024, GFP_KERNEL|GFP_DMA);
+	snd_pcm_lib_preallocate_isa_pages_for_all(pcm, 64*1024, chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024);
 
         if (rpcm)
         	*rpcm = pcm;
@@ -1616,7 +1616,7 @@
 {
 	snd_card_t *card = chip->card;
 
-	snd_power_lock(card, can_schedule);
+	snd_power_lock(card);
 	if (card->power_state == SNDRV_CTL_POWER_D3hot)
 		goto __skip;
 
@@ -1637,7 +1637,7 @@
 {
 	snd_card_t *card = chip->card;
 
-	snd_power_lock(card, can_schedule);
+	snd_power_lock(card);
 	if (card->power_state == SNDRV_CTL_POWER_D0)
 		goto __skip;
 

