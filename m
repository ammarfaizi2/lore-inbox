Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVJRVx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVJRVx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVJRVx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:53:56 -0400
Received: from serv01.siteground.net ([70.85.91.68]:23982 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932157AbVJRVxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:53:55 -0400
Date: Tue, 18 Oct 2005 14:53:51 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Alex Williamson <alex.williamson@hp.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org,
       y-goto@jp.fujitsu.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051018215351.GA3982@localhost.localdomain>
References: <200510171153.56063.ak@suse.de> <20051017153020.GB7652@localhost.localdomain> <200510171743.47926.ak@suse.de> <20051017134401.3b0d861d.akpm@osdl.org> <Pine.LNX.4.64.0510171405510.3369@g5.osdl.org> <20051018001620.GD8932@localhost.localdomain> <Pine.LNX.4.64.0510180845470.3369@g5.osdl.org> <Pine.LNX.4.64.0510180848540.3369@g5.osdl.org> <20051018195423.GA6351@localhost.localdomain> <1129670907.17545.20.camel@lts1.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129670907.17545.20.camel@lts1.fc.hp.com>
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

On Tue, Oct 18, 2005 at 03:28:27PM -0600, Alex Williamson wrote:
> ... 
>    Oops, I used 2.6.14-rc4-mm1, I'll retest.  However, this does work on
> the Superdome.  Not because of the iterating over the nodes code, but
> because of the call to alloc_bootmem_low_pages() fallback case.  Adding
> a printk(), I get this:
> 
> Node 0: 0xe000074104e6b200
> Node 1: 0xe000082080723000
> Node 2: 0xe000000101532000  *Note this is the interleaved memory node
> Placing software IO TLB between 0x4cdc000 - 0x8cdc000
> 
> Looking at the memory map of the system, I see these major ranges:
> 
> Node 2:
> 0x00000000000 - 0x0007ffdefff (~2GB)
> 0x00100000000 - 0x0017fffffff (2GB)
> 0x04080000000 - 0x040f0000000 (2GB)
> Node 0:
> 0x74100000000 - 0x741fbbfffff (~4GB)
> Node 1:
> 0x82080000000 - 0x820fb453fff (~2GB)
> 
> So, it looks like we're iterating over the nodes, but
> alloc_bootmem_node() isn't even guaranteed to try to get memory from the
> low memory on that node.

Thanks Alex. 2.6.14-rc4-mm1 already has the 
guarantee-dma-area-for-alloc_bootmem_low.patch by Yasunori-san.  So it is 
safer to confirm results on latest 2.6.14 stock.

Could it also be that Node 2 is offline when swiotlb is allocated?

Thanks,
Kiran
