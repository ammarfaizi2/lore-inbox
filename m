Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTFBT3a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 15:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbTFBT3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 15:29:30 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:44244 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261895AbTFBT32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 15:29:28 -0400
Date: Mon, 2 Jun 2003 21:41:59 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Arne Brutschy <abrutschy@xylon.de>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ide driver 2.4.21-rc6
In-Reply-To: <515243431.20030602205153@xylon.de>
Message-ID: <Pine.SOL.4.30.0306022139380.21554-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What about turning on "Special FastTrak Feature" instead...
--
Bartlomiej

On Mon, 2 Jun 2003, Arne Brutschy wrote:

> Using the Promise 20276 IDE controller without raid function
> doesn't work with 2.4.21*.
>
> If you want to use the IDE controller just as plain controller without
> Promise software raid (i.e. if you prefer to trust the linux software
> raid), the kernel always reports this:
>
> PDC20276: IDE controller at PCI slot 02:02.0
> PDC20276: chipset revision 1
> PDC20276: not 100% native mode: will probe irqs later
> PDC20276: neither IDE port enabled (BIOS)
>
> Afterwards, the kernel disables the controller. This has been reported
> by serveral other users. This small patch solves the problem.
>
> Arne
>
>
> --- linux-2.4.21-rc6/drivers/ide/setup-pci.c.orig       2003-06-01 11:38:23.000000000 +0200
> +++ linux-2.4.21-rc6/drivers/ide/setup-pci.c    2003-06-01 11:40:12.000000000 +0200
> @@ -640,7 +640,8 @@
>                  */
>                 if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
>                      ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
> -                     (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
> +                     (d->device == PCI_DEVICE_ID_PROMISE_20265) ||
> +                     (d->device == PCI_DEVICE_ID_PROMISE_20276))) &&
>                     (secondpdc++==1) && (port==1))
>                         goto controller_ok;

