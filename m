Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265670AbTGDB4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbTGDBzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:55:11 -0400
Received: from granite.he.net ([216.218.226.66]:23822 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265639AbTGDByu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:50 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845523317@kroah.com>
Subject: Re: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <10572845523547@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:12 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1363, 2003/07/03 15:50:39-07:00, willy@debian.org

[PATCH] PCI: Improve documentation
Fix some grammar problems
Add a note about Fast Back to Back support
Change the slot_name recommendation to pci_name().


 Documentation/pci.txt |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)


diff -Nru a/Documentation/pci.txt b/Documentation/pci.txt
--- a/Documentation/pci.txt	Thu Jul  3 18:17:12 2003
+++ b/Documentation/pci.txt	Thu Jul  3 18:17:12 2003
@@ -7,14 +7,14 @@
 Different PCI devices have different requirements and different bugs --
 because of this, the PCI support layer in Linux kernel is not as trivial
 as one would wish. This short pamphlet tries to help all potential driver
-authors to find their way through the deep forests of PCI handling.
+authors find their way through the deep forests of PCI handling.
 
 
 0. Structure of PCI drivers
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 There exist two kinds of PCI drivers: new-style ones (which leave most of
 probing for devices to the PCI layer and support online insertion and removal
-of devices [thus supporting PCI, hot-pluggable PCI and CardBus in single
+of devices [thus supporting PCI, hot-pluggable PCI and CardBus in a single
 driver]) and old-style ones which just do all the probing themselves. Unless
 you have a very good reason to do so, please don't use the old way of probing
 in any new code. After the driver finds the devices it wishes to operate
@@ -174,7 +174,7 @@
 the latency timer value if it's set to something bogus by the BIOS.
 
    If you want to use the PCI Memory-Write-Invalidate transaction,
-call pci_set_mwi().  This enables bit PCI_COMMAND bit for Mem-Wr-Inval
+call pci_set_mwi().  This enables the PCI_COMMAND bit for Mem-Wr-Inval
 and also ensures that the cache line size register is set correctly.
 Make sure to check the return value of pci_set_mwi(), not all architectures
 may support Memory-Write-Invalidate.
@@ -236,7 +236,7 @@
 7. Miscellaneous hints
 ~~~~~~~~~~~~~~~~~~~~~~
 When displaying PCI slot names to the user (for example when a driver wants
-to tell the user what card has it found), please use pci_dev->slot_name
+to tell the user what card has it found), please use pci_name(pci_dev)
 for this purpose.
 
 Always refer to the PCI devices by a pointer to the pci_dev structure.
@@ -247,6 +247,10 @@
 
 If you're going to use PCI bus mastering DMA, take a look at
 Documentation/DMA-mapping.txt.
+
+Don't try to turn on Fast Back to Back writes in your driver.  All devices
+on the bus need to be capable of doing it, so this is something which needs
+to be handled by platform and generic code, not individual drivers.
 
 
 8. Obsolete functions

