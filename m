Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268944AbUHMCGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268944AbUHMCGV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 22:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268945AbUHMCGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 22:06:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:61588 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268944AbUHMCGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 22:06:18 -0400
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
From: Dave Hansen <haveblue@us.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       steiner@sgi.com
In-Reply-To: <200408121638.37416.jbarnes@engr.sgi.com>
References: <200408121638.37416.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1092360960.15667.26.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 18:36:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 16:38, Jesse Barnes wrote:
> On a NUMA machine, page cache pages should be spread out across the system 
> since they're generally global in nature and can eat up whole nodes worth of 
> memory otherwise.  This can end up hurting performance since jobs will have 
> to make off node references for much or all of their non-file data.

Wouldn't this be painful for any workload that accesses a unique set of
files on each node?  If an application knows that it is touching truly
shared data which every node could possibly access, then they can use
the NUMA API to cause round-robin allocations to occur.  

Maybe a per-node watermark on page cache usage would be more useful. 
Once a node starts to get full, and it's past the watermark, we can go
and shoot down some of the node's page cache.  If the data access is
truly global, then it has a good chance of being brought in on a
different node.  

-- Dave

