Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbTHJOdj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269559AbTHJOdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:33:39 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:55803 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268702AbTHJOdh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:33:37 -0400
Date: Sun, 10 Aug 2003 16:33:00 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE (& PowerMac): Let an hwif have a real parent
In-Reply-To: <1060524726.595.13.camel@gaston>
Message-ID: <Pine.SOL.4.30.0308101630280.1330-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Aug 2003, Benjamin Herrenschmidt wrote:

> Hi Linus & Bart !
>
> This patch allows an IDE hwif to be set a "parent" field so it
> can really descend from any struct device, typically the macio_device
> I use on pmac, and not only a PCI device or the legacy stuff.
>
> This should work fine as long as hwif->gendev.parent doesn't
> contain junk, but so far, it seems it really only contains
> NULL unless specifically set by the host driver.
>
> Without that, the pmac driver will not appear in it's proper
> location in the device tree, which is a real problem for power
> management as it won't be ordered properly with it's hosting
> asic (and mediabay if any), thus breaking suspend/resume.

Looks good.

> Please apply,
> Ben.

Can you fix intendation, or I should do it?

> --- a/drivers/ide/ide-probe.c	Sun Aug 10 16:07:40 2003
> +++ b/drivers/ide/ide-probe.c	Sun Aug 10 16:07:40 2003
> @@ -650,10 +650,12 @@
>  	strlcpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
>  	snprintf(hwif->gendev.name,DEVICE_NAME_SIZE,"IDE Controller");
>  	hwif->gendev.driver_data = hwif;
> +	if (hwif->gendev.parent == NULL) {
>  	if (hwif->pci_dev)
>  		hwif->gendev.parent = &hwif->pci_dev->dev;
>  	else
>  		hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
> +	}
>  	device_register(&hwif->gendev);
>  }

--bartlomiej

