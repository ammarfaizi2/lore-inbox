Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266890AbUBFWxy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265610AbUBFWwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:52:08 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:22407 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266862AbUBFWvy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:51:54 -0500
Message-ID: <402419CD.3050505@cyberone.com.au>
Date: Sat, 07 Feb 2004 09:48:45 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rick Lindsley <ricklind@us.ibm.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <200402062234.i16MYgu13533@owlet.beaverton.ibm.com>
In-Reply-To: <200402062234.i16MYgu13533@owlet.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rick Lindsley wrote:

>    Yep. I've argued for fairness here, and that is presently what
>    we get. Between nodes the threshold should probably be higher
>    though.
>
>While I like the idea of a self-tuning scheduler, when combined with
>this new sched_domain algorithm it's hard to tell if the tuning or the
>algorithm is at fault when we get results we don't like.  Have you done
>much running with the auto-tuning turned off, using the old values,
>to see the impact (positive or negative) that just the new algorithm has?
>
>

I'm not sure what you mean by self-tuning. Do you mean the scheduling
backoff stuff? Because that makes very little difference on a 16-way
NUMAQ. However it becomes critical for SGI above around 128 CPUs IIRC
so I just kept it in mind when doing sched domains.

The new balancing calculations are definitely a win in my tests. One
tiny regression (the order of 1%) I saw on the NUMAQ was tbench due to
increased idle time. But I'll still take it as a win because we were
doing nearly 1000 times less inter node balancing.

