Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265419AbTFSMGq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 08:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbTFSMGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 08:06:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22416 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265419AbTFSMGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 08:06:41 -0400
Date: Thu, 19 Jun 2003 14:16:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Joe Korty <joe.korty@ccur.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 preemption bug in bh_kmap_irq
Message-ID: <20030619121658.GK6445@suse.de>
References: <20030414172730.GA17451@rudolph.ccur.com> <1055895865.7069.1808.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055895865.7069.1808.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17 2003, Robert Love wrote:
> On Mon, 2003-04-14 at 10:27, Joe Korty wrote:
> 
> > The bug is that bh_map_irq *conditionally* calls kmap_atomic (which
> > disables preemption as one of its functions), while bh_unmap_irq
> > *unconditionally* calls kunmap_atomic (which enables it).  This
> > imbalance results in a occasional off-by-one preempt_count, which in
> > turn causes IDE PIO mode interrupt code (specifically, read_intr) to
> > erronously invoke preempt_schedule while at interrupt level.
> 
> Thanks for this (and sorry for the very delayed reply).
> 
> I am going to put this in the 2.4.21 preempt-kernel patch, because
> actually someone else here at MontaVista fixed the problem in the same
> exact way a loooong time ago and it seems to work.
> 
> I agree it is suboptimal and I will be happy to take patches from
> someone else with a better idea. Until then, simplicity rules.  Thanks.

See 2.5 for the right fix.

-- 
Jens Axboe

