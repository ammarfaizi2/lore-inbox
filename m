Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132753AbRDINu4>; Mon, 9 Apr 2001 09:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132754AbRDINup>; Mon, 9 Apr 2001 09:50:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:30496 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132753AbRDINub>; Mon, 9 Apr 2001 09:50:31 -0400
Date: Mon, 9 Apr 2001 15:50:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: softirq buggy
Message-ID: <20010409155052.H7108@athlon.random>
In-Reply-To: <200104081758.VAA15670@ms2.inr.ac.ru> <3AD0D9A8.189AA43C@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AD0D9A8.189AA43C@colorfullife.com>; from manfred@colorfullife.com on Sun, Apr 08, 2001 at 11:35:36PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2001 at 11:35:36PM +0200, Manfred Spraul wrote:
> I've attached a new patch:
> 
> * cpu_is_idle() moved to <linux/pm.h>
> * function uninlined due to header dependencies
> * cpu_is_idle() doesn't call do_softirq directly, instead the caller
> returns to schedule()
> * cpu_is_idle() exported for modules.
> * docu updated.
> 
> I'd prefer to inline cpu_is_idle(), but optimizing the idle code path is
> probably not that important ;-)

your cpu_is_idle will return 0 in the need_resched != 0 check even if the cpu
is idle (because of the -1 trick for avoiding the SMP-IPI to notify the cpu).

The issue you are addressing is quite londstanding and it is not only related
to the loop with an idle cpu.

This is the way I prefer to fix it:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre1/ksoftirqd-1

Andrea
