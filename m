Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267194AbUGMWja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267194AbUGMWja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267196AbUGMWi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:38:27 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:16789 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S267188AbUGMWhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:37:24 -0400
Date: Wed, 14 Jul 2004 00:37:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040713223701.GM974@dualathlon.random>
References: <20040712163141.31ef1ad6.akpm@osdl.org> <200407130001.i6D01pkJ003489@localhost.localdomain> <20040712170844.6bd01712.akpm@osdl.org> <20040713162539.GD974@dualathlon.random> <20040713114829.705b9607.akpm@osdl.org> <20040713213847.GH974@dualathlon.random> <20040713145424.1217b67f.akpm@osdl.org> <20040713220103.GJ974@dualathlon.random> <20040713152532.6df4a163.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713152532.6df4a163.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 03:25:32PM -0700, Andrew Morton wrote:
> 	local_irq_disable();
> 	<fiddle with per-cpu stuff>
> 	function_which_calls_cond_resched();
> 	<fiddle with per-cpu stuff>
> 	local_irq_enable();
> 
> then we want might_sleep() to warn about the bug.

might_sleep currently _doesn't_ warn about any bug in the above case I
quoted.

the kmalloc example is trapped instead.

>From my part I don't like anybody to call schedule with irq disabled
(and I would definitely put a debug check in schedule() for that, guess
how I found about the missing sti in entry.S btw). But if you are ok
with people calling schedule with irq disabled then I cannot put a check
in there. sti doesn't cost that much, and the work-to-do and sched_yield
paths are _never_ fast paths, so they don't worth an hack like that.
