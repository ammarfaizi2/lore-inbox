Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbTCVQ1C>; Sat, 22 Mar 2003 11:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262903AbTCVQ1C>; Sat, 22 Mar 2003 11:27:02 -0500
Received: from franka.aracnet.com ([216.99.193.44]:37558 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262800AbTCVQ07>; Sat, 22 Mar 2003 11:26:59 -0500
Date: Sat, 22 Mar 2003 08:37:53 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: lmbench results for 2.4 and 2.5
Message-ID: <363980000.1048351072@[10.10.2.4]>
In-Reply-To: <3E7C8B22.7020505@nortelnetworks.com>
References: <3E7C8B22.7020505@nortelnetworks.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My previous testing with unix sockets prompted me to do a few lmbench 
> runs with 2.4.19 and 2.5.65.  The results have me a bit concerned, as 
> there is no area where 2.5 is faster and several where it is 
> significantly slower.
> 
> In particular:
> 
> stat is 8 times worse
> open/close are 7 times worse
> fork is twice as expensive
> tcp latency is 5 times worse
> file deletion and mmap are both twice as expensive
> tcp bandwidth is 5 times worse
> 
> Optimizing for muliple processors and heavy loads is nice, but this 
> looks like its happening at the cost of basic performance.  Is this 
> really the route we should be taking?

I think you're jumping to conclusions about what causes this - let's
actually try to find the real root cause. These things have many different 
causes ... for instance, rmap has been found to be a problem in some 
workloads (especially things like the fork stuff). If you want to 
try 65-mjb1 with and without the the shared pagetable stuff, you
may get some different results. (if you have stability problems, try
doing a patch -p1 -R of 400-shpte, it seems a little fragile right now).

http://www.kernel.org/pub/linux/kernel/people/mbligh/2.5.65/

Also, if you can get kernel profiles for each test, that'd help to work
out the root cause.

M.

