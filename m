Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbTBCJfD>; Mon, 3 Feb 2003 04:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbTBCJfD>; Mon, 3 Feb 2003 04:35:03 -0500
Received: from gate.perex.cz ([194.212.165.105]:32783 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S264706AbTBCJfC>;
	Mon, 3 Feb 2003 04:35:02 -0500
Date: Mon, 3 Feb 2003 10:44:12 +0100 (CET)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Adam Belay <ambx1@neo.rr.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "greg@kroah.com" <greg@kroah.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][RFC] Resource Management Improvements (1/4)
In-Reply-To: <20030202203641.GA22089@neo.rr.com>
Message-ID: <Pine.LNX.4.44.0302031036160.4023-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2003, Adam Belay wrote:

> This patch is the first of 4 experimental pnp patches.  It is against a clean
> 2.5.59 kernel.  I would appreciate for those who are interested, if you would
> test this patch series and post your results on lkml.  These changes appear 
> to be very stable on my test systems and I feel they will be a dramatic 
> improvement to the pnp layer.
> 
> Patch 1 contains resource management improvements that will allow the pnp
> layer to resolve virtually any resource conflict.  A new kernel parameter
> "pnp_max_moves=" was added to allow the user to describe the maximum number
> of device levels to move during conflict resolution.  This powerful new
> engine also includes many cleanups and more verbose reporting.  All devices
> are configured when added instead of when activated.  This will increase
> the odds that the conflict will be possible to resolve because resources
> cannot be moved in an active device.

I don't agree with this. Simply, why to activate devices which will not be
ever used? You'll occupy resources which can be assigned to another
device. Also, you simply removed my configuration templates, so the driver
cannot tell explicitly which resources PnP layer should assign. Also
activation (and resource allocation) should be on request allowing driver
to do things manually. Bad bad bad. We're again in state a month ago when
nothing worked and ALSA ISA PnP drivers are still broken, because your
model doesn't have all features like good old ISA PnP code. Also, with all
respects, I think that you're trying to write very clever code. It's also
bad. It will end with numerous problems and with undeterministic behaviour
like unnamed commercial OS. Let users to pass their own configurations.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

