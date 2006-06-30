Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWF3HSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWF3HSP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWF3HSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:18:15 -0400
Received: from tornado.reub.net ([202.89.145.182]:65423 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1751216AbWF3HSO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:18:14 -0400
Message-ID: <44A4D036.1040501@reub.net>
Date: Fri, 30 Jun 2006 19:18:14 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060623)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm4
References: <20060629013643.4b47e8bd.akpm@osdl.org>	<44A3BD65.3070201@reub.net> <20060629105215.02587a67.akpm@osdl.org>
In-Reply-To: <20060629105215.02587a67.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/06/2006 5:52 a.m., Andrew Morton wrote:
> On Thu, 29 Jun 2006 23:45:41 +1200
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> 
>>
>> On 29/06/2006 8:36 p.m., Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm4/
>>>
>>>
>>> - The RAID patches have been dropped due to testing failures in -mm3.
>>>
>>> - The SCSI Attached Storage tree (git-sas.patch) has been restored.
>> This at the end of shutdown:
>>
>> Sending all processes the TERM signal...
>> Sending all processes the KILL signal...
>> Saving random seed:
>> Syncing hardware clock to system time
>> Turning off swap:
>> Unmounting file systems:  ----------- [cut here ] --------- [please bite here ] 
>> ---------
>> Kernel BUG at fs/dcache.c:600
>> invalid opcode: 0000 [1] SMP
>> last sysfs file: /block/fd0/dev
>> CPU 0
>> Modules linked in: hidp rfcomm l2cap bluetooth ipv6 ip_gre binfmt_misc ide_cd 
>> i2c_i801 cdrom serio_raw ide_disk
>> Pid: 4216, comm: umount Not tainted 2.6.17-mm4 #1
>> RIP: 0010:[<ffffffff802c4f91>]  [<ffffffff802c4f91>] 
>> shrink_dcache_for_umount_subtree+0x151/0x260
>> RSP: 0018:ffff810034bc7db8  EFLAGS: 00010202
>> RAX: 0000000000000001 RBX: ffff81003e8ce928 RCX: ffff810001df1a00
>> RDX: 00000000000000b8 RSI: ffffffff8025e9b1 RDI: ffff81002542eba8
>> RBP: ffff810034bc7dd8 R08: 0000000000000000 R09: ffff81003dd1e970
>> R10: ffff81003dd1e970 R11: ffff81003dd1e960 R12: ffff81003e8ce928
>> R13: ffff81002542ebb8 R14: ffff81003f6466c0 R15: 0000000000000000
>> FS:  00002b032cff3750(0000) GS:ffffffff80686000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>> CR2: 00002b032cbc6000 CR3: 00000000284ac000 CR4: 00000000000006e0
>> Process umount (pid: 4216, threadinfo ffff810034bc6000, task ffff810037f8d750)
>> Stack:  ffff81003e1d5c00 ffff81003e1d5c00 ffffffff80584960 ffff810034bc7ec8
>>   ffff810034bc7df8 ffffffff802c5324 00000000000001e0 ffff81003e1d5c00
>>   ffff810034bc7e28 ffffffff802bdd64 ffff81003f6466c0 ffff810037d6bcc0
>> Call Trace:
>>   [<ffffffff802c5324>] shrink_dcache_for_umount+0x37/0x63
>>   [<ffffffff802bdd64>] generic_shutdown_super+0x24/0x14f
>>   [<ffffffff802bdeb5>] kill_block_super+0x26/0x3b
>>   [<ffffffff802bdf7f>] deactivate_super+0x4a/0x6b
>>   [<ffffffff8022e08f>] mntput_no_expire+0x56/0x8e
>>   [<ffffffff802334f1>] path_release_on_umount+0x1d/0x2c
>>   [<ffffffff802c72b1>] sys_umount+0x251/0x28c
>>   [<ffffffff8022e0db>] fput+0x14/0x19
>>   [<ffffffff80223ae8>] filp_close+0x68/0x76
>>   [<ffffffff8026014a>] system_call+0x7e/0x83
>>
> 
> Thanks.  Probably
> destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch went
> wrong, possibly an interaction between
> destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch and
> ro-bind-mounts-*.patch.
> 
> If you have time, please:
> 
> - Confirm that it is reproducible.

