Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267209AbUGMWx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267209AbUGMWx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267214AbUGMWxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:53:55 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:14797 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267209AbUGMWx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:53:28 -0400
Date: Wed, 14 Jul 2004 00:53:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040713225305.GO974@dualathlon.random>
References: <200407130001.i6D01pkJ003489@localhost.localdomain> <20040712170844.6bd01712.akpm@osdl.org> <20040713162539.GD974@dualathlon.random> <20040713114829.705b9607.akpm@osdl.org> <20040713213847.GH974@dualathlon.random> <20040713145424.1217b67f.akpm@osdl.org> <20040713220103.GJ974@dualathlon.random> <20040713152532.6df4a163.akpm@osdl.org> <20040713223701.GM974@dualathlon.random> <20040713154448.4d29e004.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713154448.4d29e004.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 03:44:48PM -0700, Andrew Morton wrote:
> Yeah, I know.  might_sleep() in cond_resched() makes sense.

What I'm doing is basically to replace all might_sleep with cond_resched
and then I add might_sleep in cond_resched. I also merged all
new might_sleep in Ingo's patch (converted to cond_resched). We'll see
what happens then when I try to boot such a thing (the sti and
sched_yield already given me some troubles).

I was considering adding a cond_resched_costly but I didn't see anything
really that costly to need a CONFIG_LOW_RESCHED_OVERHEAD.

btw, cond_resched should only be defined as might_sleep with PREEMPT
enabled, otherwise it's pointless to check need_resched at almost every
spin_unlock and to do it during cond_resched too. if might_sleep doesn't
BUG it means we didn't need to check need_resched in the first place if
preempt is enabled.

cond_resched_lock is another story of course.
