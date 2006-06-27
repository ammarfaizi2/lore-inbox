Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030715AbWF0HGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030715AbWF0HGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030714AbWF0HF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:05:58 -0400
Received: from ns2.suse.de ([195.135.220.15]:62371 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030715AbWF0HFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:05:55 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:05:47 +1000
Message-Id: <1060627070547.26046@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 008 of 12] md: Unify usage of symbolic names for perms.
References: <20060627170010.25835.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some places we use number (0660) someplaces names (S_IRUGO).
Change all numbers to be names, and change 0655 to be
what it should be.

Also make some formatting more consistent.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/md.c |   56 ++++++++++++++++++++++++++----------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff .prev/drivers/md/md.c ./drivers/md/md.c
--- .prev/drivers/md/md.c	2006-06-27 12:17:32.000000000 +1000
+++ ./drivers/md/md.c	2006-06-27 12:17:33.000000000 +1000
@@ -112,7 +112,7 @@ static ctl_table raid_table[] = {
 		.procname	= "speed_limit_min",
 		.data		= &sysctl_speed_limit_min,
 		.maxlen		= sizeof(int),
-		.mode		= 0644,
+		.mode		= S_IRUGO|S_IWUSR,
 		.proc_handler	= &proc_dointvec,
 	},
 	{
@@ -120,7 +120,7 @@ static ctl_table raid_table[] = {
 		.procname	= "speed_limit_max",
 		.data		= &sysctl_speed_limit_max,
 		.maxlen		= sizeof(int),
-		.mode		= 0644,
+		.mode		= S_IRUGO|S_IWUSR,
 		.proc_handler	= &proc_dointvec,
 	},
 	{ .ctl_name = 0 }
@@ -131,7 +131,7 @@ static ctl_table raid_dir_table[] = {
 		.ctl_name	= DEV_RAID,
 		.procname	= "raid",
 		.maxlen		= 0,
-		.mode		= 0555,
+		.mode		= S_IRUGO|S_IXUGO,
 		.child		= raid_table,
 	},
 	{ .ctl_name = 0 }
@@ -1785,8 +1785,8 @@ state_store(mdk_rdev_t *rdev, const char
 	}
 	return err ? err : len;
 }
-static struct rdev_sysfs_entry
-rdev_state = __ATTR(state, 0644, state_show, state_store);
+static struct rdev_sysfs_entry rdev_state =
+__ATTR(state, S_IRUGO|S_IWUSR, state_show, state_store);
 
 static ssize_t
 super_show(mdk_rdev_t *rdev, char *page)
@@ -1817,7 +1817,7 @@ errors_store(mdk_rdev_t *rdev, const cha
 	return -EINVAL;
 }
 static struct rdev_sysfs_entry rdev_errors =
-__ATTR(errors, 0644, errors_show, errors_store);
+__ATTR(errors, S_IRUGO|S_IWUSR, errors_show, errors_store);
 
 static ssize_t
 slot_show(mdk_rdev_t *rdev, char *page)
