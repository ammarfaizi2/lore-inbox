Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752263AbWJ0PL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbWJ0PL7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 11:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752264AbWJ0PL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 11:11:59 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:64196 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752262AbWJ0PL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 11:11:58 -0400
Date: Fri, 27 Oct 2006 08:07:18 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: "Roland Dreier" <rdreier@cisco.com>, "Andrew Morton" <akpm@osdl.org>,
       "ISS StorageDev" <iss_storagedev@hp.com>,
       "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH cciss: fix printk format warning
Message-Id: <20061027080718.42674b06.randy.dunlap@oracle.com>
In-Reply-To: <5CCF5F0F2514664CBE20FD24BCE17614A6A76E@cceexc17.americas.cpqcorp.net>
References: <20061023214608.f09074e9.randy.dunlap@oracle.com>
	<20061026160245.26f86ce2.akpm@osdl.org>
	<ada64e67jhf.fsf@cisco.com>
	<454144ED.4020101@oracle.com>
	<5CCF5F0F2514664CBE20FD24BCE17614A6A76E@cceexc17.americas.cpqcorp.net>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 08:11:46 -0500 Cameron, Steve wrote:

> > Roland Dreier wrote:
> > >  > >  	if (*total_size != (__u32) 0)
> > >  > 
> > >  > Why is cciss_read_capacity casting *total_size to u32?
> > > 
> > > It's not -- it's actually casting 0 to __32 -- there's no cast on the
> > > *total_size side of the comparison.  However that just makes the cast
> > > look even fishier.
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
> The command register to which that value is written
> is a 32 bit register.  Cast it or not, only 32 bits
> will be used.  The DMA mask used to get that memory
> should ensure it's 32 bit addressable.

Got it.  Thanks for replying.

> > and then later:
> >
> >		pci_free_consistent(h->pdev, sizeof(CommandList_struct),
> >				    c, (dma_addr_t) c->busaddr);

---
~Randy
