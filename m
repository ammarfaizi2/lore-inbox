Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264412AbUGMAyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264412AbUGMAyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 20:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUGMAyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 20:54:12 -0400
Received: from scanmail3.cableone.net ([24.116.0.123]:43273 "EHLO
	mail.cableone.net") by vger.kernel.org with ESMTP id S264412AbUGMAyG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 20:54:06 -0400
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
	Preemption Patch
From: Jan Depner <eviltwin69@cableone.net>
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
Cc: Andrew Morton <akpm@osdl.org>, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <1089677823.10777.64.camel@mindpipe>
References: <20040709182638.GA11310@elte.hu>
	 <20040710222510.0593f4a4.akpm@osdl.org>
	 <1089673014.10777.42.camel@mindpipe>
	 <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1089677823.10777.64.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1089680288.29230.5.camel@eviltwin>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 12 Jul 2004 19:58:08 -0500
Content-Transfer-Encoding: 7bit
X-Server: High Performance Mail Server - http://surgemail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this problem strictly with reiserfs in 2.6 or is it also a problem
with 2.4.  I actually experienced fewer xruns with reiserfs vs ext3 on
2.4 (preempt/ll) but I have no hard numbers to back that up.

Jan

On Mon, 2004-07-12 at 19:17, Lee Revell wrote:
> On Mon, 2004-07-12 at 19:31, Andrew Morton wrote:
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > >
> > > On Sun, 2004-07-11 at 01:25, Andrew Morton wrote:
> > > > What we need to do is to encourage audio testers to use ALSA drivers, to
> > > > enable CONFIG_SND_DEBUG in the kernel build and to set
> > > > /proc/asound/*/*/xrun_debug and to send us the traces which result from
> > > > underruns.
> > > > 
> > > 
> > > OK, here goes.  The following traces result from running JACK overnight
> > > like so, on an otherwise idle system.  Hardware is a VIA EPIA 6000, with
> > > a 600Mhz C3 processor.  Kernel is 2.6.7 + volunatary_preempt patch. 
> > > voluntary_preempt and kernel_preemption are both on.
> > > 
> > > jackd -v --realtime -d alsa --outchannels 2 --rate 48000 --shorts
> > > --playback --period 32  --nperiods 2
> > > 
> > > These settings require less than 666 microseconds scheduler latency. 
> > > The average performance is quite good - 5-20 *microseconds*!
> > 
> > OK, thanks.  The problem areas there are the timer-based route cache
> > flushing and reiserfs.
> > 
> > We can probably fix the route caceh thing by rescheduling the timer after
> > having handled 1000 routes or whatever, although I do wonder if this is a
> > thing we really need to bother about - what else was that machine up to?
> > 
> 
> Gnutella client.  Forgot about that.  I agree, it is not reasonable to
> expect low latency with this kind of network traffic happening.  I am
> impressed it worked as well as it did.
> 
> > resierfs: yes, it's a problem.  I "fixed" it multiple times in 2.4, but the
> > fixes ended up breaking the fs in subtle ways and I eventually gave up.
> > 
> 
> Interesting.  There is an overwhelming consensus amongst Linux audio
> folks that you should use reiserfs for low latency work.  Should I try
> ext3?
> 
> Lee
> 
> 
> 
> 
> 

