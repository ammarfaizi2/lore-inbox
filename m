Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263109AbVCDWRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbVCDWRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 17:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbVCDWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 17:14:13 -0500
Received: from mail.kroah.org ([69.55.234.183]:45729 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263136AbVCDUyU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:20 -0500
Cc: eike-hotplug@sf-tec.de
Subject: [PATCH] PCI Hotplug: Remove unneeded instructions from ibmphp_pci.c
In-Reply-To: <1109969635941@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:56 -0800
Message-Id: <11099696361222@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.8, 2005/02/07 14:37:42-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI Hotplug: Remove unneeded instructions from ibmphp_pci.c

this patch removes some unneeded code from ibmphp_pci.c. First I thought it
is a bug and the second line should have been "sec_no = (int) sec_number".
But than I found exactly the same read only 9 lines higher and after it the
line I expected the second one to be. Between the 2 pci_bus_read_config_byte's
are only some checks so I don't expect them to return different results. And
sec_no is and int so removing this wont change anything at all.


Signed-off-by: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/ibmphp_pci.c |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
--- a/drivers/pci/hotplug/ibmphp_pci.c	2005-03-04 12:43:20 -08:00
+++ b/drivers/pci/hotplug/ibmphp_pci.c	2005-03-04 12:43:20 -08:00
@@ -1384,9 +1384,6 @@
 		return -EINVAL;
 	}
 
-	pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_SECONDARY_BUS, &sec_number);
-	sec_no = (int) sec_no;
-
 	pci_bus_read_config_byte (ibmphp_pci_bus, devfn, PCI_SUBORDINATE_BUS, &sub_number);
 	sub_no = (int) sub_number;
 	debug ("sub_no is %d, sec_no is %d\n", sub_no, sec_no);

