Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317395AbSGITbA>; Tue, 9 Jul 2002 15:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317399AbSGITa7>; Tue, 9 Jul 2002 15:30:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22744 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317395AbSGITa4>;
	Tue, 9 Jul 2002 15:30:56 -0400
Date: Wed, 10 Jul 2002 21:30:37 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
Subject: Re: O(1) scheduler "complex" macros
In-Reply-To: <Pine.LNX.4.44.0207102027120.14732-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207102049510.15332-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the best solution might be to just lock the 'next' task - this needs a new
per-task irq-safe spinlock, to avoid deadlocks. This way whenever a task
is in the middle of a context-switch it cannot be scheduled on another
CPU.

in fact this solution simplifies things - only two per-arch macros are
needed. I've done this in my current 2.5.25 tree:

	http://redhat.com/~mingo/O(1)-scheduler/sched-2.5.25-A4

check out the sparc64 changes for the 'complex' locking scenario - it's
untested, please give it a go on ia64, does that solve your problems? x86
is tested and works just fine.

	Ingo

