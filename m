Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTJ0Jpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbTJ0Jpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:45:39 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:57804 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261464AbTJ0Jph
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:45:37 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Michel Bouissou <michel@bouissou.net>
Subject: Re: Patch for Promise PDC20276
Date: Mon, 27 Oct 2003 10:49:32 +0100
User-Agent: KMail/1.5.4
References: <200310271009.13054@totor.bouissou.net>
In-Reply-To: <200310271009.13054@totor.bouissou.net>
Cc: abrutschy@xylon.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310271049.32819.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This was discussed few times before.
Just enable "Special FastTrak feature" (overriding BIOS) config option.

On Monday 27 of October 2003 10:09, Michel Bouissou wrote:
> Hi there,
>
> The patch that Arne Brutschy posted here (see
> http://www.cs.helsinki.fi/linux/linux-kernel/2003-22/0386.html) almost
> saved my life as it allowed me to understand why my 2.4.22 kernel didn't
> activate my Promise PDC20276 IDE controller properly.
>
> (For the record, my kernel was displaying the following message at boot:
> PDC20276: neither IDE port enabled (BIOS)
> )
>
> But this patch was only halfway satisfactory, as it enabled only one of my
> 2 controller channels.
>
> So I did a quick-and-dirty hack that gives the following patch, that allows
> activation of both channels of my PDC20276.
>
> This might help others encountering the same problem...
>
> ========== CUT HERE ==========
> --- drivers/ide/setup-pci.c.orig	2003-08-25 13:44:41.000000000 +0200
> +++ drivers/ide/setup-pci.c	2003-10-26 20:35:49.000000000 +0100
> @@ -577,7 +577,7 @@
>  	ata_index_t index;
>  	u8 tmp = 0;
>  	ide_hwif_t *hwif, *mate = NULL;
> -	static int secondpdc = 0;
> +/* MiB	static int secondpdc = 0; */
>
>  	index.all = 0xf0f0;
>
> @@ -637,10 +637,10 @@
>  		 * by the bios for raid purposes.
>  		 * Skip the normal "is it enabled" test for those.
>  		 */
> -		if (((d->vendor == PCI_VENDOR_ID_PROMISE) &&
> +		if ((d->vendor == PCI_VENDOR_ID_PROMISE) &&
>  		     ((d->device == PCI_DEVICE_ID_PROMISE_20262) ||
> -		      (d->device == PCI_DEVICE_ID_PROMISE_20265))) &&
> -		    (secondpdc++==1) && (port==1))
> +		      (d->device == PCI_DEVICE_ID_PROMISE_20265) ||
> +		      (d->device == PCI_DEVICE_ID_PROMISE_20276)))
>  			goto controller_ok;
>
>  		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
> ========== CUT HERE ==========
>
> Regards

