Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVAKUau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVAKUau (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 15:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVAKUau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 15:30:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:61369 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262005AbVAKUaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 15:30:14 -0500
Message-ID: <41E436AC.1050004@osdl.org>
Date: Tue, 11 Jan 2005 12:27:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: wli@holomorphy.com
Subject: Re: [PATCH] silence numerous size_t warnings in drivers/acpi/processor_idle.c
References: <200501111916.j0BJGq1F010042@hera.kernel.org>
In-Reply-To: <200501111916.j0BJGq1F010042@hera.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.2334, 2005/01/11 09:21:40-08:00, wli@holomorphy.com
> 
> 	[PATCH] silence numerous size_t warnings in drivers/acpi/processor_idle.c
> 	
> 	Multiple format -related warnings arise from size_t issues.  This patch
> 	peppers the seq_printf()'s with 'z' qualifiers and casts to silence them all.

Does this mean that ptrdiff_t type looks same as a size_t
to printk() & seq_printf() ?

>  processor_idle.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> 
> diff -Nru a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> --- a/drivers/acpi/processor_idle.c	2005-01-11 11:17:04 -08:00
> +++ b/drivers/acpi/processor_idle.c	2005-01-11 11:17:04 -08:00
> @@ -838,12 +838,12 @@
>  	if (!pr)
>  		goto end;
>  
> -	seq_printf(seq, "active state:            C%d\n"
> +	seq_printf(seq, "active state:            C%zd\n"
>  			"max_cstate:              C%d\n"
>  			"bus master activity:     %08x\n",
>  			pr->power.state ? pr->power.state - pr->power.states : 0,
>  			max_cstate,
> -			pr->power.bm_activity);
> +			(unsigned)pr->power.bm_activity);
>  
>  	seq_puts(seq, "states:\n");
>  
> @@ -872,14 +872,14 @@
>  		}
>  
>  		if (pr->power.states[i].promotion.state)
> -			seq_printf(seq, "promotion[C%d] ",
> +			seq_printf(seq, "promotion[C%zd] ",
>  				(pr->power.states[i].promotion.state -
>  				 pr->power.states));
>  		else
>  			seq_puts(seq, "promotion[--] ");
>  
>  		if (pr->power.states[i].demotion.state)
> -			seq_printf(seq, "demotion[C%d] ",
> +			seq_printf(seq, "demotion[C%zd] ",
>  				(pr->power.states[i].demotion.state -
>  				 pr->power.states));
>  		else
> -


-- 
~Randy
