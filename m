Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286455AbRLTWzU>; Thu, 20 Dec 2001 17:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286453AbRLTWzK>; Thu, 20 Dec 2001 17:55:10 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:39428 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286448AbRLTWy5>; Thu, 20 Dec 2001 17:54:57 -0500
Date: Thu, 20 Dec 2001 14:57:55 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Momchil Velikov <velco@fadata.bg>
cc: george anzinger <george@mvista.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
In-Reply-To: <87y9jxzg5q.fsf@fadata.bg>
Message-ID: <Pine.LNX.4.40.0112201453390.1622-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Dec 2001, Momchil Velikov wrote:

> >>>>> "George" == george anzinger <george@mvista.com> writes:
>
> George> Davide Libenzi wrote:
> >> Local RT tasks apply POSIX priority rules inside the local CPU, that means
> >> that an RT task running on CPU0 cannot preempt another task ( being it
> >> normal or RT ) on CPU1.
> [...]
> >> Global RT tasks, that live in a separate run queue, have the ability to
> >> preempt remote CPU and this can lead.
> [...]
> >> The local/global RT task selection is done with setscheduler() with a new
> >> ( or'ed ) flag SCHED_RTGLOBAL, and this means that the default is RT task
> >> local.
>
> George> My understanding of the POSIX standard is the the highest priority
> George> task(s) are to get the cpu(s) using the standard calls.  If you want to
> George> deviate from this I think the standard allows extensions, but they IMHO
> George> should be requested, not the default, so I would turn your flag around
> George> to force LOCAL, not GLOBAL.
>
> I'd like to second that, IMHO the RT task scheduling should trade
> throughput for latency, and if someone wants priority inversion, let
> him explicitly request it.

No a great performance loss anyway. It's zero performance loss if the CPU
that has ran the woke up RT task for the last time is not running another
RT task ( very probable ). If the last CPU of the woke up task is running
another RT task a CPU discovery loop ( like the current scheduler ) must
be triggered. Not a great deal anyway.




- Davide


