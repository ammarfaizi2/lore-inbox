Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287002AbSA2X2p>; Tue, 29 Jan 2002 18:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286723AbSA2X1a>; Tue, 29 Jan 2002 18:27:30 -0500
Received: from codepoet.org ([166.70.14.212]:32163 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S286647AbSA2X01>;
	Tue, 29 Jan 2002 18:26:27 -0500
Date: Tue, 29 Jan 2002 16:26:29 -0700
From: Erik Andersen <andersen@codepoet.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Adaptec 1480b SlimSCSI vs hotplug
Message-ID: <20020129232629.GB937@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently came into posession of an Adaptec 1480 cardbus SCSI
adaptor.  Using kernel 2.4.18-pre7 this adaptor does not work
properly with hotplug.  I find that the following change allows
the hotplug driver to properly load the aic7xxx driver when a
hotplug "add" event occurs.  Removing the card, and then
re-inserting it fails to properly reinitialize the device (unless
the aic7xxx module has been manually unloaded in between), but
this happens with or without this patch.  At least with this
patch, the device will load in the first place.  Does this look
agreeable?

--- linux-2.4.18-pre7.orig/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	Tue Jan 29 05:20:08 2002
+++ linux/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	Tue Jan 29 05:20:08 2002
@@ -62,12 +62,12 @@
 /* We do our own ID filtering.  So, grab all SCSI storage class devices. */
 static struct pci_device_id ahc_linux_pci_id_table[] = {
 	{
-		0x9004, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_STORAGE_SCSI << 8, 0xFFFF00, 0
+		PCI_VENDOR_ID_ADAPTEC, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+		((PCI_CLASS_STORAGE_SCSI << 8) | 0x00), ~0, 0
 	},
 	{
-		0x9005, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-		PCI_CLASS_STORAGE_SCSI << 8, 0xFFFF00, 0
+		PCI_VENDOR_ID_ADAPTEC2, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+		((PCI_CLASS_STORAGE_SCSI << 8) | 0x00), ~0, 0
 	},
 	{ 0 }
 };

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
