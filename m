Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271267AbRHTPDW>; Mon, 20 Aug 2001 11:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271276AbRHTPDJ>; Mon, 20 Aug 2001 11:03:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30728 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271267AbRHTPCv>; Mon, 20 Aug 2001 11:02:51 -0400
Subject: Re: PATCH: linux-2.4.9/drivers/i2o to new module_{init,exit} interface
To: adam@yggdrasil.com (Adam J. Richter)
Date: Mon, 20 Aug 2001 16:05:02 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, deepak@plexity.net, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20010820072925.A296@baldur.yggdrasil.com> from "Adam J. Richter" at Aug 20, 2001 07:29:25 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Yqbv-0006BW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I'm not exactly sure where to send i2o patches, so I'm
> posting them to linux-kernel.  I would appreciate a pointer if there
> is a more specialized address for i2o patches.

Me for i2o

>  	sti();
> -#ifdef CONFIG_I2O
> -	i2o_init();
> -#endif
>  #ifdef CONFIG_BLK_DEV_DAC960
>  	DAC960_Initialize();

Rejected. The ordering is critical because drivers may have both i2o and
non i2o interfaces. Also an i2o card may control other pci devices and
we will need to claim the resources beforehand when we finally support that.

>  dep_tristate '  I2O Block OSM' CONFIG_I2O_BLOCK $CONFIG_I2O
> -if [ "$CONFIG_NET" = "y" ]; then
> +if [ "$CONFIG_NET" != "n" ]; then

NET cannot be modular

> -#ifdef MODULE
>  	i = core->install(c);
> -#else
> -	i = i2o_install_controller(c);
> -#endif /* MODULE */

This changes all the module dependancy patterns - yes its right, no its not
appropriate for a "stable" kernel.

