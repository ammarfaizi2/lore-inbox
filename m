Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265253AbTFZAh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 20:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbTFZAfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 20:35:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:34027 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265247AbTFZAfF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 20:35:05 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10565884943135@kroah.com>
Subject: Re: [PATCH] More PCI fixes for 2.5.73
In-Reply-To: <10565884931018@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Jun 2003 17:48:14 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1429.2.4, 2003/06/25 17:03:44-07:00, willy@debian.org

[PATCH] PCI: more PCI gubbins

I noticed we have a couple of redundancies in drivers/pci/Makefile,
have a patch...


 drivers/pci/Makefile |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)


diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Wed Jun 25 17:38:09 2003
+++ b/drivers/pci/Makefile	Wed Jun 25 17:38:09 2003
@@ -8,7 +8,7 @@
 obj-$(CONFIG_PROC_FS) += proc.o
 
 ifndef CONFIG_SPARC64
-obj-$(CONFIG_PCI) += setup-res.o
+obj-y += setup-res.o
 endif
 
 obj-$(CONFIG_HOTPLUG) += hotplug.o
@@ -29,12 +29,7 @@
 obj-$(CONFIG_SGI_IP32) += setup-irq.o
 obj-$(CONFIG_X86_VISWS) += setup-irq.o
 
-# CompactPCI hotplug requires the pbus_* functions
-ifdef CONFIG_HOTPLUG_PCI_CPCI
-obj-y += setup-bus.o
-endif
-
-# Hotplug (eg, cardbus) now requires setup-bus
+# Cardbus & CompactPCI use setup-bus
 obj-$(CONFIG_HOTPLUG) += setup-bus.o
 
 ifndef CONFIG_X86

