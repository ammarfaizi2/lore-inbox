Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267490AbTAGUdQ>; Tue, 7 Jan 2003 15:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267491AbTAGUcc>; Tue, 7 Jan 2003 15:32:32 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:4523 "HELO atlrel8.hp.com")
	by vger.kernel.org with SMTP id <S267490AbTAGUbL>;
	Tue, 7 Jan 2003 15:31:11 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] AGP 6/7: use PCI_AGP_* constants
Date: Tue, 7 Jan 2003 13:39:50 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301071339.50035.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.976   -> 1.977  
#	drivers/char/agp/sis-agp.c	1.11    -> 1.12   
#	drivers/char/agp/i7x05-agp.c	1.5     -> 1.6    
#	drivers/char/agp/generic.c	1.13    -> 1.14   
#	drivers/char/agp/sworks-agp.c	1.16    -> 1.17   
#	drivers/char/agp/intel-agp.c	1.19    -> 1.20   
#	drivers/char/agp/ali-agp.c	1.11    -> 1.12   
#	drivers/char/agp/amd-k8-agp.c	1.19    -> 1.20   
#	drivers/char/agp/via-kt400.c	1.4     -> 1.5    
#	drivers/char/agp/via-agp.c	1.18    -> 1.19   
#	drivers/char/agp/amd-k7-agp.c	1.13    -> 1.14   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/07	bjorn_helgaas@hp.com	1.977
# AGP: Use PCI_AGP_ constants.
# --------------------------------------------
#
diff -Nru a/drivers/char/agp/ali-agp.c b/drivers/char/agp/ali-agp.c
--- a/drivers/char/agp/ali-agp.c	Tue Jan  7 12:52:47 2003
+++ b/drivers/char/agp/ali-agp.c	Tue Jan  7 12:52:47 2003
@@ -350,7 +350,7 @@
 		agp_bridge.dev = dev;
 		agp_bridge.capndx = cap_ptr;
 		/* Fill in the mode register */
-		pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+4, &agp_bridge.mode);
+		pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+PCI_AGP_STATUS, &agp_bridge.mode);
 		agp_register_driver(dev);
 		return 0;
 	}
diff -Nru a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
--- a/drivers/char/agp/amd-k7-agp.c	Tue Jan  7 12:52:47 2003
+++ b/drivers/char/agp/amd-k7-agp.c	Tue Jan  7 12:52:47 2003
@@ -451,7 +451,7 @@
 		agp_bridge.dev = dev;
 		agp_bridge.capndx = cap_ptr;
 		/* Fill in the mode register */
-		pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+4, &agp_bridge.mode);
+		pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+PCI_AGP_STATUS, &agp_bridge.mode);
 		agp_register_driver(dev);
 		return 0;
 	}
diff -Nru a/drivers/char/agp/amd-k8-agp.c b/drivers/char/agp/amd-k8-agp.c
--- a/drivers/char/agp/amd-k8-agp.c	Tue Jan  7 12:52:47 2003
+++ b/drivers/char/agp/amd-k8-agp.c	Tue Jan  7 12:52:47 2003
@@ -368,12 +368,12 @@
 	}
 
 
-	pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+4, &command);
+	pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+PCI_AGP_STATUS, &command);
 
 	command = agp_collect_device_status(mode, command);
 	command |= 0x100;
 
-	pci_write_config_dword(agp_bridge.dev, agp_bridge.capndx+8, command);
+	pci_write_config_dword(agp_bridge.dev, agp_bridge.capndx+PCI_AGP_COMMAND, command);
 
 	agp_device_command(command, 1);
 }
@@ -421,7 +421,7 @@
 	agp_bridge.capndx = cap_ptr;
 
 	/* Fill in the mode register */
-	pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+4, &agp_bridge.mode);
+	pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+PCI_AGP_STATUS, &agp_bridge.mode);
 	amd_8151_setup(dev);
 	agp_register_driver(dev);
 	return 0;
diff -Nru a/drivers/char/agp/generic.c b/drivers/char/agp/generic.c
--- a/drivers/char/agp/generic.c	Tue Jan  7 12:52:47 2003
+++ b/drivers/char/agp/generic.c	Tue Jan  7 12:52:47 2003
@@ -329,7 +329,7 @@
 		 * Ok, here we have a AGP device. Disable impossible 
 		 * settings, and adjust the readqueue to the minimum.
 		 */
-		pci_read_config_dword(device, agp + 4, &scratch);
+		pci_read_config_dword(device, agp + PCI_AGP_STATUS, &scratch);
 
 		/* adjust RQ depth */
 		command = ((command & ~0xff000000) |
@@ -393,7 +393,7 @@
 
 		printk(KERN_INFO PFX "AGP: Putting AGP V%d device at %s into %dx mode\n",
 				agp_v3 ? 3 : 2, device->slot_name, mode);
-		pci_write_config_dword(device, agp + 8, command);
+		pci_write_config_dword(device, agp + PCI_AGP_COMMAND, command);
 	}
 }
 
