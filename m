Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbTJAPNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTJAPNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:13:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6294 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262406AbTJAPNm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:13:42 -0400
Message-ID: <3F7AEF15.1070301@pobox.com>
Date: Wed, 01 Oct 2003 11:13:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Marold <andrew.marold@wlm.edial.com>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: Serial ATA support in 2.4.22
References: <C67EF1F46A97534FADC870220F3AC8B79D4FDD@exchange.edial.office>
In-Reply-To: <C67EF1F46A97534FADC870220F3AC8B79D4FDD@exchange.edial.office>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Marold wrote:
> I just got some new Dell Precision 360's, 2 of which have SATA drives
> that I'm trying to install RH9 on. I built a new kernel from the 2.4.22
> sources, patched with the 2.4.22-ac4 patches. When I boot, linux
> recognizes the drives, but hangs doing a partition check. Here's what I
> see on the console:
> 
> ata1: SATA max UDMA/133 cmd 0xFE00 ctl 0xFE12 bmdma 0xFEA0 irq 17
> ata2: SATA max UDMA/133 cmd 0xFE20 ctl 0xFE32 bmdma 0xFEA8 irq 17
> ata1: dev 0 ATA, max UDMA/133, 234375000 sectors (lba48)
> ata1: dev 0 configured for UDMA/133
> ata2: port disabled, ignoring.
> scsi0: ata_piix
> scsi1: ata_piix
>   Vendor: ATA	Model: ST3120026AS	Rev: 0.71
>   Type:   Direct-Access			ANSI SCSI revision: 05
> Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
> SCSI device sda: 234375000 512-byte sectors (120000 MB)
> Partition check:
> sda:<3>ata1: DMA timeout, stat 0x24
> 
> Has this been seen before, or are these boxes just too far out on the
> bleeding edge and I'm going to have to wait a while ?


Something appears to be malfunctioning in your system, if you're getting 
DMA timeouts.

The first thing to do is try the latest versions of libata.  libata in 
-ac and -pac trees is ancient at this point, and I desperately need to 
send Alan and Bero updates.

Here is the latest Serial ATA driver ("libata"), at its FTP site:
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/

Patches are against BK snapshots of the 2.4 tree, so you may need to 
manually patch drivers/scsi/Makefile and drivers/scsi/Config.in...

Let me know if you have more trouble after updating the driver.

	Jeff


P.S.  This driver is also shipped in Fedora Core beta 2 (a.k.a. what 
would have been Red Hat Linux 10), so libata/ata_piix kernel srpm and 
rpms are available at
ftp://mirrors.kernel.org/redhat/redhat/linux/beta/severn/en/os/i386/

