Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266551AbUGKKoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266551AbUGKKoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266554AbUGKKoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:44:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:31211 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266551AbUGKKoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:44:08 -0400
Date: Sun, 11 Jul 2004 03:42:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com,
       linux-audio-dev@music.columbia.edu
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-Id: <20040711034258.796f8c6a.akpm@osdl.org>
In-Reply-To: <20040711103020.GA24797@elte.hu>
References: <20040709182638.GA11310@elte.hu>
	<20040710222510.0593f4a4.akpm@osdl.org>
	<20040711093209.GA17095@elte.hu>
	<20040711024518.7fd508e0.akpm@osdl.org>
	<20040711095039.GA22391@elte.hu>
	<20040711025855.08afbca1.akpm@osdl.org>
	<20040711103020.GA24797@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > OK, but most of the new ones are unneeded with CONFIG_PREEMPT=y.  I'm
> > still failing to see why a non-preempt, voluntary preemption kernel
> > even needs to try to be competitive with a preemptible kernel?
> 
> the reason is difference in overhead (codesize, speed) and risks (driver
> robustness).

I don't recall any testing results which showed a significant performance
difference from CONFIG_PREEMPT.

> We do not want to enable preempt for Fedora yet because it
> breaks just too much stuff

What stuff?

> (Long-term i'd like to see preempt be used unconditionally - at which
> point the 10-line CONFIG_VOLUNTARY_PREEMPT Kconfig and kernel.h change
> could go away.)

We'll never get there if people don't at least report the broken "stuff",
let alone fix it.  And "stuff" is already broken on SMP, yes?

Your voluntary preempt patch will need to borrow preempt_spin_lock() and
preempt_write_lock() btw - otherwise it won't improve worst-case latencies
on SMP at all.
