Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265123AbSKJTkR>; Sun, 10 Nov 2002 14:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265127AbSKJTkR>; Sun, 10 Nov 2002 14:40:17 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:27083 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S265123AbSKJTkP>;
	Sun, 10 Nov 2002 14:40:15 -0500
Date: Sun, 10 Nov 2002 20:46:20 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Voyager subarchitecture for 2.5.46
Message-ID: <20021110204620.A15515@ucw.cz>
References: <20021110163012.GB1564@elf.ucw.cz> <Pine.LNX.4.44.0211101050170.9581-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0211101050170.9581-100000@home.transmeta.com>; from torvalds@transmeta.com on Sun, Nov 10, 2002 at 10:59:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 10:59:55AM -0800, Linus Torvalds wrote:

> On Sun, 10 Nov 2002, Pavel Machek wrote:
> > 
> > Unfortunately, this means "bye bye vsyscalls for gettimeofday".
> 
> Not necessarily. All of the fastpatch and the checking can be done by the
> vsyscall, and if the vsyscall notices that there is a backwards jump in
> time it just gives up and does a real system call. The vsyscall does need
> to figure out the CPU it's running on somehow, but that should be solvable
> - indexing through the thread ID or something.

I'm planning to store the CPU number in the highest bits of the TSC ...

> That said, I suspect that the real issue with vsyscalls is that they don't
> really make much sense. The only system call we've ever found that matters
> at all is gettimeofday(), and the vsyscall implementation there looks like
> a "cool idea, but doesn't really matter (and complicates things a lot)".

It's not complicating things overly. We'd have to go through most of the
hoops anyway if we wanted a fast gettimeofday syscall instead of a
vsyscall.

> The system call overhead tends to scale up very well with CPU speed (the
> one esception being the P4 which just has some internal problems with "int
> 0x80" and slowed down compared to a PIII).
> 
> So I would just suggest not spending a lot of effort on it, considering
> the problems it already has. 

Agreed. The only problem left I see is the need to have an interrupt of
every CPU from time to time to update the per-cpu time values, and to
synchronize those to the 'global timer interrupt' somehow.

-- 
Vojtech Pavlik
SuSE Labs
