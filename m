Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSG2Qcq>; Mon, 29 Jul 2002 12:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSG2Qcq>; Mon, 29 Jul 2002 12:32:46 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:15098 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317506AbSG2Qcq>; Mon, 29 Jul 2002 12:32:46 -0400
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, martin@dalecki.de
In-Reply-To: <200207291549.IAA04805@adam.yggdrasil.com>
References: <200207291549.IAA04805@adam.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jul 2002 18:51:48 +0100
Message-Id: <1027965108.4050.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	With this change, I believe I can remove all of the
> cli()...restore_flags() pairs from the channel->tuneproc functions of
> each IDE driver.  I have also removed what appear to be some

Some tuning locks are needed because an interrupt during the magic
tuning sequence will break stuff


g is ready, program the new timings
>  	 */
> -	spin_lock(&cmd640_lock, flags);
> +	spin_lock_irqsave(&cmd640_lock, flags);
>  	/*

For the CMD640 please see the patch I posted. It has to use pci_lock and
it needs other 2.4 fixes forward porting which I did


> -	save_flags(flags);
> -	cli();	/* all CPUs (there should only be one CPU with this chipset) */
> +	local_irq_save(flags); /* There should only be one CPU with this
> +				  chipset. */

Not needed that I can see. It also wants to use the proper master/mwi
functions. I've got a diff for this I can post.



