Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273854AbRKHPga>; Thu, 8 Nov 2001 10:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274248AbRKHPgU>; Thu, 8 Nov 2001 10:36:20 -0500
Received: from posta2.elte.hu ([157.181.151.9]:5096 "HELO posta2.elte.hu")
	by vger.kernel.org with SMTP id <S273854AbRKHPgH>;
	Thu, 8 Nov 2001 10:36:07 -0500
Date: Thu, 8 Nov 2001 17:33:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "M. Edward Borasky" <znmeb@aracnet.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEPMEAAA.znmeb@aracnet.com>
Message-ID: <Pine.LNX.4.33.0111081726310.14244-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 Nov 2001, M. Edward Borasky wrote:

> I can think of some circumstances where one would want the *opposite*
> of this patch. Consider a "time-sharing" system running both
> CPU-intensive "batch" tasks and "interactive" tasks. There is going to
> be a tradeoff between efficiency / throughput of the batch tasks and
> the response times of interactive ones. [...]

this mechanizm is already part of the scheduler and is not affected by my
patch. Interactive tasks get their '->counter' value increased gradually
via the recalculate code in the scheduler, which after some time gives
them effective priority above that of CPU-intensive processes.

To see this mechanizm working, just boot into the stock kernel or try a
kernel with the patch applied, start a few CPU-intensive processes, eg.
a couple of subshells doing an infinite loop:

	while N=1; do N=1; done &
	while N=1; do N=1; done &
	while N=1; do N=1; done &
	while N=1; do N=1; done &

and see how the interactive shell is still responding instantaneously in
such a mixed workload, despite having the same static priority as the
subshells.

	Ingo

