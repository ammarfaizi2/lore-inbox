Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVJ0Mdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVJ0Mdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 08:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVJ0Mdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 08:33:40 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:5052 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1750714AbVJ0Mdj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 08:33:39 -0400
Message-ID: <4360C921.9000000@bootc.net>
Date: Thu, 27 Oct 2005 13:33:37 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Badness in __writeback_single_inode
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Using 2.6.14-rc5-mm1 with the spinlock inlining patches reversed and a 
couple of reiser4 patches from namesys.com. I mounted 3 CDs in 
succession (different ones, but same supplier) and the kernel spewed 
these messages out for each of the CDs:

[4417852.503000] ISO 9660 Extensions: Microsoft Joliet Level 3
[4417852.583000] ISOFS: changing to secondary root
[4417852.585000] Badness in __writeback_single_inode at 
fs/fs-writeback.c:251
[4417852.585000]  [<c0177a8d>] __writeback_single_inode+0x18d/0x1a0
[4417852.586000]  [<c0177fe0>] write_inode_now+0x60/0xb0
[4417852.586000]  [<c016f2d7>] generic_forget_inode+0x47/0x110
[4417852.586000]  [<c016f413>] iput+0x53/0x70
[4417852.586000]  [<fa20c09d>] isofs_fill_super+0x55d/0x6a0 [isofs]
[4417852.586000]  [<c021016d>] radix_tree_insert+0x11d/0x130
[4417852.586000]  [<c015c7e4>] get_sb_bdev+0xb4/0x120
[4417852.586000]  [<fa20ce68>] isofs_get_sb+0x18/0x20 [isofs]
[4417852.586000]  [<fa20bb40>] isofs_fill_super+0x0/0x6a0 [isofs]
[4417852.586000]  [<c015ca3d>] do_kern_mount+0x4d/0xc0
[4417852.586000]  [<c0171b97>] do_new_mount+0x97/0xf0
[4417852.586000]  [<c0172246>] do_mount+0x196/0x1b0
[4417852.586000]  [<c013cb1f>] __alloc_pages+0x29f/0x400
[4417852.586000]  [<c0212d3b>] strncpy_from_user+0x3b/0x70
[4417852.586000]  [<c0172059>] copy_mount_options+0x59/0xb0
[4417852.586000]  [<c0172634>] sys_mount+0x74/0xb0
[4417852.586000]  [<c0102b3f>] sysenter_past_esp+0x54/0x75
[4417852.586000] Badness in __sync_single_inode at fs/fs-writeback.c:232
[4417852.586000]  [<c01778a4>] __sync_single_inode+0x1e4/0x240
[4417852.586000]  [<c01779ab>] __writeback_single_inode+0xab/0x1a0
[4417852.586000]  [<c0177fe0>] write_inode_now+0x60/0xb0
[4417852.586000]  [<c016f2d7>] generic_forget_inode+0x47/0x110
[4417852.586000]  [<c016f413>] iput+0x53/0x70
[4417852.586000]  [<fa20c09d>] isofs_fill_super+0x55d/0x6a0 [isofs]
[4417852.586000]  [<c021016d>] radix_tree_insert+0x11d/0x130
[4417852.586000]  [<c015c7e4>] get_sb_bdev+0xb4/0x120
[4417852.586000]  [<fa20ce68>] isofs_get_sb+0x18/0x20 [isofs]
[4417852.586000]  [<fa20bb40>] isofs_fill_super+0x0/0x6a0 [isofs]
[4417852.586000]  [<c015ca3d>] do_kern_mount+0x4d/0xc0
[4417852.586000]  [<c0171b97>] do_new_mount+0x97/0xf0
[4417852.586000]  [<c0172246>] do_mount+0x196/0x1b0
[4417852.586000]  [<c013cb1f>] __alloc_pages+0x29f/0x400
[4417852.586000]  [<c0212d3b>] strncpy_from_user+0x3b/0x70
[4417852.586000]  [<c0172059>] copy_mount_options+0x59/0xb0
[4417852.586000]  [<c0172634>] sys_mount+0x74/0xb0
[4417852.586000]  [<c0102b3f>] sysenter_past_esp+0x54/0x75

Everything seemed to work just fine mind you, just scary messages. :-)

Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
