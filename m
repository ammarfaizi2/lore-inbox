Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265605AbTLINBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 08:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbTLINBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 08:01:21 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:9988 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S265605AbTLIM6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 07:58:49 -0500
Date: Tue, 9 Dec 2003 12:26:38 +0000
From: Joe Thornber <thornber@sistina.com>
To: Joe Thornber <thornber@sistina.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 4/4] dm: ioctl interface
Message-ID: <20031209122638.GF472@reti>
References: <20031209115806.GA472@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209115806.GA472@reti>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioctl interface for dm
--- diff/arch/mips64/kernel/ioctl32.c	2003-08-26 13:50:03.000000000 +0100
+++ source/arch/mips64/kernel/ioctl32.c	2003-12-09 11:04:13.000000000 +0000
@@ -37,6 +37,7 @@
 #include <linux/ext2_fs.h>
 #include <linux/raid/md_u.h>
 #include <linux/serial.h>
+#include <linux/dm-ioctl.h>
 
 #include <scsi/scsi.h>
 #undef __KERNEL__		/* This file was born to be ugly ...  */
@@ -1222,6 +1223,22 @@
 	IOCTL32_DEFAULT(RESTART_ARRAY_RW),
 #endif /* CONFIG_MD */
 
+#if defined(CONFIG_BLK_DEV_DM) || defined(CONFIG_BLK_DEV_DM_MODULE)
+	IOCTL32_DEFAULT(DM_VERSION),
+	IOCTL32_DEFAULT(DM_REMOVE_ALL),
+	IOCTL32_DEFAULT(DM_DEV_CREATE),
+	IOCTL32_DEFAULT(DM_DEV_REMOVE),
+	IOCTL32_DEFAULT(DM_TABLE_LOAD),
+	IOCTL32_DEFAULT(DM_DEV_SUSPEND),
+	IOCTL32_DEFAULT(DM_DEV_RENAME),
+	IOCTL32_DEFAULT(DM_TABLE_DEPS),
+	IOCTL32_DEFAULT(DM_DEV_STATUS),
+	IOCTL32_DEFAULT(DM_TABLE_STATUS),
+	IOCTL32_DEFAULT(DM_DEV_WAIT),
+	IOCTL32_DEFAULT(DM_LIST_DEVICES),
+	IOCTL32_DEFAULT(DM_TABLE_CLEAR),
+#endif /* CONFIG_BLK_DEV_DM */
+
 #ifdef CONFIG_SIBYTE_TBPROF
 	IOCTL32_DEFAULT(SBPROF_ZBSTART),
 	IOCTL32_DEFAULT(SBPROF_ZBSTOP),
--- diff/arch/parisc/kernel/ioctl32.c	2003-08-26 13:50:03.000000000 +0100
+++ source/arch/parisc/kernel/ioctl32.c	2003-12-09 11:04:13.000000000 +0000
@@ -55,6 +55,7 @@
 #define max max */
 #include <linux/lvm.h>
 #endif /* LVM */
+#include <linux/dm-ioctl.h>
 
 #include <scsi/scsi.h>
 /* Ugly hack. */
@@ -3423,6 +3424,22 @@
 COMPATIBLE_IOCTL(LV_BMAP)
 COMPATIBLE_IOCTL(LV_SNAPSHOT_USE_RATE)
 #endif /* LVM */
+/* Device-Mapper */
+#if defined(CONFIG_BLK_DEV_DM) || defined(CONFIG_BLK_DEV_DM_MODULE)
+COMPATIBLE_IOCTL(DM_VERSION)
+COMPATIBLE_IOCTL(DM_REMOVE_ALL)
+COMPATIBLE_IOCTL(DM_DEV_CREATE)
+COMPATIBLE_IOCTL(DM_DEV_REMOVE)
+COMPATIBLE_IOCTL(DM_TABLE_LOAD)
+COMPATIBLE_IOCTL(DM_DEV_SUSPEND)
+COMPATIBLE_IOCTL(DM_DEV_RENAME)
+COMPATIBLE_IOCTL(DM_TABLE_DEPS)
+COMPATIBLE_IOCTL(DM_DEV_STATUS)
+COMPATIBLE_IOCTL(DM_TABLE_STATUS)
+COMPATIBLE_IOCTL(DM_DEV_WAIT)
+COMPATIBLE_IOCTL(DM_LIST_DEVICES)
+COMPATIBLE_IOCTL(DM_TABLE_CLEAR)
+#endif /* CONFIG_BLK_DEV_DM */
 #if defined(CONFIG_DRM) || defined(CONFIG_DRM_MODULE)
 COMPATIBLE_IOCTL(DRM_IOCTL_GET_MAGIC)
 COMPATIBLE_IOCTL(DRM_IOCTL_IRQ_BUSID)
--- diff/arch/ppc64/kernel/ioctl32.c	2003-08-26 13:50:04.000000000 +0100
+++ source/arch/ppc64/kernel/ioctl32.c	2003-12-09 11:04:13.000000000 +0000
@@ -66,6 +66,7 @@
 #if defined(CONFIG_BLK_DEV_LVM) || defined(CONFIG_BLK_DEV_LVM_MODULE)
 #include <linux/lvm.h>
 #endif /* LVM */
+#include <linux/dm-ioctl.h>
 
 #include <scsi/scsi.h>
 /* Ugly hack. */
@@ -4435,6 +4436,22 @@
 COMPATIBLE_IOCTL(NBD_PRINT_DEBUG),
 COMPATIBLE_IOCTL(NBD_SET_SIZE_BLOCKS),
 COMPATIBLE_IOCTL(NBD_DISCONNECT),
+/* device-mapper */
+#if defined(CONFIG_BLK_DEV_DM) || defined(CONFIG_BLK_DEV_DM_MODULE)
+COMPATIBLE_IOCTL(DM_VERSION),
+COMPATIBLE_IOCTL(DM_REMOVE_ALL),
+COMPATIBLE_IOCTL(DM_DEV_CREATE),
+COMPATIBLE_IOCTL(DM_DEV_REMOVE),
+COMPATIBLE_IOCTL(DM_TABLE_LOAD),
+COMPATIBLE_IOCTL(DM_DEV_SUSPEND),
+COMPATIBLE_IOCTL(DM_DEV_RENAME),
+COMPATIBLE_IOCTL(DM_TABLE_DEPS),
+COMPATIBLE_IOCTL(DM_DEV_STATUS),
+COMPATIBLE_IOCTL(DM_TABLE_STATUS),
+COMPATIBLE_IOCTL(DM_DEV_WAIT),
+COMPATIBLE_IOCTL(DM_LIST_DEVICES),
+COMPATIBLE_IOCTL(DM_TABLE_CLEAR),
+#endif /* CONFIG_BLK_DEV_DM */
 /* Remove *PRIVATE in 2.5 */
 COMPATIBLE_IOCTL(SIOCDEVPRIVATE),
 COMPATIBLE_IOCTL(SIOCDEVPRIVATE+1),
--- diff/arch/s390x/kernel/ioctl32.c	2003-08-26 13:50:04.000000000 +0100
+++ source/arch/s390x/kernel/ioctl32.c	2003-12-09 11:04:13.000000000 +0000
@@ -30,6 +30,7 @@
 #include <linux/blk.h>
 #include <linux/elevator.h>
 #include <linux/raw.h>
