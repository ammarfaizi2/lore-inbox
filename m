Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286864AbRLWLMW>; Sun, 23 Dec 2001 06:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286865AbRLWLMM>; Sun, 23 Dec 2001 06:12:12 -0500
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:50436 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S286864AbRLWLL5>;
	Sun, 23 Dec 2001 06:11:57 -0500
Date: Sun, 23 Dec 2001 12:11:38 +0100 (CET)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Vasil Kolev <lnxkrnl@mail.ludost.net>
cc: Keith Owens <kaos@ocs.com.au>, Norbert Veber <nveber@pyre.virge.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17] net/network.o(.text.lock+0x1a88): undefined reference
 to `local symbols...
In-Reply-To: <Pine.LNX.4.33.0112231226260.1032-100000@doom.bastun.net>
Message-ID: <Pine.LNX.4.33.0112231206090.4356-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Vasil Kolev wrote:

> # ./reference_discarded.pl
> Finding objects, 538 objects, ignoring 0 module(s)
> Finding conglomerates, ignoring 48 conglomerate(s)
> Scanning objects
> Error: ./drivers/net/dmfe.o .data refers to 00000514 R_386_32
> .text.exit
> Done

Does this patch fix the problem?

/Tobias

--- dmfe.c.orig	Fri Nov 23 13:14:17 2001
+++ dmfe.c	Sun Dec 23 12:09:25 2001
@@ -527,7 +527,7 @@
 }
 
 
-static void __exit dmfe_remove_one (struct pci_dev *pdev)
+static void __devexit dmfe_remove_one (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata(pdev);
 	struct dmfe_board_info *db = dev->priv;
@@ -2059,7 +2059,7 @@
 	name:		"dmfe",
 	id_table:	dmfe_pci_tbl,
 	probe:		dmfe_init_one,
-	remove:		dmfe_remove_one,
+	remove:		__devexit_p(dmfe_remove_one),
 };
 
 MODULE_AUTHOR("Sten Wang, sten_wang@davicom.com.tw");


