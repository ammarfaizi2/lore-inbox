Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbULYPQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbULYPQn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 10:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbULYPQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 10:16:43 -0500
Received: from mail1.skjellin.no ([80.239.42.67]:45194 "EHLO mx1.skjellin.no")
	by vger.kernel.org with ESMTP id S261279AbULYPQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 10:16:41 -0500
Message-ID: <41CD8438.10207@tomt.net>
Date: Sat, 25 Dec 2004 16:16:08 +0100
From: Andre Tomt <andre@tomt.net>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10, lockup on lvrename of a snapshot volume
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

device-mapper snapshots lock up the kernel if you lvrename the snapshot 
volume. The original volume has to be mounted for this to happen.

pvcreate /dev/hdb1
vgcreate testvg /dev/hdb1
lvcreate -L10G -n test testvg
mke2fs -j /dev/mapper/testvg-test
mount /dev/mapper/testvg-test /mnt

lvcreate -s -l 128 -n test_backup testvg/test
lvrename testvg test_backup test_backup.tmp
<lockup>


SysRq Trace of lvrename:
dm_unplug_all [dm_mod]
io_shedule
sync_buffer
sync_buffer
__wait_on_bit
out_of_line_wait_on_bit
sync_buffer
wake_bit_function
wake_bit_function
sync_dirty_buffer
ext3_unlockfs [ext3]
thaw_bdev
__unlock_fs [dm_mod]
dm_resume [dm_mod]
do_resume [dm_mod]
dev_suspend [dm_mod]
ctl_ioctl [dm_mod]
sys_ioctl
syscall_call

LVM2 version is 2.00.24 (Debian Sarge userland), kernel 2.6.10 from 
kernel.org. It has been reported that this affects 2.6.9 also, but I 
have not verified this myself.
