Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbUEMXmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbUEMXmf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263962AbUEMXme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:42:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:49557 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263174AbUEMXmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:42:33 -0400
Date: Thu, 13 May 2004 16:42:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Robert.Picco@hp.com, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] HPET driver
Message-Id: <20040513164226.7efb2a83.akpm@osdl.org>
In-Reply-To: <40A40204.1060509@pobox.com>
References: <40A3F805.5090804@hp.com>
	<40A40204.1060509@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > +    vma->vm_flags |= (VM_IO | VM_SHM | VM_LOCKED);
> > +    vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +    addr = __pa(addr);
> 
> where did these flags come from?  don't you just want VM_RESERVED?

VM_IO is the way to mark mmapped I/O devices. 

	vma->vm_flags |= VM_IO;

should be sufficient here.

hm, I'm trying to decrypt how the driver accesses the hardware.  It's
taking copies of kernel virtual addresses based off hpet_virt_address, but
there are no readl's or writel's in there.  Is the actual device access
done over in time_hpet.c?

