Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVBCAEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVBCAEz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVBCACd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 19:02:33 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:37973 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262743AbVBCAAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 19:00:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Lpw5Gifis+SlBMDlIBTHDrpOETIlhmhxVXg3Cb/4oTVXkMtomY5pEqUIQi4VvdHGS8/KyoIqUNXc/bF6B7bxMLjERZUQpluiC8D1Jh5jKV+WadgHfHLm4N5NyBaR2qqxU5gM4Afp8j5Fx2PKHDnZ310i9KG+3l837PNHr7LUmXs=
Message-ID: <58cb370e0502021600506696ba@mail.gmail.com>
Date: Thu, 3 Feb 2005 01:00:15 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <tj@home-tj.org>
Subject: Re: [PATCH 2.6.11-rc2 02/29] ide: cleanup it8172
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20050202024454.GC621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050202024017.GA621@htj.dyndns.org>
	 <20050202024454.GC621@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005 11:44:54 +0900, Tejun Heo <tj@home-tj.org> wrote:
> > 02_ide_cleanup_it8172.patch
> >
> >       In drivers/ide/pci/it8172.h, it8172_ratefilter() and
> >       init_setup_it8172() are declared and the latter is referenced
> >       in it8172_chipsets.  Both functions are not defined or used
> >       anywhere.  This patch removes the prototypes and reference.
> >       it8172 should be compilable now.
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

applied, also this trivial patch is needed to fix it8172 build:

diff -Nru a/drivers/ide/pci/it8172.c b/drivers/ide/pci/it8172.c
--- a/drivers/ide/pci/it8172.c	2005-02-03 01:00:22 +01:00
+++ b/drivers/ide/pci/it8172.c	2005-02-03 01:00:22 +01:00
@@ -56,7 +56,7 @@
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	int is_slave		= (hwif->drives[1] == drive);
+	int is_slave		= (&hwif->drives[1] == drive);
 	unsigned long flags;
 	u16 drive_enables;
 	u32 drive_timing;
@@ -94,7 +94,7 @@
 	}
 
 	pci_write_config_word(dev, 0x40, drive_enables);
-	spin_unlock_irqrestore(&ide_lock, flags)
+	spin_unlock_irqrestore(&ide_lock, flags);
 }
 
 static u8 it8172_dma_2_pio (u8 xfer_rate)
