Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSHBXyY>; Fri, 2 Aug 2002 19:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSHBXyV>; Fri, 2 Aug 2002 19:54:21 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:54284 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317393AbSHBXxi>;
	Fri, 2 Aug 2002 19:53:38 -0400
Date: Fri, 2 Aug 2002 16:55:12 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI changes for 2.5.30
Message-ID: <20020802235512.GC1999@kroah.com>
References: <20020802235321.GA1999@kroah.com> <20020802235454.GB1999@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020802235454.GB1999@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 05 Jul 2002 22:51:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.514   -> 1.515  
#	 drivers/pci/names.c	1.3     -> 1.4    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/02	t-kouchi@mvf.biglobe.ne.jp	1.515
# [PATCH] [PATCH] PCI Hotplug patch to drivers/pci/names.c
# 
# I found that both compaq and ibm PCI hotplug driver call pci_scan_slot(),
# which eventually call pci_name_device() in drivers/pci/names.c.
# 
# pci_name_device() is declared as __devinit while other data are
# declared as __initdata.
# This may result in undefined behavior for example, /proc/pci.
# --------------------------------------------
#
diff -Nru a/drivers/pci/names.c b/drivers/pci/names.c
--- a/drivers/pci/names.c	Fri Aug  2 16:49:27 2002
+++ b/drivers/pci/names.c	Fri Aug  2 16:49:27 2002
@@ -32,18 +32,18 @@
  * real memory.. Parse the same file multiple times
  * to get all the info.
  */
-#define VENDOR( vendor, name )		static char __vendorstr_##vendor[] __initdata = name;
+#define VENDOR( vendor, name )		static char __vendorstr_##vendor[] __devinitdata = name;
 #define ENDVENDOR()
-#define DEVICE( vendor, device, name ) 	static char __devicestr_##vendor##device[] __initdata = name;
+#define DEVICE( vendor, device, name ) 	static char __devicestr_##vendor##device[] __devinitdata = name;
 #include "devlist.h"
 
 
-#define VENDOR( vendor, name )		static struct pci_device_info __devices_##vendor[] __initdata = {
+#define VENDOR( vendor, name )		static struct pci_device_info __devices_##vendor[] __devinitdata = {
 #define ENDVENDOR()			};
 #define DEVICE( vendor, device, name )	{ 0x##device, 0, __devicestr_##vendor##device },
 #include "devlist.h"
 
-static struct pci_vendor_info __initdata pci_vendor_list[] = {
+static struct pci_vendor_info __devinitdata pci_vendor_list[] = {
 #define VENDOR( vendor, name )		{ 0x##vendor, sizeof(__devices_##vendor) / sizeof(struct pci_device_info), __vendorstr_##vendor, __devices_##vendor },
 #define ENDVENDOR()
 #define DEVICE( vendor, device, name )
@@ -121,7 +121,7 @@
 
 #else
 
-void __init pci_name_device(struct pci_dev *dev)
+void __devinit pci_name_device(struct pci_dev *dev)
 {
 }
 
