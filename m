Return-Path: <linux-kernel-owner+w=401wt.eu-S932697AbXAJDRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbXAJDRc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 22:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbXAJDRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 22:17:32 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:52993 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932697AbXAJDRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 22:17:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TnsHcZJQCjjxHq0+ngTWVtEJ37SlB/wHnUetOZTjI/ZF7aiIX5vi+yaxHU/gacwgZRKsj7Q/zIoRn1lyZjOdKxTV/tcmWm9f3ha9KpX6+wi46XBn0GbB2iEmI/EghKlzchN3ez42CeLGFIW5Dd1UkJdVE3Cvbo8UJTkPN7uMAho=
Message-ID: <a44ae5cd0701091917o13fc3badud118364a5e8be9dd@mail.gmail.com>
Date: Tue, 9 Jan 2007 21:17:30 -0600
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: BUG: bad unlock balance detected! -- [<c017986d>] generic_sync_sb_inodes+0x26a/0x275
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ BUG: bad unlock balance detected! ]
-------------------------------------
swapper/0 is trying to release lock (inode_lock) at:
[<c017986d>] generic_sync_sb_inodes+0x26a/0x275
but there are no more locks to release!

other info that might help us debug this:
1 lock held by swapper/0:
 #0:  (&type->s_umount_key){--..}, at: [<c0161eb2>] sget+0x1e4/0x31c

stack backtrace:
 [<c0104ebb>] show_trace_log_lvl+0x1a/0x2f
 [<c010559b>] show_trace+0x12/0x14
 [<c010564d>] dump_stack+0x16/0x18
 [<c0132252>] print_unlock_inbalance_bug+0xec/0xf9
 [<c013421d>] lock_release_non_nested+0x95/0x150
 [<c013442d>] lock_release+0x155/0x17c
 [<c02d62ce>] _spin_unlock+0x16/0x3d
 [<c017986d>] generic_sync_sb_inodes+0x26a/0x275
 [<c0179895>] sync_sb_inodes+0x1d/0x20
 [<c017990d>] sync_inodes_sb+0x75/0x7d
 [<c0161ff7>] __fsync_super+0xd/0x66
 [<c016205b>] fsync_super+0xb/0x19
 [<c01620b2>] do_remount_sb+0x49/0x101
 [<c016257c>] get_sb_single+0x77/0x8c
 [<c0198c40>] sysfs_get_sb+0x1c/0x1e
 [<c016243b>] vfs_kern_mount+0x81/0xf1
 [<c01624c1>] kern_mount+0x16/0x18
 [<c03d040a>] sysfs_init+0x57/0xa5
 [<c03cefd8>] mnt_init+0xc5/0x1c2
 [<c03ceced>] vfs_caches_init+0x138/0x149
 [<c03be9e8>] start_kernel+0x1fb/0x344
 [<00000000>] 0x0
