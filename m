Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265784AbUFXWhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUFXWhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 18:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUFXWen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 18:34:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:37814 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265784AbUFXVrZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 17:47:25 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <10881135673488@kroah.com>
Date: Thu, 24 Jun 2004 14:46:07 -0700
Message-Id: <1088113567782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.103.3, 2004/06/11 17:15:00-07:00, bjorn.helgaas@hp.com

[PATCH] PCI: clarify pci.txt wrt IRQ allocation

I think we should make it explicit that PCI IRQs shouldn't be relied
upon until after pci_enable_device().  This patch:

    ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6.7-rc3-mm1/broken-out/bk-acpi.patch

does PCI interrupt routing (based on ACPI _PRT) and IRQ allocation
at pci_enable_device()-time.

(To avoid breaking things in 2.6, the above patch still allocates
all PCI IRQs in pci_acpi_init(), before any drivers are initialized.
But that shouldn't be needed by correct drivers, and I'd like to
remove it in 2.7.)


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/pci.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)


diff -Nru a/Documentation/pci.txt b/Documentation/pci.txt
--- a/Documentation/pci.txt	2004-06-24 13:51:35 -07:00
+++ b/Documentation/pci.txt	2004-06-24 13:51:35 -07:00
@@ -166,8 +166,9 @@
 ~~~~~~~~~~~~~~~~~~~
    Before you do anything with the device you've found, you need to enable
 it by calling pci_enable_device() which enables I/O and memory regions of
-the device, assigns missing resources if needed and wakes up the device
-if it was in suspended state. Please note that this function can fail.
+the device, allocates an IRQ if necessary, assigns missing resources if
+needed and wakes up the device if it was in suspended state. Please note
+that this function can fail.
 
    If you want to use the device in bus mastering mode, call pci_set_master()
 which enables the bus master bit in PCI_COMMAND register and also fixes

