Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030662AbWJCXMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030662AbWJCXMk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030663AbWJCXMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:12:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:1426 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030662AbWJCXMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:12:38 -0400
Subject: Re: [patch 2.6.18+ ] scx200_hrt - fix precedence bug manifesting
	as 27x clock in 1 MHz mode (resend with preformat)
From: john stultz <johnstul@us.ibm.com>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <4522E76C.3080202@gmail.com>
References: <4522DDBF.3070701@gmail.com>  <4522E76C.3080202@gmail.com>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 16:11:25 -0700
Message-Id: <1159917085.1642.46.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-03 at 16:42 -0600, Jim Cromie wrote:
> Fix paren-placement / precedence bug breaking initialization for 1 MHz 
> clock mode.
> Also fix comment spelling error, and fence-post (off-by-one) error on 
> symbol
> used in request_region.
> 
> Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

Acked-by: John Stultz <johnstul@us.ibm.com>

> ---
> 
> Oops, fix the <preformat>
> 
> drivers/clocksource/scx200_hrt.c |    4 ++--
> include/linux/scx200.h           |    2 +-
> 2 files changed, 3 insertions(+), 3 deletions(-)
> 
> this patch fixes http://bugzilla.kernel.org/show_bug.cgi?id=7242
> but I cannot close it, so I'll leave it to those so empowered.
> 
> should be ok for -stable, if the spelling correction doesnt break the 
> rules.
> The fence-post error is real, just not caught on x86, AFAICT.
> 
> Thanks alexander.krause@erazor-zone.de, dzpost@dedekind.net, for the 
> reports and patch test,
> and phelps@mantara.com for the independent patch and verification.
> 
> diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-sk/drivers/clocksource/scx200_hrt.c debug/drivers/clocksource/scx200_hrt.c
> --- ../linux-2.6.18-sk/drivers/clocksource/scx200_hrt.c	2006-09-19 23:58:35.000000000 -0600
> +++ debug/drivers/clocksource/scx200_hrt.c	2006-10-03 14:05:27.000000000 -0600
> @@ -63,7 +63,7 @@ static struct clocksource cs_hrt = {
>  
>  static int __init init_hrt_clocksource(void)
>  {
> -	/* Make sure scx200 has initializedd the configuration block */
> +	/* Make sure scx200 has initialized the configuration block */
>  	if (!scx200_cb_present())
>  		return -ENODEV;
>  
> @@ -76,7 +76,7 @@ static int __init init_hrt_clocksource(v
>  	}
>  
>  	/* write timer config */
> -	outb(HR_TMEN | (mhz27) ? HR_TMCLKSEL : 0,
> +	outb(HR_TMEN | (mhz27 ? HR_TMCLKSEL : 0),
>  	     scx200_cb_base + SCx200_TMCNFG_OFFSET);
>  
>  	if (mhz27) {
> diff -ruNp -X dontdiff -X exclude-diffs ../linux-2.6.18-sk/include/linux/scx200.h debug/include/linux/scx200.h
> --- ../linux-2.6.18-sk/include/linux/scx200.h	2006-09-20 00:00:59.000000000 -0600
> +++ debug/include/linux/scx200.h	2006-10-03 09:18:50.000000000 -0600
> @@ -32,7 +32,7 @@ extern unsigned scx200_cb_base;
>  
>  /* High Resolution Timer */
>  #define SCx200_TIMER_OFFSET 0x08
> -#define SCx200_TIMER_SIZE 0x05
> +#define SCx200_TIMER_SIZE 0x06
>  
>  /* Clock Generators */
>  #define SCx200_CLOCKGEN_OFFSET 0x10
> 
> 

