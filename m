Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWCaHqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWCaHqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWCaHqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:46:07 -0500
Received: from styx.suse.cz ([82.119.242.94]:38105 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751242AbWCaHqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:46:05 -0500
Date: Fri, 31 Mar 2006 09:46:05 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Edgar Toernig <froese@gmx.de>
Cc: Bodo Eggert <7eggert@gmx.de>, Joseph Fannin <jfannin@gmail.com>,
       Stas Sergeev <stsp@aknet.ru>, dtor_core@ameritech.net,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
Message-ID: <20060331074605.GC5871@suse.cz>
References: <5TCqf-E6-51@gated-at.bofh.it> <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it> <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz> <44266472.5080309@aknet.ru> <20060328183140.GA21446@nineveh.rivenstone.net> <Pine.LNX.4.58.0603282040480.2538@be1.lrz> <20060328185147.GA6475@suse.cz> <20060331010734.32e0a5fb.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331010734.32e0a5fb.froese@gmx.de>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 01:07:34AM +0200, Edgar Toernig wrote:
> Vojtech Pavlik wrote:
> >
> > On Tue, Mar 28, 2006 at 08:43:35PM +0200, Bodo Eggert wrote:
> > > On Tue, 28 Mar 2006, Joseph Fannin wrote:
> > > 
> > > >     I would think the ideal situation would be to make every ALSA
> > > > device capable of acting as the console bell (defaulting to muted,
> > > > like every other ALSA mixer control).  Then only pcspkr would be the
> > > > odd case (though maybe a common one).
> > > > 
> > > >     I dunno if there's a reasonably easy way to do that (without
> > > > changing every ALSA driver) though.
> > > 
> > > I think that should be done using a userspace input device if possible.
> >  
> > It certainly is. That way configuring the exact sound it makes would
> > also possible. The latency might be a problem, though.
> 
> Latency is no problem.  I'm using a userspace daemon to emulate
> the console beeper for about 6 months now and it work's very well.
> 
> The daemon listens on /dev/input/eventX and when receiving a

It needs to use /dev/input/uinput, not eventX. SND_TONE events are not
sent to the event devices.

> SND_TONE it opens /dev/dspY (a cheap USB-speaker), produces its
> bing and closes the audio dev after some seconds with no SND_TONE.
> 
> Latency isn't noticable and memory footprint is small.

It needs to have the sample ready in memory and not swapped out. Then
the latency will be OK, but if it needs to read it in from the disk, it
may be very noticeable.

> Sure, if ALSA could emit console beeps on any audio device even if
> it is in use I would definitely use it and trash the USB-speaker.
> But the userspace daemon is OK...

> PS:
> <rant>
> It would have been even better if Shuttle had connected the beeper
> output of the IT87 to the beeper input of the ALC650 in the first
> place.  But no, this thing is totally silent - no piezo beeper, no
> routing to the sound codec, no POST-beeps, nothing.

Pretty common nowadays.

> Why are manufacturers doing such silly things?
> </rant>


-- 
Vojtech Pavlik
Director SuSE Labs
