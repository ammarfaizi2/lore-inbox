Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbUKLXZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbUKLXZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUKLXZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:25:23 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:42893 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262693AbUKLXWq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:46 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017191459@kroah.com>
Date: Fri, 12 Nov 2004 15:21:59 -0800
Message-Id: <11003017191176@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.12, 2004/11/12 14:07:54-08:00, hannal@us.ibm.com

[PATCH] sis-agp.c: replace pci_find_device with pci_get_device

As pci_find_device is going away soon I have converted this file to use
pci_get_device instead. for_each_pci_dev is a macro wrapper around
pci_get_device.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/agp/sis-agp.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/char/agp/sis-agp.c b/drivers/char/agp/sis-agp.c
--- a/drivers/char/agp/sis-agp.c	2004-11-12 15:10:34 -08:00
+++ b/drivers/char/agp/sis-agp.c	2004-11-12 15:10:34 -08:00
@@ -86,7 +86,7 @@
 	command |= AGPSTAT_AGP_ENABLE;
 	rate = (command & 0x7) << 2;
 
-	while ((device = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, device)) != NULL) {
+	for_each_pci_dev(device) {
 		u8 agp = pci_find_capability(device, PCI_CAP_ID_AGP);
 		if (!agp)
 			continue;

