Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264194AbUDVQrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264194AbUDVQrK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUDVQrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:47:09 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:52424 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S264194AbUDVQrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:47:01 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Subject: Re: [patch 1/3] efivars driver update and move
Date: Thu, 22 Apr 2004 10:46:59 -0600
User-Agent: KMail/1.6.1
Cc: akpm@osdl.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Matt_Domsch@dell.com, matthew.e.tolentino@intel.com
References: <200404221732.i3MHWJcc023373@snoqualmie.dp.intel.com>
In-Reply-To: <200404221732.i3MHWJcc023373@snoqualmie.dp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404221046.59541.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 April 2004 11:32 am, Matt Tolentino wrote:
> I broke up the efivars driver update patch I had sent out
> quite a while ago into several smaller patches.  This 
> includes several fixes and suggestions that were pointed
> out.  The patches are broken down as follows:
> 
> 1 - remove all traces of efivars from arch/ia64/
> 2 - add new sysfs based efivars driver into
>     drivers/firmware with accompanying Kconfig/Makefile 
>     changes to make it fully functional for ia64 again.
> 3 - cleans up x86 references to the /proc version of 
>     the efivars driver.

I like these changes.

I did notice that the new drivers/.../efivars.c is not identical to
the old arch/ia64/kernel/efivars.c (the hints to emacs were removed).
I like the emacs hint removal, but didn't review patch for any other
differences.

Any plans to consolidate other bits from efi.c?  There are a number
of things there that look like they could be shared:

	is_available_memory()
	efi_init()
		(mostly)
	efi_initialize_iomem_resources()
		(i386 only today, but I think we'd like it for ia64 also)
	efi_mem_type()
	efi_mem_attributes()
		(the i386 versions look slightly buggy in that they
		assume a fixed descriptor size, so old kernels won't
		work with new firmware that adds stuff to the descriptor)

Bjorn
