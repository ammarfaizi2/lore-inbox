Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264768AbSJORzL>; Tue, 15 Oct 2002 13:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264771AbSJORzL>; Tue, 15 Oct 2002 13:55:11 -0400
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:41746 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264768AbSJORw5>; Tue, 15 Oct 2002 13:52:57 -0400
Date: Tue, 15 Oct 2002 18:58:58 +0100
To: Linux Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>
Subject: [PATCH] Device-mapper submission 6/7
Message-ID: <20021015175858.GA28170@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Device mapper]
Provide a traditional ioctl based interface to control device-mapper
from userland.

--- a/arch/mips64/kernel/ioctl32.c	Tue Oct 15 18:24:39 2002
+++ b/arch/mips64/kernel/ioctl32.c	Tue Oct 15 18:24:39 2002
@@ -27,6 +27,7 @@
 #include <linux/auto_fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/raid/md_u.h>
+#include <linux/dm-ioctl.h>
 #include <asm/types.h>
 #include <asm/uaccess.h>
 
@@ -790,6 +791,20 @@
 	IOCTL32_DEFAULT(STOP_ARRAY_RO),
 	IOCTL32_DEFAULT(RESTART_ARRAY_RW),
 #endif /* CONFIG_MD */
+
+#if defined(CONFIG_BLK_DEV_DM) || defined(CONFIG_BLK_DEV_DM_MODULE)
+	IOCTL32_DEFAULT(DM_VERSION),
+	IOCTL32_DEFAULT(DM_REMOVE_ALL),
+	IOCTL32_DEFAULT(DM_DEV_CREATE),
+	IOCTL32_DEFAULT(DM_DEV_REMOVE),
+	IOCTL32_DEFAULT(DM_DEV_RELOAD),
+	IOCTL32_DEFAULT(DM_DEV_SUSPEND),
+	IOCTL32_DEFAULT(DM_DEV_RENAME),
+	IOCTL32_DEFAULT(DM_DEV_DEPS),
+	IOCTL32_DEFAULT(DM_DEV_STATUS),
+	IOCTL32_DEFAULT(DM_TARGET_STATUS),
+	IOCTL32_DEFAULT(DM_TARGET_WAIT),
+#endif /* CONFIG_BLK_DEV_DM */
 
 	IOCTL32_DEFAULT(MTIOCTOP),			/* mtio.h ioctls  */
 	IOCTL32_HANDLER(MTIOCGET32, mt_ioctl_trans),
--- a/arch/ppc64/kernel/ioctl32.c	Tue Oct 15 18:24:39 2002
+++ b/arch/ppc64/kernel/ioctl32.c	Tue Oct 15 18:24:39 2002
@@ -66,6 +66,7 @@
 #if defined(CONFIG_BLK_DEV_LVM) || defined(CONFIG_BLK_DEV_LVM_MODULE)
 #include <linux/lvm.h>
 #endif /* LVM */
+#include <linux/dm-ioctl.h>
 
 #include <scsi/scsi.h>
 /* Ugly hack. */
@@ -4375,6 +4376,18 @@
 COMPATIBLE_IOCTL(NBD_PRINT_DEBUG),
 COMPATIBLE_IOCTL(NBD_SET_SIZE_BLOCKS),
 COMPATIBLE_IOCTL(NBD_DISCONNECT),
+/* device-mapper */
+COMPATIBLE_IOCTL(DM_VERSION),
+COMPATIBLE_IOCTL(DM_REMOVE_ALL),
+COMPATIBLE_IOCTL(DM_DEV_CREATE),
+COMPATIBLE_IOCTL(DM_DEV_REMOVE),
+COMPATIBLE_IOCTL(DM_DEV_RELOAD),
+COMPATIBLE_IOCTL(DM_DEV_SUSPEND),
+COMPATIBLE_IOCTL(DM_DEV_RENAME),
+COMPATIBLE_IOCTL(DM_DEV_DEPS),
+COMPATIBLE_IOCTL(DM_DEV_STATUS),
+COMPATIBLE_IOCTL(DM_TARGET_STATUS),
+COMPATIBLE_IOCTL(DM_TARGET_WAIT),
 /* And these ioctls need translation */
 HANDLE_IOCTL(MEMREADOOB32, mtd_rw_oob),
 HANDLE_IOCTL(MEMWRITEOOB32, mtd_rw_oob),
