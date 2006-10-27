Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752278AbWJ0PQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbWJ0PQE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWJ0PQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:16:04 -0400
Received: from ccerelbas02.cce.hp.com ([161.114.21.105]:45965 "EHLO
	ccerelbas02.cce.hp.com") by vger.kernel.org with ESMTP
	id S1752278AbWJ0PQC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:16:02 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH cciss: fix printk format warning
Date: Fri, 27 Oct 2006 10:15:18 -0500
Message-ID: <E717642AF17E744CA95C070CA815AE55B7E19A@cceexc23.americas.cpqcorp.net>
In-Reply-To: <5CCF5F0F2514664CBE20FD24BCE17614A6A76E@cceexc17.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH cciss: fix printk format warning
Thread-Index: Acb5VmqMvMYJPHgBSzy7DAfyLZe40AAcwnVlAAQrfGA=
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Cameron, Steve" <steve.cameron@hp.com>,
       "Randy Dunlap" <randy.dunlap@oracle.com>,
       "Roland Dreier" <rdreier@cisco.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "ISS StorageDev" <iss_storagedev@hp.com>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Oct 2006 15:15:19.0362 (UTC) FILETIME=[B6EA1A20:01C6F9DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Cameron, Steve 
> Sent: Friday, October 27, 2006 8:12 AM
> To: Randy Dunlap; Roland Dreier
> Cc: Andrew Morton; ISS StorageDev; lkml
> Subject: RE: [PATCH cciss: fix printk format warning
> 
> > Roland Dreier wrote:
> > >  > >  	if (*total_size != (__u32) 0)
> > >  >
> > >  > Why is cciss_read_capacity casting *total_size to u32?
> > > 
> > > It's not -- it's actually casting 0 to __32 -- there's no cast on 
> > > the *total_size side of the comparison.  However that 
> just makes the 
> > > cast look even fishier.

If the volume is >2TB read_capacity will return 8 F's. We've already
added 1 to total_size which equals 0. I only care if the lower 32 bits
are zero so that's the reason for the cast.
Does that make sense or am I out in the weeds?

mikem

> > > 
> > >  - R.
> > 
> > OK, how about this one then?
> > 
> > 
> > 	c->busaddr = (__u32) cmd_dma_handle;
> > 
> > where cmd_dma_handle is a dma_addr_t (u32 or u64)
> 
> The command register to which that value is written is a 32 
> bit register.  Cast it or not, only 32 bits will be used.  
> The DMA mask used to get that memory should ensure it's 32 
> bit addressable.
> 
> > and then later:
> >
> >		pci_free_consistent(h->pdev, sizeof(CommandList_struct),
> >				    c, (dma_addr_t) c->busaddr);
> 
> 
> 
> 
> 
