Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319602AbSH2XUb>; Thu, 29 Aug 2002 19:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319612AbSH2XUb>; Thu, 29 Aug 2002 19:20:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30735 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319602AbSH2XUa>;
	Thu, 29 Aug 2002 19:20:30 -0400
Message-ID: <3D6EAD3B.6030108@mandrakesoft.com>
Date: Thu, 29 Aug 2002 19:24:43 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Dave Hansen <haveblue@us.ibm.com>,
       Michael Obster <michael.obster@bingo-ev.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Compiling 2.5.32
References: <Pine.NEB.4.44.0208300113410.2879-100000@mimas.fachschaften.tu-muenchen.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Jeff Garzik doesn't want 1. until "someone actually tells me they are
> trying to hot-plug such a card" and he didn't apply the following patch to
> #ifdef the .remove away if the driver is compiled statically into the
> kernel:
> 
> 
> --- drivers/net/tulip/de2104x.c.old	2002-08-30 01:06:09.000000000 +0200
> +++ drivers/net/tulip/de2104x.c	2002-08-30 01:06:45.000000000 +0200
> @@ -2216,7 +2216,9 @@
>  	.name		= DRV_NAME,
>  	.id_table	= de_pci_tbl,
>  	.probe		= de_init_one,
> +#ifdef MODULE
>  	.remove		= de_remove_one,
> +#endif
>  #ifdef CONFIG_PM
>  	.suspend	= de_suspend,
>  	.resume		= de_resume,


You missed my recent message, I think.

Currently in 2.5.x, you should be able to replace that #ifdef with 
__devexit_p -- without changing the de_remove_one prototype.  I updated 
the definition of __devexit_p in 2.5.30 or so.

	Jeff



