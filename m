Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261448AbULNIHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbULNIHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 03:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbULNIHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 03:07:20 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:11182 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261448AbULNIHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 03:07:14 -0500
Date: Tue, 14 Dec 2004 09:07:08 +0100
From: Andi Kleen <ak@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ak@suse.de
Subject: Re: [PATCH] 2.6.10-rc2-mm4 panic on AMD64
Message-ID: <20041214080708.GP1046@wotan.suse.de>
References: <1102369238.2826.8.camel@dyn318077bld.beaverton.ibm.com> <20041206141515.7f4bd45f.akpm@osdl.org> <200412070022.23645.rjw@sisk.pl> <1102380640.2826.13.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102380640.2826.13.camel@dyn318077bld.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the late answer, I was travelling.

On Mon, Dec 06, 2004 at 04:50:40PM -0800, Badari Pulavarty wrote:
> Ok !! Here is the patch to fix the problem. It works
> fine on my 4-way AMD64 box. 
> 
> Rafael, can you verify on yours ?
> 
> Problem is with "c - cpu_data" arthimetic. "c" could
> be "boot_cpu_data" or "cpu_data".
> 
> Andi, is this reasonable ?

Yes thanks.  Looks good (except for the whitespace in the if ;) 

Andrew, I assume you already merged it and pushed it to Linus.

-Andi (wearing a brown paper bag) 

[...]

> --- linux.org/arch/x86_64/kernel/setup.c	2004-12-06 17:47:46.000000000 -0800
> +++ linux/arch/x86_64/kernel/setup.c	2004-12-06 17:43:39.000000000 -0800
> @@ -947,7 +947,8 @@ void __init identify_cpu(struct cpuinfo_
>  	mcheck_init(c);
>  #endif
>  #ifdef CONFIG_NUMA
> -	numa_add_cpu(c - cpu_data);
> +	if ( c != &boot_cpu_data ) 
> +		numa_add_cpu(c - cpu_data);
>  #endif
>  }
>   

