Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266459AbRGYOMc>; Wed, 25 Jul 2001 10:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268576AbRGYOMW>; Wed, 25 Jul 2001 10:12:22 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28179 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266523AbRGYOMN>; Wed, 25 Jul 2001 10:12:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Patrick Dreker <patrick@dreker.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 16:16:47 +0200
X-Mailer: KMail [version 1.2]
Cc: <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0107241726130.29909-100000@penguin.transmeta.com> <E15PJuY-0000A3-00@wintermute>
In-Reply-To: <E15PJuY-0000A3-00@wintermute>
MIME-Version: 1.0
Message-Id: <01072516164705.00907@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wednesday 25 July 2001 10:20, Patrick Dreker wrote:
> I did a few more test runs on each of the kernels to check if the
> results are reproducible:
> 2.4.7-plain:
> 17.320u 115.100s 2:17.36 96.4%	0+0k 0+0io 110pf+0w
> 17.200u 94.170s 1:53.14 98.4%	0+0k 0+0io 110pf+0w
> 17.490u 113.730s 2:13.48 98.3%	0+0k 0+0io 110pf+0w
>
> 2.4.5-use_once:
> 14.730u 108.310s 2:09.57 94.9%	0+0k 0+0io 203pf+0w
> 13.880u 79.410s 1:38.64 94.5%	0+0k 0+0io 226pf+0w
> 14.840u 78.680s 1:37.86 95.5%	0+0k 0+0io 238pf+0w

Look at the CPU dropping along with the times.  Usually it goes the 
other way.

> The time under 2.4.5-use_once stays constant from the second run on
> (I tried 3 more times), while 2.4.7 shows pretty varying performance
> but I have never seen it getting better than the 1:53.14 from the
> second run above. I had stopped all services which I knew to cause
> periodic activity (exim, cron/anacron) which could disturb the tests.
>
> I also noticed, that under 2.4.5 after the 3 test runs the KDE
> Taskbasr got swapped out, while under 2.4.7 this was not the case.

Not swapping out the task bar is a different problem, only loosely 
related.  The use-once thing is a step in the right direction because 
it makes relatively more file IO pages available for deactivation 
versus swap pages, and the task bar has a better chance of surviving.  
However, it's not a really firm connection to the problem.

An additional line of attack is to look at the aging policy.  I have a 
strong sense we can do it better.  Right now we're aging everything 
down to a uniform zero and that really obviously throws away a lot of 
information.

In the 2.5 timeframe, better unification of the page cache and swap 
paths will make it much easier to focus on the taskbar problem.

--
Daniel
