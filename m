Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265623AbUBFSjy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUBFSjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:39:54 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:20910 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265623AbUBFSjv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:39:51 -0500
Date: Fri, 06 Feb 2004 10:39:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>
cc: piggin@cyberone.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1 
Message-ID: <207100000.1076092771@flay>
In-Reply-To: <200402061815.i16IFhY07073@owlet.beaverton.ibm.com>
References: <200402061815.i16IFhY07073@owlet.beaverton.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     Good stuff, I just gave the patch a spin and things seem a little
>     calmer. However Im still seeing a lot of balancing going on within a
>     node.
> 
> This is a clearly recognizable edge case, so I'll try drawing this up on
> some paper and see if I can suggest another patch.  There's no good reason
> to move one lone process from a particular processor to another idle one.
> 
> But it also approaches a question that's come up before:  if you have 2
> tasks on processor A and 1 on processor B, do you move one from A to B?
> One argument is that the two tasks on A will take twice as long as
> the one on B if you do nothing.  But another says that bouncing a task
> around can't correct the overall imbalance and so is wasteful.  I know
> of benchmarks where both behaviors are considered important.  Thoughts?

It's the classic fairness vs throughput thing we've argued about before.
Most workloads don't have that static a number of processes, but it 
probably does need to do it if the imbalance is persistent ... but much
more reluctantly than normal balancing. See the patch I sent out a bit
earlier to test it - that may be *too* extreme in the other direction,
but it should confirm what's going on, at least.

M.

