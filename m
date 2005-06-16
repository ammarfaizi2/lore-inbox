Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVFPSAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVFPSAR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 14:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbVFPR7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 13:59:46 -0400
Received: from one.firstfloor.org ([213.235.205.2]:46826 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261783AbVFPR7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 13:59:30 -0400
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: abhay_salunke@dell.com, matt_domsch@dell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc6] char: Add Dell Systems Management Base
 driver
References: <20050616173024.GA2596@sysman-doug.us.dell.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 16 Jun 2005 19:59:29 +0200
In-Reply-To: <20050616173024.GA2596@sysman-doug.us.dell.com> (Doug
 Warzecha's message of "Thu, 16 Jun 2005 12:30:24 -0500")
Message-ID: <m1fyvinpxa.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Warzecha <Douglas_Warzecha@dell.com> writes:

> +static void *tvm_alloc_suitable(unsigned long size, unsigned long phys_max)
> +{
> +	void *ptr;
> +	unsigned int flags = GFP_KERNEL;
> +
> +	while ((ptr = kmalloc(size, flags)) != NULL) {
> +		if ((virt_to_phys(ptr) + size - 1) <= phys_max)
> +			break;
> +
> +		kfree(ptr);
> +		ptr = NULL;
> +
> +		if (flags & GFP_DMA)
> +			break;
> +		flags |= GFP_DMA;
> +	}
> +	return ptr;

Umm - what's that? 

Please drop that immediately. 2.6.13 will hopefully have GFP_DMA32
on x86-64 that will make it fully obsolete.

And even before that you can use pci_alloc_consistent() - that
will do the right now and later.

... haven't read on.

But there seems to be a use of register_ioctl32_conversion. That
needs to be replaced with ->compat_ioctl, since the former
will soon go.

-Andi
