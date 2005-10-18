Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVJRSvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVJRSvx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 14:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVJRSvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 14:51:53 -0400
Received: from serv01.siteground.net ([70.85.91.68]:30691 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751166AbVJRSvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 14:51:52 -0400
Date: Tue, 18 Oct 2005 11:51:41 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, shai@scalex86.org, clameter@engr.sgi.com,
       muli@il.ibm.com, jdmason@us.ibm.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051018185141.GA4251@localhost.localdomain>
References: <20051018125342.6799.Y-GOTO@jp.fujitsu.com> <20051018061325.GB3692@localhost.localdomain> <20051018183627.679B.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051018183627.679B.Y-GOTO@jp.fujitsu.com>
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

On Tue, Oct 18, 2005 at 07:09:03PM +0900, Yasunori Goto wrote:
> 
> I tested your patch, but unfortunately, it doesn't work IA64.
> alloc_bootmem_node() requires bigger area than MAX_DMA_ADDRESS.
> It is defined as 4GB for ia64. (arch/ia64/mm/init.c)
> But this patch require smaller area than 4GB. 
> So they are exclusive each other.

No, alloc_bootmem_node should work for 4G allocations too; So my approach
should work unless there was some other bootmem request served out of that 
node earlier.  Btw, the default is to allocate 64MB for swiotlb.  
Do you modify that for your boxes?  IMHO, we should stick to fixing the 
stock kernel now for 2.6.14.  

However, IS_LOWPAGES macro in my patch enforces that iotlb start and end 
locations to be within 4G.  I can change that to within and upto 4G, and the 
patch should work for you too.

Thanks,
Kiran
