Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUJNXEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUJNXEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 19:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268019AbUJNWZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:25:17 -0400
Received: from brown.brainfood.com ([146.82.138.61]:25474 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S267497AbUJNWRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:17:01 -0400
Date: Thu, 14 Oct 2004 17:16:57 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
In-Reply-To: <Pine.LNX.4.58.0410141230380.1221@gradall.private.brainfood.com>
Message-ID: <Pine.LNX.4.58.0410141716160.1221@gradall.private.brainfood.com>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com>
 <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
 <20041014143131.GA20258@elte.hu> <Pine.LNX.4.58.0410141230380.1221@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Adam Heath wrote:

> On Thu, 14 Oct 2004, Ingo Molnar wrote:
>
> >
> > i have released the -U1 PREEMPT_REALTIME patch:
> >
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U1
> >
> > Changes since -U0:
> >
> >  - bugfix: fixed the highmem related crash reported by Adam Heath and i
> >    think this could also fix the crash reported by Mark H Johnson.
>
> I've reenabled highmem(4g).
>
> Seems to be working fine.  Has been running 11 minutes, without problems.
>
> ps: Something that irks me.  During bootup, I get the high-latency traces for
>     swapper/0.  These fill up the dmesg ring buffer, so the early messages get
>     dropped.  Is there anything that can be done to fix that?

Got my first message.

scheduling while atomic: kswapd0/0x04000001/10
caller is cond_resched+0x53/0x70
 [<c027ad31>] schedule+0x531/0x570
 [<c027b2a3>] cond_resched+0x53/0x70
 [<c012c604>] _mutex_lock+0x14/0x40
 [<c0149521>] page_lock_anon_vma+0x31/0x60
 [<c0149725>] page_referenced_anon+0x15/0x80
 [<c01498ba>] page_referenced+0x7a/0x80
 [<c0141635>] refill_inactive_zone+0x435/0x4b0
 [<c01408a3>] shrink_slab+0x143/0x160
 [<c0141728>] shrink_zone+0x78/0xc0
 [<c0141b7a>] balance_pgdat+0x23a/0x2f0
 [<c0141ced>] kswapd+0xbd/0xf0
 [<c012c140>] autoremove_wake_function+0x0/0x50
 [<c01056d2>] ret_from_fork+0x6/0x14
 [<c012c140>] autoremove_wake_function+0x0/0x50
 [<c0141c30>] kswapd+0x0/0xf0
 [<c0103a2d>] kernel_thread_helper+0x5/0x18

Config is as before, with highmem enabled being the only difference.