+#include <linux/dm-ioctl.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
 #include <asm/dasd.h>
@@ -627,6 +628,20 @@
 
 	IOCTL32_DEFAULT(SIOCGSTAMP),
 
+	IOCTL32_DEFAULT(DM_VERSION),
+	IOCTL32_DEFAULT(DM_REMOVE_ALL),
+	IOCTL32_DEFAULT(DM_DEV_CREATE),
+	IOCTL32_DEFAULT(DM_DEV_REMOVE),
+	IOCTL32_DEFAULT(DM_TABLE_LOAD),
+	IOCTL32_DEFAULT(DM_DEV_SUSPEND),
+	IOCTL32_DEFAULT(DM_DEV_RENAME),
+	IOCTL32_DEFAULT(DM_TABLE_DEPS),
+	IOCTL32_DEFAULT(DM_DEV_STATUS),
+	IOCTL32_DEFAULT(DM_TABLE_STATUS),
+	IOCTL32_DEFAULT(DM_DEV_WAIT),
+	IOCTL32_DEFAULT(DM_LIST_DEVICES),
+	IOCTL32_DEFAULT(DM_TABLE_CLEAR),
+
 	IOCTL32_DEFAULT(LOOP_SET_FD),
 	IOCTL32_DEFAULT(LOOP_CLR_FD),
 
--- diff/arch/sparc64/kernel/ioctl32.c	2003-12-09 10:25:25.000000000 +0000
+++ source/arch/sparc64/kernel/ioctl32.c	2003-12-09 11:04:13.000000000 +0000
@@ -56,6 +56,7 @@
 #if defined(CONFIG_BLK_DEV_LVM) || defined(CONFIG_BLK_DEV_LVM_MODULE)
 #include <linux/lvm.h>
 #endif /* LVM */
+#include <linux/dm-ioctl.h>
 
 #include <scsi/scsi.h>
 /* Ugly hack. */
@@ -5086,6 +5087,22 @@
 COMPATIBLE_IOCTL(NBD_PRINT_DEBUG)
 COMPATIBLE_IOCTL(NBD_SET_SIZE_BLOCKS)
 COMPATIBLE_IOCTL(NBD_DISCONNECT)
+/* device-mapper */
+#if defined(CONFIG_BLK_DEV_DM) || defined(CONFIG_BLK_DEV_DM_MODULE)
+COMPATIBLE_IOCTL(DM_VERSION)
+COMPATIBLE_IOCTL(DM_REMOVE_ALL)
+COMPATIBLE_IOCTL(DM_DEV_CREATE)
+COMPATIBLE_IOCTL(DM_DEV_REMOVE)
+COMPATIBLE_IOCTL(DM_TABLE_LOAD)
+COMPATIBLE_IOCTL(DM_DEV_SUSPEND)
+COMPATIBLE_IOCTL(DM_DEV_RENAME)
+COMPATIBLE_IOCTL(DM_TABLE_DEPS)
+COMPATIBLE_IOCTL(DM_DEV_STATUS)
+COMPATIBLE_IOCTL(DM_TABLE_STATUS)
+COMPATIBLE_IOCTL(DM_DEV_WAIT)
+COMPATIBLE_IOCTL(DM_LIST_DEVICES)
+COMPATIBLE_IOCTL(DM_TABLE_CLEAR)
+#endif /* CONFIG_BLK_DEV_DM */
 /* Linux-1394 */
 #if defined(CONFIG_IEEE1394) || defined(CONFIG_IEEE1394_MODULE)
 COMPATIBLE_IOCTL(AMDTP_IOC_CHANNEL)
--- diff/arch/x86_64/ia32/ia32_ioctl.c	2003-12-09 10:25:25.000000000 +0000
+++ source/arch/x86_64/ia32/ia32_ioctl.c	2003-12-09 11:04:14.000000000 +0000
@@ -67,6 +67,7 @@
 #define max max
 #include <linux/lvm.h>
 #endif /* LVM */
+#include <linux/dm-ioctl.h>
 
 #include <scsi/scsi.h>
 /* Ugly hack. */
@@ -4051,6 +4052,22 @@
 COMPATIBLE_IOCTL(LV_BMAP)
 COMPATIBLE_IOCTL(LV_SNAPSHOT_USE_RATE)
 #endif /* LVM */
+/* Device-Mapper */
+#if defined(CONFIG_BLK_DEV_DM) || defined(CONFIG_BLK_DEV_DM_MODULE)
+COMPATIBLE_IOCTL(DM_VERSION)
+COMPATIBLE_IOCTL(DM_REMOVE_ALL)
+COMPATIBLE_IOCTL(DM_DEV_CREATE)
+COMPATIBLE_IOCTL(DM_DEV_REMOVE)
+COMPATIBLE_IOCTL(DM_TABLE_LOAD)
+COMPATIBLE_IOCTL(DM_DEV_SUSPEND)
+COMPATIBLE_IOCTL(DM_DEV_RENAME)
+COMPATIBLE_IOCTL(DM_TABLE_DEPS)
+COMPATIBLE_IOCTL(DM_DEV_STATUS)
+COMPATIBLE_IOCTL(DM_TABLE_STATUS)
+COMPATIBLE_IOCTL(DM_DEV_WAIT)
+COMPATIBLE_IOCTL(DM_LIST_DEVICES)
+COMPATIBLE_IOCTL(DM_TABLE_CLEAR)
+#endif /* CONFIG_BLK_DEV_DM */
 #ifdef CONFIG_AUTOFS_FS
 COMPATIBLE_IOCTL(AUTOFS_IOC_READY)
 COMPATIBLE_IOCTL(AUTOFS_IOC_FAIL)
--- diff/drivers/md/Makefile	2003-12-09 11:03:47.000000000 +0000
+++ source/drivers/md/Makefile	2003-12-09 11:02:02.000000000 +0000
@@ -8,7 +8,8 @@
 
 list-multi	:= lvm-mod.o dm-mod.o dm-mirror-mod.o
 lvm-mod-objs	:= lvm.o lvm-snap.o lvm-fs.o
-dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o
+dm-mod-objs	:= dm.o dm-table.o dm-target.o dm-linear.o dm-stripe.o \
+		   dm-ioctl.o
 
 # Note: link order is important.  All raid personalities
 # and xor.o must come before md.o, as they each initialise 
