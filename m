Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbTJIUrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 16:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTJIUrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 16:47:12 -0400
Received: from intra.cyclades.com ([64.186.161.6]:63408 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262420AbTJIUrG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 16:47:06 -0400
Date: Thu, 9 Oct 2003 17:40:53 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: 2.4.23pre6aa1
In-Reply-To: <20031005092326.GA1561@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0310091735380.3040-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Oct 2003, Andrea Arcangeli wrote:

> > > Only in 2.4.23pre6aa1: 00_get_request_wait-race-1
> > > 
> > > 	Add missing smb_mb().

Ok I see you add smp_mb() in get_request_wait_wakeup()... Can you please 
explain me in more detail why this is required? 

> > > Only in 2.4.23pre6aa1: 00_proc-readlink-1
> > > 
> > > 	Remeber to free tmp buffer (from spender)

Merged.

> > > 
> > > Only in 2.4.23pre6aa1: 00_sync-buffer-scale-1
> > > 
> > > 	Don't take the bkl (the same paths runs w/o the bkl elsewhere), from
> > > 	Chris Mason.

I prefer not applying this one.

> > > Only in 2.4.23pre6aa1: 01_softirq-nowait-1
> > > 
> > > 	We must really keep executing softirqs or it may take
> > > 	a too long time before ksoftirqd gets some cpu time.
> > > 	For an embedded device you may want to remove this,
> > > 	on a server we need this still.
> > > 
> > > Only in 2.4.23pre6aa1: 30_19-nfs-kill-unlock-1
> > > 
> > > 	Ignore errors on exiting lock cleanups. From Trond.

Talked with Trond and he has other fixes pending... Should have them by 
the weekend.

> > > Only in 2.4.23pre6aa1: 9999900_BH_Sync-remove-1
> > > 
> > > 	To really be able to help and not just waste some
> > > 	seek and cpu, wait_on_buffer should honour the
> > > 	BH_Sync, but this is late in 2.4, and so I prefer
> > > 	to get rid of it instead of giving it the full power
> > > 	it should have.
> > > 
> > > Only in 2.4.23pre6aa1: 9999_z-execve-race-1
> > > 
> > > 	Fix race in exit_mmap.
>
> I recall I sent one of these to you privately already (though not all of
> them). the ones to merge are these:
> 
> 	00_e-nodev-1
> 	00_get_request_wait-race-1
> 	00_proc-readlink-1
> 	00_sync-buffer-scale-1
> 	30_19-nfs-kill-unlock-1
> 	9999900_BH_Sync-remove-1
> 	9999_z-execve-race-1
> 
> I benchmarked BH_Sync as a worthless logic, it increases cpu usage and
> slowdown I/O a little due suprious unplugs, basically it makes no sense
> until we change wait_on_buffer not to call run_task_queue if the BH is
> BH_Sync, but personally I prefer to nuke it than to go mangle
> wait_on_buffer, it wouldn't be a huge optimization anyways (and it's a
> noop without more than one spindle running).

I want to look with more time into this one...

> as you know I tried to fix the execve race w/o removing the fast path,
> but the lazy tlb code didn't work correctly, I'm unsure exactly what
> went wrong with it. The above fix is obviously safe instead and it
> indeed works fine. I'll be busy today and early next week. If something
> doesn't apply cleanly let me know and I can fix it for you.

Thats merged as well.

Apart from this there's a huge pile of fixes all over in -aa. It would be
good if we had them merged in.

