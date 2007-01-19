Return-Path: <linux-kernel-owner+w=401wt.eu-S964854AbXASTNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbXASTNk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 14:13:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbXASTNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 14:13:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:42171 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932860AbXASTNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 14:13:39 -0500
X-Authenticated: #20450766
Date: Fri, 19 Jan 2007 20:13:32 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       Luotao Fu <lfu@pengutronix.de>
Subject: Re: [patch 3/3] clockevent driver for arm/pxa2xx
In-Reply-To: <20070109101307.715996000@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0701192010490.5127@poirot.grange>
References: <20070109100957.259649000@localhost.localdomain>
 <20070109101307.715996000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2007 s.hauer@pengutronix.de wrote:

> Add a clockevent driver for pxa systems. This patch also removes the pxa
> dyntick support since it is not necessary anymore with generic dynamic
> tick support
> 
> Signed-off-by: Luotao Fu <lfu@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> ---
>  arch/arm/mach-pxa/time.c |  106 ++++++++++++++++++++++-------------------------
>  1 file changed, 51 insertions(+), 55 deletions(-)
> 
> Index: arch/arm/mach-pxa/time.c
> ===================================================================
> --- a/arch/arm/mach-pxa/time.c.orig
> +++ b/arch/arm/mach-pxa/time.c
> @@ -19,6 +19,7 @@
>  #include <linux/errno.h>
>  #include <linux/sched.h>
>  #include <linux/clocksource.h>
> +#include <linux/clockchips.h>
>  
>  #include <asm/system.h>
>  #include <asm/hardware.h>
> @@ -29,6 +30,50 @@
>  #include <asm/mach/time.h>
>  #include <asm/arch/pxa-regs.h>
>  
> +static u32 clockevent_mode = 0;
> +
> +static void pxa_set_next_event(unsigned long evt,
> +				  struct clock_event_device *unused)
> +{
> +	OSMR0 = OSCR + evt;
> +}

This doesn't work for me in various nasty ways. Please, check for a 
minimum delay or loop to get ahead of time. See code in the "old" timer 
ISR. See how it unconditionally adds at least 10 ticks...

Thanks
Guennadi
---
Guennadi Liakhovetski
