Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312395AbSDOLrR>; Mon, 15 Apr 2002 07:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312412AbSDOLrQ>; Mon, 15 Apr 2002 07:47:16 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:3077 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S312395AbSDOLrP>; Mon, 15 Apr 2002 07:47:15 -0400
Date: Mon, 15 Apr 2002 13:47:05 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Jens Axboe <axboe@suse.de>
cc: "Ivan G." <ivangurdiev@yahoo.com>, Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 compile bugs
In-Reply-To: <20020415070728.GB12608@suse.de>
Message-ID: <Pine.LNX.4.21.0204151334350.26237-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 15 Apr 2002, Jens Axboe wrote:

> This should fix it.
> 
> --- drivers/ide/ide.c~	2002-04-15 09:05:58.000000000 +0200
> +++ drivers/ide/ide.c	2002-04-15 09:06:52.000000000 +0200
> @@ -2701,7 +2701,11 @@
>  
>  void ide_teardown_commandlist(ide_drive_t *drive)
>  {
> +#ifdef CONFIG_BLK_DEV_IDEPCI
>  	struct pci_dev *pdev= drive->channel->pci_dev;
> +#else
> +	struct pci_dev *pdev = NULL;
> +#endif
>  	struct list_head *entry;
>  
>  	list_for_each(entry, &drive->free_req) {
> @@ -2716,7 +2720,11 @@
>  
>  int ide_build_commandlist(ide_drive_t *drive)
>  {
> +#ifdef CONFIG_BLK_DEV_IDEPCI
>  	struct pci_dev *pdev= drive->channel->pci_dev;
> +#else
> +	struct pci_dev *pdev = NULL;
> +#endif
>  	struct ata_request *ar;
>  	ide_tag_info_t *tcq;
>  	int i, err;

That's not enough, some archs don't define pci_alloc_consistent/
pci_free_consistent, because they have neither PCI nor ISA.

bye, Roman

