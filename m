Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbUKVVaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbUKVVaR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUKVV1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:27:20 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:16908 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S262386AbUKVV0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 16:26:38 -0500
Date: Mon, 22 Nov 2004 13:25:54 -0800
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Huey <bhuey@lnxw.com>, Esben Nielsen <simlo@phys.au.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041122212554.GA9058@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10411212107240.29110-100000@da410.ifa.au.dk> <20041122092302.GA7210@nietzsche.lynx.com> <20041122123741.GA13574@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122123741.GA13574@elte.hu>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 01:37:41PM +0100, Ingo Molnar wrote:
> in the -RT patchset one of the reasons why i've gone for the completely
> preemptible variant is to trigger all priority inversion problems
> outright. In the first variant they didnt really trigger - but they were
> present. Once the locks were almost all preemptible, PI problems
> surfaced in a big way - causing people to report them and forcing me to
> fix them :-)
> 
> There are lots of critical sections in Linux and we cannot design around
> them - so if the goal is hard-RT properties and latencies then priority
> inversion is a problem that has to be solved. Later on we could easily
> revert some of the hw-related spinlocks to raw spinlocks, and/or the
> known-O(1) critical sections as well.

Good. Yeah, the only piont I was making is not to cover up contention
problems, which are kernel performance problems with PI. That's all.
 
> the paper cited is not very persuasive to me though. It lists problems
> of an incomplete/incorrect PI implementation, and comes to the IMO false
> (and unrelated) conclusion that somehow PI-handling is not desired.

Yeah, I agree. PI has it's place, but the main point of the paper is
that getting a really good PI protocol is a very difficult thing and
might not be worth it if you can use other techniques. What you do with
that assertion is situational.

A number of those complaints, as I see it, don't apply to Linux because
of how it's avoided things like deadlocking, fine grainedness, etc... are
done. But he does, IMO, outline the difficulty of getting a decent PI
implementation.

> Obviously PI makes only sense if it's implemented correctly. I think i
> managed to fix the problems Esben's testsuite uncovered, in the current
> -RT patch. Anyway, this implementation is also special in that it relies
> on correct SMP locking of Linux:

I'll check it out.

> i dont have any intentions to turn Linux into a 'priority inheritance
> world'. PI handling is only a property of the PREEMPT_RT feature
> intended for the most latency-sensitive applications - the main and
> primary critical-section model of Linux is and should still be a healthy
> mix of spinlocks and mutexes. Having only mutexes (or only spinlocks) is
> an extreme that _does_ hurt the common case. PREEMPT_RT 'only' lives on
> the back of SMP-Linux.

Yeah, that's my point. The reason why/if/when Linux will be strong at RT
is because of the SMP work.

bill

