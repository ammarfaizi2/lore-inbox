Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317484AbSGXTJx>; Wed, 24 Jul 2002 15:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317472AbSGXTJx>; Wed, 24 Jul 2002 15:09:53 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:30471 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317484AbSGXTJg>;
	Wed, 24 Jul 2002 15:09:36 -0400
Date: Wed, 24 Jul 2002 12:12:36 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI Hotplug changes for 2.5.27
Message-ID: <20020724191235.GD11015@kroah.com>
References: <20020724190922.GA11015@kroah.com> <20020724191010.GB11015@kroah.com> <20020724191138.GC11015@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020724191138.GC11015@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 26 Jun 2002 17:59:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.403.159.1 -> 1.403.159.2
#	drivers/hotplug/cpqphp_core.c	1.5     -> 1.6    
#	drivers/hotplug/pci_hotplug_core.c	1.19    -> 1.20   
#	drivers/hotplug/ibmphp_core.c	1.7     -> 1.8    
#	drivers/hotplug/pcihp_skeleton.c	1.1     -> 1.2    
#	drivers/hotplug/cpqphp_pci.c	1.4     -> 1.5    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	rusty@rustcorp.com.au	1.403.159.2
# [PATCH] drivers/hotplug designated initializers
# 
#  The old form of designated initializers are obsolete: we need to
#  replace them with the ISO C forms before 2.6.  Gcc has always supported
#  both forms anyway.
# --------------------------------------------
#
diff -Nru a/drivers/hotplug/cpqphp_core.c b/drivers/hotplug/cpqphp_core.c
--- a/drivers/hotplug/cpqphp_core.c	Wed Jul 24 12:00:05 2002
+++ b/drivers/hotplug/cpqphp_core.c	Wed Jul 24 12:00:05 2002
@@ -81,15 +81,15 @@
 static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
 
 static struct hotplug_slot_ops cpqphp_hotplug_slot_ops = {
-	owner:			THIS_MODULE,
-	set_attention_status:	set_attention_status,
-	enable_slot:		process_SI,
-	disable_slot:		process_SS,
-	hardware_test:		hardware_test,
-	get_power_status:	get_power_status,
-	get_attention_status:	get_attention_status,
-	get_latch_status:	get_latch_status,
-	get_adapter_status:	get_adapter_status,
+	.owner =		THIS_MODULE,
+	.set_attention_status =	set_attention_status,
+	.enable_slot =		process_SI,
+	.disable_slot =		process_SS,
+	.hardware_test =	hardware_test,
+	.get_power_status =	get_power_status,
+	.get_attention_status =	get_attention_status,
+	.get_latch_status =	get_latch_status,
+	.get_adapter_status =	get_adapter_status,
 };
 
 
@@ -1387,14 +1387,14 @@
 static struct pci_device_id hpcd_pci_tbl[] __devinitdata = {
 	{
 	/* handle any PCI Hotplug controller */
-	class:          ((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00),
-	class_mask:     ~0,
+	.class =        ((PCI_CLASS_SYSTEM_PCI_HOTPLUG << 8) | 0x00),
+	.class_mask =   ~0,
 	
 	/* no matter who makes it */
-	vendor:         PCI_ANY_ID,
-	device:         PCI_ANY_ID,
-	subvendor:      PCI_ANY_ID,
-	subdevice:      PCI_ANY_ID,
+	.vendor =       PCI_ANY_ID,
+	.device =       PCI_ANY_ID,
+	.subvendor =    PCI_ANY_ID,
+	.subdevice =    PCI_ANY_ID,
 	
 	}, { /* end: all zeroes */ }
 };
@@ -1404,9 +1404,9 @@
 
 
 static struct pci_driver cpqhpc_driver = {
-	name:		"pci_hotplug",
-	id_table:	hpcd_pci_tbl,
-	probe:		cpqhpc_probe,
+	.name =		"pci_hotplug",
+	.id_table =	hpcd_pci_tbl,
+	.probe =	cpqhpc_probe,
 	/* remove:	cpqhpc_remove_one, */
 };
 
diff -Nru a/drivers/hotplug/cpqphp_pci.c b/drivers/hotplug/cpqphp_pci.c
--- a/drivers/hotplug/cpqphp_pci.c	Wed Jul 24 12:00:05 2002
+++ b/drivers/hotplug/cpqphp_pci.c	Wed Jul 24 12:00:05 2002
@@ -232,17 +232,17 @@
 
 
 static struct pci_visit configure_functions = {
-	visit_pci_dev:		configure_visit_pci_dev,
+	.visit_pci_dev =	configure_visit_pci_dev,
 };
 
 
 static struct pci_visit unconfigure_functions_phase1 = {
-	post_visit_pci_dev:	unconfigure_visit_pci_dev_phase1
+	.post_visit_pci_dev =	unconfigure_visit_pci_dev_phase1
 };
 
 static struct pci_visit unconfigure_functions_phase2 = {
-	post_visit_pci_bus:	unconfigure_visit_pci_bus_phase2,               
-	post_visit_pci_dev:	unconfigure_visit_pci_dev_phase2
+	.post_visit_pci_bus =	unconfigure_visit_pci_bus_phase2,               
+	.post_visit_pci_dev =	unconfigure_visit_pci_dev_phase2
 };
 
 
diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Wed Jul 24 12:00:05 2002
+++ b/drivers/hotplug/ibmphp_core.c	Wed Jul 24 12:00:05 2002
@@ -893,12 +893,12 @@
 }
 
 static struct pci_visit ibm_unconfigure_functions_phase1 = {
-	post_visit_pci_dev:	ibm_unconfigure_visit_pci_dev_phase1,
+	.post_visit_pci_dev =	ibm_unconfigure_visit_pci_dev_phase1,
 };
 
 static struct pci_visit ibm_unconfigure_functions_phase2 = {
-	post_visit_pci_bus:	ibm_unconfigure_visit_pci_bus_phase2,
-	post_visit_pci_dev:	ibm_unconfigure_visit_pci_dev_phase2,
+	.post_visit_pci_bus =	ibm_unconfigure_visit_pci_bus_phase2,
+	.post_visit_pci_dev =	ibm_unconfigure_visit_pci_dev_phase2,
 };
 
 static int ibm_unconfigure_device (struct pci_func *func)