@@ -401,13 +401,15 @@
 {
 	u32 command;
 
-	pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx + 4, &command);
+	pci_read_config_dword(agp_bridge.dev,
+			      agp_bridge.capndx + PCI_AGP_STATUS,
+			      &command);
 
 	command = agp_collect_device_status(mode, command);
 	command |= 0x100;
 
 	pci_write_config_dword(agp_bridge.dev,
-			       agp_bridge.capndx + 8,
+			       agp_bridge.capndx + PCI_AGP_COMMAND,
 			       command);
 
 	agp_device_command(command, 0);
diff -Nru a/drivers/char/agp/i7x05-agp.c b/drivers/char/agp/i7x05-agp.c
--- a/drivers/char/agp/i7x05-agp.c	Tue Jan  7 12:52:47 2003
+++ b/drivers/char/agp/i7x05-agp.c	Tue Jan  7 12:52:47 2003
@@ -177,7 +177,7 @@
 		agp_bridge.dev = dev;
 		agp_bridge.capndx = cap_ptr;
 		/* Fill in the mode register */
-		pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+4, &agp_bridge.mode)
+		pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+PCI_AGP_STATUS, &agp_bridge.mode)
 		agp_register_driver(dev);
 		return 0;
 	}
diff -Nru a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
--- a/drivers/char/agp/intel-agp.c	Tue Jan  7 12:52:47 2003
+++ b/drivers/char/agp/intel-agp.c	Tue Jan  7 12:52:47 2003
@@ -1423,7 +1423,7 @@
 	agp_bridge.capndx = cap_ptr;
 
 	/* Fill in the mode register */
-	pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+4, &agp_bridge.mode);
+	pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+PCI_AGP_STATUS, &agp_bridge.mode);
 
 	/* probe for known chipsets */
 	return agp_lookup_host_bridge(dev);
diff -Nru a/drivers/char/agp/sis-agp.c b/drivers/char/agp/sis-agp.c
--- a/drivers/char/agp/sis-agp.c	Tue Jan  7 12:52:47 2003
+++ b/drivers/char/agp/sis-agp.c	Tue Jan  7 12:52:47 2003
@@ -235,7 +235,7 @@
 		agp_bridge.dev = dev;
 		agp_bridge.capndx = cap_ptr;
 		/* Fill in the mode register */
-		pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+4, &agp_bridge.mode);
+		pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+PCI_AGP_STATUS, &agp_bridge.mode);
 		agp_register_driver(dev);
 		return 0;
 	}
diff -Nru a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
--- a/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:52:47 2003
+++ b/drivers/char/agp/sworks-agp.c	Tue Jan  7 12:52:47 2003
@@ -272,7 +272,7 @@
 
 	/* Fill in the mode register */
 	pci_read_config_dword(serverworks_private.svrwrks_dev,
-			      agp_bridge.capndx+4, &agp_bridge.mode);
+			      agp_bridge.capndx+PCI_AGP_STATUS, &agp_bridge.mode);
 
 	pci_read_config_byte(agp_bridge.dev, SVWRKS_CACHING, &enable_reg);
 	enable_reg &= ~0x3;
@@ -416,7 +416,7 @@
 	u32 command;
 
 	pci_read_config_dword(serverworks_private.svrwrks_dev,
-			      agp_bridge.capndx + 4,
+			      agp_bridge.capndx + PCI_AGP_STATUS,
 			      &command);
 
 	command = agp_collect_device_status(mode, command);
@@ -427,7 +427,7 @@
 	command |= 0x100;
 
 	pci_write_config_dword(serverworks_private.svrwrks_dev,
-			       agp_bridge.capndx + 8,
+			       agp_bridge.capndx + PCI_AGP_COMMAND,
 			       command);
 
 	agp_device_command(command, 0);
diff -Nru a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
--- a/drivers/char/agp/via-agp.c	Tue Jan  7 12:52:47 2003
+++ b/drivers/char/agp/via-agp.c	Tue Jan  7 12:52:47 2003
@@ -258,7 +258,7 @@
 		agp_bridge.dev = dev;
 		agp_bridge.capndx = cap_ptr;
 		/* Fill in the mode register */
-		pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+4, &agp_bridge.mode);
+		pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+PCI_AGP_STATUS, &agp_bridge.mode);
 		agp_register_driver(dev);
 		return 0;
 	}
diff -Nru a/drivers/char/agp/via-kt400.c b/drivers/char/agp/via-kt400.c
--- a/drivers/char/agp/via-kt400.c	Tue Jan  7 12:52:47 2003
+++ b/drivers/char/agp/via-kt400.c	Tue Jan  7 12:52:47 2003
@@ -147,7 +147,7 @@
 	agp_bridge.cant_use_aperture = 0;
 
 	/* Fill in the mode register */
-	pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+4, &agp_bridge.mode);
+	pci_read_config_dword(agp_bridge.dev, agp_bridge.capndx+PCI_AGP_STATUS, &agp_bridge.mode);
 
 	agp_register_driver(dev);
 	return 0;

