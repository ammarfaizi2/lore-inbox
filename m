Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWISKIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWISKIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 06:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbWISKIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 06:08:20 -0400
Received: from lucidpixels.com ([66.45.37.187]:48579 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030191AbWISKIU (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 06:08:20 -0400
Date: Tue, 19 Sep 2006 06:08:18 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Martin Orda <as_lkml@bgnet.pl>
cc: Linux-kernel@vger.kernel.org
Subject: Re: XFS lockups in 2.6.17.13
In-Reply-To: <1158659636.3996.27.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609190607460.9101@p34.internal.lan>
References: <1158659636.3996.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xfs_da_do_buf: bno 16777216
                     ^^^^^^^

That is the XFS bug from 2.6.17 -> 2.6.17.6, if you have never fixed your 
FS to begin with, it will stay corrupted.  Check the XFS FAQ on how to 
fix.

Backup your data first :)

Justin.

On Tue, 19 Sep 2006, Martin Orda wrote:

> Morning,
>
> Please do Cc me as I'm not subscribed. Thank you.
>
> I've been experiencing issues with the XFS filesystem. I use SATA
> Seagate ST3120026AS disk on which I have two partitions. First one is
> used as XFS root partition and the second one is a LVM physical volume.
>
> On my logical volumes I run XFS. I've started getting the lockups /
> oopses after having been running the system for a couple of days. It
> either results in the complete lock-up or IO operations become very
> unstable and dmesg showing errors shown below.
>
> Details:
> distro:		debian/sid
> kernel:		2.6.17.13
> xfsprogs:	2.8.11-1
> lvm2:		2.02.06-2
>
> I've tried rebooting into single mode to minimize the number of daemons
> running and then trying to create files on the partition affected (/usr)
> reading them, listing contents, etc. Nothing happened. But it started to
> show errors once I issued apt-get install something.
>
> After that when I tried to ls /usr I got the IO Error message. Please
> find the kernel output below.
>
> I've gotten this error several times:
>
> 0x0: 00 00 00 00 01 06 6f 47 1d 46 63 41 74 6f 6d 69
> Filesystem "dm-0": XFS internal error xfs_da_do_buf(2) at line 2212 of file fs/xfs/xfs_da_btree.c.  Caller 0xc030193d
> <c0312b8a> xfs_corruption_error+0xe2/0x10a  <c030193d> xfs_da_read_buf+0x30/0x35
> <c033e474> kmem_zone_alloc+0x54/0xcb  <c0300ed4> xfs_da_buf_make+0xe2/0x12f
> <c0301887> xfs_da_do_buf+0x966/0x98d  <c030193d> xfs_da_read_buf+0x30/0x35
> <c030193d> xfs_da_read_buf+0x30/0x35  <c030c4f6> xfs_dir2_node_addname+0x480/0xb0e
> <c030c4f6> xfs_dir2_node_addname+0x480/0xb0e  <c0325743> xlog_write+0x70d/0x7f5
> <c0305bf5> xfs_dir2_isleaf+0x1b/0x50  <c0306553> xfs_dir2_createname+0xfc/0x131
> <c033e506> kmem_zone_zalloc+0x1b/0x43  <c033c268> xfs_link+0x31b/0x4fb
> <c03450f8> xfs_vn_link+0x43/0x90  <c01768cb> mntput_no_expire+0x13/0x72
> <c016b2ef> link_path_walk+0x65/0xcb  <c03380db> xfs_access+0x34/0x3a
> <c0345381> xfs_vn_permission+0x0/0x13  <c0345390> xfs_vn_permission+0xf/0x13
> <c0169105> permission+0x9f/0xa4  <c0169227> vfs_link+0x11d/0x168
> <c016bfa3> sys_linkat+0xdd/0xf9  <c015b8bd> sys_utime+0x48/0x12c
> <c041311d> _atomic_dec_and_lock+0x2d/0x50  <c01729f3> dput+0xfa/0x130
> <c015d122> __fput+0x131/0x194  <c016bfee> sys_link+0x2f/0x33
> <c0102af3> sysenter_past_esp+0x54/0x75
>
>
> And this one just once:
>
> xfs_da_do_buf: bno 16777216
> dir: inode 17256410
> Filesystem "dm-0": XFS internal error xfs_da_do_buf(1) at line 2119 of file fs/xfs/xfs_da_btree.c.  Caller 0xc030193d
> <c030123e> xfs_da_do_buf+0x31d/0x98d  <c030193d> xfs_da_read_buf+0x30/0x35
> <c030193d> xfs_da_read_buf+0x30/0x35  <c030d4e7> xfs_dir2_leafn_lookup_int+0x2c0/0x4f6
> <c030d4e7> xfs_dir2_leafn_lookup_int+0x2c0/0x4f6  <c030193d> xfs_da_read_buf+0x30/0x35
> <c030b88e> xfs_dir2_node_removename+0x30a/0x4ef  <c030b88e> xfs_dir2_node_removename+0x30a/0x4ef
> <c0306777> xfs_dir2_removename+0xee/0xf0  <c033be2e> xfs_remove+0x389/0x4a8
> <c0345381> xfs_vn_permission+0x0/0x13  <c034515c> xfs_vn_unlink+0x17/0x3b
> <c01768cb> mntput_no_expire+0x13/0x72  <c016b2ef> link_path_walk+0x65/0xcb
> <c03329b1> xfs_trans_unlocked_item+0x28/0x3c  <c03380db> xfs_access+0x34/0x3a
> <c0345381> xfs_vn_permission+0x0/0x13  <c0345390> xfs_vn_permission+0xf/0x13
> <c0169105> permission+0x9f/0xa4  <c01696d2> may_delete+0x2b/0x10d
> <c0169c8f> vfs_unlink+0x9c/0xf5  <c016ba7b> do_unlinkat+0xaf/0x12c
> <c0102af3> sysenter_past_esp+0x54/0x75
> Filesystem "dm-0": XFS internal error xfs_trans_cancel at line 1150 of file fs/xfs/xfs_trans.c.  Caller 0xc033be8b
> <c0331cea> xfs_trans_cancel+0xe1/0x102  <c033be8b> xfs_remove+0x3e6/0x4a8
> <c033be8b> xfs_remove+0x3e6/0x4a8  <c0345381> xfs_vn_permission+0x0/0x13
> <c034515c> xfs_vn_unlink+0x17/0x3b  <c01768cb> mntput_no_expire+0x13/0x72
> <c016b2ef> link_path_walk+0x65/0xcb  <c03329b1> xfs_trans_unlocked_item+0x28/0x3c
> <c03380db> xfs_access+0x34/0x3a  <c0345381> xfs_vn_permission+0x0/0x13
> <c0345390> xfs_vn_permission+0xf/0x13  <c0169105> permission+0x9f/0xa4
> <c01696d2> may_delete+0x2b/0x10d  <c0169c8f> vfs_unlink+0x9c/0xf5
> <c016ba7b> do_unlinkat+0xaf/0x12c  <c0102af3> sysenter_past_esp+0x54/0x75
> xfs_force_shutdown(dm-0,0x8) called from line 1151 of file fs/xfs/xfs_trans.c.  Return address = 0xc0348379
> Filesystem "dm-0": Corruption of in-memory data detected.  Shutting down filesystem: dm-0
> Please umount the filesystem, and rectify the problem(s)
>
> This problem affects 2 of my systems which don't run the same hardware
> but have roughtly the same software and  config. Can you please advice
> if this is related to a bug in kernel or userland and suggest some fix
> for that if possible?
>
> BTW: please let me know if I've forgotten to mention some details that
> you could find helpful. Thanks for your help.
>
> -- 
> Kind regards,
> Martin Orda
> http://securityshells.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