@@ -1851,7 +1851,7 @@ slot_store(mdk_rdev_t *rdev, const char 
 
 
 static struct rdev_sysfs_entry rdev_slot =
-__ATTR(slot, 0644, slot_show, slot_store);
+__ATTR(slot, S_IRUGO|S_IWUSR, slot_show, slot_store);
 
 static ssize_t
 offset_show(mdk_rdev_t *rdev, char *page)
@@ -1873,7 +1873,7 @@ offset_store(mdk_rdev_t *rdev, const cha
 }
 
 static struct rdev_sysfs_entry rdev_offset =
-__ATTR(offset, 0644, offset_show, offset_store);
+__ATTR(offset, S_IRUGO|S_IWUSR, offset_show, offset_store);
 
 static ssize_t
 rdev_size_show(mdk_rdev_t *rdev, char *page)
@@ -1897,7 +1897,7 @@ rdev_size_store(mdk_rdev_t *rdev, const 
 }
 
 static struct rdev_sysfs_entry rdev_size =
-__ATTR(size, 0644, rdev_size_show, rdev_size_store);
+__ATTR(size, S_IRUGO|S_IWUSR, rdev_size_show, rdev_size_store);
 
 static struct attribute *rdev_default_attrs[] = {
 	&rdev_state.attr,
@@ -2134,7 +2134,7 @@ safe_delay_store(mddev_t *mddev, const c
 	return len;
 }
 static struct md_sysfs_entry md_safe_delay =
-__ATTR(safe_mode_delay, 0644,safe_delay_show, safe_delay_store);
+__ATTR(safe_mode_delay, S_IRUGO|S_IWUSR,safe_delay_show, safe_delay_store);
 
 static ssize_t
 level_show(mddev_t *mddev, char *page)
@@ -2169,7 +2169,7 @@ level_store(mddev_t *mddev, const char *
 }
 
 static struct md_sysfs_entry md_level =
-__ATTR(level, 0644, level_show, level_store);
+__ATTR(level, S_IRUGO|S_IWUSR, level_show, level_store);
 
 
 static ssize_t
@@ -2194,7 +2194,7 @@ layout_store(mddev_t *mddev, const char 
 	return len;
 }
 static struct md_sysfs_entry md_layout =
-__ATTR(layout, 0655, layout_show, layout_store);
+__ATTR(layout, S_IRUGO|S_IWUSR, layout_show, layout_store);
 
 
 static ssize_t
@@ -2225,7 +2225,7 @@ raid_disks_store(mddev_t *mddev, const c
 	return rv ? rv : len;
 }
 static struct md_sysfs_entry md_raid_disks =
-__ATTR(raid_disks, 0644, raid_disks_show, raid_disks_store);
+__ATTR(raid_disks, S_IRUGO|S_IWUSR, raid_disks_show, raid_disks_store);
 
 static ssize_t
 chunk_size_show(mddev_t *mddev, char *page)
@@ -2249,7 +2249,7 @@ chunk_size_store(mddev_t *mddev, const c
 	return len;
 }
 static struct md_sysfs_entry md_chunk_size =
-__ATTR(chunk_size, 0644, chunk_size_show, chunk_size_store);
+__ATTR(chunk_size, S_IRUGO|S_IWUSR, chunk_size_show, chunk_size_store);
 
 static ssize_t
 resync_start_show(mddev_t *mddev, char *page)
@@ -2273,7 +2273,7 @@ resync_start_store(mddev_t *mddev, const
 	return len;
 }
 static struct md_sysfs_entry md_resync_start =
-__ATTR(resync_start, 0644, resync_start_show, resync_start_store);
+__ATTR(resync_start, S_IRUGO|S_IWUSR, resync_start_show, resync_start_store);
 
 /*
  * The array state can be:
@@ -2443,7 +2443,8 @@ array_state_store(mddev_t *mddev, const 
 	else
 		return len;
 }
-static struct md_sysfs_entry md_array_state = __ATTR(array_state, 0644, array_state_show, array_state_store);
+static struct md_sysfs_entry md_array_state =
+__ATTR(array_state, S_IRUGO|S_IWUSR, array_state_show, array_state_store);
 
 static ssize_t
 null_show(mddev_t *mddev, char *page)
@@ -2503,7 +2504,7 @@ new_dev_store(mddev_t *mddev, const char
 }
 
 static struct md_sysfs_entry md_new_device =
-__ATTR(new_dev, 0200, null_show, new_dev_store);
+__ATTR(new_dev, S_IWUSR, null_show, new_dev_store);
 
 static ssize_t
 size_show(mddev_t *mddev, char *page)
@@ -2541,7 +2542,7 @@ size_store(mddev_t *mddev, const char *b
 }
 
 static struct md_sysfs_entry md_size =
-__ATTR(component_size, 0644, size_show, size_store);
+__ATTR(component_size, S_IRUGO|S_IWUSR, size_show, size_store);
 
 
 /* Metdata version.
@@ -2589,7 +2590,7 @@ metadata_store(mddev_t *mddev, const cha
 }
 
 static struct md_sysfs_entry md_metadata =
-__ATTR(metadata_version, 0644, metadata_show, metadata_store);
+__ATTR(metadata_version, S_IRUGO|S_IWUSR, metadata_show, metadata_store);
 
 static ssize_t
 action_show(mddev_t *mddev, char *page)
@@ -2657,12 +2658,11 @@ mismatch_cnt_show(mddev_t *mddev, char *
 		       (unsigned long long) mddev->resync_mismatches);
 }
 
-static struct md_sysfs_entry
-md_scan_mode = __ATTR(sync_action, S_IRUGO|S_IWUSR, action_show, action_store);
+static struct md_sysfs_entry md_scan_mode =
+__ATTR(sync_action, S_IRUGO|S_IWUSR, action_show, action_store);
 
 
-static struct md_sysfs_entry
-md_mismatches = __ATTR_RO(mismatch_cnt);
+static struct md_sysfs_entry md_mismatches = __ATTR_RO(mismatch_cnt);
 
 static ssize_t
 sync_min_show(mddev_t *mddev, char *page)
@@ -2728,8 +2728,7 @@ sync_speed_show(mddev_t *mddev, char *pa
 	return sprintf(page, "%ld\n", db/dt/2); /* K/sec */
 }
 
-static struct md_sysfs_entry
-md_sync_speed = __ATTR_RO(sync_speed);
+static struct md_sysfs_entry md_sync_speed = __ATTR_RO(sync_speed);
 
 static ssize_t
 sync_completed_show(mddev_t *mddev, char *page)
@@ -2745,8 +2744,7 @@ sync_completed_show(mddev_t *mddev, char
 	return sprintf(page, "%lu / %lu\n", resync, max_blocks);
 }
 
-static struct md_sysfs_entry
-md_sync_completed = __ATTR_RO(sync_completed);
+static struct md_sysfs_entry md_sync_completed = __ATTR_RO(sync_completed);
 
 static ssize_t
 suspend_lo_show(mddev_t *mddev, char *page)
@@ -5676,8 +5674,8 @@ static int set_ro(const char *val, struc
 	return -EINVAL;
 }
 
-module_param_call(start_ro, set_ro, get_ro, NULL, 0600);
-module_param(start_dirty_degraded, int, 0644);
+module_param_call(start_ro, set_ro, get_ro, NULL, S_IRUSR|S_IWUSR);
+module_param(start_dirty_degraded, int, S_IRUGO|S_IWUSR);
 
 
 EXPORT_SYMBOL(register_md_personality);
