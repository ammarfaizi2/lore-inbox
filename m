Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbTAHBsv>; Tue, 7 Jan 2003 20:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267646AbTAHBsv>; Tue, 7 Jan 2003 20:48:51 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:18441 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267640AbTAHBsu>;
	Tue, 7 Jan 2003 20:48:50 -0500
Date: Tue, 7 Jan 2003 17:57:14 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI hotplug changes for 2.5.54
Message-ID: <20030108015714.GC30924@kroah.com>
References: <20030108015500.GA30924@kroah.com> <20030108015551.GB30924@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108015551.GB30924@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.895, 2003/01/07 16:29:23-08:00, greg@kroah.com

PCI: properly unregister a PCI device if it is removed.

This is only used by pci hotplug and cardbus systems.


diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	Tue Jan  7 16:44:43 2003
+++ b/drivers/pci/hotplug.c	Tue Jan  7 16:44:43 2003
@@ -105,7 +105,7 @@
 void
 pci_remove_device(struct pci_dev *dev)
 {
-	put_device(&dev->dev);
+	device_unregister(&dev->dev);
 	list_del(&dev->bus_list);
 	list_del(&dev->global_list);
 	pci_free_resources(dev);
