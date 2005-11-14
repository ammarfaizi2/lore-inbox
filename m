Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbVKNXDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbVKNXDt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 18:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVKNXDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 18:03:49 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:58252 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932174AbVKNXDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 18:03:48 -0500
Message-ID: <437917CF.5060304@us.ibm.com>
Date: Mon, 14 Nov 2005 17:03:43 -0600
From: Brian Twichell <tbrian@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: mbligh@mbligh.org, anton@samba.org, slpratt@us.ibm.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Database regression due to scheduler changes ?
References: <436FD291.2060301@us.ibm.com> <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz> <436FDDE2.4000708@us.ibm.com> <436FF6A6.1040708@yahoo.com.au> <43718334.2090905@us.ibm.com> <43718DFE.3040600@yahoo.com.au>
In-Reply-To: <43718DFE.3040600@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Just one other thing - A couple of fields aren't actually getting
> initialised at all, which I didn't pick up on.
>
> This bug looks to have been due to a mismerge between the
> common asm-powerpc directory and one of my scheduler changes
> somewhere along the line.
>
> If you get time to try this out, that would be great.
>
>===================================================================
>--- linux-2.6.orig/include/asm-powerpc/topology.h	2005-11-09 16:43:16.000000000 +1100
>+++ linux-2.6/include/asm-powerpc/topology.h	2005-11-09 16:45:17.000000000 +1100
>@@ -51,6 +51,10 @@ static inline int node_to_first_cpu(int 
> 	.cache_hot_time		= (10*1000000),		\
> 	.cache_nice_tries	= 1,			\
> 	.per_cpu_gain		= 100,			\
>+	.busy_idx		= 3,			\
>+	.idle_id		= 1,			\
>+	.newidle_idx		= 2,			\
>+	.wake_idx		= 1,			\
> 	.flags			= SD_LOAD_BALANCE	\
> 				| SD_BALANCE_EXEC	\
> 				| SD_BALANCE_NEWIDLE	\
>  
>
Nick,

That patch eliminates the regression on 2.6.13-rc5.  Thanks !!
We are currently evaluating it with other workloads.

It also gives a boost on 2.6.14, but unfortunately we are still 1%
regressed on 2.6.14.  (The regression on 2.6.14 was larger than
the regression on 2.6.13-rc5.)  We're trying to isolate the 2.6.14
regression now.  I'll let you know if we isolate it to a
scheduler change.

Cheers,
Brian

