Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbVJVUnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbVJVUnS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 16:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVJVUnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 16:43:18 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:17817 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750808AbVJVUnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 16:43:17 -0400
X-Mailbox-Line: From laurent@antares.localdomain sam oct 22 21:41:43 2005
Message-Id: <20051022194143.225100000@antares.localdomain>
References: <20051022194123.683082000@antares.localdomain>
Date: Sat, 22 Oct 2005 21:41:24 +0200
From: Laurent Riffard <laurent.riffard@free.fr>
To: Kernel development list <linux-kernel@vger.kernel.org>,
       davej@codemonkey.org.uk
Subject: [PATCH] agp : updates .owner field of struct pci_driver
Content-Disposition: inline; filename=agp_pci_driver_owner_field.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates .owner field of struct pci_driver.

This allows SYSFS to create the symlink from the driver to the
module which provides it.

$ tree /sys/bus/pci/drivers/agpgart-via/
/sys/bus/pci/drivers/agpgart-via/
|-- 0000:00:00.0 -> ../../../../devices/pci0000:00/0000:00:00.0
|-- bind
|-- module -> ../../../../module/via_agp
|-- new_id
`-- unbind

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>

--
 drivers/char/agp/ali-agp.c      |    1 +
 drivers/char/agp/amd-k7-agp.c   |    1 +
 drivers/char/agp/amd64-agp.c    |    1 +
 drivers/char/agp/ati-agp.c      |    1 +
 drivers/char/agp/efficeon-agp.c |    1 +
 drivers/char/agp/i460-agp.c     |    1 +
 drivers/char/agp/intel-agp.c    |    1 +
 drivers/char/agp/nvidia-agp.c   |    1 +
 drivers/char/agp/sis-agp.c      |    1 +
 drivers/char/agp/sworks-agp.c   |    1 +
 drivers/char/agp/uninorth-agp.c |    1 +
 drivers/char/agp/via-agp.c      |    1 +
 12 files changed, 12 insertions(+)

Index: linux-2.6-stable/drivers/char/agp/ali-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/ali-agp.c
+++ linux-2.6-stable/drivers/char/agp/ali-agp.c
@@ -388,6 +388,7 @@
 MODULE_DEVICE_TABLE(pci, agp_ali_pci_table);
 
 static struct pci_driver agp_ali_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-ali",
 	.id_table	= agp_ali_pci_table,
 	.probe		= agp_ali_probe,
Index: linux-2.6-stable/drivers/char/agp/amd-k7-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/amd-k7-agp.c
+++ linux-2.6-stable/drivers/char/agp/amd-k7-agp.c
@@ -518,6 +518,7 @@
 MODULE_DEVICE_TABLE(pci, agp_amdk7_pci_table);
 
 static struct pci_driver agp_amdk7_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-amdk7",
 	.id_table	= agp_amdk7_pci_table,
 	.probe		= agp_amdk7_probe,
Index: linux-2.6-stable/drivers/char/agp/amd64-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/amd64-agp.c
+++ linux-2.6-stable/drivers/char/agp/amd64-agp.c
@@ -701,6 +701,7 @@
 MODULE_DEVICE_TABLE(pci, agp_amd64_pci_table);
 
 static struct pci_driver agp_amd64_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-amd64",
 	.id_table	= agp_amd64_pci_table,
 	.probe		= agp_amd64_probe,
Index: linux-2.6-stable/drivers/char/agp/ati-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/ati-agp.c
+++ linux-2.6-stable/drivers/char/agp/ati-agp.c
@@ -522,6 +522,7 @@
 MODULE_DEVICE_TABLE(pci, agp_ati_pci_table);
 
 static struct pci_driver agp_ati_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-ati",
 	.id_table	= agp_ati_pci_table,
 	.probe		= agp_ati_probe,
Index: linux-2.6-stable/drivers/char/agp/efficeon-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/efficeon-agp.c
+++ linux-2.6-stable/drivers/char/agp/efficeon-agp.c
@@ -429,6 +429,7 @@
 MODULE_DEVICE_TABLE(pci, agp_efficeon_pci_table);
 
 static struct pci_driver agp_efficeon_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-efficeon",
 	.id_table	= agp_efficeon_pci_table,
 	.probe		= agp_efficeon_probe,
Index: linux-2.6-stable/drivers/char/agp/i460-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/i460-agp.c
+++ linux-2.6-stable/drivers/char/agp/i460-agp.c
@@ -617,6 +617,7 @@
 MODULE_DEVICE_TABLE(pci, agp_intel_i460_pci_table);
 
 static struct pci_driver agp_intel_i460_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-intel-i460",
 	.id_table	= agp_intel_i460_pci_table,
 	.probe		= agp_intel_i460_probe,
Index: linux-2.6-stable/drivers/char/agp/intel-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/intel-agp.c
+++ linux-2.6-stable/drivers/char/agp/intel-agp.c
@@ -1824,6 +1824,7 @@
 MODULE_DEVICE_TABLE(pci, agp_intel_pci_table);
 
 static struct pci_driver agp_intel_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-intel",
 	.id_table	= agp_intel_pci_table,
 	.probe		= agp_intel_probe,
Index: linux-2.6-stable/drivers/char/agp/nvidia-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/nvidia-agp.c
+++ linux-2.6-stable/drivers/char/agp/nvidia-agp.c
@@ -398,6 +398,7 @@
 MODULE_DEVICE_TABLE(pci, agp_nvidia_pci_table);
 
 static struct pci_driver agp_nvidia_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-nvidia",
 	.id_table	= agp_nvidia_pci_table,
 	.probe		= agp_nvidia_probe,
Index: linux-2.6-stable/drivers/char/agp/sis-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/sis-agp.c
+++ linux-2.6-stable/drivers/char/agp/sis-agp.c
@@ -332,6 +332,7 @@
 MODULE_DEVICE_TABLE(pci, agp_sis_pci_table);
 
 static struct pci_driver agp_sis_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-sis",
 	.id_table	= agp_sis_pci_table,
 	.probe		= agp_sis_probe,
Index: linux-2.6-stable/drivers/char/agp/sworks-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/sworks-agp.c
+++ linux-2.6-stable/drivers/char/agp/sworks-agp.c
@@ -531,6 +531,7 @@
 MODULE_DEVICE_TABLE(pci, agp_serverworks_pci_table);
 
 static struct pci_driver agp_serverworks_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-serverworks",
 	.id_table	= agp_serverworks_pci_table,
 	.probe		= agp_serverworks_probe,
Index: linux-2.6-stable/drivers/char/agp/uninorth-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/uninorth-agp.c
+++ linux-2.6-stable/drivers/char/agp/uninorth-agp.c
@@ -658,6 +658,7 @@
 MODULE_DEVICE_TABLE(pci, agp_uninorth_pci_table);
 
 static struct pci_driver agp_uninorth_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-uninorth",
 	.id_table	= agp_uninorth_pci_table,
 	.probe		= agp_uninorth_probe,
Index: linux-2.6-stable/drivers/char/agp/via-agp.c
===================================================================
--- linux-2.6-stable.orig/drivers/char/agp/via-agp.c
+++ linux-2.6-stable/drivers/char/agp/via-agp.c
@@ -518,6 +518,7 @@
 
 
 static struct pci_driver agp_via_pci_driver = {
+	.owner		= THIS_MODULE,
 	.name		= "agpgart-via",
 	.id_table	= agp_via_pci_table,
 	.probe		= agp_via_probe,

--

