Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUI0UHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUI0UHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267312AbUI0UHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:07:15 -0400
Received: from fmr03.intel.com ([143.183.121.5]:60596 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S267301AbUI0UGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:06:40 -0400
Date: Mon, 27 Sep 2004 13:06:16 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: anil.s.keshavamurthy@intel.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net, lhns-devel@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][3/4] Add hotplug support to drivers/acpi/numa.c
Message-ID: <20040927130616.B30443@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20040920092520.A14208@unix-os.sc.intel.com> <20040920094719.H14208@unix-os.sc.intel.com> <20040924012301.000007c6.tokunaga.keiich@jp.fujitsu.com> <20040924013255.00000337.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040924013255.00000337.tokunaga.keiich@jp.fujitsu.com>; from tokunaga.keiich@jp.fujitsu.com on Fri, Sep 24, 2004 at 01:32:55AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 01:32:55AM +0900, Keiichiro Tokunaga wrote:
> +void acpi_numa_node_init(acpi_handle handle)
Why is this function returning void? I expect
this to return int, what do you think?
> +
> +	if (acpi_bus_get_device(handle, &node_dev)) {
> +		printk(KERN_ERR"Unknown handle.\n");
> +		return_VOID;
> +	}
Why do you need to call acpi_bus_get_device?

> +	acpi_walk_namespace(ACPI_TYPE_PROCESSOR,
> +			    handle,
> +			    (u32) 1,
> +			    find_processor,
> +			    data,
> +			    (void **)&cnt);
Why are you looking for processor device here?
Please remove this acpi_walk_namespace function.

> +	/*
> diff -puN /dev/null include/acpi/numa.h
> +#ifndef MAX_PXM_DOMAINS
> +#define MAX_PXM_DOMAINS (256)
> +#endif
Why defining it again, It is already defined in asm-ia64/acpi.h file
> 
> _
