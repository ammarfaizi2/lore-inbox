Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWD1TbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWD1TbU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 15:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWD1TbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 15:31:20 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:1740 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751807AbWD1TbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 15:31:20 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200604281931.k3SJVBjR063404@fsgi900.americas.sgi.com>
Subject: [PATCH] 2.6 Altix : correct ioc3 port order
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Date: Fri, 28 Apr 2006 14:31:11 -0500 (CDT)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently loading the ioc3 as a module will cause the ports to be
numbered in reverse order. This mod maintains the proper order of cards
for port numbering.


Signed-off-by: Patrick Gefre <pfg@sgi.com>


Index: linux-2.6/drivers/sn/ioc3.c
===================================================================
--- linux-2.6.orig/drivers/sn/ioc3.c	2006-04-28 13:56:38.000000000 -0500
+++ linux-2.6/drivers/sn/ioc3.c	2006-04-28 14:20:37.919756143 -0500
@@ -678,7 +678,7 @@
 	/* Track PCI-device specific data */
 	pci_set_drvdata(pdev, idd);
 	down_write(&ioc3_devices_rwsem);
-	list_add(&idd->list, &ioc3_devices);
+	list_add_tail(&idd->list, &ioc3_devices);
 	idd->id = ioc3_counter++;
 	up_write(&ioc3_devices_rwsem);
 
