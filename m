Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132855AbRDDRDK>; Wed, 4 Apr 2001 13:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132849AbRDDRDA>; Wed, 4 Apr 2001 13:03:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:47636 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132856AbRDDRCt>; Wed, 4 Apr 2001 13:02:49 -0400
Date: Wed, 4 Apr 2001 19:00:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Kanoj Sarcar <kanoj@google.engr.sgi.com>
Cc: mingo@elte.hu, Hubertus Franke <frankeh@us.ibm.com>,
        Mike Kravetz <mkravetz@sequent.com>,
        Fabio Riccardi <fabio@chromium.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: a quest for a better scheduler
Message-ID: <20010404190043.N20911@athlon.random>
In-Reply-To: <Pine.LNX.4.30.0104041527190.5382-100000@elte.hu> <200104041639.JAA78761@google.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104041639.JAA78761@google.engr.sgi.com>; from kanoj@google.engr.sgi.com on Wed, Apr 04, 2001 at 09:39:23AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 09:39:23AM -0700, Kanoj Sarcar wrote:
> example, for NUMA, we need to try hard to schedule a thread on the 
> node that has most of its memory (for no reason other than to decrease
> memory latency). Independently, some NUMA machines build in multilevel 
> caches and local snoops that also means that specific processors on
> the same node as the last_processor are also good candidates to run 
> the process next.

yes. That will probably need to be optional and choosen by the architecture
at compile time too. The probably most important factor to consider is the
penality of accessing remote memory, I think I can say on all recent and future
machines with a small difference between local and remote memory (and possibly
as you say with a decent cache protocol able to snoop cacheline data from the
other cpus even if they're not dirty) it's much better to always try to keep
the task in its last node. My patch is actually assuming recent machines and it
keeps the task in its last node if not in the last cpu and it keeps doing
memory allocation from there and it forgets about its original node where it
started allocating the memory from.  This provided the best performance during
userspace CPU bound load as far I can tell and it also better distribute the load.

Kanoj could you also have a look at the NUMA related common code MM fixes I did
in this patch? I'd like to get them integrated (just skip the arch/alpha/*
include/asm-alpha/* stuff while reading the patch, they're totally orthogonal).

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.3aa1/00_alpha-numa-1

If you prefer I can extract them in a more finegrinded patch just dropping
the alpha stuff by hand.

Andrea
