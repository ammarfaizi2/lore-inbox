Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757776AbWKXO0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757776AbWKXO0W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 09:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934622AbWKXO0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 09:26:22 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27605 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1757776AbWKXO0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 09:26:21 -0500
Date: Fri, 24 Nov 2006 14:30:40 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Martin A. Fink" <fink@mpe.mpg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SATA Performance with Intel ICH6
Message-ID: <20061124143040.679016d5@localhost.localdomain>
In-Reply-To: <200611241510.11526.fink@mpe.mpg.de>
References: <200611241407.01210.fink@mpe.mpg.de>
	<20061124133331.6bf0d7cc@localhost.localdomain>
	<200611241510.11526.fink@mpe.mpg.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006 15:10:11 +0100
"Martin A. Fink" <fink@mpe.mpg.de> wrote:

> Well this seems to be independend from the file system. I tried to write 
> directly to the raw device, but nevertheless the cpu time was 20% (sys time).

sys time is not neccessarily CPU time.
 
> This is an interessting point. The specification say that I can handle around 
> 120 to 150 MB/s each of the 4 S-ATA ports. With ICH6 the S-ATA ports seem to 

At once ?

> be directly connected to the Southbridge, and the Southbridge is directly 
> connected to Northbridge via PCI Express. So it should be possible to get 150 
> MB/s from north to south and from there in packages of 55 MB/s to the 
> disks ?!

Ask the vendor.
 
> <6>scsi1 : ata_piix
> <5>  Vendor: ATA       Model: WDC WD740GD-75FL  Rev: 21.0
> <5>  Type:   Direct-Access                      ANSI SCSI revision: 05

The PIIX interface needs CPU intervention each command, so in practice
about every 64K or so, and the CPU gets stalled waiting for the disk
during the setup of each I/O. The newer kernels support AHCI which does
not have this overhead, but it is only present on the newest intel
controllers.

> and strace dd... gives among other information
> 6.84s 1004calls syscall: write
> 
> So I spend 45s of 52s within the kernel. Why so long?

Waiting for the disk I would imagine.

Alan

