Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbWBUVBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbWBUVBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 16:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWBUVBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 16:01:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10472 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932768AbWBUVBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 16:01:12 -0500
Date: Tue, 21 Feb 2006 12:59:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Matt_Domsch@dell.com, hostmaster@ed-soft.at
Subject: Re: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory
Message-Id: <20060221125919.5085de5f.akpm@osdl.org>
In-Reply-To: <p73ek1w4x3a.fsf@verdi.suse.de>
References: <43FA5293.4070807@ed-soft.at>
	<20060220220219.6d82366a.akpm@osdl.org>
	<p73ek1w4x3a.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> >  
> >  void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
> >  {
> > +	/* Don't unmap memory which was not mapped by acpi_os_map_memory */
> > +	if (efi_enabled &&
> > +	    (efi_mem_attributes(virt_to_phys(virt)) & EFI_MEMORY_WB))
> > +		return;
> 
> 
> The patch is wrong because if the address came from ioremap 
> virt_to_phys doesn't give the real physical address. Also looking
> at acpi_os_map_memory it doesn't quite match the logic there.
> 
> One working way to check for ioremap memory is 
> virt >= VMALLOC_START  && virt < VMALLOC_END
> 

OK, thanks.  I don't think we actually know who is trying to unmap some
memory which acpi didn't map.

Edgar, can you please describe the bug which you're trying to fix?
