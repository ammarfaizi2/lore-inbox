Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268537AbTGTUqT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 16:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268564AbTGTUqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 16:46:19 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:51471
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S268537AbTGTUp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 16:45:57 -0400
Date: Sun, 20 Jul 2003 13:53:39 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: =?utf-8?q?J=C3=BCrgen=20Stohr?= <juergen.stohr@gmx.de>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: BUG in pdc202xx_old.c
In-Reply-To: <200307202206.21872.juergen.stohr@gmx.de>
Message-ID: <Pine.LNX.4.10.10307201352010.29430-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Juergen:

I have formally given up on Promise.
If it works somebody take it and stuff it into a kernel tree it is a DGD
for me now.

DGD == Don't Giva Damn

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sun, 20 Jul 2003, [utf-8] Jürgen Stohr wrote:

> Hi Andre,
> in pdc202xx_old.c is a bug that prevents the use of "66 Clocking". The driver 
> always falls back to UDMA 33. The reason for this bug is found in function 
> "config_chipset_for_dma" when checking if the "other" drive is capable of 
> UDMA 66. The follwing patch, which should apply against 2.4.22-pre7, solves 
> the problem for me:
> 
> --- pdc202xx_old.c.broken       2003-07-20 20:12:39.000000000 +0200
> +++ pdc202xx_old.c      2003-07-20 20:18:50.000000000 +0200
> @@ -425,7 +425,7 @@
>                          * check to make sure drive on same channel
>                          * is u66 capable
>                          */
> -                       if (hwif->drives[!(drive->dn%2)].id) {
> +                       if (hwif->drives[!(drive->dn%2)].present) {
>                                 if (hwif->drives[!(drive->dn%2)].id->dma_ultra 
> & 0x0078) {
>                                         hwif->OUTB(CLKSPD | mask, 
> (hwif->dma_master + 0x11));
>                                 } else {
> 
> regards,
> Jürgen
> 

