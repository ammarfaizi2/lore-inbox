Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWDNSLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWDNSLh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWDNSLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:11:37 -0400
Received: from tim.rpsys.net ([194.106.48.114]:14291 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1751368AbWDNSLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:11:36 -0400
Subject: Re: Fix collie compilation
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: Russell King <rmk@arm.linux.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>, lenz@cs.wisc.edu
In-Reply-To: <20060414180300.GA23060@elf.ucw.cz>
References: <20060414180300.GA23060@elf.ucw.cz>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 19:11:19 +0100
Message-Id: <1145038279.6179.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 20:03 +0200, Pavel Machek wrote:
> Fix collie compilation with current defconfig
>[...]
> diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
> index be589ce..9aa6cde 100644
> --- a/arch/arm/mach-sa1100/collie.c
> +++ b/arch/arm/mach-sa1100/collie.c
> @@ -295,7 +295,9 @@ static void __init collie_init(void)
>  	LCM_DAC |= (LCM_DAC_SCLOEB | LCM_DAC_SDAOEB); /* init DAC */
>  #endif
>  
> +#ifdef CONFIG_PCMCIA_SA1100
>  	platform_scoop_config = &collie_pcmcia_config;
> +#endif

I'm fine with the defconfig changes but this last bit doesn't fix the
original problem if CONFIG_PCMCIA_SA1100=m. The correct solution is to
move platform_scoop_config back to scoop.c which I'll submit a patch
for.

Richard

