Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbTKRNaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKRNaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:30:19 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8067 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262592AbTKRNaJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:30:09 -0500
Date: Tue, 18 Nov 2003 08:31:36 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: kernwek jalsl <edityacomm@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: softirqd
In-Reply-To: <20031118063551.25057.qmail@web20710.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0311180825240.30076@chaos>
References: <20031118063551.25057.qmail@web20710.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, kernwek jalsl wrote:

>
> Hi;
>
> Sorry in case I was not very clear with my
> requirements.   With real time interrupt I meant a
> real time task waiting for IO from this interrupt.
> Assume that I have a high priority interrupt and a
> real time task waiting for it. Well followimg are the
> various latencies involved:
> L1- interrupt latency
> L2- hard and soft IRQ completion
> L3 - scheduler latency
> L4 - scheduler completion
>
> L1 is pretty acceptable on Linux. For L3 we have the
> preemption and low latency patch. And for L4 the O(1)
> scheduler solves the problem. So I see L2 as the
> bootleneck especially with soft IRQ since the softIRQs
> get scheduled in a non real time thread and there is
> no wayI can tell the softIRQd that I want highest
> priority for the interrupt that will wake up my real
> time task. I was seeking a solution to this.

The fastest would not use softIRQ at all. As previously
taught, softIRQ is used for things that can be deferred.
You should handle everything in the primary ISR and
issue wake_up_interruptible() from the ISR. You should
be waking anybody sleeping in select() and anybody sleeping
in read().

>
> I know that TimeSYS has as patch for making the
> softIRQ a real time thread as well as giving
> priorities for both the top and bottom halves. Is
> there any place where I can get some performance
> figures for this patch?
>
> Regards
>

Search RTLinux.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


