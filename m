Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262274AbSJGBWG>; Sun, 6 Oct 2002 21:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262283AbSJGBWG>; Sun, 6 Oct 2002 21:22:06 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:53392 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S262274AbSJGBWF>; Sun, 6 Oct 2002 21:22:05 -0400
Subject: Re: [PATCH] Bluetooth kbuild fix and config cleanup
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Maksim Krasnyanskiy <maxk@qualcomm.com>
In-Reply-To: <Pine.LNX.4.44.0210061646080.21788-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210061646080.21788-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 07 Oct 2002 03:26:46 +0200
Message-Id: <1033954016.909.10.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff -Nru a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> > --- a/drivers/bluetooth/Makefile	Sun Oct  6 19:19:06 2002
> > +++ b/drivers/bluetooth/Makefile	Sun Oct  6 19:19:06 2002
> > @@ -9,9 +9,14 @@
> >  obj-$(CONFIG_BLUEZ_HCIBT3C)	+= bt3c_cs.o
> >  obj-$(CONFIG_BLUEZ_HCIBLUECARD)	+= bluecard_cs.o
> >  
> > -hci_uart-y				:= hci_ldisc.o
> > -hci_uart-$(CONFIG_BLUEZ_HCIUART_H4)	+= hci_h4.o
> > -hci_uart-$(CONFIG_BLUEZ_HCIUART_BCSP)	+= hci_bcsp.o
> > -hci_uart-objs				:= $(hci_uart-y)
> > +hci_uart-objs := hci_ldisc.o
> > +
> > +ifeq ($(CONFIG_BLUEZ_HCIUART_H4),y)
> > +  hci_uart-objs += hci_h4.o
> > +endif
> > +
> > +ifeq ($(CONFIG_BLUEZ_HCIUART_BCSP),y)
> > +  hci_uart-objs += hci_bcsp.o
> > +endif
> >  
> >  include $(TOPDIR)/Rules.make
> 
> Hmm.. This seems to be reverting a perfectly good clean Makefile without 
> any conditionals to the old-stype setup. Please don't do that.

I will change this and submit you a new patch. Should I do this also for
only one conditional like in net/bluetooth/rfcomm/Makefile? So it will
look like this:

###
obj-$(CONFIG_BLUEZ_RFCOMM) += rfcomm.o

rfcomm-y                                := core.o sock.o crc.o
rfcomm-$(CONFIG_BLUEZ_RFCOMM_TTY)       += tty.o
rfcomm-objs                             := $(rfcomm-y)

include $(TOPDIR)/Rules.make
###

Regards

Marcel


