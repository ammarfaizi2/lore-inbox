Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUBHMOr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 07:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUBHMOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 07:14:47 -0500
Received: from dp.samba.org ([66.70.73.150]:11401 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263561AbUBHMOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 07:14:46 -0500
Date: Sun, 8 Feb 2004 23:14:05 +1100
From: Anton Blanchard <anton@samba.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Rick Lindsley <ricklind@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <20040208121404.GC19011@krispykreme>
References: <20040207095057.GS19011@krispykreme> <200402080040.i180eY811893@owlet.beaverton.ibm.com> <20040208011221.GV19011@krispykreme> <40258F21.30209@cyberone.com.au> <20040208014141.GX19011@krispykreme> <4025AB00.3030601@cyberone.com.au> <20040208035721.GY19011@krispykreme> <4025B572.9040904@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4025B572.9040904@cyberone.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Can you try this patch instead pretty please ;)

Still had the active rebalance problem. Martin suggested I try just the
first junk of his patch:

@@ -1442,8 +1442,8 @@ nextgroup:
        if ((long)*imbalance < 0)
                *imbalance = 0;
  
-       /* Get rid of the scaling factor now, rounding *up* as we divide */
-       *imbalance = (*imbalance + SCHED_LOAD_SCALE - 1) >> SCHED_LOAD_SHIFT;
+       /* Get rid of the scaling factor now */
+       *imbalance = *imbalance >> SCHED_LOAD_SHIFT;

This fixed the active rebalance issue, however now it doesnt want to
rebalance out of the node. Ive got one completely empty node and one full
one (all primary and secondary threads are busy).

Anton
