Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSE1PdI>; Tue, 28 May 2002 11:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSE1PdH>; Tue, 28 May 2002 11:33:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:52214 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316822AbSE1PdG>; Tue, 28 May 2002 11:33:06 -0400
Subject: Re: O(1) count_active_tasks()
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@transmeta.com
In-Reply-To: <20020526230319.GN14918@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 08:33:04 -0700
Message-Id: <1022599985.20316.32.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-05-26 at 16:03, William Lee Irwin III wrote:

> Thanks, I took some time to go over it and make it so, as I don't
> really do scheduling, I just needed a statistic there for this. It's
> not actually claimed to have any optimization value (though it may as
> a side-effect), it only addresses a pet peeve of mine. I originally
> tried avoiding sched.c by having set_current_state() tick per-cpu
> counters but that caused enormous code bloat (or did as I wrote it).

Yah, set_current_state is inlined so it would lead to a bit of code
bloat.

> This is an approximate method. I did not collect detailed statistics on
> how widely it varied from the prior method, though I did manually check
> the results against mainline for large variations or gross unfaithfulness.
> If you'd like to hold off on this until I do so, that's fine. I can get
> back to my SMP targets Tuesday and follow up then.

If I get a chance, I'll run some tests on my dual 2.5 machine and see if
they match.  But I would not let that stop anything ... this is mergable
in 2.5 imo.

One thing I notice is the patch only increments in one case:

	TASK_RUNNING -> TASK_UNINTERRUPTIBLE

whether we ever go -> TASK_UNINTERRUPTIBLE from a state other than
running I am unsure.

> Going back and looking at it, weaker memory consistency models may want
> the increment/decrement to be atomic operations, which would probably
> want some migration code to keep the counters positive. I can arrange
> that for a follow-up as well.

Personally, I would not worry about this.  This is only a statistic
after all - I am more interested in whether we are properly accounting
for everything in general.  Screw weak memory consistency computers <g>
- they need to fix nr_running too, anyhow.

	Robert Love

