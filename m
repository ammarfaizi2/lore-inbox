Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbULDVyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbULDVyL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 16:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbULDVyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 16:54:11 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:45702 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261174AbULDVyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 16:54:04 -0500
Subject: Re: [PATCH] Fix ALSA resume
From: Lee Revell <rlrevell@joe-job.com>
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <1102195391.1560.65.camel@tux.rsn.bth.se>
References: <1102195391.1560.65.camel@tux.rsn.bth.se>
Content-Type: text/plain
Date: Sat, 04 Dec 2004 16:54:02 -0500
Message-Id: <1102197242.28776.49.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc: alsa-devel@lists.sourceforge.net on all ALSA issues.

On Sat, 2004-12-04 at 22:23 +0100, Martin Josefsson wrote:
> Some time ago, a patch was merged that removed pci_save_state() and
> pci_restore_state() from various ALSA drivers. That patch also added
> pci_restore_state() to sound/core/init.c but didn't add pci_save_state()
> anywhere. This is needed since the core pci handling doesn't do this for
> us anymore.
> 
> My laptop doesn't resume (gets what I assume is an ACPI timeout and
> hangs solid) without this small obvious patch.
> 
> Signed-off-by: Martin Josefsson <gandalf@wlug.westbo.se>
> Fixed-by: Takashi Iwai <tiwai@suse.de>
> 
> --- linux/sound/core/init.c	8 Nov 2004 11:37:08 -0000	1.48
> +++ linux/sound/core/init.c	12 Nov 2004 13:56:32 -0000
> @@ -782,12 +782,15 @@<br>
>  int snd_card_pci_suspend(struct pci_dev *dev, u32 state)
>  {
>  	snd_card_t *card = pci_get_drvdata(dev);
> +	int err;
>  	if (! card || ! card->pm_suspend)
>  		return 0;
>  	if (card->power_state == SNDRV_CTL_POWER_D3hot)
>  		return 0;
>  	/* FIXME: correct state value? */
> -	return card->pm_suspend(card, 0);
> +	err = card->pm_suspend(card, 0);
> +	pci_save_state(dev);
> +	return err;
>  }
> 
>  int snd_card_pci_resume(struct pci_dev *dev)
> 
> 
-- 
Lee Revell <rlrevell@joe-job.com>

