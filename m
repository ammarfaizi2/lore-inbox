Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264831AbTFWXsP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 19:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbTFWXq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 19:46:58 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:3256 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264906AbTFWXpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 19:45:52 -0400
Date: Mon, 23 Jun 2003 16:59:42 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI fixes for 2.5.73
Message-ID: <20030623235942.GF12207@kroah.com>
References: <20030623235852.GA12207@kroah.com> <20030623235910.GB12207@kroah.com> <20030623235919.GC12207@kroah.com> <20030623235925.GD12207@kroah.com> <20030623235932.GE12207@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030623235932.GE12207@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1348.14.5, 2003/06/23 15:19:07-07:00, bunk@fs.tum.de

[PATCH] PCI Hotplug: fix buggy comparison in cpqphp_pci.c

I don't understand the code good enough to be sure my patch is correct,
but the current code is definitely buggy:

0xFF is the maximum value for an u8, so tdevice < 0x100 is _always_
true.


 drivers/pci/hotplug/cpqphp_pci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
--- a/drivers/pci/hotplug/cpqphp_pci.c	Mon Jun 23 16:53:48 2003
+++ b/drivers/pci/hotplug/cpqphp_pci.c	Mon Jun 23 16:53:48 2003
@@ -198,7 +198,7 @@
 
 	ctrl->pci_bus->number = bus_num;
 
-	for (tdevice = 0; tdevice < 0x100; tdevice++) {
+	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
 		//Scan for access first
 		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
 			continue;
@@ -210,7 +210,7 @@
 			return 0;
 		}
 	}
-	for (tdevice = 0; tdevice < 0x100; tdevice++) {
+	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
 		//Scan for access first
 		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
 			continue;
