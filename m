Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262253AbSJFXje>; Sun, 6 Oct 2002 19:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262256AbSJFXjd>; Sun, 6 Oct 2002 19:39:33 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34057 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262253AbSJFXjd>; Sun, 6 Oct 2002 19:39:33 -0400
Date: Sun, 6 Oct 2002 16:47:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-kernel@vger.kernel.org, <maxk@qualcomm.com>
Subject: Re: [PATCH] Bluetooth kbuild fix and config cleanup
In-Reply-To: <E17yFj4-0006ll-00@pegasus>
Message-ID: <Pine.LNX.4.44.0210061646080.21788-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Oct 2002, Marcel Holtmann wrote:
> 
> diff -Nru a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> --- a/drivers/bluetooth/Makefile	Sun Oct  6 19:19:06 2002
> +++ b/drivers/bluetooth/Makefile	Sun Oct  6 19:19:06 2002
> @@ -9,9 +9,14 @@
>  obj-$(CONFIG_BLUEZ_HCIBT3C)	+= bt3c_cs.o
>  obj-$(CONFIG_BLUEZ_HCIBLUECARD)	+= bluecard_cs.o
>  
> -hci_uart-y				:= hci_ldisc.o
> -hci_uart-$(CONFIG_BLUEZ_HCIUART_H4)	+= hci_h4.o
> -hci_uart-$(CONFIG_BLUEZ_HCIUART_BCSP)	+= hci_bcsp.o
> -hci_uart-objs				:= $(hci_uart-y)
> +hci_uart-objs := hci_ldisc.o
> +
> +ifeq ($(CONFIG_BLUEZ_HCIUART_H4),y)
> +  hci_uart-objs += hci_h4.o
> +endif
> +
> +ifeq ($(CONFIG_BLUEZ_HCIUART_BCSP),y)
> +  hci_uart-objs += hci_bcsp.o
> +endif
>  
>  include $(TOPDIR)/Rules.make

Hmm.. This seems to be reverting a perfectly good clean Makefile without 
any conditionals to the old-stype setup. Please don't do that.

		Linus

