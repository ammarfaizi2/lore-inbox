Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423180AbWF1FXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423180AbWF1FXv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423167AbWF1FXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:23:12 -0400
Received: from terminus.zytor.com ([192.83.249.54]:6350 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1423179AbWF1FTX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:19:23 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Subject: [klibc 23/31] kinit: replacement for in-kernel do_mount, ipconfig, nfsroot
Date: Tue, 27 Jun 2006 22:17:23 -0700
Message-Id: <klibc.200606272217.23@tazenda.hos.anvin.org>
In-Reply-To: <klibc.200606272217.00@tazenda.hos.anvin.org>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] kinit: replacement for in-kernel do_mount, ipconfig, nfsroot

kinit provides the default root-mounting code.  It should be
compatible with the in-kernel root-mounting code (modulo bugs); it
also provides a few minor enhancements.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit b202cbd956d9433d6e00cabb63546773c10680a9
tree 6fb0cdbd124476c88d5711add5f4a6c4bc0770f3
parent 8c5226a0f242be0fc40dad16236b511292115e1b
author H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:07 -0700
committer H. Peter Anvin <hpa@zytor.com> Tue, 27 Jun 2006 20:51:07 -0700

 usr/kinit/Kbuild                    |   28 +
 usr/kinit/README                    |    9 
 usr/kinit/devname.c                 |  114 +++++
 usr/kinit/do_mounts.c               |  221 ++++++++++
 usr/kinit/do_mounts.h               |   48 ++
 usr/kinit/do_mounts_md.c            |  398 ++++++++++++++++++
 usr/kinit/do_mounts_mtd.c           |   44 ++
 usr/kinit/fstype/Kbuild             |   25 +
 usr/kinit/fstype/cramfs_fs.h        |   85 ++++
 usr/kinit/fstype/ext2_fs.h          |   79 ++++
 usr/kinit/fstype/ext3_fs.h          |   92 ++++
 usr/kinit/fstype/fstype.c           |  296 ++++++++++++++
 usr/kinit/fstype/fstype.h           |   23 +
 usr/kinit/fstype/jfs_superblock.h   |  114 +++++
 usr/kinit/fstype/luks_fs.h          |   44 ++
 usr/kinit/fstype/lvm2_sb.h          |   18 +
 usr/kinit/fstype/main.c             |   58 +++
 usr/kinit/fstype/minix_fs.h         |   85 ++++
 usr/kinit/fstype/reiserfs_fs.h      |   69 +++
 usr/kinit/fstype/romfs_fs.h         |   56 +++
 usr/kinit/fstype/swap_fs.h          |   18 +
 usr/kinit/fstype/xfs_sb.h           |   16 +
 usr/kinit/getarg.c                  |   57 +++
 usr/kinit/getintfile.c              |   30 +
 usr/kinit/initrd.c                  |  199 +++++++++
 usr/kinit/ipconfig/Kbuild           |   31 +
 usr/kinit/ipconfig/README           |  103 +++++
 usr/kinit/ipconfig/bootp_packet.h   |   34 ++
 usr/kinit/ipconfig/bootp_proto.c    |  213 ++++++++++
 usr/kinit/ipconfig/bootp_proto.h    |    8 
 usr/kinit/ipconfig/dhcp_proto.c     |  212 ++++++++++
 usr/kinit/ipconfig/dhcp_proto.h     |   18 +
 usr/kinit/ipconfig/ipconfig.h       |   35 ++
 usr/kinit/ipconfig/main.c           |  758 +++++++++++++++++++++++++++++++++++
 usr/kinit/ipconfig/netdev.c         |  251 ++++++++++++
 usr/kinit/ipconfig/netdev.h         |   83 ++++
 usr/kinit/ipconfig/packet.c         |  286 +++++++++++++
 usr/kinit/ipconfig/packet.h         |    9 
 usr/kinit/kinit.c                   |  330 +++++++++++++++
 usr/kinit/kinit.h                   |   73 +++
 usr/kinit/name_to_dev.c             |  202 +++++++++
 usr/kinit/nfsmount/Kbuild           |   27 +
 usr/kinit/nfsmount/README.locking   |   26 +
 usr/kinit/nfsmount/dummypmap.c      |  188 +++++++++
 usr/kinit/nfsmount/dummypmap.h      |   13 +
 usr/kinit/nfsmount/dummypmap_test.c |    2 
 usr/kinit/nfsmount/main.c           |  263 ++++++++++++
 usr/kinit/nfsmount/mount.c          |  357 ++++++++++++++++
 usr/kinit/nfsmount/nfsmount.h       |   39 ++
 usr/kinit/nfsmount/portmap.c        |   73 +++
 usr/kinit/nfsmount/sunrpc.c         |  253 ++++++++++++
 usr/kinit/nfsmount/sunrpc.h         |   99 +++++
 usr/kinit/nfsroot.c                 |  113 +++++
 usr/kinit/open.c                    |   18 +
 usr/kinit/ramdisk_load.c            |  271 +++++++++++++
 usr/kinit/readfile.c                |   86 ++++
 usr/kinit/resume.c                  |   75 +++
 usr/kinit/run-init/Kbuild           |   25 +
 usr/kinit/run-init/run-init.c       |   95 ++++
 usr/kinit/run-init/run-init.h       |   38 ++
 usr/kinit/run-init/runinitlib.c     |  216 ++++++++++
 usr/kinit/xpio.c                    |   51 ++
 usr/kinit/xpio.h                    |   11 +
 63 files changed, 7211 insertions(+), 0 deletions(-)

Patch suppressed due to size (185 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/23-kinit-replacement-for-in-kernel-do-mount-ipconfig-nfsroot.patch
