Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUILWZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUILWZp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 18:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUILWZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 18:25:45 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56714 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263429AbUILWZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 18:25:43 -0400
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
From: Lee Revell <rlrevell@joe-job.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <20040912220720.GC3049@dualathlon.random>
References: <593560000.1094826651@[10.10.2.4]>
	 <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain>
	 <20040910151538.GA24434@devserv.devel.redhat.com>
	 <20040910152852.GC15643@x30.random>
	 <20040910153421.GD24434@devserv.devel.redhat.com>
	 <1095016687.1306.667.camel@krustophenia.net>
	 <20040912192515.GA8165@taniwha.stupidest.org>
	 <20040912193542.GB28791@elte.hu> <20040912203308.GA3049@dualathlon.random>
	 <1095025000.22893.52.camel@krustophenia.net>
	 <20040912220720.GC3049@dualathlon.random>
Content-Type: text/plain
Message-Id: <1095027951.22893.69.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 12 Sep 2004 18:25:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-12 at 18:07, Andrea Arcangeli wrote:
> On Sun, Sep 12, 2004 at 05:36:41PM -0400, Lee Revell wrote:
> > But in this case the hardirq handler can run for 2ms, which caused a
> > scheduler latency problem, because nothing could run but other IRQs. 
> > The IRQ threading in Ingo's patches solves the problem, and seems to me
> > to be the correct solution.
> 
> the irq threading must have a cost, doesn't it? I doubt you want to
> offload irqs to a kernel thread on a server, *that* would be slow (irq
> nesting is zerocost compared to scheduling a kernel thread).

Yes, on a server you would probably disable threading for the disk and
network IRQs (the VP patch lets you set this via /proc).  This feature
effectively gives you IPLs on Linux, albeit only two of them.  For
example to prevent heavy traffic on one network interface from impacting
the latency of the other, you could enable threading for the first and
disable it for the second.

I am still unsure why the IDE i/o completion is the one place that
breaks the assumption that hardirq handlers execute quickly.

Lee

