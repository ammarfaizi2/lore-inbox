Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263381AbTC2E6Y>; Fri, 28 Mar 2003 23:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263383AbTC2E6Y>; Fri, 28 Mar 2003 23:58:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4998 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263381AbTC2E6Y>;
	Fri, 28 Mar 2003 23:58:24 -0500
Message-ID: <3E852AAF.4090106@pobox.com>
Date: Sat, 29 Mar 2003 00:10:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: davej@codemonkey.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: init_etherdev conversion for sb1000
References: <200303241642.h2OGg235008237@deviant.impure.org.uk>
In-Reply-To: <200303241642.h2OGg235008237@deviant.impure.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davej@codemonkey.org.uk wrote:
> Also plugs leak by kfree'ing dev_sb1000 on exit.
> 
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/net/sb1000.c linux-2.5/drivers/net/sb1000.c
> --- bk-linus/drivers/net/sb1000.c	2003-03-08 09:57:16.000000000 +0000
> +++ linux-2.5/drivers/net/sb1000.c	2003-03-17 23:42:27.000000000 +0000
> @@ -218,7 +218,7 @@ sb1000_probe(struct net_device *dev)
>  				"S/N %#8.8x, IRQ %d.\n", dev->name, dev->base_addr,
>  				dev->mem_start, serial_number, dev->irq);
>  
> -		dev = init_etherdev(dev, 0);
> +		dev = init_etherdev(dev, sizeof(struct sb1000_private));


nope -- init_etherdev only allocs when it's first arg is NULL.

