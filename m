Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUILUcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUILUcI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 16:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUILUcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 16:32:08 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:18601 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261405AbUILUcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 16:32:05 -0400
Date: Sun, 12 Sep 2004 22:33:08 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Chris Wedgwood <cw@f00f.org>, Lee Revell <rlrevell@joe-job.com>,
       Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       LKML <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Message-ID: <20040912203308.GA3049@dualathlon.random>
References: <593560000.1094826651@[10.10.2.4]> <Pine.LNX.4.44.0409101555510.16784-100000@localhost.localdomain> <20040910151538.GA24434@devserv.devel.redhat.com> <20040910152852.GC15643@x30.random> <20040910153421.GD24434@devserv.devel.redhat.com> <1095016687.1306.667.camel@krustophenia.net> <20040912192515.GA8165@taniwha.stupidest.org> <20040912193542.GB28791@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912193542.GB28791@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 09:35:42PM +0200, Ingo Molnar wrote:
> no. A 2 msec nonpreemptable delay is a 2 msec delay, irqs on or off
> alike.

irq-latency is an order of magnitude higher prio, than the scheduler
latency. above you only talk about scheduler latency.

with irq on and nested irqs enabled, the irq latency will have a chance
to be less than 2 msec.

take audio playback for example, with an huge buffering between
userspace and kernel and kernel submitting the next I/O via irqs, the
scheduler/userspace latency almost doesn't matter, only the
_irq_latency_ matters. 

hence I don't think not allowing nested irqs at all is a good idea and
it's a nice feature to support them.

ideally all irq handlers should be quick, but if some is not quick,
really it must enable irqs and allow other lowlatency interrupts to be
nested on top of it (like audio/video etc..).