It is.  3 out of 3 times that I booted into -mm4, that oops has appeared on 
shutdown.

> - If it is, test http://www.zip.com.au/~akpm/linux/patches/stuff/rf.bz2. 
>   That's a patch against 2.6.17.  It's basically -mm4, with
>   ro-bind-mounts-*.patch removed (and with x86[_64] generic IRQ wired up). 
>   If that fails in the same way, we know that
>   destroy-the-dentries-contributed-by-a-superblock-on-unmounting.patch is
>   the bad guy.

It oopsed again the fourth time which was built with rf.tar.gz, so it looks like 
it's not that patch.  It's definitely the same oops though, the call trace is 
identical.  I changed the version number slightly to identify it:

[Linux version 2.6.17-mm4-rf (root@tornado.reub.net) (gcc version 4.1.1 20060619 
(Red Hat 4.1.1-5)) #1 SMP Fri Jun 30 11:40:30 NZST 2006]

Unmounting file systems:  ----------- [cut here ] --------- [please bite here ] 
---------
Kernel BUG at fs/dcache.c:600
invalid opcode: 0000 [1] SMP
last sysfs file: /kernel/uevent_seqnum
CPU 0
Modules linked in: binfmt_misc ide_cd serio_raw i2c_i801 cdrom ide_disk
Pid: 1465, comm: umount Not tainted 2.6.17-mm4-rf #1
RIP: 0010:[<ffffffff802c48a1>]  [<ffffffff802c48a1>] 
shrink_dcache_for_umount_subtree+0x151/0x260
RSP: 0018:ffff81003e05ddb8  EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff81003f642d80 RCX: ffff81003f642d98
RDX: ffff810001eb3d08 RSI: 0000000000000296 RDI: ffffffff8068c900
RBP: ffff81003e05ddd8 R08: 0000000000000000 R09: ffff81003e6a0970
R10: ffff81003e6a0970 R11: ffff81003e6a0960 R12: ffff81003f642300
R13: ffff81003f642de0 R14: ffff810037d18580 R15: 0000000000000000
FS:  00002b014b2a6750(0000) GS:ffffffff80682000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002b014ae79000 CR3: 000000003e6eb000 CR4: 00000000000006e0
Process umount (pid: 1465, threadinfo ffff81003e05c000, task ffff81003e11c8c0)
Stack:  ffff81003e0ca000 ffff81003e0ca000 ffffffff80583b60 ffff81003e05dec8
  ffff81003e05ddf8 ffffffff802c4c34 ffff81003e05de18 ffff81003e0ca000
  ffff81003e05de28 ffffffff802bd894 ffff810037d18580 ffff810037d8ccc0
Call Trace:
  [<ffffffff802c4c34>] shrink_dcache_for_umount+0x37/0x63
  [<ffffffff802bd894>] generic_shutdown_super+0x24/0x14f
  [<ffffffff802bd9e5>] kill_block_super+0x26/0x3b
  [<ffffffff802bdaaf>] deactivate_super+0x4a/0x6b
  [<ffffffff8022deef>] mntput_no_expire+0x56/0x8e
  [<ffffffff80233341>] path_release_on_umount+0x1d/0x2c
  [<ffffffff802c6bc1>] sys_umount+0x251/0x28c
  [<ffffffff8022df3b>] fput+0x14/0x19
  [<ffffffff80223948>] filp_close+0x68/0x76
  [<ffffffff8025fbfa>] system_call+0x7e/0x83


Code: 0f 0b 68 4e 51 4b 80 c2 58 02 4c 8b 63 28 4c 39 e3 75 05 45
RIP  [<ffffffff802c48a1>] shrink_dcache_for_umount_subtree+0x151/0x260
  RSP <ffff81003e05ddb8>
  /etc/rc6.d/S01reboot: line 14:  1465 Segmentation fault      "$@"


reuben


