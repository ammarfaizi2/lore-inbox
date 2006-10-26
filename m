Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423547AbWJZX2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423547AbWJZX2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423670AbWJZX2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:28:17 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:44092 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423547AbWJZX2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:28:16 -0400
Message-ID: <454144ED.4020101@oracle.com>
Date: Thu, 26 Oct 2006 16:29:49 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Andrew Morton <akpm@osdl.org>, iss_storagedev@hp.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH cciss: fix printk format warning
References: <20061023214608.f09074e9.randy.dunlap@oracle.com>	<20061026160245.26f86ce2.akpm@osdl.org> <ada64e67jhf.fsf@cisco.com>
In-Reply-To: <ada64e67jhf.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > >  	if (*total_size != (__u32) 0)
>  > 
>  > Why is cciss_read_capacity casting *total_size to u32?
> 
> It's not -- it's actually casting 0 to __32 -- there's no cast on the
> *total_size side of the comparison.  However that just makes the cast
> look even fishier.
> 
>  - R.

OK, how about this one then?


	c->busaddr = (__u32) cmd_dma_handle;

where cmd_dma_handle is a dma_addr_t (u32 or u64)

and then later:

		pci_free_consistent(h->pdev, sizeof(CommandList_struct),
				    c, (dma_addr_t) c->busaddr);

-- 
~Randy