--- a/arch/s390x/kernel/ioctl32.c	Tue Oct 15 18:24:39 2002
+++ b/arch/s390x/kernel/ioctl32.c	Tue Oct 15 18:24:39 2002
@@ -25,6 +25,7 @@
 #include <linux/ext2_fs.h>
 #include <linux/hdreg.h>
 #include <linux/if_bonding.h>
+#include <linux/dm-ioctl.h>
 #include <linux/blkpg.h>
 #include <linux/blk.h>
 #include <linux/loop.h>
@@ -897,6 +898,18 @@
 
 	IOCTL32_DEFAULT(SIOCGSTAMP),
 
+	IOCTL32_DEFAULT(DM_VERSION),
+	IOCTL32_DEFAULT(DM_REMOVE_ALL),
+	IOCTL32_DEFAULT(DM_DEV_CREATE),
+	IOCTL32_DEFAULT(DM_DEV_REMOVE),
+	IOCTL32_DEFAULT(DM_DEV_RELOAD),
+	IOCTL32_DEFAULT(DM_DEV_SUSPEND),
+	IOCTL32_DEFAULT(DM_DEV_RENAME),
+	IOCTL32_DEFAULT(DM_DEV_DEPS),
+	IOCTL32_DEFAULT(DM_DEV_STATUS),
+	IOCTL32_DEFAULT(DM_TARGET_STATUS),
+	IOCTL32_DEFAULT(DM_TARGET_WAIT),
+
 	IOCTL32_DEFAULT(LOOP_SET_FD),
 	IOCTL32_DEFAULT(LOOP_CLR_FD),
 
@@ -943,6 +956,18 @@
 	IOCTL32_HANDLER(EXT2_IOC32_SETFLAGS, do_ext2_ioctl),
 	IOCTL32_HANDLER(EXT2_IOC32_GETVERSION, do_ext2_ioctl),
 	IOCTL32_HANDLER(EXT2_IOC32_SETVERSION, do_ext2_ioctl),
+
+	IOCTL32_DEFAULT(DM_VERSION),
+	IOCTL32_DEFAULT(DM_REMOVE_ALL),
+	IOCTL32_DEFAULT(DM_DEV_CREATE),
+	IOCTL32_DEFAULT(DM_DEV_REMOVE),
+	IOCTL32_DEFAULT(DM_DEV_RELOAD),
+	IOCTL32_DEFAULT(DM_DEV_SUSPEND),
+	IOCTL32_DEFAULT(DM_DEV_RENAME),
+	IOCTL32_DEFAULT(DM_DEV_DEPS),
+	IOCTL32_DEFAULT(DM_DEV_STATUS),
+	IOCTL32_DEFAULT(DM_TARGET_STATUS),
+	IOCTL32_DEFAULT(DM_TARGET_WAIT),
 
 	IOCTL32_HANDLER(LOOP_SET_STATUS, loop_status),
 	IOCTL32_HANDLER(LOOP_GET_STATUS, loop_status),
--- a/arch/sparc64/kernel/ioctl32.c	Tue Oct 15 18:24:39 2002
+++ b/arch/sparc64/kernel/ioctl32.c	Tue Oct 15 18:24:39 2002
@@ -55,6 +55,7 @@
 #if defined(CONFIG_BLK_DEV_LVM) || defined(CONFIG_BLK_DEV_LVM_MODULE)
 #include <linux/lvm.h>
 #endif /* LVM */
+#include <linux/dm-ioctl.h>
 
 #include <scsi/scsi.h>
 /* Ugly hack. */
@@ -4982,6 +4983,19 @@
 COMPATIBLE_IOCTL(NBD_PRINT_DEBUG)
 COMPATIBLE_IOCTL(NBD_SET_SIZE_BLOCKS)
 COMPATIBLE_IOCTL(NBD_DISCONNECT)
