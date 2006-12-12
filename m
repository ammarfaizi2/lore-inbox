Return-Path: <linux-kernel-owner+w=401wt.eu-S932583AbWLMAMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbWLMAMO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 19:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWLMAMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 19:12:14 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54700 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932583AbWLMAMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 19:12:13 -0500
X-Greylist: delayed 2304 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 19:12:12 EST
Date: Tue, 12 Dec 2006 23:41:45 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Message-ID: <20061212234145.557cb035@localhost.localdomain>
In-Reply-To: <200612130148.34539.sshtylyov@ru.mvista.com>
References: <200612130148.34539.sshtylyov@ru.mvista.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + * We work around this by initiating dummy, zero-length DMA transfer on
> + * a DMA timeout expiration. I found no better way to do this with the current

Novel workaround and probably better than resetting the chip as the
winbong does.

> +static int tc86c001_busproc(ide_drive_t *drive, int state)
> +{

Waste of space having a busproc routine. The maintainer removed all the
usable hotplug support from old IDE so this might as well be dropped.

> @@ -1407,6 +1407,24 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260a, quirk_intel_pcie_pm);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
>  
> +/*
> + * Toshiba TC86C001 IDE controller reports the standard 8-byte BAR0 size
> + * but PIO transfer won't work if BAR0 falls at the odd 8 bytes.
> + * Re-allocate the region if needed.
> + */

NAK. I think this fixup should be testing if the device port 0 is in
native mode before doing the fixup. In comaptibility mode bar 0 is
ignored and the correct compatibility values set up in the resource tree
by the PCI layer as of 2.6.18-mm-mumble. They are also of course on a xx0
boundary.

"Close but no cookie": please fix the PCI quirk to match the current -mm
behaviour with the ATA resource tree. Otherwise - nice driver.

Alan
