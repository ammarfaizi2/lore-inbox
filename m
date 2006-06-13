Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932710AbWFMAid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbWFMAid (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWFMAeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:34:25 -0400
Received: from mail.suse.de ([195.135.220.2]:43726 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932694AbWFMAeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:34:12 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 06/16] 64bit resource: fix up printks for resources in ide drivers
Reply-To: Greg KH <greg@kroah.com>
Date: Mon, 12 Jun 2006 17:31:08 -0700
Message-Id: <11501586982289-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11501586942938-git-send-email-greg@kroah.com>
References: <20060613003033.GA10717@kroah.com> <11501586781628-git-send-email-greg@kroah.com> <1150158683636-git-send-email-greg@kroah.com> <11501586871870-git-send-email-greg@kroah.com> <11501586902008-git-send-email-greg@kroah.com> <11501586942938-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is needed if we wish to change the size of the resource structures.

Based on an original patch from Vivek Goyal <vgoyal@in.ibm.com>

Cc: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/ide/pci/aec62xx.c      |    3 ++-
 drivers/ide/pci/cmd64x.c       |    3 ++-
 drivers/ide/pci/hpt34x.c       |    2 +-
 drivers/ide/pci/pdc202xx_new.c |    4 ++--
 drivers/ide/pci/pdc202xx_old.c |    4 ++--
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/ide/pci/aec62xx.c b/drivers/ide/pci/aec62xx.c
index c743e68..8d5b872 100644
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -254,7 +254,8 @@ static unsigned int __devinit init_chips
 
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
+			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 	if (bus_speed <= 33)
diff --git a/drivers/ide/pci/cmd64x.c b/drivers/ide/pci/cmd64x.c
index 3d9c7af..9828039 100644
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -609,7 +609,8 @@ static unsigned int __devinit init_chips
 #ifdef __i386__
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
+			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 #endif
 
diff --git a/drivers/ide/pci/hpt34x.c b/drivers/ide/pci/hpt34x.c
index be334da..7da5502 100644
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -176,7 +176,7 @@ static unsigned int __devinit init_chips
 			pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 				dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
 			printk(KERN_INFO "HPT345: ROM enabled at 0x%08lx\n",
-				dev->resource[PCI_ROM_RESOURCE].start);
+				(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
 		}
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0xF0);
 	} else {
diff --git a/drivers/ide/pci/pdc202xx_new.c b/drivers/ide/pci/pdc202xx_new.c
index acd6317..20d5965 100644
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -313,8 +313,8 @@ static unsigned int __devinit init_chips
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
-			name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
+			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 #ifdef CONFIG_PPC_PMAC
diff --git a/drivers/ide/pci/pdc202xx_old.c b/drivers/ide/pci/pdc202xx_old.c
index 7ce5bf7..793e530 100644
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -580,8 +580,8 @@ static unsigned int __devinit init_chips
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
-			name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
+			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 	/*
-- 
1.4.0

