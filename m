Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTFBJoQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 05:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTFBJoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 05:44:16 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:26376
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262093AbTFBJoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 05:44:14 -0400
Date: Mon, 2 Jun 2003 02:46:51 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
In-Reply-To: <20030526045833.GA27204@gtf.org>
Message-ID: <Pine.LNX.4.10.10306020238050.23914-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


JG,

This is the right move after months of debating ideas.
Migrating the contents of ./drivers/ide/pci to scsi is reasonable too.
This will allow the legacy drivers to die.

Taskfile came to late to be really useful, it is now best used as a model
to tackle FIS/FPDMA mapping for SATA II.

Linus, my professional opinion is to follow Jeff's direction for 2.5/2.6.
This will allow Linux to push open source to the hardware vendors.
There are several bastardized scsi-ide drivers in ./scsi.

pci2000.c,h :: pci2220i.c,h :: psi240i.c,h + psi_*.h :: eata*

ATAPI is nothing more than Bastardized SCSI beaten with an ugly stick.

Packet-Taskfile is more than painful, and I am not in the fighting mood.

Cheers,

Andre

On Mon, 26 May 2003, Jeff Garzik wrote:

> Just to echo some comments I said in private, this driver is _not_
> a replacement for drivers/ide.  This is not, and has never been,
> the intention.  In fact, I need drivers/ide's continued existence,
> so that I may have fewer boundaries on future development.
> 
> Even though ATAPI support doesn't exist and error handling is
> primitive, this driver has been extensively tested locally and I feel
> is ready for a full and public kernel developer assault :)
> 
> James ok'd sending this...  I'll be sending "un-hack scsi headers" patch
> through him via his scsi-misc-2.5 tree.
> 
> 
> 
> 
> Linus, please do a
> 
> 	bk pull bk://kernel.bkbits.net/jgarzik/scsi-2.5
> 
> Others may download the patch from
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.5/2.5.69-bk18-scsi1.patch.bz2
> 
> This will update the following files:
> 
>  drivers/scsi/Kconfig    |   27 
>  drivers/scsi/Makefile   |    1 
>  drivers/scsi/ata_piix.c |  322 ++++++
>  drivers/scsi/libata.c   | 2247 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ata.h     |  485 ++++++++++
>  5 files changed, 3082 insertions(+)
> 
> through these ChangeSets:
> 
> <jgarzik@redhat.com> (03/05/26 1.1357)
>    [scsi ata] make PATA config option actually do something useful
> 
> <jgarzik@redhat.com> (03/05/26 1.1356)
>    [scsi ata] include hacks, b/c scsi headers not in include/linux
> 
> <jgarzik@redhat.com> (03/05/26 1.1355)
>    [scsi] add ATA driver
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

