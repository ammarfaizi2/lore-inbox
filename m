Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265423AbTFSEhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 00:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265426AbTFSEhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 00:37:41 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:23967 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265423AbTFSEhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 00:37:40 -0400
Date: Wed, 18 Jun 2003 21:52:33 -0700
From: Andrew Morton <akpm@digeo.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] ehci_hcd.c linkage fix
Message-Id: <20030618215233.6698960c.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jun 2003 04:51:38.0542 (UTC) FILETIME=[77EC9CE0:01C3361E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



With CONFIG_HOTPLUG=n we get, at link time:

drivers/usb/host/ehci-hcd.c:977: pci_ids causes a section type conflict

The fix is to remove the const, but I'm darned if I can remember why.  Can
anyone remind me?



--- 25/drivers/usb/host/ehci-hcd.c~ehci_hcd-linkage-fix	2003-06-18 21:48:15.000000000 -0700
+++ 25-akpm/drivers/usb/host/ehci-hcd.c	2003-06-18 21:50:06.000000000 -0700
@@ -974,7 +974,7 @@ static const struct hc_driver ehci_drive
 /* EHCI spec says PCI is required. */
 
 /* PCI driver selection metadata; PCI hotplugging uses this */
-static const struct pci_device_id __devinitdata pci_ids [] = { {
+static struct pci_device_id __devinitdata pci_ids [] = { {
 
 	/* handle any USB 2.0 EHCI controller */
 

_

