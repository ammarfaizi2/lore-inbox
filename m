Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRJDK1X>; Thu, 4 Oct 2001 06:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273345AbRJDK1N>; Thu, 4 Oct 2001 06:27:13 -0400
Received: from chiara.elte.hu ([157.181.150.200]:46601 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S273305AbRJDK1F>;
	Thu, 4 Oct 2001 06:27:05 -0400
Date: Thu, 4 Oct 2001 12:25:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <3BBC30B6.1030203@wipro.com>
Message-ID: <Pine.LNX.4.33.0110041221330.6256-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Oct 2001, BALBIR SINGH wrote:

> Shouldn't the interrupt mitigation be on a per CPU basis? [...]

this was done by an earlier version of the patch, but it's wrong. An IRQ
cannot arrive to multiple CPUs at once (well, normal device interrupts at
least) - it will arrive either to some random CPU, or can be bound via
/proc/irq/N/smp_affinity. (there are architectures that do
soft-distribution of interrupts, but that can be considered pseudo-random)

But in both cases, it's the actual, per-irq IRQ load that matters. If one
CPU is hogged by IRQ handlers that is not an issue - other CPUs can still
take over the work. If *all* CPUs are hogged then the patch detects the
overload.

	Ingo

