Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWAIXKj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWAIXKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 18:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWAIXKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 18:10:39 -0500
Received: from mail3.uklinux.net ([80.84.72.33]:5102 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1750794AbWAIXKi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 18:10:38 -0500
Date: Mon, 9 Jan 2006 23:20:43 +0000
From: John Rigg <ad@sound-man.co.uk>
To: David Lang <dlang@digitalinsight.com>
Cc: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>,
       Hannu Savolainen <hannu@opensound.com>, Jaroslav Kysela <perex@suse.cz>,
       Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org,
       ALSA development <alsa-devel@alsa-project.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Re: [OT] ALSA userspace API complexity
Message-ID: <20060109232043.GA5013@localhost.localdomain>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de> <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de> <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 01:58:00PM -0800, David Lang wrote:
> On Mon, 9 Jan 2006, René Rebe wrote:
> 
> >On Monday 09 January 2006 16:10, Hannu Savolainen wrote:
> >
> >>>>I don't think so. The library can do such conversions (and alsa-lib 
> >>>>does)
> >>>>quite easy. If we have a possibility to remove the code from the kernel
> >>>>space without any drawbacks, then it should be removed. I don't see any
> >>>>advantage to have such conversions in the kernel.
> >>>
> >>>Also, when the data is already available as single streams in a 
> >>>user-space
> >>>multi track application, why should it be forced interleaved, when the 
> >>>hardware
> >>>could handle the format just fine?
> >>Because the conversion doesn't cost anything. Trying to avoid it by
> >>making the API more complicated (I would even say confusing) is extreme
> >>overkill.
> >
> >Since when doesn't cost convesion anything? I'm able to count a lot of 
> >wasted
> >CPU cycles in there ...
> 
> if the data needed to be accessed by the CPU anyway it's free becouse 
> otherwise the CPU would stall waiting for the next chunk of memory. you 
> can do quite a bit of work on data in cache while you are waiting for the 
> next cache line to load.
> 
> in this same way, checksumming a network packet is free if the CPU needs 
> to copy the data anway, it only costs something if the data could bypass 
> the CPU.

Yes, but the CPU has plenty of other work to do. The sound cards that
would be worst affected by this are the big RME cards (non-interleaved) and
multiple ice1712 cards (non-interleaved blocks of interleaved data),
which AFAIK are the only cards capable of handling serious professional audio.
This could represent 48 or more channels of 96kHz audio, which
doesn't leave a lot of spare CPU capacity for running X, for example.

John
