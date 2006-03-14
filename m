Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWCNPyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWCNPyk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWCNPyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:54:40 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:37124 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750706AbWCNPyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:54:39 -0500
Date: Tue, 14 Mar 2006 16:54:25 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Which kernel is the best for a small linux system?
Message-ID: <20060314155424.GA19902@w.ods.org>
References: <436c596f0603121640h4f286d53h9f1dd177fd0475a4@mail.gmail.com> <1142237867.3023.8.camel@laptopd505.fenrus.org> <opcb12964ic9im9ojmobduqvvu4pcpgppc@4ax.com> <1142273212.3023.35.camel@laptopd505.fenrus.org> <20060314062144.GC21493@w.ods.org> <20060314072921.GA13969@elte.hu> <1142327130.8075.30.camel@homer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142327130.8075.30.camel@homer>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 10:05:30AM +0100, Mike Galbraith wrote:
> On Tue, 2006-03-14 at 08:29 +0100, Ingo Molnar wrote:
> > * Willy Tarreau <willy@w.ods.org> wrote:
> > 
> > > scheduler is still a big problem. Not only we occasionally see people 
> > > complaining about unfair CPU distribution across processes (may be 
> > > fixed now), but the scheduler still gives a huge boost to I/O 
> > > intensive tasks which do lots of select() with small time-outs, which 
> > > makes it practically unusable in network-intensive environments. I've 
> > > observed systems on which it was nearly impossible to log in via SSH 
> > > because of this, and I could reproduce the problem locally to create a 
> > > local DoS where a single user could prevent anybody from logging in.  
> > > 2.6.15 has improved a lot on this (pauses have reduced from 35 seconds 
> > > to 4 seconds) but it's still not very good.
> 
> Hi Willy,
> 
> BTW, if you try my stuff, it'd be good to try just the "cleanup" patch
> first.  It seems very likely to me that your problem is mostly caused by
> the sleep_avg multiplier.  If the first patch cures your woes, try
> killing just the multiplier in virgin source.
> 
> 	-Mike
> 
> (oh yeah, the pipe patch is more or less meaningless now, ignore it)

Hi Mike, Hi Ingo,

thank you both for your insights. I *will* test this, I don't know when
because I'm terribly busy, but I'm really interested.

Ingo, to reply to your question, the typical workload was around 30 Mbps with
1500-2000 sessions/s on a small number of processes (1 to 4*#CPUs). It was
with some kernels around 2.6.8 IIRC. Pauses could be of several hundreds of
milliseconds which was very annoying. But IIRC, if renicing the process(es)
improved SSH responsiveness, it also hurt the service's responsiveness.
The same process running on 2.2, 2.4, solaris 8/10, freebsd and openbsd does
not exhibit the behaviour at all. I've not retried yet with more recent
kernels, I just recently retried the proof of concept I developped at this
date, and all I remember was that 2.6.15+ was really better.

Cheers,
Willy

