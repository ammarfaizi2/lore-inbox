Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267589AbUIJQbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267589AbUIJQbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUIJQaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:30:23 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:51901 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267557AbUIJQZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:25:40 -0400
Date: Fri, 10 Sep 2004 11:25:28 -0500
From: Greg Edwards <edwardsg@sgi.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.6.8.1-mm3 lockmeter on 512p w/kernbench
Message-ID: <20040910162527.GA27541@sgi.com>
References: <20040820031919.413d0a95.akpm@osdl.org> <200408201144.49522.jbarnes@engr.sgi.com> <200408201404.32515.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408201404.32515.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 02:04:32PM -0400, Jesse Barnes wrote:
| More lockstats.  dcache is obviously still there, but for some reason the rcu 
| stuff is gone (I didn't apply Manfred's patches).  I must have done some 
| stuff prior to collecting the lockstat data last time that caused it.

...[snip]...

| SPINLOCKS         HOLD            WAIT
|   UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME
| 
|         3.1%  2.2us( 102ms)   12ms( 488ms)(35.1%) 320195677 96.9%  3.1% 0.00%  *TOTAL*

...[snip]...

|  31.2% 95.2%   71us(  10ms)   37ms( 146ms)(30.2%)   2828650  4.8% 95.2%    0%  rcu_check_quiescent_state+0xf0

Looks like the RCU contention is still there.

I ran some bench marks at 512p on a 2.6.5 SUSE kernel with and without
Manfred's patches 4 and 5 added (the SUSE kernel already has the 3
accepted RCU patches), and the results were very promising.  I think
we'll want to pursue getting these other two RCU patches accepted.

I'll to get some lockmeter numbers on a latest -mm kernel next week.

Greg
