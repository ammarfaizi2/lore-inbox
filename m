Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbUKMB0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbUKMB0C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 20:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbUKLXnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:43:12 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58262 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262712AbUKLXWy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:54 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017184012@kroah.com>
Date: Fri, 12 Nov 2004 15:21:58 -0800
Message-Id: <1100301718611@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.7, 2004/11/12 14:03:20-08:00, hannal@us.ibm.com

[PATCH] matroxfb_base.c: convert pci_find_device to pci_get_device

As pci_find_device is going away I've replaced it with pci_get_device.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/video/matrox/matroxfb_base.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)


diff -Nru a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
--- a/drivers/video/matrox/matroxfb_base.c	2004-11-12 15:11:12 -08:00
+++ b/drivers/video/matrox/matroxfb_base.c	2004-11-12 15:11:12 -08:00
@@ -1580,6 +1580,11 @@
 	unsigned int memsize;
 	int err;
 
+	static struct pci_device_id intel_82437[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437) },
+		{ },
+	};
+
 	DBG(__FUNCTION__)
 
 	/* set default values... */
@@ -1684,7 +1689,7 @@
 		mga_option |= MX_OPTION_BSWAP;
                 /* disable palette snooping */
                 cmd &= ~PCI_COMMAND_VGA_PALETTE;
-		if (pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82437, NULL)) {
+		if (pci_dev_present(intel_82437)) {
 			if (!(mga_option & 0x20000000) && !ACCESS_FBINFO(devflags.nopciretry)) {
 				printk(KERN_WARNING "matroxfb: Disabling PCI retries due to i82437 present\n");
 			}

