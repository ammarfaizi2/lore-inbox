Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265163AbUEMXth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265163AbUEMXth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265192AbUEMXth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:49:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46539 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265163AbUEMXtf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:49:35 -0400
Message-ID: <40A40982.60202@pobox.com>
Date: Thu, 13 May 2004 19:49:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Robert.Picco@hp.com, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
References: <40A3F805.5090804@hp.com>	<40A40204.1060509@pobox.com> <20040513164226.7efb2a83.akpm@osdl.org>
In-Reply-To: <20040513164226.7efb2a83.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>>+    vma->vm_flags |= (VM_IO | VM_SHM | VM_LOCKED);
>>>+    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>>+    addr = __pa(addr);
>>
>>where did these flags come from?  don't you just want VM_RESERVED?
> 
> 
> VM_IO is the way to mark mmapped I/O devices. 
> 
> 	vma->vm_flags |= VM_IO;
> 
> should be sufficient here.
> 
> hm, I'm trying to decrypt how the driver accesses the hardware.  It's
> taking copies of kernel virtual addresses based off hpet_virt_address, but
> there are no readl's or writel's in there.  Is the actual device access
> done over in time_hpet.c?


HPET writes into RAM at magic addresses, so it's not really a bus address.

Thus I think only VM_RESERVED is needed...

	Jeff



