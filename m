Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbVBBCqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbVBBCqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 21:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVBBCq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 21:46:29 -0500
Received: from [211.58.254.17] ([211.58.254.17]:27017 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262218AbVBBCpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:45:39 -0500
Date: Wed, 2 Feb 2005 11:45:38 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 03/29] ide: cleanup opti621
Message-ID: <20050202024538.GD621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 03_ide_cleanup_opti621.patch
> 
> 	In drivers/ide/pci/opti612.[hc], init_setup_opt621() is
> 	declared, defined and referenced but never actullay used.
> 	Thie patch removes the function.


Signed-off-by: Tejun Heo <tj@home-tj.org>                                       

Index: linux-ide-export/drivers/ide/pci/opti621.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/opti621.c	2005-02-02 10:27:16.326131292 +0900
+++ linux-ide-export/drivers/ide/pci/opti621.c	2005-02-02 10:28:01.947729558 +0900
@@ -348,11 +348,6 @@ static void __init init_hwif_opti621 (id
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
-static int __init init_setup_opti621 (struct pci_dev *dev, ide_pci_device_t *d)
-{
-	return ide_setup_pci_device(dev, d);
-}
-
 static int __devinit opti621_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	return ide_setup_pci_device(dev, &opti621_chipsets[id->driver_data]);
Index: linux-ide-export/drivers/ide/pci/opti621.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/opti621.h	2005-02-02 10:27:16.327131130 +0900
+++ linux-ide-export/drivers/ide/pci/opti621.h	2005-02-02 10:28:01.948729395 +0900
@@ -5,13 +5,11 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-static int init_setup_opti621(struct pci_dev *, ide_pci_device_t *);
 static void init_hwif_opti621(ide_hwif_t *);
 
 static ide_pci_device_t opti621_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "OPTI621",
-		.init_setup	= init_setup_opti621,
 		.init_hwif	= init_hwif_opti621,
 		.channels	= 2,
 		.autodma	= AUTODMA,
@@ -19,7 +17,6 @@ static ide_pci_device_t opti621_chipsets
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
 		.name		= "OPTI621X",
-		.init_setup	= init_setup_opti621,
 		.init_hwif	= init_hwif_opti621,
 		.channels	= 2,
 		.autodma	= AUTODMA,
