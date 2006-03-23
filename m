Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964918AbWCWUCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWCWUCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422671AbWCWUCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:02:45 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:1161 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964918AbWCWUCo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:02:44 -0500
Date: Thu, 23 Mar 2006 15:02:27 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Morton Andrew Morton <akpm@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, galak@kernel.crashing.org,
       gregkh@suse.de, bcrl@kvack.org, Dave Jiang <dave.jiang@gmail.com>,
       arjan@infradead.org, Maneesh Soni <maneesh@in.ibm.com>,
       Murali <muralim@in.ibm.com>
Subject: [RFC][PATCH 3/10] 64 bit resources drivers ide changes
Message-ID: <20060323200227.GG7175@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060323195752.GD7175@in.ibm.com> <20060323195944.GE7175@in.ibm.com> <20060323200119.GF7175@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060323200119.GF7175@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Changes required under drivers/ide/* for 64bit resources.

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 drivers/ide/pci/aec62xx.c      |    3 ++-
 drivers/ide/pci/cmd64x.c       |    3 ++-
 drivers/ide/pci/hpt34x.c       |    4 ++--
 drivers/ide/pci/pdc202xx_new.c |    4 ++--
 drivers/ide/pci/pdc202xx_old.c |    4 ++--
 5 files changed, 10 insertions(+), 8 deletions(-)

diff -puN drivers/ide/pci/aec62xx.c~64bit-resources-drivers-ide-changes drivers/ide/pci/aec62xx.c
--- linux-2.6.16-mm1/drivers/ide/pci/aec62xx.c~64bit-resources-drivers-ide-changes	2006-03-23 11:39:01.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/ide/pci/aec62xx.c	2006-03-23 11:39:01.000000000 -0500
@@ -254,7 +254,8 @@ static unsigned int __devinit init_chips
 
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%016llx\n", name,
+			(unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 	if (bus_speed <= 33)
diff -puN drivers/ide/pci/cmd64x.c~64bit-resources-drivers-ide-changes drivers/ide/pci/cmd64x.c
--- linux-2.6.16-mm1/drivers/ide/pci/cmd64x.c~64bit-resources-drivers-ide-changes	2006-03-23 11:39:01.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/ide/pci/cmd64x.c	2006-03-23 11:39:01.000000000 -0500
@@ -609,7 +609,8 @@ static unsigned int __devinit init_chips
 #ifdef __i386__
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%016llx\n", name,
+			(unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 #endif
 
diff -puN drivers/ide/pci/hpt34x.c~64bit-resources-drivers-ide-changes drivers/ide/pci/hpt34x.c
--- linux-2.6.16-mm1/drivers/ide/pci/hpt34x.c~64bit-resources-drivers-ide-changes	2006-03-23 11:39:01.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/ide/pci/hpt34x.c	2006-03-23 11:39:01.000000000 -0500
@@ -175,8 +175,8 @@ static unsigned int __devinit init_chips
 		if (pci_resource_start(dev, PCI_ROM_RESOURCE)) {
 			pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 				dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-			printk(KERN_INFO "HPT345: ROM enabled at 0x%08lx\n",
-				dev->resource[PCI_ROM_RESOURCE].start);
+			printk(KERN_INFO "HPT345: ROM enabled at 0x%016llx\n",
+				(unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);
 		}
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0xF0);
 	} else {
diff -puN drivers/ide/pci/pdc202xx_new.c~64bit-resources-drivers-ide-changes drivers/ide/pci/pdc202xx_new.c
--- linux-2.6.16-mm1/drivers/ide/pci/pdc202xx_new.c~64bit-resources-drivers-ide-changes	2006-03-23 11:39:01.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/ide/pci/pdc202xx_new.c	2006-03-23 11:39:01.000000000 -0500
@@ -313,8 +313,8 @@ static unsigned int __devinit init_chips
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
-			name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%016llx\n", name,
+			(unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 #ifdef CONFIG_PPC_PMAC
diff -puN drivers/ide/pci/pdc202xx_old.c~64bit-resources-drivers-ide-changes drivers/ide/pci/pdc202xx_old.c
--- linux-2.6.16-mm1/drivers/ide/pci/pdc202xx_old.c~64bit-resources-drivers-ide-changes	2006-03-23 11:39:01.000000000 -0500
+++ linux-2.6.16-mm1-root/drivers/ide/pci/pdc202xx_old.c	2006-03-23 11:39:01.000000000 -0500
@@ -580,8 +580,8 @@ static unsigned int __devinit init_chips
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
 			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n",
-			name, dev->resource[PCI_ROM_RESOURCE].start);
+		printk(KERN_INFO "%s: ROM enabled at 0x%016llx\n", name,
+			(unsigned long long)dev->resource[PCI_ROM_RESOURCE].start);
 	}
 
 	/*
_
