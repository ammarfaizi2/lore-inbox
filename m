Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSGXU2t>; Wed, 24 Jul 2002 16:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317531AbSGXU2t>; Wed, 24 Jul 2002 16:28:49 -0400
Received: from rcpt-expgw.biglobe.ne.jp ([202.225.89.143]:48581 "EHLO
	rcpt-expgw.biglobe.ne.jp") by vger.kernel.org with ESMTP
	id <S317521AbSGXU2s>; Wed, 24 Jul 2002 16:28:48 -0400
X-Biglobe-Sender: <t-kouchi@mvf.biglobe.ne.jp>
Date: Wed, 24 Jul 2002 13:32:54 -0700
From: "KOCHI, Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] aic7xxx driver doesn't release region
Cc: pcihpd-discuss@lists.sourceforge.net
Message-Id: <20020724132119.2803.T-KOUCHI@mvf.biglobe.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a patch to fix releasing memory and io regions for the
aic7xxx driver.  This applies both 2.4- and 2.5-series.
Without this, you will fail to hot-remove the device.

This patch is tested on an IA32 server with ACPI PCI hotplug,
and reported to work.

--- aic7xxx_linux_pci.c.orig	Tue Nov 13 09:19:41 2001
+++ aic7xxx_linux_pci.c	Wed Jul 17 18:03:51 2002
@@ -98,6 +98,10 @@
 			break;
 		}
 	}
+#ifdef MMAPIO
+	release_mem_region(pci_resource_start(pdev, 1), 0x1000);
+#endif
+	release_region(pci_resource_start(pdev, 0), 256);
 }
 #endif /* !LINUX_VERSION_CODE < KERNEL_VERSION(2,4,0) */
 


Thanks,
-- 
KOCHI, Takayoshi <t-kouchi@cq.jp.nec.com/t-kouchi@mvf.biglobe.ne.jp>

