Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbTBFEHO>; Wed, 5 Feb 2003 23:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbTBFEFl>; Wed, 5 Feb 2003 23:05:41 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:52752 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265385AbTBFEC6>;
	Wed, 5 Feb 2003 23:02:58 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <10445044882693@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <1044504489271@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.9, 2003/02/05 17:20:29+11:00, rddunlap@osdl.org

[PATCH] PCI Hotplug: checker patches

Fixes problems found by the CHECKER program in the pci hotplug drivers


diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Thu Feb  6 14:51:47 2003
+++ b/drivers/hotplug/cpqphp_pci.c	Thu Feb  6 14:51:47 2003
@@ -1193,7 +1193,7 @@
 				if (temp != func->config_space[cloop >> 2]) {
 					dbg("Config space compare failure!!! offset = %x\n", cloop);
 					dbg("bus = %x, device = %x, function = %x\n", func->bus, func->device, func->function);
-					dbg("temp = %x, config space = %x\n\n", temp, func->config_space[cloop]);
+					dbg("temp = %x, config space = %x\n\n", temp, func->config_space[cloop >> 2]);
 					return 1;
 				}
 			}
diff -Nru a/drivers/hotplug/ibmphp_pci.c b/drivers/hotplug/ibmphp_pci.c
--- a/drivers/hotplug/ibmphp_pci.c	Thu Feb  6 14:51:47 2003
+++ b/drivers/hotplug/ibmphp_pci.c	Thu Feb  6 14:51:47 2003
@@ -1621,23 +1621,23 @@
 			}
 
 			for (i = 0; i < count; i++) {
-				if (cur_func->io[count]) {
-					debug ("io[%d] exists \n", count);
+				if (cur_func->io[i]) {
+					debug ("io[%d] exists \n", i);
 					if (the_end > 0)
-						ibmphp_remove_resource (cur_func->io[count]);
-					cur_func->io[count] = NULL;
+						ibmphp_remove_resource (cur_func->io[i]);
+					cur_func->io[i] = NULL;
 				}
-				if (cur_func->mem[count]) {
-					debug ("mem[%d] exists \n", count);
+				if (cur_func->mem[i]) {
+					debug ("mem[%d] exists \n", i);
 					if (the_end > 0)
-						ibmphp_remove_resource (cur_func->mem[count]);
-					cur_func->mem[count] = NULL;
+						ibmphp_remove_resource (cur_func->mem[i]);
+					cur_func->mem[i] = NULL;
 				}
-				if (cur_func->pfmem[count]) {
-					debug ("pfmem[%d] exists \n", count);
+				if (cur_func->pfmem[i]) {
+					debug ("pfmem[%d] exists \n", i);
 					if (the_end > 0)
-						ibmphp_remove_resource (cur_func->pfmem[count]);
-					cur_func->pfmem[count] = NULL;
+						ibmphp_remove_resource (cur_func->pfmem[i]);
+					cur_func->pfmem[i] = NULL;
 				}
 			}
 

