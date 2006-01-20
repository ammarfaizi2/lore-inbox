Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWATXWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWATXWz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 18:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWATXWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 18:22:55 -0500
Received: from tornado.reub.net ([202.89.145.182]:50876 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932127AbWATXWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 18:22:54 -0500
Message-ID: <43D170CB.8080802@reub.net>
Date: Sat, 21 Jan 2006 12:22:51 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060119)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>
Subject: Re: 2.6.16-rc1-mm2
References: <20060120031555.7b6d65b7.akpm@osdl.org>
In-Reply-To: <20060120031555.7b6d65b7.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/01/2006 12:15 a.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm2/
> 
> 
> - This kernel has a big ACPI update
> 
> - reiser3 should be safe(r) to use.
> 
> 
> Known problems:
> 
> - You'll probably see something like this
> 
> Memory: 4017084k/6291456k available (2896k kernel code, 176452k reserved, 1868k data, 208k init)
> BUG: sleeping function called from invalid context at kernel/mutex.c:84         in_atomic():1, irqs_disabled():0
> Call Trace: <ffffffff8012374e>{__might_sleep+177} <ffffffff803cd7da>{mutex_lock+26}
> <ffffffff8016b533>{kmem_cache_create+161} <ffffffff8063b0fb>{free_all_boo
> 
> 
>   in early boot.  Please ignore.
> 
> - drivers/i2c/busses/scx200_acb.c doesn't compile on architectures which
>   don't have asm/msr.h.

Seems good here so far (yet to fully test, -mm1 broke reiser too bad for me to 
test that very much).

Noted this when shutting down:

Starting killall:  [  OK  ]
Sending all processes the TERM signal...
Sending all processes the KILL signal...
Saving random seed:
Syncing hardware clock to system time
Turning off swap:
Unmounting pipe file systems:
Unmounting file systems:
Please stand by while rebooting the system...
md: stopping all md devices.
md: md1 switched to read-only mode.
BUG: unable to handle kernel NULL pointer dereference<6>md: md2 switched to 
read-only mode.
  at virtual address 0000001c
  printing eip:
b02a6951
*pde = 00000000
Oops: 0000 [#1]
SMP
last sysfs file: /devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e/vrm
Modules linked in: iptable_mangle iptable_nat ip_nat ip_conntrack nfnetlink 
iptable_filter ip_tables nfsd exportfs lockd sunrpc ipv6 ip_gre binfmt_misc 
serio_raw piix hw_random
CPU:    0
EIP:    0060:[<b02a6951>]    Not tainted VLI
EFLAGS: 00010002   (2.6.16-rc1-mm2 #1)
EIP is at bitmap_daemon_work+0x144/0x391
eax: 0000001c   ebx: b17fbc00   ecx: b17fbc00   edx: 00000286
esi: efdb7ec0   edi: 00000206   ebp: efc90e4c   esp: efc90e24
ds: 007b   es: 007b   ss: 0068
Process md2_raid1 (pid: 382, threadinfo=efc90000 task=efca4030)
Stack: <0>00000000 efdb7eec 0003c9f0 b17fbc00 00000000 0003d1ef 00000020 efdc2340
        efdaec00 efc90000 efc90e8c b02a25a7 efc90e5c b0313488 efc90e68 0000001e
        b0456364 00000001 00000000 efc90eb4 b0115d87 b0456368 efc90f2c efdc2340
Call Trace:
  [<b0103bf5>] show_stack_log_lvl+0xc5/0xea
  [<b0103db7>] show_registers+0x19d/0x22b
  [<b0103f70>] die+0x12b/0x23b
  [<b01140d4>] do_page_fault+0x27a/0x5de
  [<b0103737>] error_code+0x4f/0x54
  [<b02a25a7>] md_check_recovery+0x1a/0x44a
  [<b029b645>] raid1d+0x2e/0xf55
  [<b02a32c4>] md_thread+0x44/0x14f
  [<b012ea27>] kthread+0xa5/0xca
  [<b0100d25>] kernel_thread_helper+0x5/0xb
Code: 00 83 45 e0 01 8b 4d e0 39 4e 1c 77 9b 8b 45 e4 85 c0 74 4f 8b 45 dc e8 9e 
cb 06 00 89 c2 8b 4d e4 8b 41 14 01 c0 01 c0 03 46 4c <8b> 08 f6 c1 04 0f 84 50 
01 00 00 83 e1 fb 89 08 8b 45 dc e8 22
  <6>md: md3 switched to read-only mode.
md: md4 switched to read-only mode.
md: md5 switched to read-only mode.
md: md0 still in use.
Synchronizing SCSI cache for disk sdc:
Synchronizing SCSI cache for disk sdb:
Synchronizing SCSI cache for disk sda:
Restarting system.

reuben


