Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318764AbSG0OQU>; Sat, 27 Jul 2002 10:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318765AbSG0OQT>; Sat, 27 Jul 2002 10:16:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1548 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318764AbSG0OQR>;
	Sat, 27 Jul 2002 10:16:17 -0400
Message-ID: <3D42ABF5.5050600@mandrakesoft.com>
Date: Sat, 27 Jul 2002 10:19:33 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.5 patch] make de2104x hotplugable
References: <Pine.NEB.4.44.0207271412150.9592-100000@mimas.fachschaften.tu-muenchen.de>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> Hi Jeff,
> 
> since drivers/net/tulip/de2104x.c does currently not compile in 2.5.29 due
> to a .text.exit error when the driver is compiled into a kernel without
> hotplug support I'm wondering whether the patch below would be correct to
> make this PCI driver hotpluggable. Is my approach to change __init to
> __devinit and __exit to __devexit correct or is there something I've
> overseen?


This driver is intentionally not hot-pluggable.  I'll convert when 
someone actually tells me they are trying to hot-plug such a card.


> -static int __init de_init (void)
> +static int __devinit de_init (void)
>  {
>  #ifdef MODULE
>  	printk("%s", version);
> @@ -2231,7 +2231,7 @@
>  	return pci_module_init (&de_driver);
>  }
> 
> -static void __exit de_exit (void)
> +static void __devexit de_exit (void)
>  {
>  	pci_unregister_driver (&de_driver);
>  }


This is incorrect in any case -- the module init/exit functions are 
always __init and __exit.

	Jeff



