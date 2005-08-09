Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVHIWCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVHIWCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 18:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbVHIWCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 18:02:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964992AbVHIWCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 18:02:51 -0400
Date: Tue, 9 Aug 2005 15:01:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@freescale.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org,
       msm@freescale.com
Subject: Re: [PATCH] ppc32: Added support for the Book-E style Watchdog
 Timer
Message-Id: <20050809150131.7eac43ad.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0508091530060.10161@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0508091530060.10161@nylon.am.freescale.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@freescale.com> wrote:
>
> PowerPC 40x and Book-E processors support a watchdog timer at the processor
> core level.  The timer has implementation dependent timeout frequencies
> that can be configured by software. 
> 
> One the first Watchdog timeout we get a critical exception.  It is left
> to board specific code to determine what should happen at this point.  If
> nothing is done and another timeout period expires the processor may
> attempt to reset the machine.
> 
> Command line parameters:
>   wdt=0 : disable watchdog (default)
>   wdt=1 : enable watchdog
> 
>   wdt_period=N : N sets the value of the Watchdog Timer Period.
> 
>   The Watchdog Timer Period meaning is implementation specific. Check
>   User Manual for the processor for more details.
> 
> This patch is based off of work done by Takeharu Kato.
> 
> ...
> 
> +#ifdef CONFIG_BOOKE_WDT
> +/* Checks wdt=x and wdt_period=xx command-line option */
> +int __init early_parse_wdt(char *p)
> +{
> +	extern u32 wdt_enable;
> +
> +	if (p && strncmp(p, "0", 1) != 0)
> +	       wdt_enable = 1;
> +
> +	return 0;
> +}
> +early_param("wdt", early_parse_wdt);
> +
> +int __init early_parse_wdt_period (char *p)
> +{
> +	extern u32 wdt_period;
> +
> +	if (p)
> +		wdt_period = simple_strtoul(p, NULL, 0);
> +
> +	return 0;
> +}


Would prefer to see the declaration of wdt_period in a header file, please.

But beware that wdt_enable() is already a static symbol in a couple of
watchdog drivers.  It might be best to rename the ppc global to something
less generic-sounding while you're there.
