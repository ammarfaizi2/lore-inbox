Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316431AbSFEV4I>; Wed, 5 Jun 2002 17:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSFEV4H>; Wed, 5 Jun 2002 17:56:07 -0400
Received: from dsl-213-023-039-098.arcor-ip.net ([213.23.39.98]:33732 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316431AbSFEV4G>;
	Wed, 5 Jun 2002 17:56:06 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Oliver Xymoron <oxymoron@waste.org>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
Date: Wed, 5 Jun 2002 23:55:26 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Mark Mielke <mark@mark.mielke.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206051612170.2614-100000@waste.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17FikY-0001fL-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 June 2002 23:22, Oliver Xymoron wrote:
> On Wed, 5 Jun 2002, Daniel Phillips wrote:
> 
> > > And that alternative sucks. Think scalability.
> > >
> > > >   2) Implement a filesystem with realtime response
> > >
> > > And your shared fs alternative sucks. Think abysmal disk throughput for
> > > the rest of the system. Think starvation. Think all the reasons we've been
> > > trying to clean up the elevator code times ten. And that's just for the
> > > device queue, never mind the deadlock avoidance problems. See "priority
> > > inversion".
> >
> > What kind of argument is that?  It sounds like: because our current block
> > interface sucks, all block interfaces suck, and always will.  On the
> > contrary, I believe our current interface sucks precisely because it is
> > not built according to sound principles of realtime design.
> 
> No, the above is a theoretical argument about how optimizing disk access
> and locking works that's in no way specific to Linux. Remember, hard RT is
> trades throughput for latency guarantees.

This is a mantra I keep hearing repeated, and it is a myth.  The correct
version goes more like: "in a realtime system, meeting deadlines is more
important than efficiency".  That doesn't mean you can't have both, and
please see my earlier description of the realtime system c/w gui, running
on a 486.  Oh wait, it also ran on a 386.  16 Mhz.

> Worst case for this is devices
> queues for disks. Go through the thought experiment of what happens when
> an RT task and a !RT task interleave disk access. Worse, what happens when
> they're creating files (and all the locking that entails) in the same
> directory.

I mentioned somewhere that the realtime filesystem would get its own
volume.  That's a big help, because it means that the entire filesystem
can run in the RTOS, and we only have to worry about the block queue,
which is an interesting and tractable problem from the realtime point
of view.  Obviously, we want the RTOS to operate the block queue, and
yes, we want it to be efficient.

Our current block queue design would benefit a lot from the kind of
thinking that would be required to make it realtime.

-- 
Daniel
