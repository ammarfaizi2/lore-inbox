Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263275AbSJCNGT>; Thu, 3 Oct 2002 09:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261224AbSJCNFV>; Thu, 3 Oct 2002 09:05:21 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:37086 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S263280AbSJCNEM>; Thu, 3 Oct 2002 09:04:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: torvalds@transmeta.com
Subject: [PATCH] EVMS core 3/4: evms_ioctl.h
Date: Thu, 3 Oct 2002 07:37:05 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <02100307370503.05904@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Here is part 3 of the EVMS core. This header file defines the ioctl API
available in EVMS.

Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/


diff -Naur linux-2.5.40/include/linux/evms/evms_ioctl.h linux-2.5.40-evms/include/linux/evms/evms_ioctl.h
--- linux-2.5.40/include/linux/evms/evms_ioctl.h	Sun Jul 17 18:46:18 1994
+++ linux-2.5.40-evms/include/linux/evms/evms_ioctl.h	Tue Oct  1 15:30:14 2002
@@ -0,0 +1,498 @@
+/* -*- linux-c -*- */
+/*
+ *
+ *   Copyright (c) International Business Machines  Corp., 2000
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+/*
+ * linux/include/linux/evms.h
+ *
+ * EVMS public kernel header file
+ *
+ */
+
+#ifndef __EVMS_IOCTL_INCLUDED__
+#define __EVMS_IOCTL_INCLUDED__
+
+#include <linux/hdreg.h>
+
+/* IOCTL interface version definitions */
+#define EVMS_IOCTL_INTERFACE_MAJOR           11
+#define EVMS_IOCTL_INTERFACE_MINOR           2
+#define EVMS_IOCTL_INTERFACE_PATCHLEVEL      0
+
+/* IOCTL definitions */
+enum evms_ioctl_cmds {
+	/* version commands */
+	EVMS_GET_IOCTL_VERSION_NUMBER = 0,
+	EVMS_GET_VERSION_NUMBER,
+#ifdef __KERNEL__
+	/* EVMS internal commands */
+	EVMS_GET_DISK_LIST_NUMBER = 0x40,
+	EVMS_CHECK_MEDIA_CHANGE_NUMBER,
+	EVMS_REVALIDATE_DISK_NUMBER,
+	EVMS_OPEN_VOLUME_NUMBER,
+	EVMS_CLOSE_VOLUME_NUMBER,
+	EVMS_QUIESCE_VOLUME_NUMBER,
+	EVMS_CHECK_DEVICE_STATUS_NUMBER,
+	EVMS_UPDATE_DEVICE_INFO_NUMBER,
+#endif
+	/* configuration commands */
+	EVMS_GET_INFO_LEVEL_NUMBER = 0x80,
+	EVMS_SET_INFO_LEVEL_NUMBER,
+	EVMS_REDISCOVER_VOLUMES_NUMBER,
+	EVMS_DELETE_VOLUME_NUMBER,
+	EVMS_PLUGIN_IOCTL_NUMBER,
+	EVMS_PROCESS_NOTIFY_EVENT_NUMBER,
+	/* query info commands */
+	EVMS_GET_LOGICAL_DISK_NUMBER = 0xC0,
+	EVMS_GET_LOGICAL_DISK_INFO_NUMBER,
+	EVMS_SECTOR_IO_NUMBER,
+	EVMS_GET_MINOR_NUMBER,
+	EVMS_GET_VOLUME_DATA_NUMBER,
+	EVMS_GET_PLUGIN_NUMBER,
+	EVMS_COMPUTE_CSUM_NUMBER,
+	EVMS_GET_BMAP_NUMBER,
+	EVMS_CHECK_MOUNT_STATUS_NUMBER,
+        /* commands for non-EVMS apps */
+	EVMS_GET_VOL_STRIPE_INFO_NUMBER = 0xF0,        
+};
+
+/* version commands */
+#define EVMS_GET_IOCTL_VERSION_STRING   "EVMS_GET_IOCTL_VERSION"
+#define EVMS_GET_IOCTL_VERSION          _IOR(EVMS_MAJOR, EVMS_GET_IOCTL_VERSION_NUMBER, struct evms_version)
+
+#define EVMS_GET_VERSION_STRING         "EVMS_GET_VERSION"
+#define EVMS_GET_VERSION                _IOR(EVMS_MAJOR, EVMS_GET_VERSION_NUMBER, struct evms_version)
+
+#ifdef __KERNEL__
+
+/* EVMS internal commands */
+#define EVMS_GET_DISK_LIST_STRING       "EVMS_GET_DISK_LIST"
+#define EVMS_GET_DISK_LIST              _IOWR(EVMS_MAJOR, EVMS_GET_DISK_LIST_NUMBER, struct list_head *)
+
+#define EVMS_CHECK_MEDIA_CHANGE_STRING  "EVMS_CHECK_MEDIA_CHANGE"
+#define EVMS_CHECK_MEDIA_CHANGE         _IO(EVMS_MAJOR, EVMS_CHECK_MEDIA_CHANGE_NUMBER)
+
+#define EVMS_REVALIDATE_DISK_STRING     "EVMS_REVALIDATE_DISK"
+#define EVMS_REVALIDATE_DISK            _IO(EVMS_MAJOR, EVMS_REVALIDATE_DISK_NUMBER)
+
+#define EVMS_OPEN_VOLUME_STRING         "EVMS_OPEN_VOLUME"
+#define EVMS_OPEN_VOLUME                _IO(EVMS_MAJOR, EVMS_OPEN_VOLUME_NUMBER)
+
+#define EVMS_CLOSE_VOLUME_STRING        "EVMS_CLOSE_VOLUME"
+#define EVMS_CLOSE_VOLUME               _IO(EVMS_MAJOR, EVMS_CLOSE_VOLUME_NUMBER)
+
+/**
+ * struct evms_quiesce_vol_pkt - ioctl packet definition
+ * @command:	0 = unquiesce, 1 = quiesce
+ * @minor:	minor device number of target volume
+ * @do_vfs:	0 = do nothing, 1 = also perform equivalent VFS operation
+ * @status:	returned operation status
+ *
+ * ioctl packet definition for EVMS_QUIESCE_VOLUME
+ **/
+struct evms_quiesce_vol_pkt {
+	s32 command;
+	s32 minor;
+	s32 do_vfs;
+	s32 status;
+};
+/**
+ * defines for evms_quiesce_vol_pkt.command field
+ **/
+#define EVMS_UNQUIESCE          0
+#define EVMS_QUIESCE            1
+/**
+ * defines for evms_quiesce_vol_pkt.do_vfs field 
+ * located below struct evms_delete_vol_pkt definition
+ **/
+
+#define EVMS_QUIESCE_VOLUME_STRING      "EVMS_QUIESCE_VOLUME"
+#define EVMS_QUIESCE_VOLUME             _IOR(EVMS_MAJOR, EVMS_QUIESCE_VOLUME_NUMBER, struct evms_quiesce_vol_pkt)
+
+#define EVMS_CHECK_DEVICE_STATUS_STRING	"EVMS_CHECK_DEVICE_STATUS"
+#define EVMS_CHECK_DEVICE_STATUS        _IOR(EVMS_MAJOR, EVMS_CHECK_DEVICE_STATUS_NUMBER, int)
+
+#define EVMS_UPDATE_DEVICE_INFO_STRING	"EVMS_UPDATE_DEVICE_INFO"
+#define EVMS_UPDATE_DEVICE_INFO         _IO(EVMS_MAJOR, EVMS_UPDATE_DEVICE_INFO_NUMBER)
+
+#endif
+
+/* configuration commands */
+#define EVMS_GET_INFO_LEVEL_STRING      "EVMS_GET_INFO_LEVEL"
+#define EVMS_GET_INFO_LEVEL             _IOR(EVMS_MAJOR, EVMS_GET_INFO_LEVEL_NUMBER, int)
+
+#define EVMS_SET_INFO_LEVEL_STRING      "EVMS_SET_INFO_LEVEL"
+#define EVMS_SET_INFO_LEVEL             _IOW(EVMS_MAJOR, EVMS_SET_INFO_LEVEL_NUMBER, int)
+
+/**
+ * struct evms_rediscover_pkt - rediscover volume ioctl packet definition
+ * @status:		return operation status
+ * @drive_count:	count of drives being probed, 0xffffffff for all disks
+ * @drive_array:	array of drive handles to be probed
+ *
+ * ioctl packet definition for EVMS_REDISCOVER_VOLUMES ioctl
+ **/
+struct evms_rediscover_pkt {
+	s32 status;
+	u32 drive_count;
+	u64 *drive_array;
+};
+/**
+ * defines for evms_delete_vol_pkt.command field
+ **/
+#define EVMS_SOFT_DELETE        0
+#define EVMS_HARD_DELETE        1
+/**
+ * defines evms_rediscover_pkt.drive_count field
+ **/
+#define REDISCOVER_ALL_DEVICES          0xFFFFFFFF
+
+#define EVMS_REDISCOVER_VOLUMES_STRING  "EVMS_REDISCOVER_VOLUMES"
+#define EVMS_REDISCOVER_VOLUMES         _IOWR(EVMS_MAJOR, EVMS_REDISCOVER_VOLUMES_NUMBER, struct evms_rediscover_pkt)
+
+/* field: command: defines */
+
+/**
+ * struct evms_delete_vol_pkt - delete volume ioctl packet definition
+ * @command:		0 = soft delete, 1 = hard delete
+ * @minor:		minor device num of target volume
+ * @do_vfs:		0 = do nothing, 1 = perform VFS operation(s)
+ * @associative_minor:	optional minor device num of associative volume, 0 when unused
+ * @author		returned operation status
+ *
+ * ioctl packet definition for EVMS_DELETE_VOLUME ioctl
+ **/
+struct evms_delete_vol_pkt {
+	s32 command;
+	s32 minor;
+	s32 do_vfs;
+	s32 associative_minor;
+	s32 status;
+};
+/**
+ * field evms_delete_vol_pkt defines
+ * @EVMS_VFS_DO_NOTHING:
+ * @EVMS_VFS_DO:
+ *
+ * NOTE: these defines are also used with evms_quiesce_vol_pkt.
+ **/
+#define EVMS_VFS_DO_NOTHING     0
+#define EVMS_VFS_DO             1
+
+#define EVMS_DELETE_VOLUME_STRING       "EVMS_DELETE_VOLUME"
+#define EVMS_DELETE_VOLUME              _IOR(EVMS_MAJOR, EVMS_DELETE_VOLUME_NUMBER, struct evms_delete_vol_pkt)
+
+/**
+ * struct evms_plugin_ioctl_pkt - generic plugin ioctl packet definition
+ * @feature_id:		plugin ID of feature to receive this ioctl
+ * @feature_command:	feature specific ioctl command
+ * @status:		0 = completed, 0 != error
+ * @feature_ioctl_data:	ptr to feature specific ioctl struct
+ *
+ * ioctl packet definition for EVMS_PLUGIN_IOCTL ioctl
+ **/
+struct evms_plugin_ioctl_pkt {
+	ulong feature_id;
+	s32 feature_command;
+	s32 status;
+	void *feature_ioctl_data;
+};
+
+#define EVMS_PLUGIN_IOCTL_STRING        "EVMS_PLUGIN_IOCTL"
+#define EVMS_PLUGIN_IOCTL               _IOR(EVMS_MAJOR, EVMS_PLUGIN_IOCTL_NUMBER, struct evms_plugin_ioctl_pkt)
+
+/**
+ * struct evms_event - evms event structure
+ * @pid:  	PID to act on
+ * @eventid:	event id to respond to
+ * @signo:	signal # to send when event occurs
+ *
+ * contains process event notification info
+ **/
+struct evms_event {
+	s32 pid;
+	s32 eventid;
+	s32 signo;
+};
+/**
+ * field evms_event_pkt.eventid defines
+ **/
+#define EVMS_EVENT_END_OF_DISCOVERY     0
+
+/**
+ * struct evms_notify_pkt - evms event notification ioctl packet definition
+ * @command:	0 = unregister, 1 = register
+ * @eventry:	event structure
+ * @status:	returned operation status
+ *
+ * ioctl packet definition for EVMS_PROCESS_NOTIFY_EVENT ioctl
+ **/
+struct evms_notify_pkt {
+	s32 command;
+	struct evms_event eventry;
+	s32 status;
+};
+/**
+ * field evms_notify_pkt.command defines
+ **/
+#define EVMS_EVENT_UNREGISTER   0
+#define EVMS_EVENT_REGISTER     1
+
+#define EVMS_PROCESS_NOTIFY_EVENT_STRING "EVMS_PROCESS_NOTIFY_EVENT"
+#define EVMS_PROCESS_NOTIFY_EVENT       _IOWR(EVMS_MAJOR, EVMS_PROCESS_NOTIFY_EVENT_NUMBER, struct evms_notify_pkt)
+
+/* query info commands */
+
+/**
+ * struct evms_user_disk_pkt - get disk handle ioctl packet definition
+ * @command:		0 = first disk, 1 = next disk
+ * @status:		0 = no more disks, 1 = valid disk info
+ * @disk_handle:	only valid when status == 1
+ *
+ * ioctl packet definition for EVMS_GET_LOGICAL_DISK ioctl
+ **/
+struct evms_user_disk_pkt {
+	s32 command;
+	s32 status;
+	u64 disk_handle;
+};
+/**
+ * field evms_user_disk_pkt.command defines
+ **/
+#define EVMS_FIRST_DISK         0
+#define EVMS_NEXT_DISK          1
+/**
+ * field evms_user_disk_pkt.status defines
+ **/
+#define EVMS_DISK_INVALID       0
+#define EVMS_DISK_VALID         1
+
+#define EVMS_GET_LOGICAL_DISK_STRING    "EVMS_GET_LOGICAL_DISK"
+#define EVMS_GET_LOGICAL_DISK           _IOWR(EVMS_MAJOR, EVMS_GET_LOGICAL_DISK_NUMBER, struct evms_user_disk_pkt)
+
+/**
+ * evms_user_disk_info_pkt - disk info packet definition
+ * @status:		return operation status
+ * @flags:		device characteristics
+ * @disk_handle:	kernel handle to specified device
+ * @disk_dev:		kernel device info, used by MD plugin
+ * @geometry:		reported device geometry
+ * @block_size:		reported block size
+ * @hardsect_size:	reported physical sector size
+ * @total_vsectors:	size of device in 512 byte units
+ * @disk_name:		legacy name for the device
+ *
+ * ioctl packet definition for EVMS_GET_LOGICAL_DISK_INFO ioctl
+ **/
+struct evms_user_disk_info_pkt {
+	u32 status;
+	u32 flags;
+	u64 disk_handle;
+	u32 disk_dev;
+	u32 geo_sectors;
+	u32 geo_heads;
+	u64 geo_cylinders;
+	u32 block_size;
+	u32 hardsect_size;
+	u64 total_sectors;
+	u8 disk_name[EVMS_VOLUME_NAME_SIZE + 1];
+};
+/**
+ * field evms_user_disk_info_pkt.flags define in evms.h
+ **/
+
+#define EVMS_GET_LOGICAL_DISK_INFO_STRING "EVMS_GET_LOGICAL_DISK_INFO"
+#define EVMS_GET_LOGICAL_DISK_INFO      _IOWR(EVMS_MAJOR, EVMS_GET_LOGICAL_DISK_INFO_NUMBER, struct evms_user_disk_info_pkt)
+
+/**
+ * struct evms_sector_io_pkt - sector io ioctl packet definition
+ * @disk_handle:	disk handle of target device
+ * @io_flag:		0 = read, 1 = write
+ * @starting_sector:	disk relative starting sector
+ * @sector_count:	count of sectors
+ * @buffer_address:	user buffer address
+ * @status:		return operation status
+ *
+ * ioctl packet definition for EVMS_SECTOR_IO ioctl
+ **/
+struct evms_sector_io_pkt {
+	u64 disk_handle;
+	s32 io_flag;
+	u64 starting_sector;
+	u64 sector_count;
+	u8 *buffer_address;
+	s32 status;
+};
+/**
+ * field evms_sector_io_pkt.io_flag defines
+ **/
+#define EVMS_SECTOR_IO_READ	0
+#define EVMS_SECTOR_IO_WRITE	1
+
+#define EVMS_SECTOR_IO_STRING           "EVMS_SECTOR_IO"
+#define EVMS_SECTOR_IO                  _IOWR(EVMS_MAJOR, EVMS_SECTOR_IO_NUMBER, struct evms_sector_io_pkt)
+
+/**
+ * struct evms_user_minor_pkt - get a list of device minors, one at a time
+ * @command:	0 = first volume, 1 = next volume
+ * @status:	returned operation status
+ * @minor:	returned minor number, only valid when status == 1
+ *
+ * ioctl packet definition for EVMS_GET_MINOR ioctl
+ **/
+struct evms_user_minor_pkt {
+	s32 command;
+	s32 status;
+	s32 minor;
+};
+/**
+ * field evms_user_minor_pkt.command defines
+ **/
+#define EVMS_FIRST_VOLUME       0
+#define EVMS_NEXT_VOLUME        1
+/**
+ * field evms_user_minor_pkt.status defines
+ **/
+#define EVMS_VOLUME_INVALID     0
+#define EVMS_VOLUME_VALID       1
+
+#define EVMS_GET_MINOR_STRING           "EVMS_GET_MINOR"
+#define EVMS_GET_MINOR                  _IOWR(EVMS_MAJOR, EVMS_GET_MINOR_NUMBER, struct evms_user_minor_pkt)
+
+/**
+ * struct evms_volume_data_pkt - volume data packet definition
+ * @minor:		minor device number of target volume
+ * @flags:		returned volume characteristics
+ * @volume_name:	returned volume name
+ * @status:		returned operation status
+ *
+ * ioctl packet definition for EVMS_GET_VOLUME_DATA ioctl
+ **/
+struct evms_volume_data_pkt {
+	s32 minor;
+	s32 flags;
+	u8 volume_name[EVMS_VOLUME_NAME_SIZE + 1];
+	s32 status;
+};
+/**
+ * field evms_volume_data_pkt.flags defines found in evms_common.h
+ **/
+
+#define EVMS_GET_VOLUME_DATA_STRING     "EVMS_GET_VOLUME_DATA"
+#define EVMS_GET_VOLUME_DATA            _IOWR(EVMS_MAJOR, EVMS_GET_VOLUME_DATA_NUMBER, struct evms_volume_data_pkt)
+
+/**
+ * struct evms_kernel_plugin_pkt - get kernel plugin ioctl packet definition
+ * @command:	0 = first plugin, 1 = next plugin
+ * @id:		returned plugin id
+ * @version:	returned plugin version info
+ * @status:	returned operation status
+ *
+ * ioctl packet definition for EVMS_GET_PLUGIN ioctl
+ **/
+struct evms_kernel_plugin_pkt {
+	s32 command;
+	u32 id;
+	struct evms_version version;
+	s32 status;
+};
+/**
+ * field evms_kernel_plugin_pkt.command defines
+ **/
+#define EVMS_FIRST_PLUGIN       0
+#define EVMS_NEXT_PLUGIN        1
+/**
+ * field evms_kernel_plugin_pkt.status defines
+ **/
+#define EVMS_PLUGIN_INVALID     0
+#define EVMS_PLUGIN_VALID       1
+
+#define EVMS_GET_PLUGIN_STRING          "EVMS_GET_PLUGIN"
+#define EVMS_GET_PLUGIN                 _IOWR(EVMS_MAJOR, EVMS_GET_PLUGIN_NUMBER, struct evms_kernel_plugin_pkt)
+
+/**
+ * struct evms_compute_csum_pkt - compute checksum ioctl packet definition
+ * @buffer_address:
+ * @buffer_size:
+ * @insum:
+ * @outsum:
+ * @status:
+ *
+ * ioctl packet definition for EVMS_COMPUTE_CSUM ioctl
+ **/
+struct evms_compute_csum_pkt {
+	u8 *buffer_address;
+	s32 buffer_size;
+	u32 insum;
+	u32 outsum;
+	s32 status;
+};
+
+#define EVMS_COMPUTE_CSUM_STRING        "EVMS_COMPUTE_CSUM"
+#define EVMS_COMPUTE_CSUM               _IOWR(EVMS_MAJOR, EVMS_COMPUTE_CSUM_NUMBER, struct evms_compute_csum_pkt)
+
+/**
+ * struct evms_get_bmap_pkt - get bmap data ioctl packet definition
+ * @rsector:	input, volume relative rsector value
+ * 		output, disk relative rsector value
+ * @dev		output, physical device
+ * @status:	output, operation status
+ *
+ * ioctl packet definition for EVMS_GET_BMAP ioctl
+ **/
+struct evms_get_bmap_pkt {
+	u64 rsector;
+	u32 dev;
+	s32 status;
+};
+
+#define EVMS_GET_BMAP_STRING            "EVMS_GET_BMAP"
+#define EVMS_GET_BMAP                   _IOWR(EVMS_MAJOR, EVMS_GET_BMAP_NUMBER, struct evms_get_bmap_pkt)
+
+/**
+ * struct evms_mount_status_pkt - ioctl packet definition
+ * @minor:	input, minor of volume to check
+ * @mounted:	output, TRUE if mounted, FALSE if not
+ * @status:	output, operation completion status
+ *
+ * ioctl packet definition for EVMS_CHECK_MOUNT_STATUS ioctl.
+ **/
+struct evms_mount_status_pkt {
+	u32 minor;
+	u32 mounted;
+	s32 status;
+};
+
+#define EVMS_CHECK_MOUNT_STATUS_STRING	"EVMS_CHECK_MOUNT_STATUS"
+#define EVMS_CHECK_MOUNT_STATUS         _IOWR(EVMS_MAJOR, EVMS_CHECK_MOUNT_STATUS_NUMBER, struct evms_mount_status_pkt)
+
+/**
+ * struct evms_vol_stripe_info_pkt - ioctl packet definition
+ * @size:	the stripe unit specified in 512 byte block units
+ * @width:	the number of stripe members or RAID data disks
+ *
+ * ioctl packet definition for EVMS_GET_VOL_STRIPE_INFO ioctl.
+ **/
+struct evms_vol_stripe_info_pkt {
+	u32 size;
+	u32 width;
+};
+
+#define EVMS_GET_VOL_STRIPE_INFO_STRING	"EVMS_GET_VOL_STRIPE_INFO"
+#define EVMS_GET_VOL_STRIPE_INFO	_IOR(EVMS_MAJOR, EVMS_GET_VOL_STRIPE_INFO_NUMBER, struct evms_vol_stripe_info_pkt)
+#endif
