Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWG0KPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWG0KPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 06:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWG0KPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 06:15:39 -0400
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:15983 "EHLO
	mtagate5.uk.ibm.com") by vger.kernel.org with ESMTP id S932542AbWG0KPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 06:15:38 -0400
Date: Thu, 27 Jul 2006 13:15:34 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Jon Mason <jdmason@us.ibm.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: swiotlb=force fix
Message-ID: <20060727101534.GJ6197@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

I was looking at your swiotlb=force fix at
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/broken-out/x86_64-mm-fix-swiotlb-force.patch.

In general I agree with the patch (and thanks for fixing it).

> -	if (!iommu_detected && !no_iommu &&
> -	    (end_pfn > MAX_DMA32_PFN || force_iommu))
> +	if (!iommu_detected && !no_iommu && end_pfn > MAX_DMA32_PFN)
>  	       swiotlb = 1;

what is the expected outcome if the user specifies 'iommu=force' with
no HW IOMMU in the machine and swiotlb compiled in? we thought the
path of least surprise is to enable swiotlb unconditionally in this
case. You removed the check for force_iommu here so now this set of
command line options will *not* turn on swiotlb unless there's more
than 4G in the machine, which can be surprising.

> +extern int swiotlb_force;
> +
>  #ifdef CONFIG_SWIOTLB
>  extern int swiotlb;
>  #else
>  #define swiotlb 0
>  #endif

Any reason not to move this into the CONFIG_SWIOTLB bit the same way
'extern int swiotlb' is declared?

Cheers,
Muli