@@ -962,7 +962,7 @@
 }
 
 static struct pci_visit configure_functions = {
-	visit_pci_dev:	configure_visit_pci_dev,
+	.visit_pci_dev =configure_visit_pci_dev,
 };
 
 static int ibm_configure_device (struct pci_func *func)
@@ -1494,19 +1494,19 @@
 }
 
 struct hotplug_slot_ops ibmphp_hotplug_slot_ops = {
-	owner:				THIS_MODULE,
-	set_attention_status:		set_attention_status,
-	enable_slot:			enable_slot,
-	disable_slot:			ibmphp_disable_slot,
-	hardware_test:			NULL,
-	get_power_status:		get_power_status,
-	get_attention_status:		get_attention_status,
-	get_latch_status:		get_latch_status,
-	get_adapter_status:		get_adapter_present,
+	.owner =			THIS_MODULE,
+	.set_attention_status =		set_attention_status,
+	.enable_slot =			enable_slot,
+	.disable_slot =			ibmphp_disable_slot,
+	.hardware_test =		NULL,
+	.get_power_status =		get_power_status,
+	.get_attention_status =		get_attention_status,
+	.get_latch_status =		get_latch_status,
+	.get_adapter_status =		get_adapter_present,
 /*	get_max_bus_speed_status:	get_max_bus_speed,
-	get_max_adapter_speed_status:	get_max_adapter_speed,
-	get_cur_bus_speed_status:	get_cur_bus_speed,
-	get_card_bus_names_status:	get_card_bus_names,
+	.get_max_adapter_speed_status =	get_max_adapter_speed,
+	.get_cur_bus_speed_status =	get_cur_bus_speed,
+	.get_card_bus_names_status =	get_card_bus_names,
 */
 };
 
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Wed Jul 24 12:00:05 2002
+++ b/drivers/hotplug/pci_hotplug_core.c	Wed Jul 24 12:00:05 2002
@@ -230,71 +230,71 @@
 }
 
 static struct file_operations default_file_operations = {
-	read:		default_read_file,
-	write:		default_write_file,
-	open:		default_open,
-	llseek:		default_file_lseek,
+	.read =		default_read_file,
+	.write =	default_write_file,
+	.open =		default_open,
+	.llseek =	default_file_lseek,
 };
 
 /* file ops for the "power" files */
 static ssize_t power_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
 static ssize_t power_write_file (struct file *file, const char *buf, size_t count, loff_t *ppos);
 static struct file_operations power_file_operations = {
-	read:		power_read_file,
-	write:		power_write_file,
-	open:		default_open,
-	llseek:		default_file_lseek,
+	.read =		power_read_file,
+	.write =	power_write_file,
+	.open =		default_open,
+	.llseek =	default_file_lseek,
 };
 
 /* file ops for the "attention" files */
 static ssize_t attention_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
 static ssize_t attention_write_file (struct file *file, const char *buf, size_t count, loff_t *ppos);
 static struct file_operations attention_file_operations = {
-	read:		attention_read_file,
-	write:		attention_write_file,
-	open:		default_open,
-	llseek:		default_file_lseek,
+	.read =		attention_read_file,
+	.write =	attention_write_file,
+	.open =		default_open,
+	.llseek =	default_file_lseek,
 };
 
 /* file ops for the "latch" files */
 static ssize_t latch_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
 static struct file_operations latch_file_operations = {
-	read:		latch_read_file,
-	write:		default_write_file,
-	open:		default_open,
-	llseek:		default_file_lseek,
+	.read =		latch_read_file,
+	.write =	default_write_file,
+	.open =		default_open,
+	.llseek =	default_file_lseek,
 };
 
 /* file ops for the "presence" files */
 static ssize_t presence_read_file (struct file *file, char *buf, size_t count, loff_t *offset);
 static struct file_operations presence_file_operations = {
-	read:		presence_read_file,
-	write:		default_write_file,
-	open:		default_open,
-	llseek:		default_file_lseek,
+	.read =		presence_read_file,
+	.write =	default_write_file,
+	.open =		default_open,
+	.llseek =	default_file_lseek,
 };
 
 /* file ops for the "test" files */
 static ssize_t test_write_file (struct file *file, const char *buf, size_t count, loff_t *ppos);
 static struct file_operations test_file_operations = {
-	read:		default_read_file,
-	write:		test_write_file,
-	open:		default_open,
-	llseek:		default_file_lseek,
+	.read =		default_read_file,
+	.write =	test_write_file,
+	.open =		default_open,
+	.llseek =	default_file_lseek,
 };
 
 static struct inode_operations pcihpfs_dir_inode_operations = {
-	create:		pcihpfs_create,
-	lookup:		simple_lookup,
-	unlink:		pcihpfs_unlink,
-	mkdir:		pcihpfs_mkdir,
-	rmdir:		pcihpfs_rmdir,
-	mknod:		pcihpfs_mknod,
+	.create =	pcihpfs_create,
+	.lookup =	simple_lookup,
+	.unlink =	pcihpfs_unlink,
+	.mkdir =	pcihpfs_mkdir,
+	.rmdir =	pcihpfs_rmdir,
+	.mknod =	pcihpfs_mknod,
 };
 
 static struct super_operations pcihpfs_ops = {
-	statfs:		simple_statfs,
-	drop_inode:	generic_delete_inode,
+	.statfs =	simple_statfs,
+	.drop_inode =	generic_delete_inode,
 };
 
 static int pcihpfs_fill_super(struct super_block *sb, void *data, int silent)
