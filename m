Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266866AbUBFWES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266478AbUBFWER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:04:17 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:40644 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266866AbUBFWCu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:02:50 -0500
Message-ID: <40240F07.9060105@cyberone.com.au>
Date: Sat, 07 Feb 2004 09:02:47 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <200402061815.i16IFhY07073@owlet.beaverton.ibm.com> <207100000.1076092771@flay>
In-Reply-To: <207100000.1076092771@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>    Good stuff, I just gave the patch a spin and things seem a little
>>    calmer. However Im still seeing a lot of balancing going on within a
>>    node.
>>
>>This is a clearly recognizable edge case, so I'll try drawing this up on
>>some paper and see if I can suggest another patch.  There's no good reason
>>to move one lone process from a particular processor to another idle one.
>>
>>But it also approaches a question that's come up before:  if you have 2
>>tasks on processor A and 1 on processor B, do you move one from A to B?
>>One argument is that the two tasks on A will take twice as long as
>>the one on B if you do nothing.  But another says that bouncing a task
>>around can't correct the overall imbalance and so is wasteful.  I know
>>of benchmarks where both behaviors are considered important.  Thoughts?
>>
>
>It's the classic fairness vs throughput thing we've argued about before.
>Most workloads don't have that static a number of processes, but it 
>probably does need to do it if the imbalance is persistent ... but much
>more reluctantly than normal balancing. See the patch I sent out a bit
>earlier to test it - that may be *too* extreme in the other direction,
>but it should confirm what's going on, at least.
>
>

Yep. I've argued for fairness here, and that is presently what
we get. Between nodes the threshold should probably be higher
though.

