Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVAXQBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVAXQBf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 11:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVAXQBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 11:01:35 -0500
Received: from news.suse.de ([195.135.220.2]:15017 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261234AbVAXQBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 11:01:33 -0500
Date: Mon, 24 Jan 2005 17:00:53 +0100
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: Andi Kleen <ak@suse.de>, Matthew Wilcox <matthew@wil.cx>, akpm@osdl.org,
       paulus@samba.org, tony.luck@intel.com, ralf@linux-mips.org,
       schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Problems disabling SYSCTL
Message-ID: <20050124160053.GB29950@wotan.suse.de>
References: <20050123050102.GD5920@krispykreme.ozlabs.ibm.com> <20050123143500.GC31455@parcelfarce.linux.theplanet.co.uk> <20050123191743.GB6784@wotan.suse.de> <20050124135001.GC27258@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124135001.GC27258@krispykreme.ozlabs.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 12:50:01AM +1100, Anton Blanchard wrote:
> 
> > > Is there any reason to not move the sys32_sysctl code to kernel/sysctl.c?
> > 
> > iirc it relies on a unified address space (= user pointers still
> > work in KERNEL_DS) 
> 
> Yeah the sys32_sysctl code is pretty awful, perhaps we could do a better
> job now we have compat_alloc_userspace.

It also mishandles array of longs.

But seriously I wouldn't bother - the syscall interface is deprecated anyways
and has been for a long time. The only sysctl that needs to be handled
is (CTL_KERN,KERN_VERSION) [used by glibc], the others are not needed
and I hoep to eventually remove them even natively.

-Andi

P.S.: Andrew I just discovered you removed the printk code for this.
That's not good, how are users supposed to know it's deprecated?