--- diff/drivers/md/dm-ioctl.c	1970-01-01 01:00:00.000000000 +0100
+++ source/drivers/md/dm-ioctl.c	2003-12-09 11:01:41.000000000 +0000
@@ -0,0 +1,1284 @@
+/*
+ * Copyright (C) 2001, 2002 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/miscdevice.h>
+#include <linux/dm-ioctl.h>
+#include <linux/init.h>
+#include <linux/wait.h>
+#include <linux/blk.h>
+#include <linux/slab.h>
+
+#include <asm/uaccess.h>
+
+#define DM_DRIVER_EMAIL "dm@uk.sistina.com"
+
+/*-----------------------------------------------------------------
+ * The ioctl interface needs to be able to look up devices by
+ * name or uuid.
+ *---------------------------------------------------------------*/
+struct hash_cell {
+	struct list_head name_list;
+	struct list_head uuid_list;
+
+	char *name;
+	char *uuid;
+	struct mapped_device *md;
+	struct dm_table *new_map;
+
+	/* I hate devfs */
+	devfs_handle_t devfs_entry;
+};
+
+#define NUM_BUCKETS 64
+#define MASK_BUCKETS (NUM_BUCKETS - 1)
+static struct list_head _name_buckets[NUM_BUCKETS];
+static struct list_head _uuid_buckets[NUM_BUCKETS];
+
+static devfs_handle_t _dev_dir;
+void dm_hash_remove_all(void);
+
+/*
+ * Guards access to both hash tables.
+ */
+static DECLARE_RWSEM(_hash_lock);
+
+static void init_buckets(struct list_head *buckets)
+{
+	unsigned int i;
+
+	for (i = 0; i < NUM_BUCKETS; i++)
+		INIT_LIST_HEAD(buckets + i);
+}
+
+int dm_hash_init(void)
+{
+	init_buckets(_name_buckets);
+	init_buckets(_uuid_buckets);
+	_dev_dir = devfs_mk_dir(0, DM_DIR, NULL);
+	return 0;
+}
+
+void dm_hash_exit(void)
+{
+	dm_hash_remove_all();
+	devfs_unregister(_dev_dir);
+}
+
+/*-----------------------------------------------------------------
+ * Hash function:
+ * We're not really concerned with the str hash function being
+ * fast since it's only used by the ioctl interface.
+ *---------------------------------------------------------------*/
+static unsigned int hash_str(const char *str)
+{
+	const unsigned int hash_mult = 2654435387U;
+	unsigned int h = 0;
+
+	while (*str)
+		h = (h + (unsigned int) *str++) * hash_mult;
+
+	return h & MASK_BUCKETS;
+}
+
+/*-----------------------------------------------------------------
+ * Code for looking up a device by name
+ *---------------------------------------------------------------*/
+static struct hash_cell *__get_name_cell(const char *str)
+{
+	struct list_head *tmp;
+	struct hash_cell *hc;
+	unsigned int h = hash_str(str);
+
+	list_for_each (tmp, _name_buckets + h) {
+		hc = list_entry(tmp, struct hash_cell, name_list);
+		if (!strcmp(hc->name, str))
+			return hc;
+	}
+
+	return NULL;
+}
+
+static struct hash_cell *__get_uuid_cell(const char *str)
+{
+	struct list_head *tmp;
+	struct hash_cell *hc;
+	unsigned int h = hash_str(str);
+
+	list_for_each (tmp, _uuid_buckets + h) {
+		hc = list_entry(tmp, struct hash_cell, uuid_list);
+		if (!strcmp(hc->uuid, str))
+			return hc;
+	}
+
+	return NULL;
+}
+
+/*-----------------------------------------------------------------
+ * Inserting, removing and renaming a device.
+ *---------------------------------------------------------------*/
+static inline char *kstrdup(const char *str)
+{
+	char *r = kmalloc(strlen(str) + 1, GFP_KERNEL);
+	if (r)
+		strcpy(r, str);
+	return r;
+}
+
+static struct hash_cell *alloc_cell(const char *name, const char *uuid,
+				    struct mapped_device *md)
+{
+	struct hash_cell *hc;
+
+	hc = kmalloc(sizeof(*hc), GFP_KERNEL);
+	if (!hc)
+		return NULL;
+
+	hc->name = kstrdup(name);
+	if (!hc->name) {
+		kfree(hc);
+		return NULL;
+	}
+
+	if (!uuid)
+		hc->uuid = NULL;
+
+	else {
+		hc->uuid = kstrdup(uuid);
+		if (!hc->uuid) {
+			kfree(hc->name);
+			kfree(hc);
+			return NULL;
+		}
+	}
+
+	INIT_LIST_HEAD(&hc->name_list);
+	INIT_LIST_HEAD(&hc->uuid_list);
+	hc->md = md;
+	hc->new_map = NULL;
+	return hc;
+}
+
+static void free_cell(struct hash_cell *hc)
+{
+	if (hc) {
+		kfree(hc->name);
+		kfree(hc->uuid);
+		kfree(hc);
+	}
+}
+
+/*
+ * devfs stuff.
+ */
+static int register_with_devfs(struct hash_cell *hc)
+{
+	kdev_t dev = dm_kdev(hc->md);
+
+	hc->devfs_entry =
+	    devfs_register(_dev_dir, hc->name, DEVFS_FL_CURRENT_OWNER,
+			   major(dev), minor(dev),
+			   S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP,
+			   &dm_blk_dops, NULL);
+
+	return 0;
+}
+
+static int unregister_with_devfs(struct hash_cell *hc)
+{
+	devfs_unregister(hc->devfs_entry);
+	return 0;
+}
+
+/*
+ * The kdev_t and uuid of a device can never change once it is
+ * initially inserted.
+ */
+int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md)
+{
+	struct hash_cell *cell;
+
+	/*
+	 * Allocate the new cells.
+	 */
+	cell = alloc_cell(name, uuid, md);
+	if (!cell)
+		return -ENOMEM;
+
+	/*
+	 * Insert the cell into both hash tables.
+	 */
+	down_write(&_hash_lock);
+	if (__get_name_cell(name))
+		goto bad;
+
+	list_add(&cell->name_list, _name_buckets + hash_str(name));
+
+	if (uuid) {
+		if (__get_uuid_cell(uuid)) {
+			list_del(&cell->name_list);
+			goto bad;
+		}
+		list_add(&cell->uuid_list, _uuid_buckets + hash_str(uuid));
+	}
+	register_with_devfs(cell);
+	dm_get(md);
+	up_write(&_hash_lock);
+
+	return 0;
+
+      bad:
+	up_write(&_hash_lock);
+	free_cell(cell);
+	return -EBUSY;
+}
+
+void __hash_remove(struct hash_cell *hc)
+{
+	/* remove from the dev hash */
+	list_del(&hc->uuid_list);
+	list_del(&hc->name_list);
+	unregister_with_devfs(hc);
+	dm_put(hc->md);
+	if (hc->new_map)
+		dm_table_put(hc->new_map);
+	free_cell(hc);
+}
+
+void dm_hash_remove_all(void)
+{
+	int i;
+	struct hash_cell *hc;
+	struct list_head *tmp, *n;
+
+	down_write(&_hash_lock);
+	for (i = 0; i < NUM_BUCKETS; i++) {
+		list_for_each_safe (tmp, n, _name_buckets + i) {
+			hc = list_entry(tmp, struct hash_cell, name_list);
+			__hash_remove(hc);
+		}
+	}
+	up_write(&_hash_lock);
+}
+
+int dm_hash_rename(const char *old, const char *new)
+{
+	char *new_name, *old_name;
+	struct hash_cell *hc;
+
+	/*
+	 * duplicate new.
+	 */
+	new_name = kstrdup(new);
+	if (!new_name)
+		return -ENOMEM;
+
+	down_write(&_hash_lock);
+
+	/*
+	 * Is new free ?
+	 */
+	hc = __get_name_cell(new);
+	if (hc) {
+		DMWARN("asked to rename to an already existing name %s -> %s",
+		       old, new);
+		up_write(&_hash_lock);
+		kfree(new_name);
+		return -EBUSY;
+	}
+
+	/*
+	 * Is there such a device as 'old' ?
+	 */
+	hc = __get_name_cell(old);
+	if (!hc) {
+		DMWARN("asked to rename a non existent device %s -> %s",
+		       old, new);
+		up_write(&_hash_lock);
+		kfree(new_name);
+		return -ENXIO;
+	}
+
+	/*
+	 * rename and move the name cell.
+	 */
+	list_del(&hc->name_list);
+	old_name = hc->name;
+	hc->name = new_name;
+	list_add(&hc->name_list, _name_buckets + hash_str(new_name));
+
+	/* rename the device node in devfs */
+	unregister_with_devfs(hc);
+	register_with_devfs(hc);
+
+	up_write(&_hash_lock);
+	kfree(old_name);
+	return 0;
+}
+
+/*-----------------------------------------------------------------
+ * Implementation of the ioctl commands
+ *---------------------------------------------------------------*/
+/*
+ * All the ioctl commands get dispatched to functions with this
+ * prototype.
+ */
+typedef int (*ioctl_fn)(struct dm_ioctl *param, size_t param_size);
+
+static int remove_all(struct dm_ioctl *param, size_t param_size)
+{
+	dm_hash_remove_all();
+	param->data_size = 0;
+	return 0;
+}
+
+/*
+ * Round up the ptr to an 8-byte boundary.
+ */
+#define ALIGN_MASK 7
+static inline void *align_ptr(void *ptr)
+{
+	return (void *) (((size_t) (ptr + ALIGN_MASK)) & ~ALIGN_MASK);
+}
+
+/*
+ * Retrieves the data payload buffer from an already allocated
+ * struct dm_ioctl.
+ */
+static void *get_result_buffer(struct dm_ioctl *param, size_t param_size,
+			       size_t *len)
+{
+	param->data_start = align_ptr(param + 1) - (void *) param;
+
+	if (param->data_start < param_size)
+		*len = param_size - param->data_start;
+	else
+		*len = 0;
+
+	return ((void *) param) + param->data_start;
+}
+
+static int list_devices(struct dm_ioctl *param, size_t param_size)
+{
+	unsigned int i;
+	struct hash_cell *hc;
+	size_t len, needed = 0;
+	struct dm_name_list *nl, *old_nl = NULL;
+
+	down_write(&_hash_lock);
+
+	/*
+	 * Loop through all the devices working out how much
+	 * space we need.
+	 */
+	for (i = 0; i < NUM_BUCKETS; i++) {
+		list_for_each_entry (hc, _name_buckets + i, name_list) {
+			needed += sizeof(struct dm_name_list);
+			needed += strlen(hc->name);
+			needed += ALIGN_MASK;
+		}
+	}
+
+	/*
+	 * Grab our output buffer.
+	 */
+	nl = get_result_buffer(param, param_size, &len);
+	if (len < needed) {
+		param->flags |= DM_BUFFER_FULL_FLAG;
+		goto out;
+	}
+	param->data_size = param->data_start + needed;
+
+	nl->dev = 0;	/* Flags no data */
+
+	/*
+	 * Now loop through filling out the names.
+	 */
+	for (i = 0; i < NUM_BUCKETS; i++) {
+		list_for_each_entry (hc, _name_buckets + i, name_list) {
+			if (old_nl)
+				old_nl->next = (uint32_t) ((void *) nl -
+							   (void *) old_nl);
+
+			nl->dev = dm_kdev(hc->md);
+			nl->next = 0;
+			strcpy(nl->name, hc->name);
+
+			old_nl = nl;
+			nl = align_ptr(((void *) ++nl) + strlen(hc->name) + 1);
+		}
+	}
+
+ out:
+	up_write(&_hash_lock);
+	return 0;
+}
+
+static int check_name(const char *name)
+{
+	if (strchr(name, '/')) {
+		DMWARN("invalid device name");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Fills in a dm_ioctl structure, ready for sending back to
+ * userland.
+ */
+static int __dev_status(struct mapped_device *md, struct dm_ioctl *param)
+{
+	kdev_t dev = dm_kdev(md);
+	struct dm_table *table;
+	struct block_device *bdev;
+
+	param->flags &= ~(DM_SUSPEND_FLAG | DM_READONLY_FLAG |
+			  DM_ACTIVE_PRESENT_FLAG);
+
+	if (dm_suspended(md))
+		param->flags |= DM_SUSPEND_FLAG;
+
+	param->dev = kdev_t_to_nr(dev);
+
+	if (is_read_only(dev))
+		param->flags |= DM_READONLY_FLAG;
+
+	param->event_nr = dm_get_event_nr(md);
+
+	table = dm_get_table(md);
+	if (table) {
+		param->flags |= DM_ACTIVE_PRESENT_FLAG;
+		param->target_count = dm_table_get_num_targets(table);
+		dm_table_put(table);
+	} else
+		param->target_count = 0;
+
+	bdev = bdget(param->dev);
+	if (!bdev)
+		return -ENXIO;
+	param->open_count = bdev->bd_openers;
+	bdput(bdev);
+
+	return 0;
+}
+
+static int dev_create(struct dm_ioctl *param, size_t param_size)
+{
+	int r;
+	kdev_t dev = 0;
+	struct mapped_device *md;
+
+	r = check_name(param->name);
+	if (r)
+		return r;
+
+	if (param->flags & DM_PERSISTENT_DEV_FLAG)
+		dev = to_kdev_t(param->dev);
+
+	r = dm_create(dev, &md);
+	if (r)
+		return r;
+
+	r = dm_hash_insert(param->name, *param->uuid ? param->uuid : NULL, md);
+	if (r) {
+		dm_put(md);
+		return r;
+	}
+
+	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
+
+	r = __dev_status(md, param);
+	dm_put(md);
+
+	return r;
+}
+
+/*
+ * Always use UUID for lookups if it's present, otherwise use name.
+ */
+static inline struct hash_cell *__find_device_hash_cell(struct dm_ioctl *param)
+{
+	return *param->uuid ?
+	    __get_uuid_cell(param->uuid) : __get_name_cell(param->name);
+}
+
+static inline struct mapped_device *find_device(struct dm_ioctl *param)
+{
+	struct hash_cell *hc;
+	struct mapped_device *md = NULL;
+
+	down_read(&_hash_lock);
+	hc = __find_device_hash_cell(param);
+	if (hc) {
+		md = hc->md;
+
+		/*
+		 * Sneakily write in both the name and the uuid
+		 * while we have the cell.
+		 */
+		strncpy(param->name, hc->name, sizeof(param->name));
+		if (hc->uuid)
+			strncpy(param->uuid, hc->uuid, sizeof(param->uuid) - 1);
+		else
+			param->uuid[0] = '\0';
+
+		if (hc->new_map)
+			param->flags |= DM_INACTIVE_PRESENT_FLAG;
+		else
+			param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
+
+		dm_get(md);
+	}
+	up_read(&_hash_lock);
+
+	return md;
+}
+
+static int dev_remove(struct dm_ioctl *param, size_t param_size)
+{
+	struct hash_cell *hc;
+
+	down_write(&_hash_lock);
+	hc = __find_device_hash_cell(param);
+
+	if (!hc) {
+		DMWARN("device doesn't appear to be in the dev hash table.");
+		up_write(&_hash_lock);
+		return -ENXIO;
+	}
+
+	__hash_remove(hc);
+	up_write(&_hash_lock);
+	param->data_size = 0;
+	return 0;
+}
+
+/*
+ * Check a string doesn't overrun the chunk of
+ * memory we copied from userland.
+ */
+static int invalid_str(char *str, void *end)
+{
+	while ((void *) str < end)
+		if (!*str++)
+			return 0;
+
+	return -EINVAL;
+}
+
+static int dev_rename(struct dm_ioctl *param, size_t param_size)
+{
+	int r;
+	char *new_name = (char *) param + param->data_start;
+
+	if (new_name < (char *) (param + 1) ||
+	    invalid_str(new_name, (void *) param + param_size)) {
+		DMWARN("Invalid new logical volume name supplied.");
+		return -EINVAL;
+	}
+
+	r = check_name(new_name);
+	if (r)
+		return r;
+
+	param->data_size = 0;
+	return dm_hash_rename(param->name, new_name);
+}
+
+static int do_suspend(struct dm_ioctl *param)
+{
+	int r = 0;
+	struct mapped_device *md;
+
+	md = find_device(param);
+	if (!md)
+		return -ENXIO;
+
+	if (!dm_suspended(md))
+		r = dm_suspend(md);
+
+	if (!r)
+		r = __dev_status(md, param);
+
+	dm_put(md);
+	return r;
+}
+
+static int do_resume(struct dm_ioctl *param)
+{
+	int r = 0;
+	struct hash_cell *hc;
+	struct mapped_device *md;
+	struct dm_table *new_map;
+
+	down_write(&_hash_lock);
+
+	hc = __find_device_hash_cell(param);
+	if (!hc) {
+		DMWARN("device doesn't appear to be in the dev hash table.");
+		up_write(&_hash_lock);
+		return -ENXIO;
+	}
+
+	md = hc->md;
+	dm_get(md);
+
+	new_map = hc->new_map;
+	hc->new_map = NULL;
+	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
+
+	up_write(&_hash_lock);
+
+	/* Do we need to load a new map ? */
+	if (new_map) {
+		/* Suspend if it isn't already suspended */
+		if (!dm_suspended(md))
+			dm_suspend(md);
+
+		r = dm_swap_table(md, new_map);
+		if (r) {
+			dm_put(md);
+			dm_table_put(new_map);
+			return r;
+		}
+
+		if (dm_table_get_mode(new_map) & FMODE_WRITE)
+			set_device_ro(dm_kdev(md), 0);
+		else
+			set_device_ro(dm_kdev(md), 1);
+
+		dm_table_put(new_map);
+	}
+
+	if (dm_suspended(md))
+		r = dm_resume(md);
+
+	if (!r)
+		r = __dev_status(md, param);
+
+	dm_put(md);
+	return r;
+}
+
+/*
+ * Set or unset the suspension state of a device.
+ * If the device already is in the requested state we just return its status.
+ */
+static int dev_suspend(struct dm_ioctl *param, size_t param_size)
+{
+	if (param->flags & DM_SUSPEND_FLAG)
+		return do_suspend(param);
+
+	return do_resume(param);
+}
+
+/*
+ * Copies device info back to user space, used by
+ * the create and info ioctls.
+ */
+static int dev_status(struct dm_ioctl *param, size_t param_size)
+{
+	int r;
+	struct mapped_device *md;
+
+	md = find_device(param);
+	if (!md)
+		return -ENXIO;
+
+	r = __dev_status(md, param);
+	dm_put(md);
+	return r;
+}
+
+/*
+ * Build up the status struct for each target
+ */
+static void retrieve_status(struct dm_table *table, struct dm_ioctl *param,
+			    size_t param_size)
+{
+	unsigned int i, num_targets;
+	struct dm_target_spec *spec;
+	char *outbuf, *outptr;
+	status_type_t type;
+	size_t remaining, len, used = 0;
+
+	outptr = outbuf = get_result_buffer(param, param_size, &len);
+
+	if (param->flags & DM_STATUS_TABLE_FLAG)
+		type = STATUSTYPE_TABLE;
+	else
+		type = STATUSTYPE_INFO;
+
+	/* Get all the target info */
+	num_targets = dm_table_get_num_targets(table);
+	for (i = 0; i < num_targets; i++) {
+		struct dm_target *ti = dm_table_get_target(table, i);
+
+		remaining = len - (outptr - outbuf);
+		if (remaining < sizeof(struct dm_target_spec)) {
+			param->flags |= DM_BUFFER_FULL_FLAG;
+			break;
+		}
+
+		spec = (struct dm_target_spec *) outptr;
+
+		spec->status = 0;
+		spec->sector_start = ti->begin;
+		spec->length = ti->len;
+		strncpy(spec->target_type, ti->type->name,
+			sizeof(spec->target_type));
+
+		outptr += sizeof(struct dm_target_spec);
+		remaining = len - (outptr - outbuf);
+
+		/* Get the status/table string from the target driver */
+		if (ti->type->status) {
+			if (ti->type->status(ti, type, outptr, remaining)) {
+				param->flags |= DM_BUFFER_FULL_FLAG;
+				break;
+			}
+		} else
+			outptr[0] = '\0';
+
+		outptr += strlen(outptr) + 1;
+		used = param->data_start + (outptr - outbuf);
+
+		align_ptr(outptr);
+		spec->next = outptr - outbuf;
+	}
+
+	if (used)
+		param->data_size = used;
+
+	param->target_count = num_targets;
+}
+
+/*
+ * Wait for a device to report an event
+ */
+static int dev_wait(struct dm_ioctl *param, size_t param_size)
+{
+	int r;
+	struct mapped_device *md;
+	struct dm_table *table;
+	DECLARE_WAITQUEUE(wq, current);
+
+	md = find_device(param);
+	if (!md)
+		return -ENXIO;
+
+	/*
+	 * Wait for a notification event
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+	if (!dm_add_wait_queue(md, &wq, param->event_nr)) {
+		schedule();
+		dm_remove_wait_queue(md, &wq);
+	}
+	set_current_state(TASK_RUNNING);
+
+	/*
+	 * The userland program is going to want to know what
+	 * changed to trigger the event, so we may as well tell
+	 * him and save an ioctl.
+	 */
+	r = __dev_status(md, param);
+	if (r)
+		goto out;
+
+	table = dm_get_table(md);
+	if (table) {
+		retrieve_status(table, param, param_size);
+		dm_table_put(table);
+	}
+
+ out:
+	dm_put(md);
+	return r;
+}
+
+static inline int get_mode(struct dm_ioctl *param)
+{
+	int mode = FMODE_READ | FMODE_WRITE;
+
+	if (param->flags & DM_READONLY_FLAG)
+		mode = FMODE_READ;
+
+	return mode;
+}
+
+static int next_target(struct dm_target_spec *last, uint32_t next, void *end,
+		       struct dm_target_spec **spec, char **target_params)
+{
+	*spec = (struct dm_target_spec *) ((unsigned char *) last + next);
+	*target_params = (char *) (*spec + 1);
+
+	if (*spec < (last + 1))
+		return -EINVAL;
+
+	return invalid_str(*target_params, end);
+}
+
+static int populate_table(struct dm_table *table, struct dm_ioctl *param,
+			  size_t param_size)
+{
+	int r;
+	unsigned int i = 0;
+	struct dm_target_spec *spec = (struct dm_target_spec *) param;
+	uint32_t next = param->data_start;
+	void *end = (void *) param + param_size;
+	char *target_params;
+
+	if (!param->target_count) {
+		DMWARN("populate_table: no targets specified");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < param->target_count; i++) {
+
+		r = next_target(spec, next, end, &spec, &target_params);
+		if (r) {
+			DMWARN("unable to find target");
+			return r;
+		}
+
+		r = dm_table_add_target(table, spec->target_type,
+					(sector_t) spec->sector_start,
+					(sector_t) spec->length,
+					target_params);
+		if (r) {
+			DMWARN("error adding target to table");
+			return r;
+		}
+
+		next = spec->next;
+	}
+
+	return dm_table_complete(table);
+}
+
+static int table_load(struct dm_ioctl *param, size_t param_size)
+{
+	int r;
+	struct hash_cell *hc;
+	struct dm_table *t;
+
+	r = dm_table_create(&t, get_mode(param), param->target_count);
+	if (r)
+		return r;
+
+	r = populate_table(t, param, param_size);
+	if (r) {
+		dm_table_put(t);
+		return r;
+	}
+
+	down_write(&_hash_lock);
+	hc = __find_device_hash_cell(param);
+	if (!hc) {
+		DMWARN("device doesn't appear to be in the dev hash table.");
+		up_write(&_hash_lock);
+		return -ENXIO;
+	}
+
+	if (hc->new_map)
+		dm_table_put(hc->new_map);
+	hc->new_map = t;
+	param->flags |= DM_INACTIVE_PRESENT_FLAG;
+
+	r = __dev_status(hc->md, param);
+	up_write(&_hash_lock);
+	return r;
+}
+
+static int table_clear(struct dm_ioctl *param, size_t param_size)
+{
+	int r;
+	struct hash_cell *hc;
+
+	down_write(&_hash_lock);
+
+	hc = __find_device_hash_cell(param);
+	if (!hc) {
+		DMWARN("device doesn't appear to be in the dev hash table.");
+		up_write(&_hash_lock);
+		return -ENXIO;
+	}
+
+	if (hc->new_map) {
+		dm_table_put(hc->new_map);
+		hc->new_map = NULL;
+	}
+
+	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
+
+	r = __dev_status(hc->md, param);
+	up_write(&_hash_lock);
+	return r;
+}
+
+/*
+ * Retrieves a list of devices used by a particular dm device.
+ */
+static void retrieve_deps(struct dm_table *table, struct dm_ioctl *param,
+			  size_t param_size)
+{
+	unsigned int count = 0;
+	struct list_head *tmp;
+	size_t len, needed;
+	struct dm_target_deps *deps;
+
+	deps = get_result_buffer(param, param_size, &len);
+
+	/*
+	 * Count the devices.
+	 */
+	list_for_each(tmp, dm_table_get_devices(table))
+		count++;
+
+	/*
+	 * Check we have enough space.
+	 */
+	needed = sizeof(*deps) + (sizeof(*deps->dev) * count);
+	if (len < needed) {
+		param->flags |= DM_BUFFER_FULL_FLAG;
+		return;
+	}
+
+	/*
+	 * Fill in the devices.
+	 */
+	deps->count = count;
+	count = 0;
+	list_for_each(tmp, dm_table_get_devices(table)) {
+		struct dm_dev *dd = list_entry(tmp, struct dm_dev, list);
+		deps->dev[count++] = dd->bdev->bd_dev;
+	}
+
+	param->data_size = param->data_start + needed;
+}
+
+static int table_deps(struct dm_ioctl *param, size_t param_size)
+{
+	int r;
+	struct mapped_device *md;
+	struct dm_table *table;
+
+	md = find_device(param);
+	if (!md)
+		return -ENXIO;
+
+	r = __dev_status(md, param);
+	if (r)
+		goto out;
+
+	table = dm_get_table(md);
+	if (table) {
+		retrieve_deps(table, param, param_size);
+		dm_table_put(table);
+	}
+
+ out:
+	dm_put(md);
+	return r;
+}
+
+/*
+ * Return the status of a device as a text string for each
+ * target.
+ */
+static int table_status(struct dm_ioctl *param, size_t param_size)
+{
+	int r;
+	struct mapped_device *md;
+	struct dm_table *table;
+
+	md = find_device(param);
+	if (!md)
+		return -ENXIO;
+
+	r = __dev_status(md, param);
+	if (r)
+		goto out;
+ 
+	table = dm_get_table(md);
+	if (table) {
+		retrieve_status(table, param, param_size);
+		dm_table_put(table);
+	}
+
+ out:
+	dm_put(md);
+	return r;
+}
+
+/*-----------------------------------------------------------------
+ * Implementation of open/close/ioctl on the special char
+ * device.
+ *---------------------------------------------------------------*/
+static ioctl_fn lookup_ioctl(unsigned int cmd)
+{
+	static struct {
+		int cmd;
+		ioctl_fn fn;
+	} _ioctls[] = {
+		{DM_VERSION_CMD, NULL},	/* version is dealt with elsewhere */
+		{DM_REMOVE_ALL_CMD, remove_all},
+		{DM_LIST_DEVICES_CMD, list_devices},
+
+		{DM_DEV_CREATE_CMD, dev_create},
+		{DM_DEV_REMOVE_CMD, dev_remove},
+		{DM_DEV_RENAME_CMD, dev_rename},
+		{DM_DEV_SUSPEND_CMD, dev_suspend},
+		{DM_DEV_STATUS_CMD, dev_status},
+		{DM_DEV_WAIT_CMD, dev_wait},
+
+		{DM_TABLE_LOAD_CMD, table_load},
+		{DM_TABLE_CLEAR_CMD, table_clear},
+		{DM_TABLE_DEPS_CMD, table_deps},
+		{DM_TABLE_STATUS_CMD, table_status}
+	};
+
+	return (cmd >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[cmd].fn;
+}
+
+/*
+ * As well as checking the version compatibility this always
+ * copies the kernel interface version out.
+ */
+static int check_version(unsigned int cmd, struct dm_ioctl *user)
+{
+	uint32_t version[3];
+	int r = 0;
+
+	if (copy_from_user(version, user->version, sizeof(version)))
+		return -EFAULT;
+
+	if ((DM_VERSION_MAJOR != version[0]) ||
+	    (DM_VERSION_MINOR < version[1])) {
+		DMWARN("ioctl interface mismatch: "
+		       "kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)",
+		       DM_VERSION_MAJOR, DM_VERSION_MINOR,
+		       DM_VERSION_PATCHLEVEL,
+		       version[0], version[1], version[2], cmd);
+		r = -EINVAL;
+	}
+
+	/*
+	 * Fill in the kernel version.
+	 */
+	version[0] = DM_VERSION_MAJOR;
+	version[1] = DM_VERSION_MINOR;
+	version[2] = DM_VERSION_PATCHLEVEL;
+	if (copy_to_user(user->version, version, sizeof(version)))
+		return -EFAULT;
+
+	return r;
+}
+
+static void free_params(struct dm_ioctl *param)
+{
+	vfree(param);
+}
+
+static int copy_params(struct dm_ioctl *user, struct dm_ioctl **param)
+{
+	struct dm_ioctl tmp, *dmi;
+
+	if (copy_from_user(&tmp, user, sizeof(tmp)))
+		return -EFAULT;
+
+	if (tmp.data_size < sizeof(tmp))
+		return -EINVAL;
+
+	dmi = (struct dm_ioctl *) vmalloc(tmp.data_size);
+	if (!dmi)
+		return -ENOMEM;
+
+	if (copy_from_user(dmi, user, tmp.data_size)) {
+		vfree(dmi);
+		return -EFAULT;
+	}
+
+	*param = dmi;
+	return 0;
+}
+
+static int validate_params(uint cmd, struct dm_ioctl *param)
+{
+	/* Always clear this flag */
+	param->flags &= ~DM_BUFFER_FULL_FLAG;
+
+	/* Ignores parameters */
+	if (cmd == DM_REMOVE_ALL_CMD || cmd == DM_LIST_DEVICES_CMD)
+		return 0;
+
+	/* Unless creating, either name or uuid but not both */
+	if (cmd != DM_DEV_CREATE_CMD) {
+		if ((!*param->uuid && !*param->name) ||
+		    (*param->uuid && *param->name)) {
+			DMWARN("one of name or uuid must be supplied, cmd(%u)",
+			       cmd);
+			return -EINVAL;
+		}
+	}
+
+	/* Ensure strings are terminated */
+	param->name[DM_NAME_LEN - 1] = '\0';
+	param->uuid[DM_UUID_LEN - 1] = '\0';
+
+	return 0;
+}
+
+static int ctl_ioctl(struct inode *inode, struct file *file,
+		     uint command, ulong u)
+{
+	int r = 0;
+	unsigned int cmd;
+	struct dm_ioctl *param;
+	struct dm_ioctl *user = (struct dm_ioctl *) u;
+	ioctl_fn fn = NULL;
+	size_t param_size;
+
+	/* only root can play with this */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (_IOC_TYPE(command) != DM_IOCTL)
+		return -ENOTTY;
+
+	cmd = _IOC_NR(command);
+
+	/*
+	 * Check the interface version passed in.  This also
+	 * writes out the kernel's interface version.
+	 */
+	r = check_version(cmd, user);
+	if (r)
+		return r;
+
+	/*
+	 * Nothing more to do for the version command.
+	 */
+	if (cmd == DM_VERSION_CMD)
+		return 0;
+
+	fn = lookup_ioctl(cmd);
+	if (!fn) {
+		DMWARN("dm_ctl_ioctl: unknown command 0x%x", command);
+		return -ENOTTY;
+	}
+
+	/*
+	 * FIXME: I don't like this, we're trying to avoid low
+	 * memory issues when a device is suspended.
+	 */
+	current->flags |= PF_MEMALLOC;
+
+	/*
+	 * Copy the parameters into kernel space.
+	 */
+	r = copy_params(user, &param);
+	if (r) {
+		current->flags &= ~PF_MEMALLOC;
+		return r;
+	}
+
+	r = validate_params(cmd, param);
+	if (r)
+		goto out;
+
+	param_size = param->data_size;
+	param->data_size = sizeof(*param);
+	r = fn(param, param_size);
+
+	/*
+	 * Copy the results back to userland.
+	 */
+	if (!r && copy_to_user(user, param, param->data_size))
+		r = -EFAULT;
+
+ out:
+	free_params(param);
+	current->flags &= ~PF_MEMALLOC;
+	return r;
+}
+
+static struct file_operations _ctl_fops = {
+	.ioctl	 = ctl_ioctl,
+	.owner	 = THIS_MODULE,
+};
+
+static devfs_handle_t _ctl_handle;
+
+static struct miscdevice _dm_misc = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name  = DM_NAME,
+	.fops  = &_ctl_fops
+};
+
+/*
+ * Create misc character device and link to DM_DIR/control.
+ */
+int __init dm_interface_init(void)
+{
+	int r;
+	char rname[64];
+
+	r = dm_hash_init();
+	if (r)
+		return r;
+
+	r = misc_register(&_dm_misc);
+	if (r) {
+		DMERR("misc_register failed for control device");
+		dm_hash_exit();
+		return r;
+	}
+
+	r = devfs_generate_path(_dm_misc.devfs_handle, rname + 3,
+				sizeof rname - 3);
+	if (r == -ENOSYS)
+		goto done;	/* devfs not present */
+
+	if (r < 0) {
+		DMERR("devfs_generate_path failed for control device");
+		goto failed;
+	}
+
+	strncpy(rname + r, "../", 3);
+	r = devfs_mk_symlink(NULL, DM_DIR "/control",
+			     DEVFS_FL_DEFAULT, rname + r, &_ctl_handle, NULL);
+	if (r) {
+		DMERR("devfs_mk_symlink failed for control device");
+		goto failed;
+	}
+	devfs_auto_unregister(_dm_misc.devfs_handle, _ctl_handle);
+
+      done:
+	DMINFO("%d.%d.%d%s initialised: %s", DM_VERSION_MAJOR,
+	       DM_VERSION_MINOR, DM_VERSION_PATCHLEVEL, DM_VERSION_EXTRA,
+	       DM_DRIVER_EMAIL);
+	return 0;
+
+      failed:
+	misc_deregister(&_dm_misc);
+	dm_hash_exit();
+	return r;
+}
+
+void dm_interface_exit(void)
+{
+	if (misc_deregister(&_dm_misc) < 0)
+		DMERR("misc_deregister failed for control device");
+
+	dm_hash_exit();
+}
--- diff/include/linux/dm-ioctl.h	1970-01-01 01:00:00.000000000 +0100
+++ source/include/linux/dm-ioctl.h	2003-12-09 11:01:41.000000000 +0000
@@ -0,0 +1,237 @@
+/*
+ * Copyright (C) 2001 - 2003 Sistina Software (UK) Limited.
+ *
+ * This file is released under the LGPL.
+ */
+
+#ifndef _LINUX_DM_IOCTL_H
+#define _LINUX_DM_IOCTL_H
+
+#include <linux/types.h>
+
+#define DM_DIR "mapper"		/* Slashes not supported */
+#define DM_MAX_TYPE_NAME 16
+#define DM_NAME_LEN 128
+#define DM_UUID_LEN 129
+
+/*
+ * A traditional ioctl interface for the device mapper.
+ *
+ * Each device can have two tables associated with it, an
+ * 'active' table which is the one currently used by io passing
+ * through the device, and an 'inactive' one which is a table
+ * that is being prepared as a replacement for the 'active' one.
+ *
+ * DM_VERSION:
+ * Just get the version information for the ioctl interface.
+ *
+ * DM_REMOVE_ALL:
+ * Remove all dm devices, destroy all tables.  Only really used
+ * for debug.
+ *
+ * DM_LIST_DEVICES:
+ * Get a list of all the dm device names.
+ *
+ * DM_DEV_CREATE:
+ * Create a new device, neither the 'active' or 'inactive' table
+ * slots will be filled.  The device will be in suspended state
+ * after creation, however any io to the device will get errored
+ * since it will be out-of-bounds.
+ *
+ * DM_DEV_REMOVE:
+ * Remove a device, destroy any tables.
+ *
+ * DM_DEV_RENAME:
+ * Rename a device.
+ *
+ * DM_SUSPEND:
+ * This performs both suspend and resume, depending which flag is
+ * passed in.
+ * Suspend: This command will not return until all pending io to
+ * the device has completed.  Further io will be deferred until
+ * the device is resumed.
+ * Resume: It is no longer an error to issue this command on an
+ * unsuspended device.  If a table is present in the 'inactive'
+ * slot, it will be moved to the active slot, then the old table
+ * from the active slot will be _destroyed_.  Finally the device
+ * is resumed.
+ *
+ * DM_DEV_STATUS:
+ * Retrieves the status for the table in the 'active' slot.
+ *
+ * DM_DEV_WAIT:
+ * Wait for a significant event to occur to the device.  This
+ * could either be caused by an event triggered by one of the
+ * targets of the table in the 'active' slot, or a table change.
+ *
+ * DM_TABLE_LOAD:
+ * Load a table into the 'inactive' slot for the device.  The
+ * device does _not_ need to be suspended prior to this command.
+ *
+ * DM_TABLE_CLEAR:
+ * Destroy any table in the 'inactive' slot (ie. abort).
+ *
+ * DM_TABLE_DEPS:
+ * Return a set of device dependencies for the 'active' table.
+ *
+ * DM_TABLE_STATUS:
+ * Return the targets status for the 'active' table.
+ */
+
+/*
+ * All ioctl arguments consist of a single chunk of memory, with
+ * this structure at the start.  If a uuid is specified any
+ * lookup (eg. for a DM_INFO) will be done on that, *not* the
+ * name.
+ */
+struct dm_ioctl {
+	/*
+	 * The version number is made up of three parts:
+	 * major - no backward or forward compatibility,
+	 * minor - only backwards compatible,
+	 * patch - both backwards and forwards compatible.
+	 *
+	 * All clients of the ioctl interface should fill in the
+	 * version number of the interface that they were
+	 * compiled with.
+	 *
+	 * All recognised ioctl commands (ie. those that don't
+	 * return -ENOTTY) fill out this field, even if the
+	 * command failed.
+	 */
+	uint32_t version[3];	/* in/out */
+	uint32_t data_size;	/* total size of data passed in
+				 * including this struct */
+
+	uint32_t data_start;	/* offset to start of data
+				 * relative to start of this struct */
+
+	uint32_t target_count;	/* in/out */
+	int32_t open_count;	/* out */
+	uint32_t flags;		/* in/out */
+	uint32_t event_nr;      /* in/out */
+	uint32_t padding;
+
+	uint64_t dev;		/* in/out */
+
+	char name[DM_NAME_LEN];	/* device name */
+	char uuid[DM_UUID_LEN];	/* unique identifier for
+				 * the block device */
+};
+
+/*
+ * Used to specify tables.  These structures appear after the
+ * dm_ioctl.
+ */
+struct dm_target_spec {
+	uint64_t sector_start;
+	uint64_t length;
+	int32_t status;		/* used when reading from kernel only */
+
+	/*
+	 * Offset in bytes (from the start of this struct) to
+	 * next target_spec.
+	 */
+	uint32_t next;
+
+	char target_type[DM_MAX_TYPE_NAME];
+
+	/*
+	 * Parameter string starts immediately after this object.
+	 * Be careful to add padding after string to ensure correct
+	 * alignment of subsequent dm_target_spec.
+	 */
+};
+
+/*
+ * Used to retrieve the target dependencies.
+ */
+struct dm_target_deps {
+	uint32_t count;		/* Array size */
+	uint32_t padding;	/* unused */
+	uint64_t dev[0];	/* out */
+};
+
+/*
+ * Used to get a list of all dm devices.
+ */
+struct dm_name_list {
+	uint64_t dev;
+	uint32_t next;		/* offset to the next record from
+				   the _start_ of this */
+	char name[0];
+};
+
+/*
+ * If you change this make sure you make the corresponding change
+ * to dm-ioctl.c:lookup_ioctl()
+ */
+enum {
+	/* Top level cmds */
+	DM_VERSION_CMD = 0,
+	DM_REMOVE_ALL_CMD,
+	DM_LIST_DEVICES_CMD,
+
+	/* device level cmds */
+	DM_DEV_CREATE_CMD,
+	DM_DEV_REMOVE_CMD,
+	DM_DEV_RENAME_CMD,
+	DM_DEV_SUSPEND_CMD,
+	DM_DEV_STATUS_CMD,
+	DM_DEV_WAIT_CMD,
+
+	/* Table level cmds */
+	DM_TABLE_LOAD_CMD,
+	DM_TABLE_CLEAR_CMD,
+	DM_TABLE_DEPS_CMD,
+	DM_TABLE_STATUS_CMD,
+};
+
+#define DM_IOCTL 0xfd
+
+#define DM_VERSION       _IOWR(DM_IOCTL, DM_VERSION_CMD, struct dm_ioctl)
+#define DM_REMOVE_ALL    _IOWR(DM_IOCTL, DM_REMOVE_ALL_CMD, struct dm_ioctl)
+#define DM_LIST_DEVICES  _IOWR(DM_IOCTL, DM_LIST_DEVICES_CMD, struct dm_ioctl)
+
+#define DM_DEV_CREATE    _IOWR(DM_IOCTL, DM_DEV_CREATE_CMD, struct dm_ioctl)
+#define DM_DEV_REMOVE    _IOWR(DM_IOCTL, DM_DEV_REMOVE_CMD, struct dm_ioctl)
+#define DM_DEV_RENAME    _IOWR(DM_IOCTL, DM_DEV_RENAME_CMD, struct dm_ioctl)
+#define DM_DEV_SUSPEND   _IOWR(DM_IOCTL, DM_DEV_SUSPEND_CMD, struct dm_ioctl)
+#define DM_DEV_STATUS    _IOWR(DM_IOCTL, DM_DEV_STATUS_CMD, struct dm_ioctl)
+#define DM_DEV_WAIT      _IOWR(DM_IOCTL, DM_DEV_WAIT_CMD, struct dm_ioctl)
+
+#define DM_TABLE_LOAD    _IOWR(DM_IOCTL, DM_TABLE_LOAD_CMD, struct dm_ioctl)
+#define DM_TABLE_CLEAR   _IOWR(DM_IOCTL, DM_TABLE_CLEAR_CMD, struct dm_ioctl)
+#define DM_TABLE_DEPS    _IOWR(DM_IOCTL, DM_TABLE_DEPS_CMD, struct dm_ioctl)
+#define DM_TABLE_STATUS  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, struct dm_ioctl)
+
+#define DM_VERSION_MAJOR	4
+#define DM_VERSION_MINOR	0
+#define DM_VERSION_PATCHLEVEL	5
+#define DM_VERSION_EXTRA	"-ioctl (2003-11-18)"
+
+/* Status bits */
+#define DM_READONLY_FLAG	(1 << 0) /* In/Out */
+#define DM_SUSPEND_FLAG		(1 << 1) /* In/Out */
+#define DM_PERSISTENT_DEV_FLAG	(1 << 3) /* In */
+
+/*
+ * Flag passed into ioctl STATUS command to get table information
+ * rather than current status.
+ */
+#define DM_STATUS_TABLE_FLAG	(1 << 4) /* In */
+
+/*
+ * Flags that indicate whether a table is present in either of
+ * the two table slots that a device has.
+ */
+#define DM_ACTIVE_PRESENT_FLAG   (1 << 5) /* Out */
+#define DM_INACTIVE_PRESENT_FLAG (1 << 6) /* Out */
+
+/*
+ * Indicates that the buffer passed in wasn't big enough for the
+ * results.
+ */
+#define DM_BUFFER_FULL_FLAG	(1 << 8) /* Out */
+
+#endif				/* _LINUX_DM_IOCTL_H */
