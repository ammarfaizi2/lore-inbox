Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbVHZAQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVHZAQd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 20:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVHZAQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 20:16:32 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8200 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965031AbVHZAQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 20:16:32 -0400
Date: Fri, 26 Aug 2005 02:16:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: libata-dev queue updated
Message-ID: <20050826001628.GF6471@stusta.de>
References: <BF571719A4041A478005EF3F08EA6DF001617B39@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BF571719A4041A478005EF3F08EA6DF001617B39@pcsmail03.pcs.pc.ome.toshiba.co.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2005 at 09:04:37AM +0900, Tomita, Haruo wrote:
> On  Thursday, August 25, 2005 8:02 PM (JST), Adrian Bunk wrote:
> 
> > > 2.6.13- rc7-libata1.patch.bz2 was used. 
> > > A combined mode of ata_piix seems not to work. 
> > > Is the following patches correct?
> > > 
> > > diff -urN linux-2.6.13-rc7.orig/drivers/scsi/Kconfig 
> > linux-2.6.13-rc7/drivers/scsi/Kconfig
> > > --- linux-2.6.13-rc7.orig/drivers/scsi/Kconfig	
> > 2005-08-25 13:44:33.000000000 +0900
> > > +++ linux-2.6.13-rc7/drivers/scsi/Kconfig	2005-08-25 
> > 14:33:38.000000000 +0900
> > > @@ -424,7 +424,7 @@
> > >  source "drivers/scsi/megaraid/Kconfig.megaraid"
> > >  
> > >  config SCSI_SATA
> > > -	tristate "Serial ATA (SATA) support"
> > > +	bool "Serial ATA (SATA) support"
> > >  	depends on SCSI
> > >  	help
> > >  	  This driver family supports Serial ATA host controllers
> > 
> > No, this bug reintroduces a problem with SCSI=m.
> 
> Please explain this bug in detail. 

Assuming your patch is applied:

With SCSI=m and SCSI_SATA=y this allows the static enabling of the SATA 
drivers with unwanted effects, e.g.:
- SCSI=m, SCSI_SATA=y, SCSI_ATA_ADMA=y
  -> SCSI_ATA_ADMA is built statically but scsi/built-in.o is not linked 
     into the kernel
- SCSI=m, SCSI_SATA=y, SCSI_ATA_ADMA=y, SCSI_SATA_AHCI=m
  -> SCSI_ATA_ADMA and libata are built statically but 
     scsi/built-in.o is not linked into the kernel,
     SCSI_SATA_AHCI is built modular (unresolved symbols due to missing 
                                      libata)

> > Which problem do you face?
> > And how did this change alone fix it for you?
> 
> I am using Intel 82801EB SATA controller.
> 2.6.13-rc7-libata1.patch.bz2 worked as PATA when 82801EB was used in a combined mode. 
> Does quirk_intel_ide_combined() work effectively?

I do still not see how your proposed patch would have _any_ influence on 
your problem.

> Thanks,
> Haruo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

