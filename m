Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288783AbSANFQQ>; Mon, 14 Jan 2002 00:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288799AbSANFQH>; Mon, 14 Jan 2002 00:16:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:16139 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288783AbSANFPx>; Mon, 14 Jan 2002 00:15:53 -0500
Message-ID: <3C426819.982E5967@zip.com.au>
Date: Sun, 13 Jan 2002 21:09:45 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <3C41A545.A903F24C@linux-m68k.org> <20020113153602.GA19130@fenrus.demon.nl>,
		<20020113153602.GA19130@fenrus.demon.nl> <E16PzHb-00006g-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On January 13, 2002 04:36 pm, Arjan van de Ven wrote:
> > On Sun, Jan 13, 2002 at 04:18:29PM +0100, Roman Zippel wrote:
> >
> > > What somehow got lost in this discussion, that both patches don't
> > > necessarily conflict with each other, they both attack the same problem
> > > with different approaches, which complement each other. I prefer to get
> > > the best of both patches.
> >
> > If you do this (and I've seen the results of doing both at once vs only
> > either of then vs pure) then there's NO benifit for the preemption left.
> 
> Sorry, that's incorrect.  I stated why earlier in this thread and akpm signed
> off on it.  With preempt you get ASAP (i.e., as soon as the outermost
> spinlock is done) process scheduling.  With hand-coded scheduling points you
> get 'as soon as it happens to hit a scheduling point'.

With preempt it's "as soon as you hit a lock-break point".  They're equivalent,
for the inside-lock case, which is where most of the problems and complexity
lie.

> That is not the only benefit, just the most obvious one.

I'd say the most obvious benefit of preempt is that it catches some
of the cases which the explicit schedules do not - the stuff which
the developer didn't test for, and which is outside locks.

How useful this is, is moot.

But we can *make* it useful.  I believe that internal preemption is
the foundation to improve 2.5 kernel latency.  But first we need
consensus that we *want* linux to be a low-latency kernel.

Do we have that?

If we do, then as I've said before, holding a lock for more than N milliseconds
becomes a bug to be fixed.  We can put tools in the hands of testers to
locate those bugs.  Easy.

-
