Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbUCJQ32 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 11:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbUCJQ32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 11:29:28 -0500
Received: from [217.157.19.70] ([217.157.19.70]:2827 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S262700AbUCJQ3Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 11:29:25 -0500
Date: Wed, 10 Mar 2004 16:29:23 +0000 (GMT)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: andre@linux-ide.org, <arjanv@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.x Linux Medley RAID Version 7
In-Reply-To: <200403101707.38595.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.40.0403101625210.1120-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Bartlomiej Zolnierkiewicz wrote:

> Ideally I would like you to split your driver on a set of patches against
> sil_raid.c but it will be sufficient if you clean this patch a bit.
> [ Please read Documentation/CodingStyle. ]
> [...]
> Patch for inclusion should have this cleaned up.

I'll clean it and resubmit.

> +	/* If this drive is not on a PCI controller, it is not Medley RAID.
> +	 * Medley matches the PCI device ID with the metadata to check if it is valid. */
> +	pcidev = drvinfo->hwif?drvinfo->hwif->pci_dev:NULL;
> +	if (!pcidev)
> +	{
> +		return NULL;
> +	}
>
> IMHO this is redundant/bogus -> I can get drives with Medley RAID off CMD/SiI
> controller and plug them into legacy ISA controller and still be happy
> (hey, it is a Linux way of doing things).
[...]
>
> +		/* A valid Medley RAID has the PCI vendor/device ID of its IDE controller,
> +		 * and the correct checksum. */
> +		md = (void *)(bh->b_data);
> +
> +		if (pcidev->vendor == md->vendor_id && pcidev->device == md->product_id)
>
> The similar thing here - ie. I would like to replug drives to on-board Intel.
> When Linux is driving RAID purely in software it shouldn't matter what
> controller we are using.

I see your point, but it's the Medley standard and the "official"  way
they detect the array. If I can't compare with the PCI vendor and device
ID, I have no reliable way (other than heuristics) to see if it is a valid
Medley superblock..  There are many different variants of Medley out
there, and they each use their own vendor/device ID as the superblock
magic word.

So I would prefer to keep these.

Thanks,
Thomas

