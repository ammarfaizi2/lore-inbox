Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265348AbSJRRb6>; Fri, 18 Oct 2002 13:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265294AbSJRR1j>; Fri, 18 Oct 2002 13:27:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38925 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265307AbSJRRLg>; Fri, 18 Oct 2002 13:11:36 -0400
Date: Fri, 18 Oct 2002 10:19:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Michael Hohnbaum <hbaum@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.5.34_vsyscall_A0
In-Reply-To: <20021018171139.GM23930@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0210181018070.21302-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Oct 2002, Andrea Arcangeli wrote:

> On Fri, Oct 18, 2002 at 09:45:41AM -0700, george anzinger wrote:
> > Stephen Hemminger wrote:
> > > current cpu (and maybe current pid) somehow.  And it would be possible
> > > to avoid  preemption while in a vsyscall text page, some other Unix
> > > variants do this to implement portions of the thread library in kernel
> > > provided user text pages.
> > > 
> > Now there is an idea!  Lock preemption in user space if and
> 
> sounds not good to me, you would miss a wakeup and you would delay the
> schedule of 1/HZ in the worst (close to the common) case.

That's not the real problem.

The real problem is that somebody can jump into the middle of a function 
(or even into the middle of an instruction), causing the function to do 
something totally different from the intended effect.

In particular, it can cause the function to loop forever.

If you disable preemption of user space, you now killed the machine.

In short - others may do it, but it's a total _DISASTER_ from a security 
and stability standpoint. Don't go there.

		Linus

