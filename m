Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbVEHA6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVEHA6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 20:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVEHA6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 20:58:13 -0400
Received: from fsmlabs.com ([168.103.115.128]:38543 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S262774AbVEHA6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 20:58:03 -0400
Date: Sat, 7 May 2005 19:00:39 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Natalie.Protasevich@unisys.com
cc: akpm@osdl.org, ak@suse.de, len.brown@intel.com,
       venkatesh.pallipadi@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/1] Do not enforce unique IO_APIC_ID for Xeon processors
 in EM64T mode (x86_64)
In-Reply-To: <20050507053435.6DA214749E@linux.site>
Message-ID: <Pine.LNX.4.61.0505071900080.7817@montezuma.fsmlabs.com>
References: <20050507053435.6DA214749E@linux.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 May 2005 Natalie.Protasevich@unisys.com wrote:

> diff -puN arch/x86_64/kernel/io_apic.c~no-ioapic-check-x86_64-2 arch/x86_64/kernel/io_apic.c
> --- linux-2.6.13-rc3-mm3/arch/x86_64/kernel/io_apic.c~no-ioapic-check-x86_64-2	2005-05-06 21:58:55.149700760 -0700
> +++ linux-2.6.13-rc3-mm3-root/arch/x86_64/kernel/io_apic.c	2005-05-06 22:00:41.361554104 -0700
> @@ -1867,12 +1867,16 @@ int __init io_apic_get_unique_id (int io
>  	int i = 0;
>  
>  	/*
> +	 * xAPIC systems take advantage of APIC system bus architecture.
> +	 */
> +	
> +	 if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> +		return apic_id;
> +	

Shouldn't this be for both em64t and amd64?