+/* device-mapper */
+COMPATIBLE_IOCTL(DM_VERSION)
+COMPATIBLE_IOCTL(DM_REMOVE_ALL)
+COMPATIBLE_IOCTL(DM_DEV_CREATE)
+COMPATIBLE_IOCTL(DM_DEV_REMOVE)
+COMPATIBLE_IOCTL(DM_DEV_RELOAD)
+COMPATIBLE_IOCTL(DM_DEV_SUSPEND)
+COMPATIBLE_IOCTL(DM_DEV_RENAME)
+COMPATIBLE_IOCTL(DM_DEV_DEPS)
+COMPATIBLE_IOCTL(DM_DEV_STATUS)
+COMPATIBLE_IOCTL(DM_TARGET_STATUS)
+COMPATIBLE_IOCTL(DM_TARGET_WAIT)
+
 /* And these ioctls need translation */
 HANDLE_IOCTL(MEMREADOOB32, mtd_rw_oob)
 HANDLE_IOCTL(MEMWRITEOOB32, mtd_rw_oob)
--- a/drivers/md/Makefile	Tue Oct 15 18:24:39 2002
+++ b/drivers/md/Makefile	Tue Oct 15 18:24:39 2002
@@ -5,7 +5,7 @@
 export-objs	:= md.o xor.o dm-table.o dm-target.o
 lvm-mod-objs	:= lvm.o lvm-snap.o lvm-fs.o
 dm-mod-objs	:= dm.o dm-hash.o dm-table.o dm-target.o dm-linear.o \
