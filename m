Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUIMMcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUIMMcl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 08:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266619AbUIMMck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 08:32:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43745 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266603AbUIMMcV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:32:21 -0400
Date: Mon, 13 Sep 2004 14:30:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Ingo Molnar <mingo@elte.hu>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040913123036.GJ2326@suse.de>
References: <20040910153421.GD24434@devserv.devel.redhat.com> <1095016687.1306.667.camel@krustophenia.net> <20040912192515.GA8165@taniwha.stupidest.org> <20040912193542.GB28791@elte.hu> <20040912203308.GA3049@dualathlon.random> <1095025000.22893.52.camel@krustophenia.net> <20040912220720.GC3049@dualathlon.random> <1095027951.22893.69.camel@krustophenia.net> <20040913073259.GF2326@suse.de> <20040913103158.GA17625@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913103158.GA17625@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13 2004, Andrea Arcangeli wrote:
> On Mon, Sep 13, 2004 at 09:32:59AM +0200, Jens Axboe wrote:
> > completion from hardirq context, SCSI is the exception since it does it
> > defers the completion to softirq context.
> 
> which btw doesn't really make much difference at all to run it in irq
> context with irq enabled since it'll run from irq context anyways and
> you'll still depend on nested hardirqs to avoid huge latencies from
> softirq handlers (the most difference between softirq and hardirq with
> irq enabled happens if you can use spin_lock_bh instead of spin_lock_irq
> in the critical sections to protect against other cpus).
> 
> softirq runs inside an hardirq in all common cases, so a softirq is
> still an hardirq and to allow other hardirq to run you need nested
> interrupts in the hardware (which again explains why it's a bad idea to
> forbid nesting by design, and really I don't buy the slowdown argument,
> enter/exit kernel would happen anyways, it's just the pipeline will be
> stalled once and the cache may be trashed a bit, but irqs have not an
> huge memory footprint anyways).

It also does the completion lockless from the softirq context, which I
guess means it's preemptable with Ingo's patches.

The main point of the mail was that SCSI is the exception, not IDE. This
is important to note if Lee thinks that the latency problems with io
completion is IDE only and have been fixed.

-- 
Jens Axboe

