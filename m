Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWIYWUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWIYWUX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWIYWUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:20:23 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35049 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751532AbWIYWUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:20:21 -0400
Subject: [PATCH] pcmcia: switch to ref counting/hotplug safe API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-pcmcia@lists.infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 23:44:05 +0100
Message-Id: <1159224245.11049.165.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/pcmcia/cardbus.c linux-2.6.18-mm1/drivers/pcmcia/cardbus.c
--- linux.vanilla-2.6.18-mm1/drivers/pcmcia/cardbus.c	2006-09-25 12:08:50.000000000 +0100
+++ linux-2.6.18-mm1/drivers/pcmcia/cardbus.c	2006-09-25 12:23:54.000000000 +0100
@@ -138,7 +138,7 @@
 
 	cs_dbg(s, 3, "read_cb_mem(%d, %#x, %u)\n", space, addr, len);
 
-	dev = pci_find_slot(s->cb_dev->subordinate->number, 0);
+	dev = pci_get_slot(s->cb_dev->subordinate, 0);
 	if (!dev)
 		goto fail;
 
@@ -152,6 +152,9 @@
 	}
 
 	res = dev->resource + space - 1;
+	
+	pci_dev_put(dev);
+	
 	if (!res->flags)
 		goto fail;
 

