Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424860AbWKQBT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424860AbWKQBT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424862AbWKQBT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:19:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55048 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424860AbWKQBT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:19:28 -0500
Date: Fri, 17 Nov 2006 02:19:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] drivers/pci/hotplug/ibmphp_pci.c: fix NULL dereference
Message-ID: <20061117011925.GO31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The correct order is: NULL check before dereference

Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/drivers/pci/hotplug/ibmphp_pci.c.old	2006-11-16 22:44:42.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/pci/hotplug/ibmphp_pci.c	2006-11-16 22:43:44.000000000 +0100
@@ -1371,12 +1371,12 @@ static int unconfigure_boot_bridge (u8 b
 	}
 
 	bus = ibmphp_find_res_bus (sec_number);
-	debug ("bus->busno is %x\n", bus->busno);
-	debug ("sec_number is %x\n", sec_number);
 	if (!bus) {
 		err ("cannot find Bus structure for the bridged device\n");
 		return -EINVAL;
 	}
+	debug("bus->busno is %x\n", bus->busno);
+	debug("sec_number is %x\n", sec_number);
 
 	ibmphp_remove_bus (bus, busno);
 
