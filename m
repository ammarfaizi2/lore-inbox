Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbVJRWEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbVJRWEi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 18:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVJRWEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 18:04:38 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:40112 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932162AbVJRWEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 18:04:38 -0400
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
From: Alex Williamson <alex.williamson@hp.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org,
       y-goto@jp.fujitsu.com
In-Reply-To: <20051018215351.GA3982@localhost.localdomain>
References: <200510171153.56063.ak@suse.de>
	 <20051017153020.GB7652@localhost.localdomain>
	 <200510171743.47926.ak@suse.de> <20051017134401.3b0d861d.akpm@osdl.org>
	 <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org>
	 <20051018001620.GD8932@localhost.localdomain>
	 <Pine.LNX.4.64.0510180845470.3369@g5.osdl.org>
	 <Pine.LNX.4.64.0510180848540.3369@g5.osdl.org>
	 <20051018195423.GA6351@localhost.localdomain>
	 <1129670907.17545.20.camel@lts1.fc.hp.com>
	 <20051018215351.GA3982@localhost.localdomain>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 18 Oct 2005 16:04:00 -0600
Message-Id: <1129673040.17545.32.camel@lts1.fc.hp.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 14:53 -0700, Ravikiran G Thirumalai wrote:
> On Tue, Oct 18, 2005 at 03:28:27PM -0600, Alex Williamson wrote:
> > So, it looks like we're iterating over the nodes, but
> > alloc_bootmem_node() isn't even guaranteed to try to get memory from the
> > low memory on that node.
> 
> Thanks Alex. 2.6.14-rc4-mm1 already has the 
> guarantee-dma-area-for-alloc_bootmem_low.patch by Yasunori-san.  So it is 
> safer to confirm results on latest 2.6.14 stock.

   Ok. I'll need to build a stock tree then.

> Could it also be that Node 2 is offline when swiotlb is allocated?

   Nope.  Note that Node2 is iterated in the for_each_online_node, my
printk is within the body of the loop.  Also, the allocation it did get
is still from Node2.  My understanding is that goal for
alloc_bootmem_node is MAX_DMA_ADDRESS.  On ia64, that defaults to 4GB.
So it makes sense that we're using the second region in the
discontiguous space of that node.  This solution therefore relies on one
of the nodes having less than 4GB of zero base memory.  That's a pretty
weak assumption.  Thanks,

	Alex

-- 

