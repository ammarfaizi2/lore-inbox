Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbVGAUx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbVGAUx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVGAUvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:51:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:49633 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262398AbVGAUtg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:49:36 -0400
Cc: apw@shadowen.org
Subject: [PATCH] gregkh-pci-pci-assign-unassigned-resources fix
In-Reply-To: <11202509122229@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Jul 2005 13:48:32 -0700
Message-Id: <11202509122830@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] gregkh-pci-pci-assign-unassigned-resources fix

It seems that X86 architectures in general need the setup-bus.o
not just those with HOTPLUG.  This avoids the following error on
X86_NUMAQ and x86_64:

    arch/i386/pci/built-in.o(.init.text+0x15a6): In function `pcibios_init':
    : undefined reference to `pci_assign_unassigned_resources'

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 43a6b76050aa137c51d00eec91d67ac43ac3846e
tree f29f94e98a45c5102f1516afa45ac2ec46f2dd57
parent 5848f23d811acc1cb6c19a12e1341e0640a85d0e
author Andy Whitcroft <apw@shadowen.org> Mon, 20 Jun 2005 14:29:25 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 01 Jul 2005 13:35:52 -0700

 drivers/pci/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_HOTPLUG_PCI) += hotplug/
 #
 # Some architectures use the generic PCI setup functions
 #
+obj-$(CONFIG_X86) += setup-bus.o
 obj-$(CONFIG_ALPHA) += setup-bus.o setup-irq.o
 obj-$(CONFIG_ARM) += setup-bus.o setup-irq.o
 obj-$(CONFIG_PARISC) += setup-bus.o

