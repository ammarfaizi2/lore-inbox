Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945966AbWJZXv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945966AbWJZXv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946028AbWJZXv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:51:58 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:361 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1945966AbWJZXv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:51:57 -0400
Message-ID: <45414A7A.8060800@oracle.com>
Date: Thu, 26 Oct 2006 16:53:30 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Andrew Morton <akpm@osdl.org>, iss_storagedev@hp.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH cciss: fix printk format warning
References: <20061023214608.f09074e9.randy.dunlap@oracle.com>	<20061026160245.26f86ce2.akpm@osdl.org> <ada64e67jhf.fsf@cisco.com>	<454144ED.4020101@oracle.com> <ada1wou7i4p.fsf@cisco.com>
In-Reply-To: <ada1wou7i4p.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > OK, how about this one then?
>  > 
>  > 	c->busaddr = (__u32) cmd_dma_handle;
>  > 
>  > where cmd_dma_handle is a dma_addr_t (u32 or u64)
> 
> It's super-fishy looking but actually I think it's OK, at least as
> things stand now.  As you see later from how it's freed:
> 
>  > 		pci_free_consistent(h->pdev, sizeof(CommandList_struct),
>  > 				    c, (dma_addr_t) c->busaddr);
> 
> this is the bus address of memory from pci_alloc_consistent(), and
> since cciss never does pci_set_consistent_dma_mask(), the mask will
> remain at the default 32 bits.  So the driver is actually safe in
> assuming that cmd_dma_handle fits into 32 bits.  assuming that
> cmd_dma_handle.

Hm, OK.  Thanks.

-- 
~Randy
