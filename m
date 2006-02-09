Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbWBIP3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbWBIP3c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 10:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWBIP3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 10:29:32 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11737 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932524AbWBIP3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 10:29:32 -0500
Subject: Re: libATA  PATA status report, new patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.SOC.4.61.0602082024010.21660@math.ut.ee>
References: <20060207084347.54CD01430C@rhn.tartu-labor>
	 <1139310335.18391.2.camel@localhost.localdomain>
	 <Pine.SOC.4.61.0602071305310.10491@math.ut.ee>
	 <1139312330.18391.14.camel@localhost.localdomain>
	 <1139324653.18391.41.camel@localhost.localdomain>
	 <Pine.SOC.4.61.0602082024010.21660@math.ut.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 09 Feb 2006 15:31:42 +0000
Message-Id: <1139499102.1255.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-02-08 at 20:28 +0200, Meelis Roos wrote:
> A new kind of crash on ALi chipset laptop (Toshiba Satellite 1800), 
> lspci below. I could not use netconsole on this laptop since yenta is 
> initialized after netconsole and so my cardbus NIC is not usable for 
> netconsole. I captured the details using a digital camera, in 2 
> different vga resolutions (to see different parts of it):
> 
> http://www.cs.ut.ee/~mroos/alicrash1.png
> http://www.cs.ut.ee/~mroos/alicrash2.png


Thanks: Utterly dumb bug made while converting to the newer refcounting
PCI API

--- drivers/scsi/pata_ali.c~	2006-02-09 15:17:06.430326208 +0000
+++ drivers/scsi/pata_ali.c	2006-02-09 15:17:06.431326056 +0000
@@ -528,7 +528,7 @@
 		pci_write_config_byte(pdev, 0x4B, tmp | 0x08);
 	}
 		
-	north = pci_get_slot(0, PCI_DEVFN(0,0));
+	north = pci_get_slot(pdev->bus, PCI_DEVFN(0,0));
 	isa_bridge = pci_get_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, NULL);
 	
 	if(north && north->vendor == PCI_VENDOR_ID_AL) {

