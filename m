Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932900AbWF2Lpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900AbWF2Lpp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932891AbWF2Lpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:45:45 -0400
Received: from tornado.reub.net ([202.89.145.182]:21725 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932899AbWF2Lpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:45:44 -0400
Message-ID: <44A3BD65.3070201@reub.net>
Date: Thu, 29 Jun 2006 23:45:41 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060623)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm4
References: <20060629013643.4b47e8bd.akpm@osdl.org>
In-Reply-To: <20060629013643.4b47e8bd.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/06/2006 8:36 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm4/
> 
> 
> - The RAID patches have been dropped due to testing failures in -mm3.
> 
> - The SCSI Attached Storage tree (git-sas.patch) has been restored.

This at the end of shutdown:

Sending all processes the TERM signal...
Sending all processes the KILL signal...
Saving random seed:
Syncing hardware clock to system time
Turning off swap:
Unmounting file systems:  ----------- [cut here ] --------- [please bite here ] 
---------
Kernel BUG at fs/dcache.c:600
invalid opcode: 0000 [1] SMP
last sysfs file: /block/fd0/dev
CPU 0
Modules linked in: hidp rfcomm l2cap bluetooth ipv6 ip_gre binfmt_misc ide_cd 
i2c_i801 cdrom serio_raw ide_disk
Pid: 4216, comm: umount Not tainted 2.6.17-mm4 #1
RIP: 0010:[<ffffffff802c4f91>]  [<ffffffff802c4f91>] 
shrink_dcache_for_umount_subtree+0x151/0x260
RSP: 0018:ffff810034bc7db8  EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff81003e8ce928 RCX: ffff810001df1a00
RDX: 00000000000000b8 RSI: ffffffff8025e9b1 RDI: ffff81002542eba8
RBP: ffff810034bc7dd8 R08: 0000000000000000 R09: ffff81003dd1e970
R10: ffff81003dd1e970 R11: ffff81003dd1e960 R12: ffff81003e8ce928
R13: ffff81002542ebb8 R14: ffff81003f6466c0 R15: 0000000000000000
FS:  00002b032cff3750(0000) GS:ffffffff80686000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002b032cbc6000 CR3: 00000000284ac000 CR4: 00000000000006e0
Process umount (pid: 4216, threadinfo ffff810034bc6000, task ffff810037f8d750)
Stack:  ffff81003e1d5c00 ffff81003e1d5c00 ffffffff80584960 ffff810034bc7ec8
  ffff810034bc7df8 ffffffff802c5324 00000000000001e0 ffff81003e1d5c00
  ffff810034bc7e28 ffffffff802bdd64 ffff81003f6466c0 ffff810037d6bcc0
Call Trace:
  [<ffffffff802c5324>] shrink_dcache_for_umount+0x37/0x63
  [<ffffffff802bdd64>] generic_shutdown_super+0x24/0x14f
  [<ffffffff802bdeb5>] kill_block_super+0x26/0x3b
  [<ffffffff802bdf7f>] deactivate_super+0x4a/0x6b
  [<ffffffff8022e08f>] mntput_no_expire+0x56/0x8e
  [<ffffffff802334f1>] path_release_on_umount+0x1d/0x2c
  [<ffffffff802c72b1>] sys_umount+0x251/0x28c
  [<ffffffff8022e0db>] fput+0x14/0x19
  [<ffffffff80223ae8>] filp_close+0x68/0x76
  [<ffffffff8026014a>] system_call+0x7e/0x83


Code: 0f 0b 68 84 62 4b 80 c2 58 02 4c 8b 63 28 4c 39 e3 75 05 45
RIP  [<ffffffff802c4f91>] shrink_dcache_for_umount_subtree+0x151/0x260
  RSP <ffff810034bc7db8>
  /etc/rc6.d/S01reboot: line 14:  4216 Segmentation fault      "$@"

Unmounting file ----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/dcache.c:600
invalid opcode: 0000 [2] SMP
last sysfs file: /block/fd0/dev
CPU 1
Modules linked in: hidp rfcomm l2cap bluetooth ipv6 ip_gre binfmt_misc ide_cd 
i2c_i801 cdrom serio_raw ide_disk
Pid: 4223, comm: umount Not tainted 2.6.17-mm4 #1
RIP: 0010:[<ffffffff802c4f91>] systems (retry): [<ffffffff802c4f91>] 
shrink_dcache_for_umount_subtree+0x151/0x260
RSP: 0018:ffff81001c2eddb8  EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff81003eccf1d8 RCX: ffff810001df9a00
RDX: 00000000000000dd RSI: ffffffff8025e9b1 RDI: ffff8100259f1e58
RBP: ffff81001c2eddd8 R08: 0000000000000000 R09: ffffffffffffffff
R10: ffffffffffffffff R11: ffffffffffffffff R12: ffff81003eccf1d8
R13: ffff8100259f1e68 R14: ffff81003f6467c0 R15: 0000000000000000
FS:  00002b807684d750(0000) GS:ffff810037f10640(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00000036edcdf000 CR3: 000000003f508000 CR4: 00000000000006e0
Process umount (pid: 4223, threadinfo ffff81001c2ec000, task ffff810037fbe890)
Stack:  ffff81003e224c00 ffff81003e224c00 ffffffff80584960 ffff81001c2edec8
  ffff81001c2eddf8 ffffffff802c5324 ffff81001c2ede18 ffff81003e224c00
  ffff81001c2ede28 ffffffff802bdd64 ffff81003f6467c0 ffff81003ed14980
Call Trace:
    [<ffffffff802c5324>] shrink_dcache_for_umount+0x37/0x63
  [<ffffffff802bdd64>] generic_shutdown_super+0x24/0x14f
  [<ffffffff802bdeb5>] kill_block_super+0x26/0x3b
  [<ffffffff802bdf7f>] deactivate_super+0x4a/0x6b
  [<ffffffff8022e08f>] mntput_no_expire+0x56/0x8e
  [<ffffffff802334f1>] path_release_on_umount+0x1d/0x2c
  [<ffffffff802c72b1>] sys_umount+0x251/0x28c
  [<ffffffff8026014a>] system_call+0x7e/0x83


Code: 0f 0b 68 84 62 4b 80 c2 58 02 4c 8b 63 28 4c 39 e3 75 05 45
RIP  [<ffffffff802c4f91>] shrink_dcache_for_umount_subtree+0x151/0x260
  RSP <ffff81001c2eddb8>
  /etc/rc6.d/S01reboot: line 14:  4223 Segmentation fault      "$@"

reuben


