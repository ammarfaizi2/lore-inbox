Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277247AbRJIOX0>; Tue, 9 Oct 2001 10:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277248AbRJIOXQ>; Tue, 9 Oct 2001 10:23:16 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:35857 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277247AbRJIOXG>; Tue, 9 Oct 2001 10:23:06 -0400
Date: Tue, 9 Oct 2001 11:01:31 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrea Arcangeli <andrea@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
In-Reply-To: <3BC30701.2060908@wipro.com>
Message-ID: <Pine.LNX.4.21.0110091057470.5604-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Oct 2001, BALBIR SINGH wrote:

> Most of the traditional unices maintained a pool for each subsystem
> (this is really useful when u have the memory to spare), so not matter
> what they use memory only from their pool (and if needed peek outside),
> but nobody else used the memory from the pool.
> 
> I have seen cases where, I have run out of physical memory on my system,
> so I try to log in using the serial console, but since the serial driver
> does get_free_page (this most likely fails) and the driver complains back.
> So, I had suggested a while back that important subsystems should maintain
> their own pool (it will take a new thread to discuss the right size of
> each pool).
> 
> Why can't Linux follow the same approach? especially on systems with a lot
> of memory.

There is nothing which avoids us from doing that (there is one reserved
pool I remeber right now: the highmem bounce buffering pool, but that one
is a special case due to the way Linux does IO in high memory and its only
needed on _real_ emergencies --- it will be removed in 2.5, I hope).

In general, its a better approach to share the memory and have a unified
pool. If a given subsystem is not using its own "reversed" memory, another
subsystems can use it.

The problem we are seeing now can be fixed even without the reserved
pools.


