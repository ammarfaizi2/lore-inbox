Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266798AbUIOBS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266798AbUIOBS0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266805AbUIOBS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:18:26 -0400
Received: from holomorphy.com ([207.189.100.168]:64151 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266798AbUIOBSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:18:24 -0400
Date: Tue, 14 Sep 2004 18:18:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Robert Love <rml@ximian.com>, Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915011809.GE9106@holomorphy.com>
References: <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095185103.23385.1.camel@betsy.boston.ximian.com> <20040914185212.GY9106@holomorphy.com> <1095188569.23385.11.camel@betsy.boston.ximian.com> <20040914192104.GB9106@holomorphy.com> <1095189593.16988.72.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095189593.16988.72.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 08:19:57PM +0100, Alan Cox wrote:
> The problem is people think of the BKL as a lock. It isn't a lock it has
> never been a lock and it's all DaveM's fault 8) for naming it that when
> he moved my asm entry point stuff into C.
> The BKL turns on old style unix non-pre-emptive sematics between all
> code that is within lock_kernel sections, that is it. That also makes it
> hard to clean up because lock_kernel is delimiting code properties (its
> essentially almost a function attribute) and spin_lock/down/up and
> friends are real locks and lock data.
> I've seen very few cases where there is a magic transform from one to
> the other because of this. So if you want to kill the BKL add proper
> locking to data structures covered by BKL users until the lock_kernel
> simply does nothing.

The perfect critic has no method, save one.


On Maw, 2004-09-14 at 20:21, William Lee Irwin III wrote:
>> or sweeps others care to devolve to me, so I'll largely be using
>> whatever tactic whoever cares to drive all this (probably Alan) prefers.

On Tue, Sep 14, 2004 at 08:19:57PM +0100, Alan Cox wrote:
> Fix the data structure locking starting at the lowest level is how I've
> always tackled these messes. When the low level locking is right the
> rest just works (usually 8)).

This is the opposite of what some parties endorse, which is pushing the
BKL downward safely as audits determine, adding locking to enable it to
be done safely, and so on. So ad hoc it is.


-- wli
