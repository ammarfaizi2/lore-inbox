Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUGLX2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUGLX2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUGLX2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:28:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:13491 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264246AbUGLX2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:28:44 -0400
Date: Mon, 12 Jul 2004 16:31:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel
 Preemption Patch
Message-Id: <20040712163141.31ef1ad6.akpm@osdl.org>
In-Reply-To: <1089673014.10777.42.camel@mindpipe>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<1089673014.10777.42.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Sun, 2004-07-11 at 01:25, Andrew Morton wrote:
> > What we need to do is to encourage audio testers to use ALSA drivers, to
> > enable CONFIG_SND_DEBUG in the kernel build and to set
> > /proc/asound/*/*/xrun_debug and to send us the traces which result from
> > underruns.
> > 
> 
> OK, here goes.  The following traces result from running JACK overnight
> like so, on an otherwise idle system.  Hardware is a VIA EPIA 6000, with
> a 600Mhz C3 processor.  Kernel is 2.6.7 + volunatary_preempt patch. 
> voluntary_preempt and kernel_preemption are both on.
> 
> jackd -v --realtime -d alsa --outchannels 2 --rate 48000 --shorts
> --playback --period 32  --nperiods 2
> 
> These settings require less than 666 microseconds scheduler latency. 
> The average performance is quite good - 5-20 *microseconds*!

OK, thanks.  The problem areas there are the timer-based route cache
flushing and reiserfs.

We can probably fix the route caceh thing by rescheduling the timer after
having handled 1000 routes or whatever, although I do wonder if this is a
thing we really need to bother about - what else was that machine up to?

resierfs: yes, it's a problem.  I "fixed" it multiple times in 2.4, but the
fixes ended up breaking the fs in subtle ways and I eventually gave up.
