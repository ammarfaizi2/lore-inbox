Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263847AbUG2GWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbUG2GWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 02:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbUG2GWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 02:22:16 -0400
Received: from asmodis.mb-net.net ([193.22.253.2]:32991 "EHLO
	asmodis.mb-net.net") by vger.kernel.org with ESMTP id S263847AbUG2GWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 02:22:03 -0400
Date: Thu, 29 Jul 2004 08:22:01 +0200
From: Michael Bussmann <bus@mb-net.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.[67]: Kernel NULL ptr dereference (Box hangs, semi-accepting connections)
Message-ID: <20040729062201.GA30125@ruf098.fkie.fgan.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag: Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since I upgraded to 2.6.6 (or 2.6.7) I'm experiencing a strange problem.
The machine worked flawlessly for several weeks running 2.6.2.

>From time to time (usually after 1-4 days update) the box seems to hang.
It still reacts to ICMP ECHO, answers ARP, it even accepts connections
for ports where daemons listen on (like ssh, httpd), however it seems no
data is passed to the applications, so that connections will time out.

SysRq still works, you can type at the login prompt, but no login is
possible, it just hangs after typing your user name.

I was able to capture a kernel message right before the box went into this
state.  It's attached to this piece of mail.

There were some other messages with tg3_* in it, but I couldn't write them
down.  I'll try another NIC (and deactivate the on-board tg3) this weekend.
(It's a production system, so I can't do that many tests).

Has anyone experienced simimar problems or can shed some light on this?

Thanks in advance for any information.

Cheers,
MB

Hardware:
	MSI E7505 Master
	2 x Xeon 2.4 GHz (SMP Kernel, HT enabled)
	Broadcom BCM5703CKHB on board (using the tg3 driver)
	ICP Vortex GDT 6113RS RAID-1

LVM2, swap on LV

Kernel message:

| ksymoops 2.4.9 on i686 2.6.2.  Options used
|      -v /boot/2.6.7/vmlinux (specified)
|      -K (specified)
|      -l /proc/modules (default)
|      -o /lib/modules/2.6.7 (specified)
|      -m /boot/2.6.7/System.map (specified)
| 
| No modules in ksyms, skipping objects
| No ksyms, skipping lsmod
| Jul 28 19:07:04 ruf098 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000068
| Jul 28 19:07:04 ruf098 kernel: c014695b
| Jul 28 19:07:04 ruf098 kernel: CPU:    2
| Jul 28 19:07:04 ruf098 kernel: EIP:    0060:[<c014695b>]    Not tainted
| Using defaults from ksymoops -t elf32-i386 -a i386
| Jul 28 19:07:04 ruf098 kernel: EFLAGS: 00010246   (2.6.7)
| Jul 28 19:07:04 ruf098 kernel: eax: 00000000   ebx: f2906564   ecx: f2906564   edx: f7c80e64
| Jul 28 19:07:04 ruf098 kernel: esi: c171d420   edi: 00000000   ebp: 00000000   esp: f7c80e20
| Jul 28 19:07:04 ruf098 kernel: ds: 007b   es: 007b   ss: 0068
| Jul 28 19:07:04 ruf098 kernel: Stack: fffd3174 00000007 f2906564 c171d420 f4ff73e0 00000000 c0146ad8 c171d420
| Jul 28 19:07:04 ruf098 kernel:        f2906564 f7c80e64 0000000c 0000000c f4d113c8 0000000c 00000000 f4ff73dc
| Jul 28 19:07:04 ruf098 kernel:        00000000 00000001 f4f322ec 00000040 00000000 00000000 c171d420 c0397d80
| Jul 28 19:07:04 ruf098 kernel: Call Trace:
| Jul 28 19:07:04 ruf098 kernel:  [<c0146ad8>] page_referenced+0x90/0x164
| Jul 28 19:07:04 ruf098 kernel:  [<c013e958>] refill_inactive_zone+0x4dd/0x580
| Jul 28 19:07:04 ruf098 kernel:  [<c0165f8c>] dput+0x21/0x193
| Jul 28 19:07:04 ruf098 kernel:  [<c0166463>] prune_dcache+0x140/0x16b
| Jul 28 19:07:04 ruf098 kernel:  [<c0166806>] shrink_dcache_memory+0x1f/0x28
| Jul 28 19:07:04 ruf098 kernel:  [<c013eaa0>] shrink_zone+0xa5/0xe4
| Jul 28 19:07:04 ruf098 kernel:  [<c013ee79>] balance_pgdat+0x1b8/0x221
| Jul 28 19:07:04 ruf098 kernel:  [<c013efb2>] kswapd+0xd0/0xee
| Jul 28 19:07:04 ruf098 kernel:  [<c0118814>] autoremove_wake_function+0x0/0x57
| Jul 28 19:07:04 ruf098 kernel:  [<c0103e0e>] ret_from_fork+0x6/0x14
| Jul 28 19:07:04 ruf098 kernel:  [<c0118814>] autoremove_wake_function+0x0/0x57
| Jul 28 19:07:04 ruf098 kernel:  [<c013eee2>] kswapd+0x0/0xee
| Jul 28 19:07:04 ruf098 kernel:  [<c0102271>] kernel_thread_helper+0x5/0xb
| Jul 28 19:07:04 ruf098 kernel: Code: 8b 5f 68 85 db 0f 84 95 00 00 00 8b 46 14 8b 51 04 2b 41 48
| 
| 
| >>EIP; c014695b <sys_msync+a4/125>   <=====
| 
| >>ebx; f2906564 <pg0+32433564/3fb2b000>
| >>ecx; f2906564 <pg0+32433564/3fb2b000>
| >>edx; f7c80e64 <pg0+377ade64/3fb2b000>
| >>esi; c171d420 <pg0+124a420/3fb2b000>
| >>esp; f7c80e20 <pg0+377ade20/3fb2b000>
| 
| Trace; c0146ad8 <__anon_vma_merge+b/7a>
| Trace; c013e958 <refill_inactive_zone+1cd/580>
| Trace; c0165f8c <lock_may_write+5f/e6>
| Trace; c0166463 <d_invalidate+55/bc>
| Trace; c0166806 <shrink_dcache_sb+68/18f>
| Trace; c013eaa0 <refill_inactive_zone+315/580>
| Trace; c013ee79 <try_to_free_pages+27/17f>
| Trace; c013efb2 <try_to_free_pages+160/17f>
| Trace; c0118814 <free_task+9/2f>
| Trace; c0103e0e <ret_from_fork+6/14>
| Trace; c0118814 <free_task+9/2f>
| Trace; c013eee2 <try_to_free_pages+90/17f>
| Trace; c0102271 <kernel_thread_helper+5/b>
| 
| Code;  c014695b <sys_msync+a4/125>
| 00000000 <_EIP>:
| Code;  c014695b <sys_msync+a4/125>   <=====
|    0:   8b 5f 68                  mov    0x68(%edi),%ebx   <=====
| Code;  c014695e <sys_msync+a7/125>
|    3:   85 db                     test   %ebx,%ebx
| Code;  c0146960 <sys_msync+a9/125>
|    5:   0f 84 95 00 00 00         je     a0 <_EIP+0xa0>
| Code;  c0146966 <sys_msync+af/125>
|    b:   8b 46 14                  mov    0x14(%esi),%eax
| Code;  c0146969 <sys_msync+b2/125>
|    e:   8b 51 04                  mov    0x4(%ecx),%edx
| Code;  c014696c <sys_msync+b5/125>
|   11:   2b 41 48                  sub    0x48(%ecx),%eax
| 
-- 
Michael Bussmann <bus@mb-net.net>
BOFH excuse #74:

You're out of memory
