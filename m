Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbUDBHTM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 02:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbUDBHTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 02:19:12 -0500
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:63111 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263308AbUDBHTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 02:19:08 -0500
Message-ID: <406D13D4.8040607@yahoo.com.au>
Date: Fri, 02 Apr 2004 17:18:44 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>, Ingo Molnar <mingo@redhat.com>,
       John Hawkes <hawkes@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Scheduler balancing statistics
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have been adapting Rick's schedstats package to extract
more information from the sched-domains infrastructure.

Before I release a patch, I'd like some input as to what
statistics people want covered, and in what form they would
like them presented (I'm talking only about balancing).

I have covered the basic stuff I could think of, and
written a small C program to parse it (I'm no good at perl)
and output this (sorry it is still pretty ugly):

npiggin@didi:~/usr/src/linux-2.4$ stats7 pre post
For domain0
  31.005358l load balance calls / s move 1.162474l tasks / s
   Of which, 66.198008l% calls and 67.187500l% task moves from idle balancing
    93.539823l% found no imbalance
    2.654867l% found an imbalance but failed
    30.232558l% of tasks were moved with cache nice
   Of which, 25.834798l% calls and 28.125000l% task moves from busy balancing
    95.918367l% found no imbalance
    0.000000l% found an imbalance but failed
    100.000000l% of tasks were moved with cache nice
   Of which, 7.967194l% calls and 4.687500l% task moves from newidle balancing
    94.117647l% found no imbalance
    0.000000l% found an imbalance but failed
    100.000000l% of tasks were moved with cache nice
  0.000000l active balances / s  move 0.000000l tasks / s
  0.036327l passive load balances / s
  2.070657l affine wakeups / s
  0.000000l exec balances / s

This was the behaviour during a make -j4 bzImage on a 2xSMP. For
a NUMA system, it would also give you domain1 for example.

A few interesting things this tells us: load_balance is being
called 31 times per second, ~95% of the time there is no imbalance,
and it moves 1.16 tasks per second.

idle balancing is going over the cache_nice_tries limit 70% of
the time which might warrant cache_nice_tries being increased.

etc.

Comments?
