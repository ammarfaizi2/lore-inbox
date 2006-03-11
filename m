Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWCKMeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWCKMeU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 07:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWCKMeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 07:34:20 -0500
Received: from lana.hrz.tu-chemnitz.de ([134.109.132.3]:51620 "EHLO
	lana.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S1750858AbWCKMeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 07:34:19 -0500
Date: Sat, 11 Mar 2006 13:34:16 +0100
From: Steffen Klassert <klassert@mathematik.tu-chemnitz.de>
To: linux-kernel@vger.kernel.org
Cc: bjorn.helgaas@hp.com, jgarzik@pobox.com, mm-commits@vger.kernel.org
Subject: Re: + eisa-tidy-up-driver_register-return-value.patch added to -mm tree
Message-ID: <20060311123416.GB19157@bayes.mathematik.tu-chemnitz.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com,
	jgarzik@pobox.com, mm-commits@vger.kernel.org
References: <200603022346.k22NktbJ015140@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603022346.k22NktbJ015140@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
X-Spam-Score: -1.4 (-)
X-Spam-Report: --- Start der SpamAssassin 3.1.0 Textanalyse (-1.4 Punkte)
	Fragen an/questions to:  Postmaster TU Chemnitz <postmaster@tu-chemnitz.de>
	-1.4 ALL_TRUSTED            Nachricht wurde nur ueber vertrauenswuerdige Rechner
	weitergeleitet
	--- Ende der SpamAssassin Textanalyse
X-Scan-Signature: 85efea2434610bb461976c4d7ea3ef3f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 03:49:10PM -0800, akpm@osdl.org wrote:

...

> 
> From: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Remove the assumption that driver_register() returns the number of devices
> bound to the driver.  In fact, it returns zero for success or a negative
> error value.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Cc: Jeff Garzik <jgarzik@pobox.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

...

> diff -puN drivers/net/3c59x.c~eisa-tidy-up-driver_register-return-value drivers/net/3c59x.c
> --- 25/drivers/net/3c59x.c~eisa-tidy-up-driver_register-return-value	Thu Mar  2 15:48:23 2006
> +++ 25-akpm/drivers/net/3c59x.c	Thu Mar  2 15:48:23 2006
> @@ -1094,9 +1094,11 @@ static int __init vortex_eisa_init (void
>  {
>  	int eisa_found = 0;
>  	int orig_cards_found = vortex_cards_found;
> +	int err;
>  
>  #ifdef CONFIG_EISA
> -	if (eisa_driver_register (&vortex_eisa_driver) >= 0) {
> +	err = eisa_driver_register (&vortex_eisa_driver);
> +	if (!err) {
>  			/* Because of the way EISA bus is probed, we cannot assume
>  			 * any device have been found when we exit from
>  			 * eisa_driver_register (the bus root driver may not be


This results in

drivers/net/3c59x.c: In function `vortex_eisa_init':
drivers/net/3c59x.c:1091: warning: unused variable `err'

if CONFIG_EISA is not defined.
