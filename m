Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266033AbUFUFNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbUFUFNX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 01:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266018AbUFUFNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 01:13:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11201 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266033AbUFUFLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 01:11:33 -0400
Message-ID: <40D66DF3.10609@pobox.com>
Date: Mon, 21 Jun 2004 01:11:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.7-bk way too fast
References: <40D64DF7.5040601@pobox.com>	<40D657B7.8040807@pobox.com> <20040620210233.1e126ddc.akpm@osdl.org>
In-Reply-To: <20040620210233.1e126ddc.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Try this.
> 
> 
> --- 25/arch/i386/kernel/mpparse.c~i386-double-clock-speed-fix	2004-06-20 18:04:47.409952912 -0700
> +++ 25-akpm/arch/i386/kernel/mpparse.c	2004-06-20 18:05:13.034057456 -0700
> @@ -1017,7 +1017,8 @@ void __init mp_config_acpi_legacy_irqs (
>  
>  		for (idx = 0; idx < mp_irq_entries; idx++)
>  			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
> -				(mp_irqs[idx].mpc_dstapic == ioapic) &&
> +				(mp_irqs[idx].mpc_dstapic ==
> +					mp_ioapics[ioapic].mpc_apicid) &&
>  				(mp_irqs[idx].mpc_srcbusirq == i ||
>  				mp_irqs[idx].mpc_dstirq == i))
>  					break;


ACK -- this patch fixes it for me, at least.

Thanks muchly,

	Jeff


