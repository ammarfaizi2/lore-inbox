Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVHDJQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVHDJQm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 05:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262305AbVHDJQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 05:16:42 -0400
Received: from cantor2.suse.de ([195.135.220.15]:32663 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262277AbVHDJQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 05:16:41 -0400
Date: Thu, 4 Aug 2005 11:16:40 +0200
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Suresh B Siddha <suresh.b.siddha@intel.com>,
       ashok.raj@intel.com, Andi Kleen <ak@suse.de>,
       Rajesh Shah <rajesh.shah@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] updated - Automatically enable bigsmp when we have more than 8 CPUs
Message-ID: <20050804091640.GK8266@wotan.suse.de>
References: <20050728115142.A30921@unix-os.sc.intel.com> <20050803102023.GN10895@wotan.suse.de> <20050803160114.A5938@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803160114.A5938@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 04:01:14PM -0700, Venkatesh Pallipadi wrote:
> 
> Below is the updated patch.

Looks good. Only minor nit.

> +++ linux-2.6.13-rc3-auto/arch/i386/kernel/setup.c	2005-08-03 14:33:34.450182216 -0700
> @@ -1593,8 +1594,13 @@ void __init setup_arch(char **cmdline_p)
>  	 */
>  	acpi_boot_table_init();
>  	acpi_boot_init();
> -#endif
>  
> +#ifdef CONFIG_X86_PC
> +	if (def_to_bigsmp) {
> +		printk(KERN_WARNING "More than 8 CPUs detected and CONFIG_X86_PC cannot handle it. Use CONFIG_X86_GENERICARCH or CONFIG_X86_BIGSMP.\n");

Isn't that printk line longer than 80 characters?  Will it even fit 
on the screen? 

-Andi
