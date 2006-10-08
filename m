Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWJHJpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWJHJpd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 05:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWJHJpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 05:45:33 -0400
Received: from www.osadl.org ([213.239.205.134]:183 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750988AbWJHJpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 05:45:32 -0400
Subject: Re: + clocksource-initialize-list-value.patch added to -mm tree
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: akpm@osdl.org
Cc: dwalker@mvista.com, johnstul@us.ibm.com, mingo@elte.hu,
       zippel@linux-m68k.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200610070153.k971rsDf020869@shell0.pdx.osdl.net>
References: <200610070153.k971rsDf020869@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Sun, 08 Oct 2006 11:50:39 +0200
Message-Id: <1160301039.22911.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-06 at 18:53 -0700, akpm@osdl.org wrote:
> A change to clocksource initialization.  It's optional for new clocksources,
> but prefered.  If the list field is initialized it allows clocksource_register
> to complete faster since it doesn't have the scan the list of clocks doing
> strcmp on each.

Either make it required or not.

> diff -puN arch/i386/kernel/hpet.c~clocksource-initialize-list-value arch/i386/kernel/hpet.c
> --- a/arch/i386/kernel/hpet.c~clocksource-initialize-list-value
> +++ a/arch/i386/kernel/hpet.c
> @@ -27,6 +27,7 @@ static struct clocksource clocksource_hp
>  	.mult		= 0, /* set below */
>  	.shift		= HPET_SHIFT,
>  	.is_continuous	= 1,
> +	.list		= CLOCKSOURCE_LIST_INIT(clocksource_hpet.list),
... 
> +/* Abstracted list initialization */
> +#define CLOCKSOURCE_LIST_INIT(x)	LIST_HEAD_INIT(x)
> +

Please use LIST_HEAD_INIT(). This is not an abstraction, this is an
obfuscation. 

	tglx


