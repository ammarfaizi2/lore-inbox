Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbTAAQa4>; Wed, 1 Jan 2003 11:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbTAAQa4>; Wed, 1 Jan 2003 11:30:56 -0500
Received: from gate.perex.cz ([194.212.165.105]:23049 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S267271AbTAAQaz>;
	Wed, 1 Jan 2003 11:30:55 -0500
Date: Wed, 1 Jan 2003 17:39:08 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Marcus Alanen <maalanen@ra.abo.fi>
cc: "trivial@rustcorp.com.au" <trivial@rustcorp.com.au>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch, 2.5] opti92x-ad1848 one check_region fixup
In-Reply-To: <Pine.LNX.4.44.0212302222530.30703-100000@tuxedo.abo.fi>
Message-ID: <Pine.LNX.4.33.0301011730590.500-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Dec 2002, Marcus Alanen wrote:

> Initializes the variables (the chip->xxx stuff) before calling 
> anything else. snd_legacy_find_free_ioport() uses request_region now, 
> so remember to release regions in the private freeing routine 
> snd_card_opti9xx_free().
> 
> Note how I changed it to return SNDRV_AUTO_PORT instead of -1, I'm 
> not sure if they are guaranteed to be the same, so I changed it 
> instead explicitely.
> 
> No other snd_legacy_find_free_ioport users in this file or elsewhere 
> in the kernel.

Your patch is bad. Lowlevel drivers allocate the hardware resources (see
snd_cs4231_create() or snd_ad1848_create() code), but these functions will
fail, because you allocate resources in the top-level code. I think that 
it will be sufficient to replace check_region call with request_region and 
release_resource. The collision frame is so small and the code returns 
with an error code when a problem occurs.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

