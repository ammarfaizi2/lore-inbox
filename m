Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbUCFCgR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 21:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUCFCgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 21:36:17 -0500
Received: from dp.samba.org ([66.70.73.150]:59268 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261571AbUCFCgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 21:36:16 -0500
Date: Sat, 6 Mar 2004 13:31:50 +1100
From: Anton Blanchard <anton@samba.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: problem with cache flush routine for G5?
Message-ID: <20040306023150.GK5801@krispykreme>
References: <40479A50.9090605@nortelnetworks.com> <1078444268.5698.27.camel@gaston> <4047CBB3.9050608@nortelnetworks.com> <1078452637.5700.45.camel@gaston> <404812A2.70207@nortelnetworks.com> <1078465612.5704.52.camel@gaston> <4048B720.4010403@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4048B720.4010403@nortelnetworks.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> After doing some digging in the 970fx specs, it seems that we may not 
> need to explicitly force a store of the L1 dcache at all.  According to 
> the docs, the L1 dcache is unconditionally store-through. Thus, for a 
> brute-force implementation we should be able to just invalidate the 
> whole icache, do the appropriate sync/isync, and it should pick up the 
> changed instructions from the L2 cache.  Do you see any problems with 
> this?  Do I actually still need the store?

Yeah you will get away with it on the 970FX, do the sync before and
isync afterwards. As you suggest, you really should modify it to track 
changed regions and flush them explicitly :)

Anton
