Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUBFSSc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265577AbUBFSSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:18:31 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:40400 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265353AbUBFSSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:18:30 -0500
Message-Id: <200402061815.i16IFhY07073@owlet.beaverton.ibm.com>
To: Anton Blanchard <anton@samba.org>
cc: piggin@cyberone.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mjbligh@us.ibm.com, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1 
In-reply-to: Your message of "Fri, 06 Feb 2004 21:30:10 +1100."
             <20040206103010.GI19011@krispykreme> 
Date: Fri, 06 Feb 2004 10:15:43 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Good stuff, I just gave the patch a spin and things seem a little
    calmer. However Im still seeing a lot of balancing going on within a
    node.

This is a clearly recognizable edge case, so I'll try drawing this up on
some paper and see if I can suggest another patch.  There's no good reason
to move one lone process from a particular processor to another idle one.

But it also approaches a question that's come up before:  if you have 2
tasks on processor A and 1 on processor B, do you move one from A to B?
One argument is that the two tasks on A will take twice as long as
the one on B if you do nothing.  But another says that bouncing a task
around can't correct the overall imbalance and so is wasteful.  I know
of benchmarks where both behaviors are considered important.  Thoughts?

Rick
