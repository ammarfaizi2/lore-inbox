Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312420AbSDOLvo>; Mon, 15 Apr 2002 07:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312427AbSDOLvn>; Mon, 15 Apr 2002 07:51:43 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6151 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312420AbSDOLvn>;
	Mon, 15 Apr 2002 07:51:43 -0400
Date: Mon, 15 Apr 2002 13:51:31 +0200
From: Jens Axboe <axboe@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "Ivan G." <ivangurdiev@yahoo.com>, Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 compile bugs
Message-ID: <20020415115131.GN12608@suse.de>
In-Reply-To: <20020415070728.GB12608@suse.de> <Pine.LNX.4.21.0204151334350.26237-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15 2002, Roman Zippel wrote:
> > This should fix it.
> > 
> > --- drivers/ide/ide.c~	2002-04-15 09:05:58.000000000 +0200
> > +++ drivers/ide/ide.c	2002-04-15 09:06:52.000000000 +0200
> > @@ -2701,7 +2701,11 @@
> >  
> >  void ide_teardown_commandlist(ide_drive_t *drive)
> >  {
> > +#ifdef CONFIG_BLK_DEV_IDEPCI
> >  	struct pci_dev *pdev= drive->channel->pci_dev;
> > +#else
> > +	struct pci_dev *pdev = NULL;
> > +#endif
> >  	struct list_head *entry;
> >  
> >  	list_for_each(entry, &drive->free_req) {
> > @@ -2716,7 +2720,11 @@
> >  
> >  int ide_build_commandlist(ide_drive_t *drive)
> >  {
> > +#ifdef CONFIG_BLK_DEV_IDEPCI
> >  	struct pci_dev *pdev= drive->channel->pci_dev;
> > +#else
> > +	struct pci_dev *pdev = NULL;
> > +#endif
> >  	struct ata_request *ar;
> >  	ide_tag_info_t *tcq;
> >  	int i, err;
> 
> That's not enough, some archs don't define pci_alloc_consistent/
> pci_free_consistent, because they have neither PCI nor ISA.

Please, then those archs need to provide similar functionality. This is
the established api, unless you want to change the documentation and xxx
number of drivers?

-- 
Jens Axboe

