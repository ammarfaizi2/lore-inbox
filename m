Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318747AbSICKUM>; Tue, 3 Sep 2002 06:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318748AbSICKUM>; Tue, 3 Sep 2002 06:20:12 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7652 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318747AbSICKUL>;
	Tue, 3 Sep 2002 06:20:11 -0400
Date: Tue, 3 Sep 2002 12:28:18 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209031150310.6862-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.44.0209031220230.25506-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Sep 2002, Tobias Ringstrom wrote:

> For the case of a game server, this means that when the CPU utilization
> gets above 50% (roughly), it will switch from -5 to +5 in dynamic
> priority in a few seconds and stay there until the CPU utilization drops
> under 50%.
> 
> Is my analysis correct, and is this what we want?

do you expect a task that uses up 50% CPU time over an extended period of
time to be rated 'interactive'?

we might make the '50%' rule to be '100% / nr_running_avg', so that if
your task is the only one in the system then it gets rated interactive -
but i suspect it will still be rated a CPU hog if it keeps trying to use
up 50% of CPU time even during busier periods. I have tried the
(1/nr_running) rule in earlier incarnations of the scheduler, and it didnt
make much difference, but we obviously need a boundary case like yours to
see the differences.

> I tried that yesterday (without the O(1) scheduler), and it does wonders
> for the in-game latency (i.e. ping).  I suppose that the dynamic prio
> will still be +5 at 70% CPU utilization even with a HZ of 1000 using the
> O(1)  scheduler.  Why would it make a difference?

(it could in theory make a difference in some rare cases, in which the
frequency of sampling resonates with internal timings of the application -
i asked for this only to make sure there are no interactions.)

	Ingo

