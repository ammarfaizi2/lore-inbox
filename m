Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbUKPBRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbUKPBRN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 20:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbUKPBRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 20:17:13 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:56745 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261740AbUKPBRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 20:17:09 -0500
Message-ID: <4199550E.1030704@cyberone.com.au>
Date: Tue, 16 Nov 2004 12:17:02 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Darren Hart <dvhltc@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Matt Dobson <colpatch@us.ibm.com>,
       Martin J Bligh <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] scheduler: rebalance_tick interval update
References: <1100558313.17202.58.camel@localhost.localdomain>
In-Reply-To: <1100558313.17202.58.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Darren Hart wrote:

>The current rebalance_tick() code assigns each sched_domain's
>last_balance field to += interval after performing a load_balance.  If
>interval is 10, this has the effect of saying:  we want to run
>load_balance at time = 10, 20, 30, 40, etc...  If for example
>last_balance=10 and for some reason rebalance_tick can't be run until
>30, load_balance will be called and last_balance will be updated to 20,
>causing it to call load_balance again immediately the next time it is
>called since the interval is 10 and we are already at >30.  It seems to
>me that it would make much more sense for last_balance to be assigned
>jiffies after a load_balance, then the meaning of last_balance is more
>exact: "this domain was last balanced at jiffies" rather than "we last
>handled the balance we were supposed to do at 20, at some indeterminate
>time".  The following patch makes this change.
>
>

Hi Darren,

This is how I first implemented it... but I think this will cause
rebalance points of each processor to tend to become synchronised
(rather than staggered) as ticks get lost.

