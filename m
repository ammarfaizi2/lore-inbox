Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWJ0NPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWJ0NPQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 09:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbWJ0NPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 09:15:15 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:39893 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751794AbWJ0NPO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 09:15:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH cciss: fix printk format warning
Date: Fri, 27 Oct 2006 08:11:46 -0500
Message-ID: <5CCF5F0F2514664CBE20FD24BCE17614A6A76E@cceexc17.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH cciss: fix printk format warning
Thread-Index: Acb5VmqMvMYJPHgBSzy7DAfyLZe40AAcwnVl
References: <20061023214608.f09074e9.randy.dunlap@oracle.com>	<20061026160245.26f86ce2.akpm@osdl.org> <ada64e67jhf.fsf@cisco.com> <454144ED.4020101@oracle.com>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>,
       "Roland Dreier" <rdreier@cisco.com>
Cc: "Andrew Morton" <akpm@osdl.org>, "ISS StorageDev" <iss_storagedev@hp.com>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Oct 2006 13:15:10.0934 (UTC) FILETIME=[EE5B4760:01C6F9C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roland Dreier wrote:
> >  > >  	if (*total_size != (__u32) 0)
> >  > 
> >  > Why is cciss_read_capacity casting *total_size to u32?
> > 
> > It's not -- it's actually casting 0 to __32 -- there's no cast on the
> > *total_size side of the comparison.  However that just makes the cast
> > look even fishier.
> > 
> >  - R.
> 
> OK, how about this one then?
> 
> 
> 	c->busaddr = (__u32) cmd_dma_handle;
> 
> where cmd_dma_handle is a dma_addr_t (u32 or u64)

The command register to which that value is written
is a 32 bit register.  Cast it or not, only 32 bits
will be used.  The DMA mask used to get that memory
should ensure it's 32 bit addressable.

> and then later:
>
>		pci_free_consistent(h->pdev, sizeof(CommandList_struct),
>				    c, (dma_addr_t) c->busaddr);