-		   dm-stripe.o
+		   dm-stripe.o dm-ioctl.o
 
 # Note: link order is important.  All raid personalities
 # and xor.o must come before md.o, as they each initialise 
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/md/dm-ioctl.c	Tue Oct 15 18:24:39 2002
@@ -0,0 +1,810 @@
+/*
+ * Copyright (C) 2001 Sistina Software (UK) Limited.
+ *
+ * This file is released under the GPL.
+ */
+
+#include "dm.h"
+
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/compatmac.h>
+#include <linux/miscdevice.h>
+#include <linux/dm-ioctl.h>
+#include <linux/init.h>
+#include <linux/wait.h>
+
+/*-----------------------------------------------------------------
+ * Implementation of the ioctl commands
+ *---------------------------------------------------------------*/
+
+/*
+ * All the ioctl commands get dispatched to functions with this
+ * prototype.
+ */
+typedef int (*ioctl_fn)(struct dm_ioctl *param, struct dm_ioctl *user);
+
+/*
+ * This is really a debug only call.
+ */
+static int remove_all(struct dm_ioctl *param, struct dm_ioctl *user)
+{
+	dm_destroy_all();
+	return 0;
+}
+
+/*
+ * Check a string doesn't overrun the chunk of
+ * memory we copied from userland.
+ */
+static int valid_str(char *str, void *begin, void *end)
+{
+	while (((void *) str >= begin) && ((void *) str < end))
+		if (!*str++)
+			return 0;
+
+	return -EINVAL;
+}
+
+static int next_target(struct dm_target_spec *last, uint32_t next,
+		       void *begin, void *end,
+		       struct dm_target_spec **spec, char **params)
+{
+	*spec = (struct dm_target_spec *)
+	    ((unsigned char *) last + next);
+	*params = (char *) (*spec + 1);
+
+	if (*spec < (last + 1) || ((void *) *spec > end))
+		return -EINVAL;
+
+	return valid_str(*params, begin, end);
+}
+
+static int populate_table(struct dm_table *table, struct dm_ioctl *args)
+{
+	int i = 0, r, first = 1, argc;
+	struct dm_target_spec *spec;
+	char *params, *argv[MAX_ARGS];
+	void *begin, *end;
+	sector_t highs = 0;
+	struct dm_target ti;
+
+	if (!args->target_count) {
+		DMWARN("populate_table: no targets specified");
+		return -EINVAL;
+	}
+
+	begin = (void *) args;
+	end = begin + args->data_size;
+
+#define PARSE_ERROR(msg) {DMWARN(msg); return -EINVAL;}
+
+	for (i = 0; i < args->target_count; i++) {
+		memset(&ti, 0, sizeof(ti));
+		ti.table = table;
+		ti.error = "Unknown error";
+
+		if (first)
+			r = next_target((struct dm_target_spec *) args,
+					args->data_start,
+					begin, end, &spec, &params);
+		else
+			r = next_target(spec, spec->next, begin, end,
+					&spec, &params);
+
+		if (r)
+			PARSE_ERROR("unable to find target");
+
+		/* transfer begin and len into the target */
+		ti.begin = spec->sector_start;
+		ti.len = spec->length;
+
+		/* Look up the target type */
+		ti.type = dm_get_target_type(spec->target_type);
+		if (!ti.type)
+			PARSE_ERROR("unable to find target type");
+
+		/* Split up the parameter list */
+		if (split_args(MAX_ARGS, &argc, argv, params) < 0)
+			PARSE_ERROR("Too many arguments");
+
+		/* Build the target */
+		if (ti.type->ctr(&ti, argc, argv)) {
+			DMWARN("%s: target constructor failed", ti.error);
+			return -EINVAL;
+		}
+
+		/* Add the target to the table */
+		highs = spec->sector_start + (spec->length - 1);
+		if (dm_table_add_target(table, &ti))
+			PARSE_ERROR("internal error adding target to table");
+
+		first = 0;
+	}
+
+#undef PARSE_ERROR
+
+	r = dm_table_complete(table);
+	return r;
+}
+
+/*
+ * Round up the ptr to the next 'align' boundary.  Obviously
+ * 'align' must be a power of 2.
+ */
+static inline void *align_ptr(void *ptr, unsigned int align)
+{
+	align--;
+	return (void *) (((unsigned long) (ptr + align)) & ~align);
+}
+
+/*
+ * Copies a dm_ioctl and an optional additional payload to
+ * userland.
+ */
+static int results_to_user(struct dm_ioctl *user, struct dm_ioctl *param,
+			   void *data, uint32_t len)
+{
+	int r;
+	void *ptr = NULL;
+
+	if (data) {
+		ptr = align_ptr(user + 1, sizeof(unsigned long));
+		param->data_start = ptr - (void *) user;
+	}
+
+	/*
+	 * The version number has already been filled in, so we
+	 * just copy later fields.
+	 */
+	r = copy_to_user(&user->data_size, &param->data_size,
+			 sizeof(*param) - sizeof(param->version));
+	if (r)
+		return -EFAULT;
+
+	if (data) {
+		if (param->data_start + len > param->data_size)
+			return -ENOSPC;
+
+		if (copy_to_user(ptr, data, len))
+			r = -EFAULT;
+	}
+
+	return r;
+}
+
+/*
+ * Fills in a dm_ioctl structure, ready for sending back to
+ * userland.
+ */
+static void __info(struct mapped_device *md, struct dm_ioctl *param)
+{
+	param->flags = DM_EXISTS_FLAG;
+	if (test_bit(DMF_SUSPENDED, &md->flags))
+		param->flags |= DM_SUSPEND_FLAG;
+
+	if (test_bit(DMF_RO, &md->flags))
+		param->flags |= DM_READONLY_FLAG;
+
+	strncpy(param->name, md->name, sizeof(param->name));
+
+	if (md->uuid)
+		strncpy(param->uuid, md->uuid, sizeof(param->uuid) - 1);
+	else
+		param->uuid[0] = '\0';
+
+	param->open_count = md->use_count;
+	param->dev = kdev_t_to_nr(md->dev);
+	param->target_count = md->map->num_targets;
+}
+
+/*
+ * Always use UUID for lookups if it's present, otherwise use name.
+ */
+static inline struct mapped_device *find_device_r(struct dm_ioctl *param)
+{
+	return (*param->uuid ?
+		dm_get_uuid_r(param->uuid) :
+		dm_get_name_r(param->name));
+}
+
+static inline struct mapped_device *find_device_w(struct dm_ioctl *param)
+{
+	return (*param->uuid ?
+		dm_get_uuid_w(param->uuid) :
+		dm_get_name_w(param->name));
+}
+
+#define ALIGNMENT sizeof(int)
+static void *_align(void *ptr, unsigned int a)
+{
+	register unsigned long align = --a;
+
+	return (void *) (((unsigned long) ptr + align) & ~align);
+}
+
+/*
+ * Copies device info back to user space, used by
+ * the create and info ioctls.
+ */
+static int info(struct dm_ioctl *param, struct dm_ioctl *user)
+{
+	struct mapped_device *md;
+
+	param->flags = 0;
+
+	md = find_device_r(param);
+	if (!md)
+		/*
+		 * Device not found - returns cleared exists flag.
+		 */
+		goto out;
+
+	__info(md, param);
+	dm_put_r(md);
+
+      out:
+	return results_to_user(user, param, NULL, 0);
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
+static int create(struct dm_ioctl *param, struct dm_ioctl *user)
+{
+	int r, ro;
+	struct dm_table *t;
+	int minor;
+
+	r = dm_table_create(&t, get_mode(param));
+	if (r)
+		return r;
+
+	r = populate_table(t, param);
+	if (r) {
+		dm_table_destroy(t);
+		return r;
+	}
+
+	minor = (param->flags & DM_PERSISTENT_DEV_FLAG) ?
+		minor(to_kdev_t(param->dev)) : -1;
+
+	ro = (param->flags & DM_READONLY_FLAG) ? 1 : 0;
+
+	r = dm_create(param->name, param->uuid, minor, ro, t);
+	if (r) {
+		dm_table_destroy(t);
+		return r;
+	}
+
+	r = info(param, user);
+	return r;
+}
+
+
+
+/*
+ * Build up the status struct for each target
+ */
+static int __status(struct mapped_device *md, struct dm_ioctl *param,
+		    char *outbuf, int *len)
+{
+	int i;
+	struct dm_target_spec *spec;
+	uint64_t sector = 0LL;
+	char *outptr;
+	status_type_t type;
+
+	if (param->flags & DM_STATUS_TABLE_FLAG)
+		type = STATUSTYPE_TABLE;
+	else
+		type = STATUSTYPE_INFO;
+
+	outptr = outbuf;
+
+	/* Get all the target info */
+	for (i = 0; i < md->map->num_targets; i++) {
+		struct target_type *tt = md->map->targets[i].type;
+		sector_t high = md->map->highs[i];
+
+		if (outptr - outbuf +
+		    sizeof(struct dm_target_spec) > param->data_size)
+			    return -ENOMEM;
+
+		spec = (struct dm_target_spec *) outptr;
+
+		spec->status = 0;
+		spec->sector_start = sector;
+		spec->length = high - sector + 1;
+		strncpy(spec->target_type, tt->name, sizeof(spec->target_type));
+
+		outptr += sizeof(struct dm_target_spec);
+
+		/* Get the status/table string from the target driver */
+		if (tt->status)
+			tt->status(md->map->targets + i, type, outptr,
+				   outbuf + param->data_size - outptr);
+		else
+			outptr[0] = '\0';
+
+		outptr += strlen(outptr) + 1;
+		_align(outptr, ALIGNMENT);
+
+		sector = high + 1;
+
+		spec->next = outptr - outbuf;
+	}
+
+	param->target_count = md->map->num_targets;
+	*len = outptr - outbuf;
+
+	return 0;
+}
+
+/*
+ * Return the status of a device as a text string for each
+ * target.
+ */
+static int get_status(struct dm_ioctl *param, struct dm_ioctl *user)
+{
+	struct mapped_device *md;
+	int len = 0;
+	int ret;
+	char *outbuf = NULL;
+
+	md = find_device_r(param);
+	if (!md)
+		/*
+		 * Device not found - returns cleared exists flag.
+		 */
+		goto out;
+
+	/* We haven't a clue how long the resultant data will be so
+	   just allocate as much as userland has allowed us and make sure
+	   we don't overun it */
+	outbuf = kmalloc(param->data_size, GFP_KERNEL);
+	if (!outbuf)
+		goto out;
+	/*
+	 * Get the status of all targets
+	 */
+	__status(md, param, outbuf, &len);
+
+	/*
+	 * Setup the basic dm_ioctl structure.
+	 */
+	__info(md, param);
+
+      out:
+	if (md)
+		dm_put_r(md);
+
+	ret = results_to_user(user, param, outbuf, len);
+
+	if (outbuf)
+		kfree(outbuf);
+
+	return ret;
+}
+
+/*
+ * Wait for a device to report an event
+ */
+static int wait_device_event(struct dm_ioctl *param, struct dm_ioctl *user)
+{
+	struct mapped_device *md;
+	DECLARE_WAITQUEUE(wq, current);
+
+	md = find_device_r(param);
+	if (!md)
+		/*
+		 * Device not found - returns cleared exists flag.
+		 */
+		goto out;
+	/*
+	 * Setup the basic dm_ioctl structure.
+	 */
+	__info(md, param);
+
+	/*
+	 * Wait for a notification event
+	 */
+	set_current_state(TASK_INTERRUPTIBLE);
+	add_wait_queue(&md->map->eventq, &wq);
+
+	dm_put_r(md);
+
+	yield();
+	set_current_state(TASK_RUNNING);
+
+      out:
+	return results_to_user(user, param, NULL, 0);
+}
+
+/*
+ * Retrieves a list of devices used by a particular dm device.
+ */
+static int dep(struct dm_ioctl *param, struct dm_ioctl *user)
+{
+	int count, r;
+	struct mapped_device *md;
+	struct list_head *tmp;
+	size_t len = 0;
+	struct dm_target_deps *deps = NULL;
+
+	md = find_device_r(param);
+	if (!md)
+		goto out;
+
+	/*
+	 * Setup the basic dm_ioctl structure.
+	 */
+	__info(md, param);
+
+	/*
+	 * Count the devices.
+	 */
+	count = 0;
+	list_for_each(tmp, &md->map->devices)
+	    count++;
+
+	/*
+	 * Allocate a kernel space version of the dm_target_status
+	 * struct.
+	 */
+	if (array_too_big(sizeof(*deps), sizeof(*deps->dev), count)) {
+		dm_put_r(md);
+		return -ENOMEM;
+	}
+
+	len = sizeof(*deps) + (sizeof(*deps->dev) * count);
+	deps = kmalloc(len, GFP_KERNEL);
+	if (!deps) {
+		dm_put_r(md);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Fill in the devices.
+	 */
+	deps->count = count;
+	count = 0;
+	list_for_each(tmp, &md->map->devices) {
+		struct dm_dev *dd = list_entry(tmp, struct dm_dev, list);
+		deps->dev[count++] = kdev_t_to_nr(dd->dev);
+	}
+	dm_put_r(md);
+
+      out:
+	r = results_to_user(user, param, deps, len);
+
+	kfree(deps);
+	return r;
+}
+
+static int remove(struct dm_ioctl *param, struct dm_ioctl *user)
+{
+	int r;
+	struct mapped_device *md;
+
+	md = find_device_w(param);
+	if (!md)
+		return -ENXIO;
+
+	/*
+	 * This unlocks and deallocates md.
+	 */
+	r = dm_destroy(md);
+	if (r) {
+		dm_put_w(md);
+		return r;
+	}
+
+	return 0;
+}
+
+static int suspend(struct dm_ioctl *param, struct dm_ioctl *user)
+{
+	struct mapped_device *md;
+
+	md = find_device_w(param);
+	if (!md)
+		return -ENXIO;
+
+	/*
+	 * The lock will be dropped within dm_suspend/dm_resume.
+	 */
+	if (param->flags & DM_SUSPEND_FLAG)
+		return dm_suspend(md);
+
+	return dm_resume(md);
+}
+
+static int reload(struct dm_ioctl *param, struct dm_ioctl *user)
+{
+	int r;
+	struct mapped_device *md;
+	struct dm_table *t;
+
+	r = dm_table_create(&t, get_mode(param));
+	if (r)
+		return r;
+
+	r = populate_table(t, param);
+	if (r) {
+		dm_table_destroy(t);
+		return r;
+	}
+
+	md = find_device_w(param);
+	if (!md) {
+		dm_table_destroy(t);
+		return -ENXIO;
+	}
+
+	r = dm_swap_table(md, t);
+	if (r) {
+		dm_put_w(md);
+		dm_table_destroy(t);
+		return r;
+	}
+
+	if (param->flags & DM_READONLY_FLAG)
+		dm_set_ro(md);
+	else
+		dm_set_rw(md);
+
+	dm_put_w(md);
+
+	r = info(param, user);
+	return r;
+}
+
+static int rename(struct dm_ioctl *param, struct dm_ioctl *user)
+{
+	char *newname = (char *) param + param->data_start;
+
+	if (!param->name) {
+		DMWARN("Invalid old logical volume name supplied.");
+		return -EINVAL;
+	}
+
+	if (valid_str(newname, (void *) param,
+		      (void *) param + param->data_size)) {
+		DMWARN("Invalid new logical volume name supplied.");
+		return -EINVAL;
+	}
+
+	return dm_set_name(param->name, newname);
+}
+
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
+		{DM_DEV_CREATE_CMD, create},
+		{DM_DEV_REMOVE_CMD, remove},
+		{DM_DEV_RELOAD_CMD, reload},
+		{DM_DEV_RENAME_CMD, rename},
+		{DM_DEV_SUSPEND_CMD, suspend},
+		{DM_DEV_DEPS_CMD, dep},
+		{DM_DEV_STATUS_CMD, info},
+		{DM_TARGET_STATUS_CMD, get_status},
+		{DM_TARGET_WAIT_CMD, wait_device_event},
+	};
+
+	return (cmd >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[cmd].fn;
+}
+
+/*
+ * As well as checking the version compatibility this always
+ * copies the kernel interface version out.
+ */
+static int check_version(int cmd, struct dm_ioctl *user)
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
+	/* Unless creating, either name of uuid but not both */
+	if (cmd != DM_DEV_CREATE_CMD) {
+		if ((!*param->uuid && !*param->name) ||
+		    (*param->uuid && *param->name)) {
+			DMWARN("one of name or uuid must be supplied");
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
+	int r = 0, cmd;
+	struct dm_ioctl *param;
+	struct dm_ioctl *user = (struct dm_ioctl *) u;
+	ioctl_fn fn = NULL;
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
+	 * writes out the kernels interface version.
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
+	 * Copy the parameters into kernel space.
+	 */
+	r = copy_params(user, &param);
+	if (r)
+		return r;
+
+	r = validate_params(cmd, param);
+	if (r) {
+		free_params(param);
+		return r;
+	}
+
+	r = fn(param, user);
+	free_params(param);
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
+	r = misc_register(&_dm_misc);
+	if (r) {
+		DMERR("misc_register failed for control device");
+		return r;
+	}
+
+	r = devfs_generate_path(_dm_misc.devfs_handle, rname + 3,
+				sizeof rname - 3);
+	if (r == -ENOSYS)
+		return 0;	/* devfs not present */
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
+	DMINFO("%d.%d.%d%s initialised: %s", DM_VERSION_MAJOR,
+	       DM_VERSION_MINOR, DM_VERSION_PATCHLEVEL, DM_VERSION_EXTRA,
+	       DM_DRIVER_EMAIL);
+	return 0;
+
+      failed:
+	misc_deregister(&_dm_misc);
+	return r;
+}
+
+void dm_interface_exit(void)
+{
+	if (misc_deregister(&_dm_misc) < 0)
+		DMERR("misc_deregister failed for control device");
+}
--- a/drivers/md/dm.c	Tue Oct 15 18:24:39 2002
+++ b/drivers/md/dm.c	Tue Oct 15 18:24:39 2002
@@ -115,6 +115,7 @@
 	xx(dm_target)
 	xx(dm_linear)
 	xx(dm_stripe)
+	xx(dm_interface)
 #undef xx
 };
 
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/dm-ioctl.h	Tue Oct 15 18:24:39 2002
@@ -0,0 +1,145 @@
+/*
+ * Copyright (C) 2001 Sistina Software (UK) Limited.
+ *
+ * This file is released under the LGPL.
+ */
+
+#ifndef _LINUX_DM_IOCTL_H
+#define _LINUX_DM_IOCTL_H
+
+#include <linux/device-mapper.h>
+#include <linux/types.h>
+
+/*
+ * Implements a traditional ioctl interface to the device mapper.
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
+	uint32_t open_count;	/* out */
+	uint32_t flags;		/* in/out */
+
+	__kernel_dev_t dev;	/* in/out */
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
+	int32_t status;		/* used when reading from kernel only */
+	uint64_t sector_start;
+	uint32_t length;
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
+	uint32_t count;
+
+	__kernel_dev_t dev[0];	/* out */
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
+
+	/* device level cmds */
+	DM_DEV_CREATE_CMD,
+	DM_DEV_REMOVE_CMD,
+	DM_DEV_RELOAD_CMD,
+	DM_DEV_RENAME_CMD,
+	DM_DEV_SUSPEND_CMD,
+	DM_DEV_DEPS_CMD,
+	DM_DEV_STATUS_CMD,
+
+	/* target level cmds */
+	DM_TARGET_STATUS_CMD,
+	DM_TARGET_WAIT_CMD
+};
+
+#define DM_IOCTL 0xfd
+
+#define DM_VERSION       _IOWR(DM_IOCTL, DM_VERSION_CMD, struct dm_ioctl)
+#define DM_REMOVE_ALL    _IOWR(DM_IOCTL, DM_REMOVE_ALL_CMD, struct dm_ioctl)
+
+#define DM_DEV_CREATE    _IOWR(DM_IOCTL, DM_DEV_CREATE_CMD, struct dm_ioctl)
+#define DM_DEV_REMOVE    _IOWR(DM_IOCTL, DM_DEV_REMOVE_CMD, struct dm_ioctl)
+#define DM_DEV_RELOAD    _IOWR(DM_IOCTL, DM_DEV_RELOAD_CMD, struct dm_ioctl)
+#define DM_DEV_SUSPEND   _IOWR(DM_IOCTL, DM_DEV_SUSPEND_CMD, struct dm_ioctl)
+#define DM_DEV_RENAME    _IOWR(DM_IOCTL, DM_DEV_RENAME_CMD, struct dm_ioctl)
+#define DM_DEV_DEPS      _IOWR(DM_IOCTL, DM_DEV_DEPS_CMD, struct dm_ioctl)
+#define DM_DEV_STATUS    _IOWR(DM_IOCTL, DM_DEV_STATUS_CMD, struct dm_ioctl)
+
+#define DM_TARGET_STATUS _IOWR(DM_IOCTL, DM_TARGET_STATUS_CMD, struct dm_ioctl)
+#define DM_TARGET_WAIT   _IOWR(DM_IOCTL, DM_TARGET_WAIT_CMD, struct dm_ioctl)
+
+#define DM_VERSION_MAJOR	1
+#define DM_VERSION_MINOR	0
+#define DM_VERSION_PATCHLEVEL	6
+#define DM_VERSION_EXTRA	"-ioctl (2002-10-15)"
+
+/* Status bits */
+#define DM_READONLY_FLAG	0x00000001
+#define DM_SUSPEND_FLAG		0x00000002
+#define DM_EXISTS_FLAG		0x00000004
+#define DM_PERSISTENT_DEV_FLAG	0x00000008
+
+/*
+ * Flag passed into ioctl STATUS command to get table information
+ * rather than current status.
+ */
+#define DM_STATUS_TABLE_FLAG	0x00000010
+
+#endif				/* _LINUX_DM_IOCTL_H */
