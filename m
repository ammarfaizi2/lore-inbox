Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265037AbUF1PnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbUF1PnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 11:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUF1PnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 11:43:19 -0400
Received: from chaos.analogic.com ([204.178.40.224]:55434 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265037AbUF1PnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 11:43:05 -0400
Date: Mon, 28 Jun 2004 11:42:53 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Con Kolivas <kernel@kolivas.org>
cc: Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nice 19 process still gets some CPU
In-Reply-To: <40E03844.1080000@kolivas.org>
Message-ID: <Pine.LNX.4.53.0406281131190.4245@chaos>
References: <40E035CE.1020401@techsource.com> <40E03376.20705@kolivas.org>
 <40E03C2D.5000809@techsource.com> <40E03844.1080000@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004, Con Kolivas wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Timothy Miller wrote:
> |
> |
> | Con Kolivas wrote:
> |
> |>
> |> It definitely should _not_ starve. That is the unixy way of doing
> |> things. Everything must go forward. Around 5% cpu for nice 19 sounds
> |> just right. If you want scheduling only when there's spare cpu cycles
> |> you need a sched batch(idle) implementation.
> |>
> |>
> |
> | Well, since I can't rewrite the app, I can't make it sched batch.  Nice
> | values are an easy thing to get at for anything that's running.
> |
> | Besides, comparing nice 0 to nice 19, I'd expect something more like a
> | 100:1 ratio or worse.  (That is, I don't expect nice to be linear.)
> |
> | Maybe this is just me, but when I set a process to the worst possible
> | priority (nice 19), I expect it only to run when nothing else needs the
> | CPU.
>
>
> Sched batch is a kernel modification, and a simple wrapper will allow
> you  to run _any_ program as sched batch without modifying it's source.
>
> The design has had that ratio of 20:1 for a very long time so now is not
> the time to suddenly decide it should be different. However if you want
> to make it 100:1 for your machine feel free to edit kernel/sched.c
> and change
> #define MIN_TIMESLICE		( 10 * HZ / 1000)
> to
> #define MIN_TIMESLICE		( 1 * HZ / 1000)
>
> That will give you more what you're looking for.
>
> Con


And if HZ is 100, you have gone from 1 to 0 which probably
means you haven't done anything. It seems that if a process
is computable, it will always get the CPU at least for one
tick.

The original poster wants it to not get the CPU if there is
anything else that is computable. Since the scheduler looks
at each task in turn, I don't think that ever happens with
the either SCHED_FIFO or SCHED_RR. Maybe he can change the
policy to SCHED_OTHER and see if that works.

The granularity of -19 to +19 is not really very good for
fine process control in Unix..

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


