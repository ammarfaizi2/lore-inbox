Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTFKTBv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 15:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTFKTBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 15:01:51 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:59274 "EHLO
	rwcrmhc13.attbi.com") by vger.kernel.org with ESMTP id S263631AbTFKTBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 15:01:51 -0400
Message-ID: <3EE77FD6.9020502@attbi.com>
Date: Wed, 11 Jun 2003 12:15:34 -0700
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Looks like your PCI patch broke the PPC build (and others)?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://marc.theaimsgroup.com/?l=linux-kernel&m=105527406918793&w=2

   CC      drivers/pci/probe.o
drivers/pci/probe.c: In function `pci_scan_device':
drivers/pci/probe.c:532: dereferencing pointer to incomplete type
make[3]: *** [drivers/pci/probe.o] Error 1

--------------

diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Tue Jun 10 11:16:11 2003
+++ b/drivers/pci/probe.c	Tue Jun 10 11:16:11 2003
@@ -529,7 +529,8 @@
  	pci_name_device(dev);

  	/* now put in global tree */
-	strcpy(dev->dev.bus_id,dev->slot_name);
+	sprintf(dev->dev.bus_id, "%04x:%s", pci_domain_nr(bus),
+			dev->slot_name);
  	dev->dev.dma_mask = &dev->dma_mask;

  	return dev;

