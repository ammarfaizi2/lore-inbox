Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318217AbSGPVKR>; Tue, 16 Jul 2002 17:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318219AbSGPVKQ>; Tue, 16 Jul 2002 17:10:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:18175 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318217AbSGPVKO>; Tue, 16 Jul 2002 17:10:14 -0400
Date: Tue, 16 Jul 2002 23:13:00 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Daiki Ueno <ueno@unixuser.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] orinoco_pci.c build fix
In-Reply-To: <44a4b565-6a1b-420d-9729-378868991c76@deisui.org>
Message-ID: <Pine.NEB.4.44.0207162025010.16056-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Daiki Ueno wrote:

> Hi,

Hi,

> While I've tried to get drivers/net/wireless/orinoco_pci.c compiled in,
> I happened to get an error:
>
> >drivers/net/wireless/wireless_net.o(.data+0x534): undefined reference to `local symbols in discarded section .text.exit'
>
> Is there a missing __devexit_p?  Here is the patch to 2.4.19-rc1.
>
> --- drivers/net/wireless/orinoco_pci.c~	Wed Jul 17 02:37:33 2002
> +++ drivers/net/wireless/orinoco_pci.c	Wed Jul 17 02:38:22 2002
> @@ -364,9 +364,11 @@
>  	name:"orinoco_pci",
>  	id_table:orinoco_pci_pci_id_table,
>  	probe:orinoco_pci_init_one,
> -	remove:orinoco_pci_remove_one,
> +	remove:__devexit_p(orinoco_pci_remove_one),
> +#ifdef CONFIG_PM
>  	suspend:0,
>  	resume:0
> +#endif /* CONFIG_PM */
>  };
>
>  static int __init orinoco_pci_init(void)


a similar __devexit_p-patch is already in in Marcelo's BK repository (and
it will therefore be in -rc2). Why do you think the #ifdef CONFIG_PM is
needed?


> Regards,

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



