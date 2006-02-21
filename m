Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWBUOPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWBUOPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 09:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161222AbWBUOPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 09:15:36 -0500
Received: from cantor2.suse.de ([195.135.220.15]:56224 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161096AbWBUOPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 09:15:35 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Matt Domsch <Matt_Domsch@dell.com>, hostmaster@ed-soft.at
Subject: Re: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory
References: <43FA5293.4070807@ed-soft.at>
	<20060220220219.6d82366a.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 21 Feb 2006 15:15:21 +0100
In-Reply-To: <20060220220219.6d82366a.akpm@osdl.org>
Message-ID: <p73ek1w4x3a.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

>  
>  void acpi_os_unmap_memory(void __iomem * virt, acpi_size size)
>  {
> +	/* Don't unmap memory which was not mapped by acpi_os_map_memory */
> +	if (efi_enabled &&
> +	    (efi_mem_attributes(virt_to_phys(virt)) & EFI_MEMORY_WB))
> +		return;


The patch is wrong because if the address came from ioremap 
virt_to_phys doesn't give the real physical address. Also looking
at acpi_os_map_memory it doesn't quite match the logic there.

One working way to check for ioremap memory is 
virt >= VMALLOC_START  && virt < VMALLOC_END

-Andi

