Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSH0Sda>; Tue, 27 Aug 2002 14:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316728AbSH0Sda>; Tue, 27 Aug 2002 14:33:30 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:46352 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S316705AbSH0Sda>; Tue, 27 Aug 2002 14:33:30 -0400
Message-ID: <3D6BC685.216B5B67@zip.com.au>
Date: Tue, 27 Aug 2002 11:35:49 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lahti Oy <rlahti@netikka.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched.c
References: <000b01c24df5$aacc7ed0$d20a5f0a@deldaran>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lahti Oy wrote:
> 
> Small patch that makes NR_CPUS loops decrement from 31 to 0 in sched.c to
> squeeze out some cycles (of course only on SMP machines). Also deprecated a
> macro that was only used once in the code and changed one if-conditional to
> else if.
> 
> ...
> 
> - for (i = 0; i < NR_CPUS; i++)
> + for (i = NR_CPUS; i; i--)
>    sum += cpu_rq(i)->nr_running;

Off-by-one there.  You'd want

	for (i = NR_CPUS; --i >= 0; )

or something similarly foul ;)

But these are not performance-critical functions.  And by far the
most inefficient part of them is that they're reading data for
CPUs which cannot exist.   That can be fixed with a `cpu_possible(i)'
test in there, but Rusty was going to give us a `for_each_cpu' macro.
We haven't seen that yet.
