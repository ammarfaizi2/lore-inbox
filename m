Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVIWXay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVIWXay (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 19:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVIWXay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 19:30:54 -0400
Received: from serv01.siteground.net ([70.85.91.68]:40325 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751346AbVIWXax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 19:30:53 -0400
Date: Fri, 23 Sep 2005 16:30:48 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, rusty@rustcorp.com.au, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/6] mm: alloc_percpu and bigrefs
Message-ID: <20050923233048.GA4970@localhost.localdomain>
References: <20050923062529.GA4209@localhost.localdomain> <20050923001013.28b7f032.akpm@osdl.org> <20050923184052.GA4103@localhost.localdomain> <20050923.115058.63342389.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923.115058.63342389.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 11:50:58AM -0700, David S. Miller wrote:
> From: Ravikiran G Thirumalai <kiran@scalex86.org>
> Date: Fri, 23 Sep 2005 11:40:52 -0700
> 
> 
> I worry about real life sites, such as a big web server, that will by
> definition have hundreds of thousands of routing cache (and thus
> 'dst') entries active.
> 
> The memory usage will increase, and that's particularly bad in this
> kind of case because unlike the 'lo' benchmarks you won't have nodes
> and cpus fighting over access to the same routes.  In such a load
> the bigrefs are just wasted memory and aren't actually needed.

Point taken. That is the reason I have excluded the dst patches in this
patchset.  The problem with dst.__refcount stays and we should probably look
for some other approach rather than thinking per-cpu/per-node counters for 
this. 
But the patch in question now is net_device refcount. Surely that doesn't
affect webservers with many dst entries.

> 
> I really would like to encourage a move away from this fascination
> with optimizating the loopback interface performance on enormous
> systems, yes even if it is hit hard by the benchmarks.  It just
> means the benchmarks are wrong, not that we should optimize for
> them.

Benchmarks could be wrong, but we don't control what people run. 
And there are apps which use lo (for whatever reason) :(. 

Thanks,
Kiran
