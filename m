Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbVLIRtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbVLIRtT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbVLIRtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:49:19 -0500
Received: from ns1.suse.de ([195.135.220.2]:22729 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964813AbVLIRtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:49:18 -0500
Date: Fri, 9 Dec 2005 18:49:04 +0100
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@muc.de>
Cc: Matt Tolentino <metolent@cs.vt.edu>, akpm@osdl.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, matthew.e.tolentino@intel.com
Subject: Re: [discuss] Re: [patch 3/3] add x86-64 support for memory hot-add II
Message-ID: <20051209174904.GA30117@brahms.suse.de>
References: <200512091523.jB9FNn5J006697@ap1.cs.vt.edu> <20051209173249.GA54033@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209173249.GA54033@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In general SRAT has a hotplug memory bit so it's possible
> to predict how much memory there will be in advance. Since
> the overhead of the kernel page tables should be very
> low I would prefer if you just used instead.
> 
> (i.e. instead of extending the kernel mapping preallocate
> the direct mapping and just clear the P bits) 
> 
> That should be much simpler.

Looking at it again - accessing SRAT currently relies on the 
direct mapping already. Untangling that would be possible,
but require an bt_ioremap which would also add lots of code.

Ok I retract that objection. I guess your way is better
for now.

In addition to the __cpuinit comment

+if (after_bootmem) spin_unlock(&init_mm.page_table_lock);

Conditional locking is evil. spinlocking in the boot
case should just work too I think.

The EXPORTs should be probably EXPORT_SYMBOL_GPL.

With these changes it would look ok for me.

-Andi
