Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130580AbRCIW0L>; Fri, 9 Mar 2001 17:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130730AbRCIW0B>; Fri, 9 Mar 2001 17:26:01 -0500
Received: from [199.239.160.155] ([199.239.160.155]:41861 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S130721AbRCIWZz>; Fri, 9 Mar 2001 17:25:55 -0500
Date: Fri, 9 Mar 2001 14:23:32 -0800
From: Robert Read <rread@datarithm.net>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
        Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] serial console vs NMI watchdog
Message-ID: <20010309142332.E1792@tenchi.datarithm.net>
Mail-Followup-To: Andrew Morton <andrewm@uow.edu.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
	Keith Owens <kaos@ocs.com.au>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3AA8E6E5.A4AD5035@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AA8E6E5.A4AD5035@uow.edu.au>; from andrewm@uow.edu.au on Sat, Mar 10, 2001 at 01:21:25AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 10, 2001 at 01:21:25AM +1100, Andrew Morton wrote:
> +static atomic_t nmi_watchdog_enabled = ATOMIC_INIT(0);	/* 0 == enabled */
> +
> +void enable_nmi_watchdog(int yes)
> +{
> +	if (yes)
> +		atomic_inc(&nmi_watchdog_enabled);
> +	else
> +		atomic_dec(&nmi_watchdog_enabled);
> +}
>  
>  void nmi_watchdog_tick (struct pt_regs * regs)
>  {
> @@ -255,7 +264,7 @@
>  
>  	sum = apic_timer_irqs[cpu];
>  
> -	if (last_irq_sums[cpu] == sum) {
> +	if (last_irq_sums[cpu] == sum && atomic_read(&nmi_watchdog_enabled) == 0) {

Shouldn't that be atomic_read(&nmi_watchdog_enabled) != 0?
