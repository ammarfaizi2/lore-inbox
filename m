Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272801AbTG3H7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272802AbTG3H7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:59:25 -0400
Received: from Sina.Sharif.EDU ([81.31.160.35]:5341 "EHLO sina.sharif.edu")
	by vger.kernel.org with ESMTP id S272801AbTG3H7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:59:23 -0400
Date: Wed, 30 Jul 2003 12:33:32 +0430 (IRST)
From: Behdad Esfahbod <behdad@bamdad.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0-test2 : ACPI poweroff fix
In-Reply-To: <20030730072919.GA5773@alpha.home.local>
Message-ID: <Pine.LNX.4.44.0307301231410.6799-100000@gilas.bamdad.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The same patch fixes ACPI poweroff problem on my machine with 
2.6.0-test2 too.  Well, it should be applied to acpi/sleep/main.c 
and acpi/sleep/poweroff.c

On Wed, 30 Jul 2003, Willy Tarreau wrote:

> On Thu, Jul 24, 2003 at 06:02:15PM -0300, Marcelo Tosatti wrote:
> > 
> > Great. I`ll apply it to the 2.4 tree later and it will be present in
> > -pre9.
> 
> Hi Marcelo,
> 
> it seems you forgot the patch in -pre9. Never mind, I've just rediffed it,
> here it is.
> 
> Cheers,
> Willy
> 
> 
> diff -urN linux-2.4.22-pre9/drivers/acpi/system.c linux-2.4.22-pre9-fix/drivers/acpi/system.c
> --- linux-2.4.22-pre9/drivers/acpi/system.c	Wed Jul 30 09:18:40 2003
> +++ linux-2.4.22-pre9-fix/drivers/acpi/system.c	Wed Jul 30 09:21:56 2003
> @@ -90,9 +90,7 @@
>  static void
>  acpi_power_off (void)
>  {
> -	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
> -	ACPI_DISABLE_IRQS();
> -	acpi_enter_sleep_state(ACPI_STATE_S5);
> +	acpi_suspend(ACPI_STATE_S5);
>  }
>  
>  #endif /*CONFIG_PM*/
> @@ -180,7 +178,7 @@
>  			return AE_ERROR;
>  	}
>  
> -	if (state < ACPI_STATE_S5) {
> +	if (state <= ACPI_STATE_S5) {
>  		/* Tell devices to stop I/O and actually save their state.
>  		 * It is theoretically possible that something could fail,
>  		 * so handle that gracefully..
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Behdad Esfahbod		8 Mordad 1382, 2003 Jul 30 
http://behdad.org/	[Finger for Geek Code]

If you do a job too well, you'll get stuck with it.

