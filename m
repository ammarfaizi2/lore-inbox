Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756922AbWKVGqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922AbWKVGqZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 01:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756924AbWKVGqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 01:46:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:11137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1756922AbWKVGqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 01:46:25 -0500
Date: Tue, 21 Nov 2006 22:46:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: wbrana@gmail.com
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] snd-hda-intel: fix insufficient memory
Message-Id: <20061121224613.548207f9.akpm@osdl.org>
In-Reply-To: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com>
References: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 21:33:29 +0100
wbrana@gmail.com wrote:

> Module allocates insufficient memory for multichannel and high quality
> audio (96 kHz, 24 bit)
> Patch for 2.6.19-* changes default/maximal size from 64/128 to 256/4096 kB.
> 
> --- sound/pci/hda/hda_intel.c.orig      2006-09-29 13:40:36.000000000 +0200
> +++ sound/pci/hda/hda_intel.c   2006-11-05 16:45:13.000000000 +0100
> @@ -1270,5 +1270,5 @@
>         snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
>                                               snd_dma_pci_data(chip->pci),
> -                                             1024 * 64, 1024 * 128);
> +                                             1024 * 256, 1024 * 4096);
>         chip->pcm[pcm_dev] = pcm;
>         if (chip->pcm_devs < pcm_dev + 1)

This was recently increased, but not by such a large amount:

	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
					      snd_dma_pci_data(chip->pci),
					      1024 * 64, 1024 * 1024);

is that sufficient?
