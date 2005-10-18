Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbVJRWrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVJRWrd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 18:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVJRWrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 18:47:33 -0400
Received: from serv01.siteground.net ([70.85.91.68]:64384 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932300AbVJRWrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 18:47:32 -0400
Date: Tue, 18 Oct 2005 15:47:29 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Alex Williamson <alex.williamson@hp.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org,
       y-goto@jp.fujitsu.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051018224729.GA4535@localhost.localdomain>
References: <200510171743.47926.ak@suse.de> <20051017134401.3b0d861d.akpm@osdl.org> <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org> <20051018001620.GD8932@localhost.localdomain> <Pine.LNX.4.64.0510180845470.3369@g5.osdl.org> <Pine.LNX.4.64.0510180848540.3369@g5.osdl.org> <20051018195423.GA6351@localhost.localdomain> <1129670907.17545.20.camel@lts1.fc.hp.com> <20051018215351.GA3982@localhost.localdomain> <1129673040.17545.32.camel@lts1.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129673040.17545.32.camel@lts1.fc.hp.com>
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

On Tue, Oct 18, 2005 at 04:04:00PM -0600, Alex Williamson wrote:
> On Tue, 2005-10-18 at 14:53 -0700, Ravikiran G Thirumalai wrote:
> > On Tue, Oct 18, 2005 at 03:28:27PM -0600, Alex Williamson wrote:
> > > So, it looks like we're iterating over the nodes, but
> > > alloc_bootmem_node() isn't even guaranteed to try to get memory from the
> > > low memory on that node.
> > 
> > Thanks Alex. 2.6.14-rc4-mm1 already has the 
> > guarantee-dma-area-for-alloc_bootmem_low.patch by Yasunori-san.  So it is 
> > safer to confirm results on latest 2.6.14 stock.
> 
>    Ok. I'll need to build a stock tree then.
> 
> > Could it also be that Node 2 is offline when swiotlb is allocated?
> 
>    Nope.  Note that Node2 is iterated in the for_each_online_node, my
> printk is within the body of the loop.  Also, the allocation it did get
> is still from Node2.  My understanding is that goal for
> alloc_bootmem_node is MAX_DMA_ADDRESS.  On ia64, that defaults to 4GB.

Ahhh... and it is 16MB on x86_64.  alloc_bootmem_node will never work here
for ia64 then, However, alloc_bootmem_low_pages_node will work, but then it will 
dig into 16MB DMA area of x86_64.... arrrrgh...

The first cleanup post 2.6.14 should be to seperate swiotlb for ia64 and
x86_64 IMHO. 
