Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbSLBHSE>; Mon, 2 Dec 2002 02:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbSLBHSE>; Mon, 2 Dec 2002 02:18:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45318 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265402AbSLBHR4>;
	Mon, 2 Dec 2002 02:17:56 -0500
Date: Mon, 2 Dec 2002 00:25:43 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [PATCH] PCI Hotplug changes for 2.5.50
Message-ID: <20021202082543.GC12121@kroah.com>
References: <20021202082443.GA12121@kroah.com> <20021202082525.GB12121@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021202082525.GB12121@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.871.3.2, 2002/11/26 11:26:14-08:00, ahaas@airmail.net

[PATCH] C99 initializers for drivers/hotplug

Here's a small set of patches for switching drivers/hotplug to use C99
initializers. The patches are against 2.5.49.


diff -Nru a/drivers/hotplug/cpci_hotplug_pci.c b/drivers/hotplug/cpci_hotplug_pci.c
--- a/drivers/hotplug/cpci_hotplug_pci.c	Sun Dec  1 23:26:29 2002
+++ b/drivers/hotplug/cpci_hotplug_pci.c	Sun Dec  1 23:26:29 2002
@@ -572,16 +572,16 @@
 }
 
 static struct pci_visit configure_functions = {
-	visit_pci_dev:configure_visit_pci_dev,
+	.visit_pci_dev = configure_visit_pci_dev,
 };
 
 static struct pci_visit unconfigure_functions_phase1 = {
-	post_visit_pci_dev:unconfigure_visit_pci_dev_phase1
+	.post_visit_pci_dev = unconfigure_visit_pci_dev_phase1
 };
 
 static struct pci_visit unconfigure_functions_phase2 = {
-	post_visit_pci_bus:unconfigure_visit_pci_bus_phase2,
-	post_visit_pci_dev:unconfigure_visit_pci_dev_phase2
+	.post_visit_pci_bus = unconfigure_visit_pci_bus_phase2,
+	.post_visit_pci_dev = unconfigure_visit_pci_dev_phase2
 };
 
 
diff -Nru a/drivers/hotplug/ibmphp_ebda.c b/drivers/hotplug/ibmphp_ebda.c
--- a/drivers/hotplug/ibmphp_ebda.c	Sun Dec  1 23:26:29 2002
+++ b/drivers/hotplug/ibmphp_ebda.c	Sun Dec  1 23:26:29 2002
@@ -1240,11 +1240,11 @@
 
 static struct pci_device_id id_table[] __devinitdata = {
 	{
-		vendor:		PCI_VENDOR_ID_IBM,
-		device:		HPC_DEVICE_ID,
-		subvendor:	PCI_VENDOR_ID_IBM,
-		subdevice:	HPC_SUBSYSTEM_ID,
-		class:		((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00),
+		.vendor		= PCI_VENDOR_ID_IBM,
+		.device		= HPC_DEVICE_ID,
+		.subvendor	= PCI_VENDOR_ID_IBM,
+		.subdevice	= HPC_SUBSYSTEM_ID,
+		.class		= ((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00),
 	}, {}
 };		
 
@@ -1252,9 +1252,9 @@
 
 static int ibmphp_probe (struct pci_dev *, const struct pci_device_id *);
 static struct pci_driver ibmphp_driver = {
-	name:		"ibmphp",
-	id_table:	id_table,
-	probe:		ibmphp_probe,
+	.name		= "ibmphp",
+	.id_table	= id_table,
+	.probe		= ibmphp_probe,
 };
 
 int ibmphp_register_pci (void)
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Sun Dec  1 23:26:29 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Sun Dec  1 23:26:29 2002
@@ -319,19 +319,19 @@
 /* file ops for the "max bus speed" files */
 static ssize_t max_bus_speed_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
 static struct file_operations max_bus_speed_file_operations = {
-	read:		max_bus_speed_read_file,
-	write:		default_write_file,
-	open:		default_open,
-	llseek:		default_file_lseek,
+	.read		= max_bus_speed_read_file,
+	.write		= default_write_file,
+	.open		= default_open,
+	.llseek		= default_file_lseek,
 };
 
 /* file ops for the "current bus speed" files */
 static ssize_t cur_bus_speed_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
 static struct file_operations cur_bus_speed_file_operations = {
-	read:		cur_bus_speed_read_file,
-	write:		default_write_file,
-	open:		default_open,
-	llseek:		default_file_lseek,
+	.read		= cur_bus_speed_read_file,
+	.write		= default_write_file,
+	.open		= default_open,
+	.llseek		= default_file_lseek,
 };
 
 /* file ops for the "test" files */
