Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVBYLWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVBYLWA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 06:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVBYLV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 06:21:59 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:62860 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262673AbVBYLV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 06:21:58 -0500
Message-ID: <421F0A52.5020209@yahoo.com.au>
Date: Fri, 25 Feb 2005 22:21:54 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 12/13] schedstats additions for sched-balance-fork
References: <200502251107.j1PB7Ptk008435@owlet.beaverton.ibm.com>
In-Reply-To: <200502251107.j1PB7Ptk008435@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley wrote:
>     There is little help we get from userspace, and i'm not sure we want to
>     add scheduler overhead for this single benchmark - when something like a
>     _tiny_ bit of NUMAlib use within the OpenMP library would probably solve
>     things equally well!
> 
> There's has been a general problem with sched domains and it trying to
> meet two goals: "1) spread things around evenly within a domain and
> balance across domains infrequently", and "2) load up cores before
> loading up siblings, even at the expense of violating 1)".
> 

Yes, you hit the nail on the head. Well, the other (potentially
more problematic) part of the equation is "3) keep me close to
my parent and siblings, because we'll be likely to share memory
and/or communicate".

However: I'm hoping that on unloaded or lightly loaded NUMA
systems, it is usually the right choice to spread tasks across
nodes. Especially on the newer breed of low remote latency, high
bandwidth systems like Opterons and POWER5s.

When load ramps up a bit and we start saturating CPUs, the amount
of balance-on-forking should slow down, so we start to fulfil
requirement 3 for workloads that perhaps resemble more general
purpose server stuff.

That's the plan anyway. We'll see...

