Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUILVgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUILVgf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 17:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUILVgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 17:36:35 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:60549 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262279AbUILVgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 17:36:33 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Lee Revell <rlrevell@joe-job.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20040912203308.GA3049@dualathlon.random>
References: <593560000.1094826651@[10.10.2.4]>
	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
	 <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
	 <20040910153421.GD24434@devserv.devel.redhat.com>
	 <1095016687.1306.667.camel@krustophenia.net>
	 <20040912192515.GA8165@taniwha.stupidest.org>
	 <20040912193542.GB28791@elte.hu>  <20040912203308.GA3049@dualathlon.random>
Content-Type: text/plain
Message-Id: <1095025000.22893.52.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 12 Sep 2004 17:36:41 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-12 at 16:33, Andrea Arcangeli wrote:
> On Sun, Sep 12, 2004 at 09:35:42PM +0200, Ingo Molnar wrote:
> > no. A 2 msec nonpreemptable delay is a 2 msec delay, irqs on or off
> > alike.
> 
> irq-latency is an order of magnitude higher prio, than the scheduler
> latency. above you only talk about scheduler latency.
> 

But in this case the hardirq handler can run for 2ms, which caused a
scheduler latency problem, because nothing could run but other IRQs. 
The IRQ threading in Ingo's patches solves the problem, and seems to me
to be the correct solution.

> hence I don't think not allowing nested irqs at all is a good idea and
> it's a nice feature to support them.

Agreed.  I was just pointing out that in addition to being a bad idea it
wouldn't work unless the IDE i/o completion issue is addressed.

The issue IIRC was the potential for stack overflow with 4K stacks if we
get deeply nested IRQs.  I believe the VP patches allow you to see the
IRQ nesting in the logs, you could probably grep the logs for these
incidents.

Seems like you could test the stack overflow theory by setting up a
stream of interrupts from the sound card and RTC to coincide with the
timer interrupt, then stressing the disks and network.

Lee



