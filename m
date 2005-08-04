Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVHDAwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVHDAwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVHDAuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:50:16 -0400
Received: from terminus.zytor.com ([209.128.68.124]:45756 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261678AbVHDAtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:49:01 -0400
Message-ID: <42F165BC.9030504@zytor.com>
Date: Wed, 03 Aug 2005 17:47:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: zach@vmware.com
CC: akpm@osdl.org, chrisl@vmware.com, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, pratap@vmware.com, Riley@Williams.Name
Subject: Re: [PATCH] 1/5 more-asm-cleanup
References: <200508040043.j740h4wB004166@zach-dev.vmware.com>
In-Reply-To: <200508040043.j740h4wB004166@zach-dev.vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zach@vmware.com wrote:
> Some more assembler cleanups I noticed along the way.

> Index: linux-2.6.13/arch/i386/kernel/cpu/intel.c
> ===================================================================
> --- linux-2.6.13.orig/arch/i386/kernel/cpu/intel.c	2005-08-03 15:18:18.000000000 -0700
> +++ linux-2.6.13/arch/i386/kernel/cpu/intel.c	2005-08-03 15:19:39.000000000 -0700
> @@ -82,16 +82,12 @@
>   */
>  static int __devinit num_cpu_cores(struct cpuinfo_x86 *c)
>  {
> -	unsigned int eax;
> +	unsigned int eax, ebx, ecx, edx;
>  
>  	if (c->cpuid_level < 4)
>  		return 1;
>  
> -	__asm__("cpuid"
> -		: "=a" (eax)
> -		: "0" (4), "c" (0)
> -		: "bx", "dx");
> -
> +	cpuid(4, &eax, &ebx, &ecx, &edx);
>  	if (eax & 0x1f)
>  		return ((eax >> 26) + 1);

Reject!  This is a bogus patch; Intel's CPUID level 4 has a nonstandard 
dependency on ECX (idiots...) and therefore this needs special handling.

	-hpa
