Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262875AbTIANAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 09:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262877AbTIANAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 09:00:45 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:16864 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S262875AbTIANAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 09:00:44 -0400
Subject: Re: request_firmware() backport to 2.4
From: Marcel Holtmann <marcel@holtmann.org>
To: Marcelo Tosatti <marcelo@parcelfarce.linux.theplanet.co.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0309010859250.2504-100000@logos.cnet>
References: <Pine.LNX.4.44.0309010859250.2504-100000@logos.cnet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2003 15:00:18 +0200
Message-Id: <1062421224.13730.111.camel@pegasus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

> > I have collected the patches for the request_firmware() interface
> > backport for 2.4 done by Manuel Estrada Sainz. It is now in -ac for a
> > while and I have used it in my -mh patches. It works fine and seems to
> > be clean and very stable. Karsten Keil has tested it together with my
> > ported bfusb.o Bluetooth driver on AMD64.
> > 
> > Please do a
> > 
> >         bk pull http://linux-mh.bkbits.net/fw-loader-2.4
> > 
> > This will update the following files:
> > 
> >  drivers/bluetooth/bfusb.h                             |52261 ------------------
> 
> Now bfusb loads "bfubase.frm", but stock kernel has no such thing. 
> 
> I assume that breaks bfusb?

no, the bfubase.frm is the original firmware file from AVM. This file
have to be placed somewhere on the filesystem. And if you call
request_firmware() this will call the firmware.agent hotplug script,
which loads it into the kernel through the /proc interface. This is the
big advantage of the request_firmware() architecture, because we don't
have to place the firmware as header file in the kernel source. The
firmware can be replaced with a newer version without recompiling the
kernel, because the only thing you have to do is to unplug and replug
the device. This also solves some legal problems with firmwares from
companies who are not so Linux friendly like AVM.

I have some short infos about the driver itself under

	http://www.holtmann.org/linux/bluetooth/bfusb.html

Another driver which makes use of request_firmware() interface at the
moment is the orinoco_usb.o wireless lan driver:

	http://orinoco-usb.alioth.debian.org

Regards

Marcel