@@ -330,10 +330,10 @@
 }
 
 static struct file_system_type pcihpfs_type = {
-	owner:		THIS_MODULE,
-	name:		"pcihpfs",
-	get_sb:		pcihpfs_get_sb,
-	kill_sb:	kill_litter_super,
+	.owner =	THIS_MODULE,
+	.name =		"pcihpfs",
+	.get_sb =	pcihpfs_get_sb,
+	.kill_sb =	kill_litter_super,
 };
 
 static int get_mount (void)
diff -Nru a/drivers/hotplug/pcihp_skeleton.c b/drivers/hotplug/pcihp_skeleton.c
--- a/drivers/hotplug/pcihp_skeleton.c	Wed Jul 24 12:00:05 2002
+++ b/drivers/hotplug/pcihp_skeleton.c	Wed Jul 24 12:00:05 2002
@@ -89,15 +89,15 @@
 static int get_adapter_status	(struct hotplug_slot *slot, u8 *value);
 
 static struct hotplug_slot_ops skel_hotplug_slot_ops = {
-	owner:			THIS_MODULE,
-	enable_slot:		enable_slot,
-	disable_slot:		disable_slot,
-	set_attention_status:	set_attention_status,
-	hardware_test:		hardware_test,
-	get_power_status:	get_power_status,
-	get_attention_status:	get_attention_status,
-	get_latch_status:	get_latch_status,
-	get_adapter_status:	get_adapter_status,
+	.owner =		THIS_MODULE,
+	.enable_slot =		enable_slot,
+	.disable_slot =		disable_slot,
+	.set_attention_status =	set_attention_status,
+	.hardware_test =	hardware_test,
+	.get_power_status =	get_power_status,
+	.get_attention_status =	get_attention_status,
+	.get_latch_status =	get_latch_status,
+	.get_adapter_status =	get_adapter_status,
 };
 
 
