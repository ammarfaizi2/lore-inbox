Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265513AbTAWXGx>; Thu, 23 Jan 2003 18:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTAWXGx>; Thu, 23 Jan 2003 18:06:53 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:30993 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id <S265513AbTAWXGw>;
	Thu, 23 Jan 2003 18:06:52 -0500
Date: Fri, 24 Jan 2003 00:15:49 +0100
From: romieu@fr.zoreil.com
To: Michael Still <mikal@stillhq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Fix errors in aironet4500 driver (cli_sti_removal-004) (fwd)
Message-ID: <20030124001549.B28073@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.30.0301240708430.10063-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.30.0301240708430.10063-100000@localhost.localdomain>; from mikal@stillhq.com on Fri, Jan 24, 2003 at 07:09:06AM +1100
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Still <mikal@stillhq.com> :
> 
> I'm resending this in the hope of people applying it.
> 
>  #endif /* AIRONET4500_H */
> diff -Nur linux-2.5.55/drivers/net/aironet4500_card.c linux-2.5.55-cli_sti_removal-002/drivers/net/aironet4500_card.c
> --- linux-2.5.55/drivers/net/aironet4500_card.c	Fri Jan 10 09:18:46 2003
> +++ linux-2.5.55-cli_sti_removal-002/drivers/net/aironet4500_card.c	Thu Jan  9 22:24:11 2003
[...]
> @@ -406,18 +398,18 @@
> 
>  		((struct awc_private *)dev->priv)->bus =  logdev;
> 
> -		cli();
> +		spin_lock_irq(&aironet4500_lock);
>  		if ( awc_init(dev) ){
>  			printk("card not found at irq %x io %lx\n",dev->irq, dev->base_addr);
>  			if (card==0){
> -				sti();
> +				spin_unlock_irq(&aironet4500_lock);
>  				return -1;
>  			}
> -			sti();
> +			spin_unlock_irq(&aironet4500_lock);

It isn't pretty and awc4500_pnp_probe() leaks memory with this return
(hint: follow 'dev').

--
Ueimor
