Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbTBFEHM>; Wed, 5 Feb 2003 23:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265400AbTBFEGH>; Wed, 5 Feb 2003 23:06:07 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:55568 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265402AbTBFEC7>;
	Wed, 5 Feb 2003 23:02:59 -0500
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.59
In-reply-to: <10445044901818@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Wed, 5 Feb 2003 20:08 -0800
Message-id: <10445044903733@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.947.23.11, 2003/02/06 10:04:49+11:00, greg@kroah.com

[PATCH] PCI:  put proper field sizes on sysfs files, and add class file.


diff -Nru a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
--- a/drivers/pci/pci-sysfs.c	Thu Feb  6 14:51:27 2003
+++ b/drivers/pci/pci-sysfs.c	Thu Feb  6 14:51:27 2003
@@ -35,10 +35,11 @@
 }									\
 static DEVICE_ATTR(field, S_IRUGO, show_##field, NULL);
 
-pci_config_attr(vendor, "%x\n");
-pci_config_attr(device, "%x\n");
-pci_config_attr(subsystem_vendor, "%x\n");
-pci_config_attr(subsystem_device, "%x\n");
+pci_config_attr(vendor, "%04x\n");
+pci_config_attr(device, "%04x\n");
+pci_config_attr(subsystem_vendor, "%04x\n");
+pci_config_attr(subsystem_device, "%04x\n");
+pci_config_attr(class, "%06x\n");
 pci_config_attr(irq, "%u\n");
 
 /* show resources */
@@ -69,6 +70,7 @@
 	device_create_file (dev, &dev_attr_device);
 	device_create_file (dev, &dev_attr_subsystem_vendor);
 	device_create_file (dev, &dev_attr_subsystem_device);
+	device_create_file (dev, &dev_attr_class);
 	device_create_file (dev, &dev_attr_irq);
 	device_create_file (dev, &dev_attr_resource);
 }

