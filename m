Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030428AbWJKO1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030428AbWJKO1a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 10:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWJKO1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 10:27:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60133 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030408AbWJKO13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 10:27:29 -0400
Subject: Re: [2.6 patch] drivers/scsi/dpt_i2o.c: remove dead code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org
In-Reply-To: <20061008231627.GO6755@stusta.de>
References: <20061008231627.GO6755@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 11 Oct 2006 15:51:40 +0100
Message-Id: <1160578300.16513.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-10-09 am 01:16 +0200, ysgrifennodd Adrian Bunk:
> The Coverity checker spotted this dead code introduced by
> commit a07f353701acae77e023f6270e8af353b37af7c4.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Semi-NAK

Its not dead jim, its in the wrong location

>  	while ((pDev = pci_get_device( PCI_DPT_VENDOR_ID, PCI_ANY_ID, pDev))) {
>  		if(pDev->device == PCI_DPT_DEVICE_ID ||
>  		   pDev->device == PCI_DPT_RAPTOR_DEVICE_ID){
>  			if(adpt_install_hba(sht, pDev) ){
>  				PERROR("Could not Init an I2O RAID device\n");
>  				PERROR("Will not try to detect others.\n");

------------------------> pci_dev_put()

is needed there instead I think.


Been away so just catching up

