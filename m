Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267264AbUGNAkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267264AbUGNAkm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 20:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267266AbUGNAkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 20:40:41 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:19368 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267264AbUGNAki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 20:40:38 -0400
Date: Wed, 14 Jul 2004 02:40:01 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: paul@linuxaudiosystems.com, rlrevell@joe-job.com,
       linux-audio-dev@music.columbia.edu, mingo@elte.hu, arjanv@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040714004001.GR974@dualathlon.random>
References: <20040713213847.GH974@dualathlon.random> <20040713145424.1217b67f.akpm@osdl.org> <20040713220103.GJ974@dualathlon.random> <20040713152532.6df4a163.akpm@osdl.org> <20040713223701.GM974@dualathlon.random> <20040713154448.4d29e004.akpm@osdl.org> <20040713225305.GO974@dualathlon.random> <20040713160628.596b96a3.akpm@osdl.org> <20040713231803.GP974@dualathlon.random> <20040713163236.0dbf3872.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040713163236.0dbf3872.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2004 at 04:32:36PM -0700, Andrew Morton wrote:
> OK.
> 
> 
> cond_resched() is usually a waste of space with CONFIG_PREEMPT.  It might
> make sense to define a cond_resched_if_not_preempt thingy, which only does
> things if !CONFIG_PREEMPT.  We'd still need to use cond_resched() inside
> lock_kernel().

Though most of the current cond_resched invocations in mainline (and the
future ones too) should be optimized away with preempt enabled, so maybe
it's simpler to just implement a cond_resched_force() that isn't
optimized away with preempt enabled and use it in lock_kernel? I'm
missing where cond_resched is needed inside lock_kernel though,
preempt_schedule already checks TIF_NEED_RESCHED by hand (on the top of
my mind I don't recall cond_rescheds that shouldn't be optimized away
with preempt enabled).

> I think Ingo's patch includes Arjan's one.  Ingo's patch apparently breaks

Ok.

> ext3.  I have a bunch of ext3 and other fixes here, but there's still an occasional
> problem on SMP.

I also had instability with it and I've seen debug checks in ext3 too
(but it's not finished anyways), and I've still a bit of printk flooding
so I'm uncertain if it's my mistake due the more strict debugging I
added in schedule() or an issue in the newer cond_resched but thanks for
the info (sounds like not all the debug checks triggering are my mistake ;).
