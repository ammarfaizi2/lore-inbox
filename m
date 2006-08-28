Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWH1Vjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWH1Vjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWH1Vje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:39:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932183AbWH1Vjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:39:33 -0400
Date: Mon, 28 Aug 2006 14:39:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, michael.olbrich@gmx.net
Subject: Re: [PATCH -mm] Fix faulty HPET clocksource usage (fix for bug
 #7062)
Message-Id: <20060828143928.c6fc1b85.akpm@osdl.org>
In-Reply-To: <1156800759.16398.6.camel@localhost.localdomain>
References: <1156800759.16398.6.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 14:32:39 -0700
john stultz <johnstul@us.ibm.com> wrote:

> Apparently some systems export valid HPET addresses, but hpet_enable()
> fails. Then when the HPET clocksource starts up, it only checks for a
> valid HPET address, and the result is a system where time does not
> advance.
> 
> See http://bugme.osdl.org/show_bug.cgi?id=7062 for details.
> 
> This patch just makes sure we better check that the HPET is functional
> before registering the HPET clocksource.
> 
> Signed-off-by: John Stultz <johnstul@us.ibm.com>
> 
> diff --git a/arch/i386/kernel/hpet.c b/arch/i386/kernel/hpet.c
> index c6737c3..17647a5 100644
> --- a/arch/i386/kernel/hpet.c
> +++ b/arch/i386/kernel/hpet.c
> @@ -35,7 +35,7 @@ static int __init init_hpet_clocksource(
>  	void __iomem* hpet_base;
>  	u64 tmp;
>  
> -	if (!hpet_address)
> +	if (!is_hpet_enabled())
>  		return -ENODEV;
>  
>  	/* calculate the hpet address: */

Thanks.   This would be a 2.6.18 thing, wouldn't it?
