Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSKKWBx>; Mon, 11 Nov 2002 17:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbSKKWBx>; Mon, 11 Nov 2002 17:01:53 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:52870 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S261518AbSKKWBw>;
	Mon, 11 Nov 2002 17:01:52 -0500
Date: Mon, 11 Nov 2002 23:08:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
Message-ID: <20021111230822.A27828@ucw.cz>
References: <20021110163012.GB1564@elf.ucw.cz> <Pine.LNX.4.44.0211101050170.9581-100000@home.transmeta.com> <20021110204620.A15515@ucw.cz> <1037047250.1625.5.camel@cornchips>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1037047250.1625.5.camel@cornchips>; from johnstul@us.ibm.com on Mon, Nov 11, 2002 at 12:40:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 12:40:49PM -0800, john stultz wrote:
> On Sun, 2002-11-10 at 11:46, Vojtech Pavlik wrote:
> > On Sun, Nov 10, 2002 at 10:59:55AM -0800, Linus Torvalds wrote:
> > > On Sun, 10 Nov 2002, Pavel Machek wrote:
> > > > Unfortunately, this means "bye bye vsyscalls for gettimeofday".
> > > 
> > > Not necessarily. All of the fastpatch and the checking can be done by the
> > > vsyscall, and if the vsyscall notices that there is a backwards jump in
> > > time it just gives up and does a real system call. The vsyscall does need
> > > to figure out the CPU it's running on somehow, but that should be solvable
> > > - indexing through the thread ID or something.
> > 
> > I'm planning to store the CPU number in the highest bits of the TSC ...
> 
> I could be wrong, but we had considered this earlier, and found that
> there isn't a way to set the high bits of the TSC, you can only clear
> them. 

I'll have to test that. Another option is per-cpu page mappings for
vsyscalls. But that's rather ugly.

> > > The system call overhead tends to scale up very well with CPU speed (the
> > > one esception being the P4 which just has some internal problems with "int
> > > 0x80" and slowed down compared to a PIII).
> > > 
> > > So I would just suggest not spending a lot of effort on it, considering
> > > the problems it already has. 
> > 
> > Agreed. The only problem left I see is the need to have an interrupt of
> > every CPU from time to time to update the per-cpu time values, and to
> > synchronize those to the 'global timer interrupt' somehow.
> 
> Yes, this would be needed for per-cpu tsc. 

-- 
Vojtech Pavlik
SuSE Labs
