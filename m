Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbSLBHT5>; Mon, 2 Dec 2002 02:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSLBHT3>; Mon, 2 Dec 2002 02:19:29 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:46086 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265513AbSLBHSi>;
	Mon, 2 Dec 2002 02:18:38 -0500
Date: Mon, 2 Dec 2002 00:26:29 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.50
Message-ID: <20021202082629.GE12121@kroah.com>
References: <20021202082443.GA12121@kroah.com> <20021202082525.GB12121@kroah.com> <20021202082543.GC12121@kroah.com> <20021202082608.GD12121@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021202082608.GD12121@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.924.3.3, 2002/11/30 01:28:13-08:00, greg@kroah.com

PCI: changed pci_?et_drvdata to use the generic driver model functions
     instead of accessing the data directly.


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Sun Dec  1 23:26:20 2002
+++ b/include/linux/pci.h	Sun Dec  1 23:26:20 2002
@@ -747,17 +747,17 @@
 	  pci_resource_start((dev),(bar)) + 1))
 
 /* Similar to the helpers above, these manipulate per-pci_dev
- * driver-specific data.  Currently stored as pci_dev::driver_data,
- * a void pointer, but it is not present on older kernels.
+ * driver-specific data.  They are really just a wrapper around
+ * the generic device structure functions of these calls.
  */
 static inline void *pci_get_drvdata (struct pci_dev *pdev)
 {
-	return pdev->dev.driver_data;
+	return dev_get_drvdata(&pdev->dev);
 }
 
 static inline void pci_set_drvdata (struct pci_dev *pdev, void *data)
 {
-	pdev->dev.driver_data = data;
+	dev_set_drvdata(&pdev->dev, data);
 }
 
 /*
