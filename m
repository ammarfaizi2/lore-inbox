Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUG1HFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUG1HFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266569AbUG1HFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:05:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:6882 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266366AbUG1HFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:05:17 -0400
Date: Wed, 28 Jul 2004 00:03:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dimitri Sivanich <sivanich@sgi.com>
Cc: manfred@colorfullife.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH] Move cache_reap out of timer context
Message-Id: <20040728000340.7f95060f.akpm@osdl.org>
In-Reply-To: <20040714180942.GA18425@sgi.com>
References: <20040714180942.GA18425@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri Sivanich <sivanich@sgi.com> wrote:
>
> I'm submitting two patches associated with moving cache_reap functionality
>  out of timer context.  Note that these patches do not make any further
>  optimizations to cache_reap at this time.
> 
>  The first patch adds a function similiar to schedule_delayed_work to
>  allow work to be scheduled on another cpu.
> 
>  The second patch makes use of schedule_delayed_work_on to schedule
>  cache_reap to run from keventd.

It goes splat in cache_reap() if slab debugging is enabled, for rather
obvious reasons:

#if DEBUG
	BUG_ON(!in_interrupt());
	BUG_ON(in_irq());
#endif

I've so far spent nearly two days just getting all the gunk people have
sent in the last two weeks to compile properly.  Heaven knows how long
it'll take to test it.  So I need somebody to grump at.  So.  Grump.

May I have the temerity to suggest that it would be more efficient if
people were to test their own patches a bit more before sending them?

