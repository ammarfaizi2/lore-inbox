Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286867AbRLWLch>; Sun, 23 Dec 2001 06:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286868AbRLWLcR>; Sun, 23 Dec 2001 06:32:17 -0500
Received: from ns.suse.de ([213.95.15.193]:30984 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286867AbRLWLcL>;
	Sun, 23 Dec 2001 06:32:11 -0500
Date: Sun, 23 Dec 2001 12:31:55 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
Cc: Vasil Kolev <lnxkrnl@mail.ludost.net>, Keith Owens <kaos@ocs.com.au>,
        Norbert Veber <nveber@pyre.virge.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [2.4.17] net/network.o(.text.lock+0x1a88): undefined reference
 to `local symbols...
In-Reply-To: <Pine.LNX.4.33.0112231206090.4356-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.33.0112231229190.15032-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Tobias Ringstrom wrote:

> On Sun, 23 Dec 2001, Vasil Kolev wrote:
> > # ./reference_discarded.pl
> > Finding objects, 538 objects, ignoring 0 module(s)
> > Finding conglomerates, ignoring 48 conglomerate(s)
> > Scanning objects
> > Error: ./drivers/net/dmfe.o .data refers to 00000514 R_386_32
> > .text.exit
> > Done
>
> Does this patch fix the problem?
>
> /Tobias
>
> --- dmfe.c.orig	Fri Nov 23 13:14:17 2001
> +++ dmfe.c	Sun Dec 23 12:09:25 2001
> @@ -527,7 +527,7 @@
>  }
>
> -static void __exit dmfe_remove_one (struct pci_dev *pdev)
> +static void __devexit dmfe_remove_one (struct pci_dev *pdev)
>  {
>  	struct net_device *dev = pci_get_drvdata(pdev);
>  	struct dmfe_board_info *db = dev->priv;
> @@ -2059,7 +2059,7 @@
>  	name:		"dmfe",
>  	id_table:	dmfe_pci_tbl,
>  	probe:		dmfe_init_one,
> -	remove:		dmfe_remove_one,
> +	remove:		__devexit_p(dmfe_remove_one),

Note, that this patch was dropped between rc2 & final,
(on Jeff's request iirc).

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

