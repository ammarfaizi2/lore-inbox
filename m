Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUCHHvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 02:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbUCHHvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 02:51:25 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:31657 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S262424AbUCHHvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 02:51:02 -0500
In-Reply-To: <4048B720.4010403@nortelnetworks.com>
References: <40479A50.9090605@nortelnetworks.com>	 <1078444268.5698.27.camel@gaston>  <4047CBB3.9050608@nortelnetworks.com>	 <1078452637.5700.45.camel@gaston>  <404812A2.70207@nortelnetworks.com> <1078465612.5704.52.camel@gaston> <4048B720.4010403@nortelnetworks.com>
Mime-Version: 1.0 (Apple Message framework v612)
Message-Id: <59D75402-6F0E-11D8-9B46-000A95A4DC02@kernel.crashing.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: problem with cache flush routine for G5?
Date: Sat, 6 Mar 2004 02:34:03 +0100
To: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Apple Mail (2.612)
X-MIMETrack: Itemize by SMTP Server on D12ML045/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 08/03/2004 08:50:53,
	Serialize by Router on D12ML045/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 08/03/2004 08:50:55,
	Serialize complete at 08/03/2004 08:50:55
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After doing some digging in the 970fx specs, it seems that we may not 
> need to explicitly force a store of the L1 dcache at all.  According 
> to the docs, the L1 dcache is unconditionally store-through. Thus, for 
> a brute-force implementation we should be able to just invalidate the 
> whole icache, do the appropriate sync/isync, and it should pick up the 
> changed instructions from the L2 cache.  Do you see any problems with 
> this?  Do I actually still need the store?

You need a  sync  instruction before the instruction cache invalidate,
to make sure all stores to L2 have completed.

I don't know which "970fx specs" you mean, but if it's the programming
manual, it should tell you how to invalidate the entire instruction
cache (and how to flush the L2 cache, if you really must.  But just 
don't).


Segher

