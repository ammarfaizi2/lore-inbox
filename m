Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbUK1Qva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUK1Qva (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUK1QpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:45:09 -0500
Received: from main.gmane.org ([80.91.229.2]:58581 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261330AbUK1Qev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:34:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Sun, 28 Nov 2004 10:34:46 -0600
Message-ID: <cocun6$e1g$1@sea.gmane.org>
References: <19865.1101395592@redhat.com> <200411272353.54056.arnd@arndb.de> <1101626019.2638.2.camel@laptop.fenrus.org> <200411281303.46609.arnd@arndb.de> <1101644385.2638.11.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 12-219-2-179.client.mchsi.com
User-Agent: KNode/0.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> implementing your own is still evil, but glibc provides similar
> constructs already. busy waiting in userspace is evil anyway (use futex
> :) and.... just as with atomic.h, spinlock.h only gets compiled in for
> CONFIG_SMP so the same caveats apply

Yeah, this is on it's way out now that futexes exist, but KDE (for one) used
to use spinlocks for a thread-pooled malloc (spin-sleep-spin-sleep though,
calling either sched_yield or nanosleep if the lock-grab failed - so it
wasn't a pure busy-wait). It didn't reuse spinlock.h from the kernel, but
it did use the general concept, since the old pre-futex posix mutexes were
crazy-slow for a lock which was heavily used but rarely contended.

