Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbWB0EzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWB0EzB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 23:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWB0EzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 23:55:01 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:10138 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750828AbWB0EzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 23:55:00 -0500
Message-ID: <440285AB.20903@jp.fujitsu.com>
Date: Mon, 27 Feb 2006 13:52:59 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
CC: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>,
       Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       benh@kernel.crashing.org
Subject: [PATCH 2/4] PCI legacy I/O port free driver (take 3) - Update Documentation/pci.txt
References: <44028502.4000108@soft.fujitsu.com>
In-Reply-To: <44028502.4000108@soft.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the description about legacy I/O port free driver into
Documentation/pci.txt.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 Documentation/pci.txt |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+)

Index: linux-2.6.16-rc4/Documentation/pci.txt
===================================================================
--- linux-2.6.16-rc4.orig/Documentation/pci.txt	2006-02-27 13:29:34.000000000 +0900
+++ linux-2.6.16-rc4/Documentation/pci.txt	2006-02-27 13:29:42.000000000 +0900
@@ -269,3 +269,31 @@
 pci_find_device()		Superseded by pci_get_device()
 pci_find_subsys()		Superseded by pci_get_subsys()
 pci_find_slot()			Superseded by pci_get_slot()
+
+
+9. Legacy I/O port free driver
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+On the large servers, I/O port resources could not be assigned to all
+PCI devices because it is limited (64KB on Intel Architecture[1]) and
+it would be fragmented (I/O base register of PCI-to-PCI bridge will
+usually be aligned to a 4KB boundary[2]). On such systems,
+pci_enable_device() and pci_request_regions() for those devices will
+fail because those functions try to enable all the regions. However,
+it is a problem for some PCI devices which provide both I/O port and
+MMIO interface because some of them can be handled without using I/O
+port interface. The reason why such devices provide I/O port interface
+is for compatibility to legacy OSs. So this kind of devices should
+work even if enough I/O port resources are not assigned. The "PCI
+Local Bus Specification Revision 3.0" also mentions about this topic
+(Please see p.44, "IMPLEMENTATION NOTE").
+
+This problem is solved by telling the kernel if your driver needs to
+use I/O port to handle the device. If your driver doesn't need any I/O
+port regions to handle the device, you can tell it to the kernel by
+setting the no_ioport flag in struct pci_dev. If the no_ioport flag is
+set, kernel will never touch I/O port regions for the corresponding
+devices. Please note that you need to set the no_ioport flag before
+calling pci_enable_device() and pci_request_regions().
+
+[1] Some systems support 64KB I/O port space per PCI segment.
+[2] Some PCI-to-PCI bridges support optional 1KB aligned I/O base.

