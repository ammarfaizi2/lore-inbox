Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTE1WiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTE1WiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:38:19 -0400
Received: from 213-4-13-153.uc.nombres.ttd.es ([213.4.13.153]:62213 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261305AbTE1WiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:38:15 -0400
Subject: Re: Fix suspend with pccardd running
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       dahinds@users.sourceforge.net
In-Reply-To: <20030528212724.GA695@elf.ucw.cz>
References: <20030528212724.GA695@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1054162287.747.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 29 May 2003 00:51:27 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-05-28 at 23:27, Pavel Machek wrote:
> Hi!
> 
> This fixes suspend when pccards are used... Please apply,
> 
> 							Pavel
> 
> --- /usr/src/tmp/linux/drivers/pcmcia/cs.c	2003-05-27 13:43:10.000000000 +0200
> +++ /usr/src/linux/drivers/pcmcia/cs.c	2003-05-28 23:09:47.000000000 +0200
> @@ -48,6 +48,7 @@
>  #include <linux/pm.h>
>  #include <linux/pci.h>
>  #include <linux/device.h>
> +#include <linux/suspend.h>
>  #include <asm/system.h>
>  #include <asm/irq.h>
>  
> @@ -783,6 +784,9 @@
>  		}
>  
>  		schedule();
> +		if (current->flags & PF_FREEZE)
> +			refrigerator(PF_IOTHREAD);
> +
>  		if (!skt->thread)
>  			break;
>  	}

This fixes the pccard-becomes-a-CPU-hog for me when resuming after
suspending (S3) using 2.5.70-mm1 and ACPI. Nice work!

