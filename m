Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbWBNGKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbWBNGKD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030478AbWBNGKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:10:03 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:48802 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030477AbWBNGKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:10:00 -0500
Message-ID: <43F173B7.3030905@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 15:07:51 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [RFC][PATCH 2/4] PCI legacy I/O port free driver - Update Documantion/pci.txt
References: <43F172BA.1020405@jp.fujitsu.com>
In-Reply-To: <43F172BA.1020405@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the description about pci_select_resource() into
Documenation/pci.txt.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 Documentation/pci.txt |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

Index: linux-2.6.16-rc3/Documentation/pci.txt
===================================================================
--- linux-2.6.16-rc3.orig/Documentation/pci.txt	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.16-rc3/Documentation/pci.txt	2006-02-14 12:28:03.000000000 +0900
@@ -169,6 +169,31 @@
 needed and wakes up the device if it was in suspended state. Please note
 that this function can fail.
 
+   If you want to enable only the specific type of regions of the device,
+you can tell it to the kernel by calling pci_set_bar_mask() or
+pci_set_bar_mask_by_resource() before calling pci_enable_device(). Once
+you tell it to the kernel, the following pci_enable_device() and
+pci_request_regions() call will handles only the regions you specified.
+The kernel will enables all regions of the device if you don't use
+pci_set_bar_mask*(). The pci_set_bar_mask*() would be needed to make some
+drivers legacy I/O port free. On the large servers, I/O port resource could
+not be assigned to all PCI devices because it is limited (64KB on Intel
+Architecture[1]) and it would be fragmented (I/O base register of
+PCI-to-PCI bridge will usually be aligned to a 4KB boundary[2]). In this
+case, pci_enable_device() for those devices will fail if you try to enable
+all the regions. However, it is a problem for some PCI devices that provide
+both I/O port and MMIO interface because some of them can be handled
+without using I/O port interface. The reason why such devices provide I/O
+port interface is for compatibility to legacy OSs. So this kind of devices
+should work even if enough I/O port resources are not assigned. The "PCI
+Local Bus Specification Revision 3.0" also mentions about this topic
+(Please see p.44, "IMPLEMENTATION NOTE"). You can solve this problem by
+using pci_set_bar_mask*(). Please note that the information specified
+through pci_set_bar_mask*() will be cleared at pci_disable_device() time.
+---
+[1] Some machines support 64KB I/O port space per PCI segment.
+[2] Some P2P bridges support optional 1KB aligned I/O base.
+
    If you want to use the device in bus mastering mode, call pci_set_master()
 which enables the bus master bit in PCI_COMMAND register and also fixes
 the latency timer value if it's set to something bogus by the BIOS.


