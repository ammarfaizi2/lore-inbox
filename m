Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVLHOc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVLHOc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbVLHOc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:32:27 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:15533 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932087AbVLHOcZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:32:25 -0500
Subject: Re: [ACPI] Re: RFC: ACPI/scsi/libata integration and hotswap
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Christoph Hellwig <hch@infradead.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
In-Reply-To: <43983FC6.6050108@pobox.com>
References: <20051208030242.GA19923@srcf.ucam.org>
	 <20051208091542.GA9538@infradead.org>
	 <20051208132657.GA21529@srcf.ucam.org>
	 <20051208133308.GA13267@infradead.org>
	 <20051208133945.GA21633@srcf.ucam.org>
	 <20051208135225.GA13122@havoc.gtf.org>
	 <1134050863.17102.5.camel@localhost.localdomain>
	 <43983FC6.6050108@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Dec 2005 14:30:57 +0000
Message-Id: <1134052257.17102.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-08 at 09:14 -0500, Jeff Garzik wrote:
> These are only for PATA.  We don't care about _GTM/_STM on SATA.

Even your piix driver supports PATA. Put the foaming (justified ;))
hatred for ACPI aside for a moment and take a look at the real world as
it unfortunately is right now.

> Further, SATA completely resets and re-initializes the device as if from 
> a hardware reset (except on ata_piix, which doesn't support COMRESET, 
> and PATA).  This makes _GTF uninteresting, as well.

You don't know what the sequences the resume method is concerned about
actually are.

> suspend/resume works just fine with Jens' out-of-tree patch.

Only on some systems.

> > If you don't run the resume methods your disk subsystem status after a
> > resume is simply undefined and unsafe.
> 
> I initialize the hardware to a defined state.

Sure, but sometimes the *wrong* defined state. The BIOS ACPI methods
include things like unlocking drive passwords on restore with some
systems. You don't handle that at all.

Having said that I still think ACPI awareness doesn't belong in libata
or scsi because we'd then have awareness of every pm scheme in the wrong
layer and a dozen pm systems all with scsi hooks. Gak...

SCSI/libata can go easily from ata channel to pci device to device. The
rest of the logic belongs outside of scsi/libata.

Alan

