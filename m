Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbUAOQDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 11:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUAOQDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 11:03:49 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:20638
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S264547AbUAOQDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 11:03:45 -0500
Message-ID: <4006B998.5040403@tmr.com>
Date: Thu, 15 Jan 2004 11:02:32 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Randy Appleton <rappleto@nmu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unneeded Code Found??
References: <3FFF3931.4030202@nmu.edu>
In-Reply-To: <3FFF3931.4030202@nmu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Appleton wrote:
> I think I have found some useless code in the Linux kernel
> in the block request functions.
>                                                                                         
> 
> I have modified the __make_request function in ll_rw_blk.c.
> Now every request for a block off the hard drive is logged.
>                                                                                         
> 
> The function __make_request has code to attempt to merge the current
> block request with some contigious existing request for better
> performance. This merge function keeps a one-entry cache pointing to the
> last block request made.  An attempt is made to merge the current
> request with the last request, and if that is not possible then
> a search of the whole queue is done, looking at merger possibililites.
>                                                                                         
> 
> Looking at the data from my logs, I notice that over 50% of all requests
> can be merged.  However, a merge only ever happens between the
> current request and the previous one.  It never happens between the
> current request and any other request that might be in the queue (for
> more than 50,000 requests examined).
>                                                                                         
> 
> This is true for several test runs, including "daily usage" and doing
> two kernel compiles at the same time.  I have only tested on a
> single-CPU machine.
>                                                                                         
> 
> I wonder if the code (and CPU time) used to search the entire request
> queue is actually useful.  Would this be a reasonable candidate for code
> elimination?

If you never get a hit, it means either (a) your test load actually 
doesn't have one, or (b) the code isn't correctly finding them.

Of course if your disk is keeping up and the queue is short, then you 
may simply not have anything in the queue to match.

Any of this kick a train of thought?


-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
