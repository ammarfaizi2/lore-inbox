Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265020AbTFRAKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 20:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbTFRAKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 20:10:34 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23282 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265020AbTFRAKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 20:10:34 -0400
Subject: Re: [PATCH] 2.4 preemption bug in bh_kmap_irq
From: Robert Love <rml@tech9.net>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030414172730.GA17451@rudolph.ccur.com>
References: <20030414172730.GA17451@rudolph.ccur.com>
Content-Type: text/plain
Message-Id: <1055895865.7069.1808.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 17 Jun 2003 17:24:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 10:27, Joe Korty wrote:

> The bug is that bh_map_irq *conditionally* calls kmap_atomic (which
> disables preemption as one of its functions), while bh_unmap_irq
> *unconditionally* calls kunmap_atomic (which enables it).  This
> imbalance results in a occasional off-by-one preempt_count, which in
> turn causes IDE PIO mode interrupt code (specifically, read_intr) to
> erronously invoke preempt_schedule while at interrupt level.

Thanks for this (and sorry for the very delayed reply).

I am going to put this in the 2.4.21 preempt-kernel patch, because
actually someone else here at MontaVista fixed the problem in the same
exact way a loooong time ago and it seems to work.

I agree it is suboptimal and I will be happy to take patches from
someone else with a better idea. Until then, simplicity rules.  Thanks.

	Robert Love


