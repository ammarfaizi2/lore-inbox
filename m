Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945998AbWJZXtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945998AbWJZXtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 19:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946030AbWJZXtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 19:49:12 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:36128 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1945998AbWJZXtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 19:49:11 -0400
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, iss_storagedev@hp.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH cciss: fix printk format warning
X-Message-Flag: Warning: May contain useful information
References: <20061023214608.f09074e9.randy.dunlap@oracle.com>
	<20061026160245.26f86ce2.akpm@osdl.org> <ada64e67jhf.fsf@cisco.com>
	<454144ED.4020101@oracle.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 26 Oct 2006 16:49:10 -0700
In-Reply-To: <454144ED.4020101@oracle.com> (Randy Dunlap's message of "Thu, 26 Oct 2006 16:29:49 -0700")
Message-ID: <ada1wou7i4p.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 26 Oct 2006 23:49:10.0698 (UTC) FILETIME=[5568E0A0:01C6F959]
Authentication-Results: sj-dkim-7.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > OK, how about this one then?
 > 
 > 	c->busaddr = (__u32) cmd_dma_handle;
 > 
 > where cmd_dma_handle is a dma_addr_t (u32 or u64)

It's super-fishy looking but actually I think it's OK, at least as
things stand now.  As you see later from how it's freed:

 > 		pci_free_consistent(h->pdev, sizeof(CommandList_struct),
 > 				    c, (dma_addr_t) c->busaddr);

this is the bus address of memory from pci_alloc_consistent(), and
since cciss never does pci_set_consistent_dma_mask(), the mask will
remain at the default 32 bits.  So the driver is actually safe in
assuming that cmd_dma_handle fits into 32 bits.  assuming that
cmd_dma_handle.

 - R.
