Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318643AbSIKKUi>; Wed, 11 Sep 2002 06:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318650AbSIKKUi>; Wed, 11 Sep 2002 06:20:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:39317 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318643AbSIKKUi>;
	Wed, 11 Sep 2002 06:20:38 -0400
Date: Wed, 11 Sep 2002 12:25:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Drokin <green@namesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
       Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org,
       andre@linux-ide.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911102507.GA1364@suse.de>
References: <20020911112808.A6341@namesys.com> <Pine.LNX.4.44.0209110937190.5764-100000@localhost.localdomain> <20020911120551.A937@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911120551.A937@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11 2002, Oleg Drokin wrote:
> Hello!
> 
> On Wed, Sep 11, 2002 at 09:38:25AM +0200, Ingo Molnar wrote:
> 
> > > I have preemption disabled.
> > nevertheless please print out preempt_count() in sched.c - since the big
> > IRQ cleanups we use the preemption count even if preemption is disabled.
> > this way we'll know what kind of problem happened - a stuck softirq count, 
> > a stuck hardirq count or an underflow?
> 
> You was exactly right.  preemption count is -1.  I inserted chack in
> dec_preempt_count() and here is updated correct stacktrace.  Seems
> like ide_unmap_buffer is called with some bogus data or something like
> that. Also I guess the bug is only visible with debug highmem = ON and
> highmem enabled.

ok I see the bug. it's due to the imbalanced nature of ide_map_buffer()
vs ide_unmap_buffer(). i'll cook up a fix right away.

-- 
Jens Axboe

