Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUENLTU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUENLTU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 07:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264444AbUENLTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 07:19:20 -0400
Received: from styx.suse.cz ([82.208.2.94]:62855 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265253AbUENLSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 07:18:41 -0400
Date: Fri, 14 May 2004 13:19:26 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Robert.Picco@hp.com,
       linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
Message-ID: <20040514111926.GA30876@ucw.cz>
References: <40A3F805.5090804@hp.com> <40A40204.1060509@pobox.com> <20040513164226.7efb2a83.akpm@osdl.org> <40A40982.60202@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40A40982.60202@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 07:49:22PM -0400, Jeff Garzik wrote:
> Andrew Morton wrote:
> >Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> >>>+    vma->vm_flags |= (VM_IO | VM_SHM | VM_LOCKED);
> >>>+    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> >>>+    addr = __pa(addr);
> >>
> >>where did these flags come from?  don't you just want VM_RESERVED?
> >
> >
> >VM_IO is the way to mark mmapped I/O devices. 
> >
> >	vma->vm_flags |= VM_IO;
> >
> >should be sufficient here.
> >
> >hm, I'm trying to decrypt how the driver accesses the hardware.  It's
> >taking copies of kernel virtual addresses based off hpet_virt_address, but
> >there are no readl's or writel's in there.  Is the actual device access
> >done over in time_hpet.c?
> 
> 
> HPET writes into RAM at magic addresses, so it's not really a bus address.

Since it lives in the bridge (either north or south), IMO it is a bus
address ... at least on AMD machines it's the same space where MMIO
comes from.

> Thus I think only VM_RESERVED is needed...
> 
> 	Jeff

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
