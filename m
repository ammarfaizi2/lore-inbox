Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319099AbSIDITp>; Wed, 4 Sep 2002 04:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319100AbSIDITp>; Wed, 4 Sep 2002 04:19:45 -0400
Received: from cs144080.pp.htv.fi ([213.243.144.80]:59661 "EHLO chip.ath.cx")
	by vger.kernel.org with ESMTP id <S319099AbSIDITo>;
	Wed, 4 Sep 2002 04:19:44 -0400
Date: Wed, 4 Sep 2002 11:23:47 +0300 (EEST)
From: Panu Matilainen <pmatilai@welho.com>
X-X-Sender: pmatilai@chip.ath.cx
To: urban@teststation.com
cc: linux-kernel@vger.kernel.org
Subject: 32bit UID wraps around with smbfs
Message-ID: <Pine.LNX.4.44.0209041115590.7970-100000@chip.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Smbfs has problems with 32bit UID/GID's: when you do
'smbmount //some/share /mnt/samba -o uid=100000' the mountpoint UID (and 
GID) wrap around at 65535.

The attached patch, along with samba recompile against fixed headers
apparently fixes it. This problem is present at least in all 2.4 kernels,
I haven't looked at 2.5.

	- Panu -

--- linux/include/linux/smb_mount.h.uid32	Thu Aug 29 17:37:40 2002
+++ linux/include/linux/smb_mount.h	Thu Aug 29 17:39:34 2002
@@ -15,9 +15,9 @@
 
 struct smb_mount_data {
 	int version;
-	__kernel_uid_t mounted_uid; /* Who may umount() this filesystem? */
-	__kernel_uid_t uid;
-	__kernel_gid_t gid;
+	__kernel_uid32_t mounted_uid; /* Who may umount() this filesystem? */
+	__kernel_uid32_t uid;
+	__kernel_gid32_t gid;
 	__kernel_mode_t file_mode;
 	__kernel_mode_t dir_mode;
 };
@@ -42,9 +42,9 @@
 struct smb_mount_data_kernel {
 	int version;
 
-	__kernel_uid_t mounted_uid;	/* Who may umount() this filesystem? */
-	__kernel_uid_t uid;
-	__kernel_gid_t gid;
+	__kernel_uid32_t mounted_uid;	/* Who may umount() this filesystem? */
+	__kernel_uid32_t uid;
+	__kernel_gid32_t gid;
 	__kernel_mode_t file_mode;
 	__kernel_mode_t dir_mode;
 


