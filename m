Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVK2UBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVK2UBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVK2UBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:01:13 -0500
Received: from smtpout.mac.com ([17.250.248.45]:38865 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932370AbVK2UBM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:01:12 -0500
X-PGP-Universal: processed;
	by AlPB on Tue, 29 Nov 2005 14:01:11 -0600
Date: Tue, 29 Nov 2005 14:01:02 -0600
From: Mark Rustad <MRustad@mac.com>
Subject: [PATCH 2.6.15-rc3] pci: restore 2 missing pci ids
To: linux-kernel@vger.kernel.org
X-Priority: 3
Message-ID: <r02010500-1043-DE5DF2F5611211DAB2B70011248907EC@[10.64.61.10]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Mailer: Mailsmith 2.1.5 (Blindsider)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhere between 2.6.14 and 2.6.15-rc3, some PCI ids were apparently removed.
The ecc.c module, which is not a part of the kernel.org tree, but included in
some distributions, fails to compile.

<soapbox>
I don't understand why valid PCI ids were removed. It seems to me that other
projects underway -such as EDAC - are just going to have to add these and
probably more of them back when they are merged. It seems really shortsighted
and foolish to remove valid PCI id information even if the current kernel
source happens to not reference it. The information has intrinsic value and
avoids having different names being associated with the same ids over time
by avoiding removing and adding PCI ids.
</soapbox>

I have included a patch below that fixes my immediate problem, but I think
I would prefer reverting the patch that removed them in the first place. Yes,
I know there is a whitespace error in this patch, but that is what is in the
file in -rc3 and I didn't want to turn this into a whitespace-correction patch.


Restore 2 PCI ids needed for ECC monitoring.

Signed-off-by: Mark Rustad <mrustad@mac.com>
---

--- linux-2.6.15-rc3/include/linux/pci_ids.h
+++ new/include/linux/pci_ids.h
@@ -2015,6 +2015,7 @@
 #define PCI_DEVICE_ID_INTEL_82801EB_5  0x24d5
 #define PCI_DEVICE_ID_INTEL_82801EB_6  0x24d6
 #define PCI_DEVICE_ID_INTEL_82801EB_11 0x24db
+#define PCI_DEVICE_ID_INTEL_82801EB_13 0x24dd
 #define PCI_DEVICE_ID_INTEL_ESB_1      0x25a1
 #define PCI_DEVICE_ID_INTEL_ESB_2      0x25a2
 #define PCI_DEVICE_ID_INTEL_ESB_4      0x25a4
@@ -2097,6 +2097,7 @@
 #define PCI_DEVICE_ID_INTEL_82443GX_2  0x71a2
 #define PCI_DEVICE_ID_INTEL_82372FB_1  0x7601
 #define PCI_DEVICE_ID_INTEL_82454GX    0x84c4
+#define PCI_DEVICE_ID_INTEL_82450GX    0x84c5
 #define PCI_DEVICE_ID_INTEL_82451NX    0x84ca
 #define PCI_DEVICE_ID_INTEL_82454NX     0x84cb
 #define PCI_DEVICE_ID_INTEL_84460GX    0x84ea
-- 
Mark Rustad, mrustad@mac.com
