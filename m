Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWHEXRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWHEXRd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 19:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWHEXRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 19:17:33 -0400
Received: from ozlabs.org ([203.10.76.45]:15022 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751366AbWHEXRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 19:17:33 -0400
Subject: Re: [patch 7/8] Add a bootparameter to reserve high linear address
	space.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Zachary Amsden <zach@vmware.com>, chrisw@sous-sol.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060805145840.653912a2.akpm@osdl.org>
References: <20060803002510.634721860@xensource.com>
	 <20060803002518.595166293@xensource.com>
	 <20060802231912.ed77f930.akpm@osdl.org> <44D1A6B6.8040003@vmware.com>
	 <20060803004144.554d9882.akpm@osdl.org> <44D1BAB8.8070509@vmware.com>
	 <20060805145840.653912a2.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 06 Aug 2006 09:17:29 +1000
Message-Id: <1154819850.29151.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-05 at 14:58 -0700, Andrew Morton wrote:
> On Thu, 03 Aug 2006 01:58:32 -0700
> Zachary Amsden <zach@vmware.com> wrote:
> 
> > Add a bootparameter to reserve high linear address space for hypervisors.
> > This is necessary to allow dynamically loaded hypervisor modules, which
> > might not happen until userspace is already running, and also provides a
> > useful tool to benchmark the performance impact of reduced lowmem address
> > space.
> 
> Andi has gone and rotorooted the x86 boot parameter handling in there. 

That was me, via Andi, but yep:

> diff -puN arch/i386/kernel/setup.c~x86-add-a-bootparameter-to-reserve-high-linear-address-space arch/i386/kernel/setup.c
> --- a/arch/i386/kernel/setup.c~x86-add-a-bootparameter-to-reserve-high-linear-address-space
> +++ a/arch/i386/kernel/setup.c
> @@ -149,6 +149,12 @@ static char command_line[COMMAND_LINE_SI
>  
>  unsigned char __initdata boot_params[PARAM_SIZE];
>  
> +static int __init setup_reservetop(char *s)
> +{
> +	return 1;
> +}
> +__setup("reservetop", setup_reservetop);
> +
>  static struct resource data_resource = {
>  	.name	= "Kernel data",
>  	.start	= 0,

Please remove this hunk: it's now junk.

Cheers,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

