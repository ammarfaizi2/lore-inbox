Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318811AbSICQl4>; Tue, 3 Sep 2002 12:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318812AbSICQl4>; Tue, 3 Sep 2002 12:41:56 -0400
Received: from otter.mbay.net ([206.55.237.2]:40204 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S318811AbSICQlz> convert rfc822-to-8bit;
	Tue, 3 Sep 2002 12:41:55 -0400
From: John Alvord <jalvo@mbay.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tobias Ringstrom <tori@ringstrom.mine.nu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
Date: Tue, 03 Sep 2002 09:46:09 -0700
Message-ID: <mmp9nukto4k7halscs3tq8gc8tqtdlf8l0@4ax.com>
References: <Pine.LNX.4.44.0209031150310.6862-100000@boris.prodako.se> <Pine.LNX.4.44.0209031220230.25506-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0209031220230.25506-100000@localhost.localdomain>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002 12:28:18 +0200 (CEST), Ingo Molnar <mingo@elte.hu>
wrote:

>
>On Tue, 3 Sep 2002, Tobias Ringstrom wrote:
>
>> For the case of a game server, this means that when the CPU utilization
>> gets above 50% (roughly), it will switch from -5 to +5 in dynamic
>> priority in a few seconds and stay there until the CPU utilization drops
>> under 50%.
>> 
>> Is my analysis correct, and is this what we want?
>
>do you expect a task that uses up 50% CPU time over an extended period of
>time to be rated 'interactive'?
>
>we might make the '50%' rule to be '100% / nr_running_avg', so that if
>your task is the only one in the system then it gets rated interactive -
>but i suspect it will still be rated a CPU hog if it keeps trying to use
>up 50% of CPU time even during busier periods. I have tried the
>(1/nr_running) rule in earlier incarnations of the scheduler, and it didnt
>make much difference, but we obviously need a boundary case like yours to
>see the differences.
>
>> I tried that yesterday (without the O(1) scheduler), and it does wonders
>> for the in-game latency (i.e. ping).  I suppose that the dynamic prio
>> will still be +5 at 70% CPU utilization even with a HZ of 1000 using the
>> O(1)  scheduler.  Why would it make a difference?
>
>(it could in theory make a difference in some rare cases, in which the
>frequency of sampling resonates with internal timings of the application -
>i asked for this only to make sure there are no interactions.)
>
It seems to me that this condition could arise for any server process
which is used by many interactive processes. Imagine 300 users and a
server process which needs 70% to do the work. This could be a
database server as well as the current game server.

john
