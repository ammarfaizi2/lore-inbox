Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbREURGJ>; Mon, 21 May 2001 13:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbREURF7>; Mon, 21 May 2001 13:05:59 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:48132 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S261593AbREURFy>;
	Mon, 21 May 2001 13:05:54 -0400
Date: Mon, 21 May 2001 19:05:45 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Marcus Meissner <Marcus.Meissner@caldera.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: maestro ported to 2.4 PCI API
Message-ID: <20010521190545.A3522@se1.cogenit.fr>
In-Reply-To: <20010521173707.A10692@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010521173707.A10692@caldera.de>; from Marcus.Meissner@caldera.de on Mon, May 21, 2001 at 05:37:07PM +0200
X-Organisation: Marie's fan club
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Meissner <Marcus.Meissner@caldera.de> ecrit :
[...]
>  	if( request_region(iobase, 256, card_names[card_type]) == NULL )
>  	{
>  		printk(KERN_WARNING "maestro: can't allocate 256 bytes I/O at 0x%4.4x\n", iobase);
> -		return 0;
> -	}
> -
> -	/* this was tripping up some machines */
> -	if(pcidev->irq == 0) {
> -		printk(KERN_WARNING "maestro: pci subsystem reports irq 0, this might not be correct.\n");
> +		return -EBUSY;
>  	}
>  
>  	/* just to be sure */
> @@ -3406,7 +3429,7 @@
>  	if(card == NULL)
>  	{
>  		printk(KERN_WARNING "maestro: out of memory\n");
> -		return 0;
> +		return -ENOMEM;

request_region is unbalanced in this return path.

-- 
Ueimor
