Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWC3XHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWC3XHk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 18:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWC3XHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 18:07:40 -0500
Received: from mail.gmx.de ([213.165.64.20]:8401 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750944AbWC3XHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 18:07:40 -0500
X-Authenticated: #271361
Date: Fri, 31 Mar 2006 01:07:34 +0200
From: Edgar Toernig <froese@gmx.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Bodo Eggert <7eggert@gmx.de>, Joseph Fannin <jfannin@gmail.com>,
       Stas Sergeev <stsp@aknet.ru>, dtor_core@ameritech.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
Message-Id: <20060331010734.32e0a5fb.froese@gmx.de>
In-Reply-To: <20060328185147.GA6475@suse.cz>
References: <5TCqf-E6-49@gated-at.bofh.it>
	<5TCqf-E6-51@gated-at.bofh.it>
	<5TCqf-E6-53@gated-at.bofh.it>
	<5TCqg-E6-55@gated-at.bofh.it>
	<5TCqf-E6-47@gated-at.bofh.it>
	<E1FMv1A-0000fN-Lp@be1.lrz>
	<44266472.5080309@aknet.ru>
	<20060328183140.GA21446@nineveh.rivenstone.net>
	<Pine.LNX.4.58.0603282040480.2538@be1.lrz>
	<20060328185147.GA6475@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
>
> On Tue, Mar 28, 2006 at 08:43:35PM +0200, Bodo Eggert wrote:
> > On Tue, 28 Mar 2006, Joseph Fannin wrote:
> > 
> > >     I would think the ideal situation would be to make every ALSA
> > > device capable of acting as the console bell (defaulting to muted,
> > > like every other ALSA mixer control).  Then only pcspkr would be the
> > > odd case (though maybe a common one).
> > > 
> > >     I dunno if there's a reasonably easy way to do that (without
> > > changing every ALSA driver) though.
> > 
> > I think that should be done using a userspace input device if possible.
>  
> It certainly is. That way configuring the exact sound it makes would
> also possible. The latency might be a problem, though.

Latency is no problem.  I'm using a userspace daemon to emulate
the console beeper for about 6 months now and it work's very well.

The daemon listens on /dev/input/eventX and when receiving a
SND_TONE it opens /dev/dspY (a cheap USB-speaker), produces its
bing and closes the audio dev after some seconds with no SND_TONE.

Latency isn't noticable and memory footprint is small.

Sure, if ALSA could emit console beeps on any audio device even if
it is in use I would definitely use it and trash the USB-speaker.
But the userspace daemon is OK...

Ciao, ET.

PS:
<rant>
It would have been even better if Shuttle had connected the beeper
output of the IT87 to the beeper input of the ALC650 in the first
place.  But no, this thing is totally silent - no piezo beeper, no
routing to the sound codec, no POST-beeps, nothing.

Why are manufacturers doing such silly things?
</rant>
