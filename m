Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277734AbRJIOpQ>; Tue, 9 Oct 2001 10:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277735AbRJIOpJ>; Tue, 9 Oct 2001 10:45:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2310 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277732AbRJIOnh>; Tue, 9 Oct 2001 10:43:37 -0400
Date: Tue, 9 Oct 2001 11:22:01 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>, bcrl@redhat.com
Subject: Re: pre6 VM issues
In-Reply-To: <3BC30B9F.9060609@wipro.com>
Message-ID: <Pine.LNX.4.21.0110091117010.5604-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Oct 2001, BALBIR SINGH wrote:

> Marcelo Tosatti wrote:
> 
> >
> >On Tue, 9 Oct 2001, BALBIR SINGH wrote:
> >
> >>Most of the traditional unices maintained a pool for each subsystem
> >>(this is really useful when u have the memory to spare), so not matter
> >>what they use memory only from their pool (and if needed peek outside),
> >>but nobody else used the memory from the pool.
> >>
> >>I have seen cases where, I have run out of physical memory on my system,
> >>so I try to log in using the serial console, but since the serial driver
> >>does get_free_page (this most likely fails) and the driver complains back.
> >>So, I had suggested a while back that important subsystems should maintain
> >>their own pool (it will take a new thread to discuss the right size of
> >>each pool).
> >>
> >>Why can't Linux follow the same approach? especially on systems with a lot
> >>of memory.
> >>
> >
> >There is nothing which avoids us from doing that (there is one reserved
> >pool I remeber right now: the highmem bounce buffering pool, but that one
> >is a special case due to the way Linux does IO in high memory and its only
> >needed on _real_ emergencies --- it will be removed in 2.5, I hope).
> >
> >In general, its a better approach to share the memory and have a unified
> >pool. If a given subsystem is not using its own "reversed" memory, another
> >subsystems can use it.
> >
> >The problem we are seeing now can be fixed even without the reserved
> >pools.
> >
> I agree that is the fair and nice thing to do, but I was talking about reserving
> memory for device vs sharing it with a user process, user processes can wait,
> their pages can even be swapped out if needed. But for a device that is not willing
> to wait (GFP_ATOMIC) say in an interrupt context, this might be a issue.
> 
> 
> Anyway, how do you plan to solve this ?

I plan to have saner limits for atomic allocations for 2.4. For the corner
cases, we can make then those limits tunable.

For 2.5, I guess we'll need some scheme for those corner cases, since they
will probably become more common (think about gigabit ethernet, etc).

I'm not sure yet which one will be used. Ben (bcrl@redhat.com) has a nice
scheme ready for reservation. But thats 2.5 only anyway.

