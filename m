Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422669AbWCJBCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbWCJBCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWCJBCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:02:44 -0500
Received: from hqemgate01.nvidia.com ([216.228.112.170]:62746 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S1422669AbWCJBCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:02:43 -0500
Date: Thu, 9 Mar 2006 19:02:30 -0600
From: Terence Ripperda <tripperda@nvidia.com>
To: Jon Mason <jdmason@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mulix@mulix.org, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] x86-64: Make GART_IOMMU kconfig help text more specific (trivial)
Message-ID: <20060310010230.GV8626@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <20060308214829.GJ28921@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060308214829.GJ28921@us.ibm.com>
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.6.12-10-386 
User-Agent: Mutt/1.5.9i
X-OriginalArrivalTime: 10 Mar 2006 01:02:31.0132 (UTC) FILETIME=[4ED991C0:01C643DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Also, note that the previous help text stated that IOMMU was needed for
> >3GB memory instead of >4GB.  This is fixed in the newer version.

note that many system bioses have memory remapping, to accomodate pci
i/o ranges. some address space is reserved by the bios for these i/o
ranges, and as system memory approaches this reserved space, the
memory is remapped to >4GB. this usually happens around 3.25GB -
3.5GB, but probably varies based on bios and pci devices. once this
memory is remapped to >4GB, the IOMMU kicks in.

so the original text is probably more accurate.

On Wed, Mar 08, 2006 at 03:48:30PM -0600, jdmason@us.ibm.com wrote:
> Oops, forgot to CC lkml.
> 
> ----- Forwarded message from Jon Mason <jdmason@us.ibm.com> -----
> 
> User-Agent: Mutt/1.5.11
> From: Jon Mason <jdmason@us.ibm.com>
> To: Andi Kleen <ak@muc.de>
> Date: Wed, 8 Mar 2006 15:45:49 -0600
> Subject: [PATCH] x86-64: Make GART_IOMMU kconfig help text more specific (trivial)
> 
> Have the GART_IOMMU help text specify that this is the hardware IOMMU in
> amd64 processors.  This will be significant if/when other IOMMUs are
> added to the x86-64 architecture. :-)
> 
> Also, note that the previous help text stated that IOMMU was needed for
> >3GB memory instead of >4GB.  This is fixed in the newer version.
> 
> Thanks,
> Jon
> 
> Signed-off-by: Jon Mason <jdmason@us.ibm.com>
> 
> diff -r 149aa2a22913 arch/x86_64/Kconfig
> --- a/arch/x86_64/Kconfig	Tue Feb 28 22:02:10 2006
> +++ b/arch/x86_64/Kconfig	Wed Mar  8 15:24:44 2006
> @@ -364,13 +364,14 @@
>  	select SWIOTLB
>  	depends on PCI
>  	help
> -	  Support the IOMMU. Needed to run systems with more than 3GB of memory
> -	  properly with 32-bit PCI devices that do not support DAC (Double Address
> -	  Cycle). The IOMMU can be turned off at runtime with the iommu=off parameter.
> -	  Normally the kernel will take the right choice by itself.
> -	  This option includes a driver for the AMD Opteron/Athlon64 northbridge IOMMU
> -	  and a software emulation used on other systems.
> -	  If unsure, say Y.
> +	  Support for hardware IOMMU in AMD's Opteron/Athlon64 Processors.
> +	  Needed to run systems with more than 4GB of memory properly with
> +	  32-bit PCI devices that do not support DAC (Double Address Cycle).
> +	  The IOMMU can be turned off at runtime with the iommu=off parameter.
> +  	  Normally the kernel will take the right choice by itself.
> +  	  This option includes a driver for the AMD Opteron/Athlon64 IOMMU
> +  	  northbridge and a software emulation used on some other systems.
> +  	  If unsure, say Y.
>  
>  # need this always enabled with GART_IOMMU for the VIA workaround
>  config SWIOTLB
> 
> ----- End forwarded message -----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
