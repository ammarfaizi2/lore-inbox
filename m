Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbUKPC10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbUKPC10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 21:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbUKPC10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 21:27:26 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:54217 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261759AbUKPC1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 21:27:23 -0500
Message-ID: <41996584.5080306@cyberone.com.au>
Date: Tue, 16 Nov 2004 13:27:16 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: colpatch@us.ibm.com, Darren Hart <dvhltc@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] scheduler: rebalance_tick interval update
References: <1100558313.17202.58.camel@localhost.localdomain>	 <4199550E.1030704@cyberone.com.au> <1100569992.30259.20.camel@arrakis> <41996353.1060604@cyberone.com.au>
In-Reply-To: <41996353.1060604@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
> Another example, in some ticks, a CPU won't see the updated 'jiffies', 
> other
> times it will (at least on Altix systems, this can happen).
>
>

Note that if you didn't want to have this rash of balancing attempted after
a CPU wasn't able to run the rebalance for a long time, the solution would
be to keep adding the balance interval until it becomes greater than the
current jiffies.

I actually prefer it to try to make up the lost balances, just from the
perspective of gathering scheduler statistics. I don't suspect it happens
enough to justify adding the extra logic - Darren, are you actually seeing
problems?

