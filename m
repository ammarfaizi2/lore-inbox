Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270763AbTGPM5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 08:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270776AbTGPM5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 08:57:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18121
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270763AbTGPM5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 08:57:42 -0400
Subject: Re: Trying to get DMA working with IDE alim15x3 controller
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Art Haas <ahaas@airmail.net>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030715233202.GB17444@artsapartment.org>
References: <Pine.SOL.4.30.0307160050340.27735-100000@mion.elka.pw.edu.pl>
	 <Pine.SOL.4.30.0307160109140.27735-100000@mion.elka.pw.edu.pl>
	 <20030715233202.GB17444@artsapartment.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058360981.6633.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jul 2003 14:09:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-16 at 00:32, Art Haas wrote:
> I'd received mail from another person stating that the ALi DMA is broken
> from many old chips, but that it is only the UDMA stuff that is broken,

The older chips dont do UDMA. Then a lot of the next range of chips do
UDMA but not 48bit command so you can end up in PIO mode. Possibly our
logic for this needs tightening now we use lba28 commands whenever 
possible, so an LBA48 capable disk under LBA48 limit size is drivable
entirely in LBA28 safely.

> and the MW_DMA stuff works. Also the notes about the 2.6 transition
> indicate ali15x3 and DMA don't always play nicely together. Still,
> if the MW_DMA stuff works, some hdparm trickery like ...

Simplex DMA needs some fixing for one. That should only bite you if you
have a set up something like

hda -> unused
hdb -> unused
hdc -> DISK
hdd -> unused

in which case we assign the DMA engine to hda/hdb!

