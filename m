Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422730AbWAMQax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422730AbWAMQax (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 11:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422734AbWAMQax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 11:30:53 -0500
Received: from dolly.gnuher.de ([212.227.64.154]:33007 "EHLO dolly.gnuher.de")
	by vger.kernel.org with ESMTP id S1422730AbWAMQax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 11:30:53 -0500
Date: Fri, 13 Jan 2006 17:30:43 +0100
From: Sven Geggus <sven@geggus.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.15: oops in sysfs_create_link
Message-ID: <20060113163043.GA5417@geggus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-MimeOLE: Produced By Exchange Microsoft V6.6.6
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel people,

the attached oops happens when I try to create an md-array on an aoe device
in conjunction with vanilla Kernel 2.6.15+drbd+aoe:

--cut--
kernel BUG at fs/sysfs/symlink.c:87!
invalid operand: 0000 [#1]
SMP 
Modules linked in: aoe
CPU:    0
EIP:    0060:[<c01762f7>]    Not tainted VLI
EFLAGS: 00010246   (2.6.15-jupiter-frontend) 
EIP is at sysfs_create_link+0x18/0x4e
eax: f1b9e8bc   ebx: 00000000   ecx: c031954c   edx: f7cac700
esi: f1b9e880   edi: f7d77000   ebp: f1b9e8bc   esp: f153bdbc
ds: 007b   es: 007b   ss: 0068
Process mdadm (pid: 13983, threadinfo=f153a000 task=f6ddba30)
Stack: f153bdf0 c02ab6b2 f1b9e8bc f72cbe10 c031954c ffffffff f1b9e880
c020cbbc 
       f1b9e8d4 f1b9e880 c02abf08 f1b9e8bc f4f27690 65687465 652f6472
00302e31 
       c0155502 f4f27690 ee9e511e 459ecce4 00000010 00000010 f1b9e880
f7d77000 
Call Trace:
 [<c02ab6b2>] bind_rdev_to_array+0x13c/0x14b
 [<c020cbbc>] kobject_init+0xe/0x3a
 [<c02abf08>] md_import_device+0x83/0x16e
 [<c0155502>] __link_path_walk+0xabe/0xbb5
 [<c02ad6db>] add_new_disk+0x24e/0x2ff
 [<c020e2aa>] radix_tree_gang_lookup_tag+0x42/0x5c
 [<c0210356>] copy_from_user+0x3a/0x60
 [<c02ae556>] md_ioctl+0x3df/0x4f6
 [<c0138a89>] pagevec_lookup+0x1a/0x21
 [<c0138e97>] invalidate_mapping_pages+0xa0/0xb5
 [<c02075d2>] blkdev_driver_ioctl+0x40/0x58
 [<c0207731>] blkdev_ioctl+0x147/0x154
 [<c0150443>] block_ioctl+0x1a/0x1e
 [<c0158488>] do_ioctl+0x28/0x66
 [<c0158758>] vfs_ioctl+0x17e/0x18c
 [<c0158791>] sys_ioctl+0x2b/0x46
 [<c01027a1>] syscall_call+0x7/0xb
Code: 15 fc ff 5e 53 e8 69 15 fc ff 59 89 e8 5a 5b 5e 5f 5d c3 53 8b 44 24
08 8b 4c 24 10 85 c0 8b 58 30 74 08 85 db 74 04 85 c9 75 08 <0f> 0b 57 00 e8
34 32 c0 8b 53 0c f0 ff 4a 74 0f 88 c4 01 00 00 
--cut--

Oops happens while the following ioctl is running:

ioctl(3, 0x40140921 <unfinished ...>

fd3 is /dev/md0

The command I have been using was:
mdadm -C --level=raid1 -n 2 --auto=md /dev/md0 /dev/etherd/e1.0 /dev/etherd/e2.0

Concerning the strace Output I would assume a bug in the md code rather
than aoe. Unfortunaltely I am unable to test this with generic IDE devices.

Regards

Sven

-- 
"Those who do not understand Unix are condemned to reinvent it, poorly"
(Henry Spencer)

/me is giggls@ircnet, http://sven.gegg.us/ on the Web
