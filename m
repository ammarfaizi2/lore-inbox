Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030472AbWBHGUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWBHGUP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbWBHGUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:20:15 -0500
Received: from tornado.reub.net ([202.89.145.182]:4741 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1030472AbWBHGUL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:20:11 -0500
Message-ID: <43E98D98.2090805@reub.net>
Date: Wed, 08 Feb 2006 19:20:08 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060206)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, kaber@trash.net
Subject: Re: 2.6.16-rc1-mm5
References: <20060203000704.3964a39f.akpm__33726.4416892596$1138954098$gmane$org@osdl.org>
In-Reply-To: <20060203000704.3964a39f.akpm__33726.4416892596$1138954098$gmane$org@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/02/2006 9:07 p.m., Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm5/
> 
> 
> - The ntp/time rework patches from John Stultz have been resurrected and fixed.
> 
> - There's now a `hot-fixes' directory at the above URL.  Please look in
>   there for any updates which should be applied.
> 
> 
> Known problems:

[Andrew just released another -mm while I was typing this one up]

I've been hunting down some hard-to-catch reboots in the last two -mm releases 
that leave no traces in the log other than an abrupt halt of all logging, at 
first I thought I was chasing a Netfilter problem but after a few days of full 
Netfilter debugging on, I came to the conclusion that the problem wasn't 
necessarily Netfilter specific as I was still seeing reboots with no Netfilter 
errors logged immediately before the crash.  With most of the debugging options 
turned on in "Kernel Hacking" and the machine running like a dog for a few days, 
it seemed stable (unfortunately).

Anyway, I might have finally hit the jackpot this time, as it only ever seemed 
to crash when I was at work.  But I'm here, and it just did it...

Fedora Core release 4 (Rawhide)
Kernel 2.6.16-rc1-mm5 on an i686

tornado.reub.net login: BUG: unable to handle kernel paging request at virtual 
address b0446000
  printing eip:
b013fe7a
*pde = 018e9163
*pte = 00446000
Oops: 0002 [#1]
SMP
last sysfs file: /devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e/vrm
Modules linked in: nfsd exportfs lockd sunrpc lm85 hwmon_vid eeprom ipv6 ip_gre 
iptable_filter iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle 
ip_tables binfmt_misc ide_cd cdrom serio_raw piix hw_random i2c_i801
CPU:    1
EIP:    0060:[<b013fe7a>]    Not tainted VLI
EFLAGS: 00010282   (2.6.16-rc1-mm5 #1)
EIP is at get_page_from_freelist+0x325/0x386
eax: 00000000   ebx: b10088c0   ecx: 00000400   edx: b03c2780
esi: 00000000   edi: b0446000   ebp: b2bddeb8   esp: b2bdde5c
ds: 007b   es: 007b   ss: 0068
Process check_ifopersta (pid: 21337, threadinfo=b2bdd000 task=b4974ab0)
Stack: <0>00000002 00000044 b0446000 b03c2900 00000001 00000001 00000000 b03c2780
        00000000 00000002 00000000 000280d2 b03c35ac b10088c0 00000000 b2bddfa0
        00000282 00000001 00000000 00000001 b03c35a8 b4974ab0 000280d2 b2bddef8
Call Trace:
  [<b0103bf5>] show_stack_log_lvl+0xc5/0xea
  [<b0103db8>] show_registers+0x19e/0x22b
  [<b0103f61>] die+0x11c/0x22c
  [<b01137c4>] do_page_fault+0x27a/0x5de
  [<b0103737>] error_code+0x4f/0x54
  [<b013ff30>] __alloc_pages+0x55/0x2bf
  [<b0147a53>] __handle_mm_fault+0x6e5/0x7fb
  [<b0113917>] do_page_fault+0x3cd/0x5de
  [<b0103737>] error_code+0x4f/0x54
Code: db 0f 8e 2e ff ff ff 8b 5d d8 c7 45 dc 00 00 00 00 31 f6 ba 03 00 00 00 89 
d8 e8 4f 46 fd ff 89 45 <1>BUG: unable to handle kernel paging request at 
virtual address b0444000
  printing eip:
b013fe7a
*pde = 018e9163
*pte = 00444000
ac b9 00 04 00 00 89 c7 89 f0 <f3> ab ba 03 00 00 00 8b 45 ac e8 b2 46 fd ff 83 
45 dc 01 83 c3
  <0>Oops: 0002 [#2]
note: check_ifopersta[21337] exited with preempt_count 1
SMP
last sysfs file: /devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e/vrm
Modules linked in: nfsd exportfs lockd sunrpc lm85 hwmon_vid eeprom ipv6 ip_gre 
iptable_filter iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle 
ip_tables binfmt_misc ide_cd cdrom serio_raw piix hw_random i2c_i801
CPU:    0
EIP:    0060:[<b013fe7a>]    Not tainted VLI
EFLAGS: 00010282   (2.6.16-rc1-mm5 #1)
EIP is at get_page_from_freelist+0x325/0x386
eax: 00000000   ebx: b1008880   ecx: 00000400   edx: b03c2780
esi: 00000000   edi: b0444000   ebp: e2857eb8   esp: e2857e5c
ds: 007b   es: 007b   ss: 0068
Process python (pid: 2532, threadinfo=e2857000 task=de395570)
Stack: <0>00000002 00000044 b0444000 b03c2900 00000001 00000001 00000000 b03c2780
        00000000 00000002 00000000 000280d2 b03c35ac b1008880 00000000 b016629f
        00000286 00000001 00000000 00000001 b03c35a8 de395570 000280d2 e2857ef8
Call Trace:
  [<b0103bf5>] show_stack_log_lvl+0xc5/0xea
  [<b0103db8>] show_registers+0x19e/0x22b
  [<b0103f61>] die+0x11c/0x22c
  [<b01137c4>] do_page_fault+0x27a/0x5de
  [<b0103737>] error_code+0x4f/0x54
  [<b013ff30>] __alloc_pages+0x55/0x2bf
  [<b0147a53>] __handle_mm_fault+0x6e5/0x7fb
  [<b0113917>] do_page_fault+0x3cd/0x5de
  [<b0103737>] error_code+0x4f/0x54
Code: db 0f 8e 2e ff ff ff 8b 5d d8 c7 45 dc 00 00 00 00 31 f6 ba 03 00 00 00 89 
d8 e8 4f 46 fd ff 89 45 ac b9 00 04 00 00 89 c7 89 f0 <f3> ab ba 03 00 00 00 8b 
45 ac e8 b2 46 fd ff 83 45 dc 01 83 c3
  <6>note: python[2532] exited with preempt_count 1
BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
  [<b010412b>] show_trace+0xd/0xf
  [<b0104251>] dump_stack+0x17/0x19
  [<b0114eb1>] __might_sleep+0xa0/0xa7
  [<b011d386>] exit_mm+0x32/0x164
  [<b011e9ba>] do_exit+0x108/0x845
  [<b0104071>] do_trap+0x0/0x9e
  [<b01137c4>] do_page_fault+0x27a/0x5de
  [<b0103737>] error_code+0x4f/0x54
  [<b013ff30>] __alloc_pages+0x55/0x2bf
  [<b0147a53>] __handle_mm_fault+0x6e5/0x7fb
  [<b0113917>] do_page_fault+0x3cd/0x5de
  [<b0103737>] error_code+0x4f/0x54
BUG: unable to handle kernel paging request at virtual address b0445000
BUG: unable to handle kernel paging request at virtual address b0412004
  printing eip:
b016986e
*pde = 018e9163
*pte = 00412000
Oops: 0002 [#3]
SMP
last sysfs file: /devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e/vrm
Modules linked in: nfsd exportfs lockd sunrpc lm85 hwmon_vid eeprom ipv6 ip_gre 
iptable_filter iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle 
ip_tables binfmt_misc ide_cd cdrom serio_raw piix hw_random i2c_i801
CPU:    0
EIP:    0060:[<b016986e>]    Not tainted VLI
EFLAGS: 00010286   (2.6.16-rc1-mm5 #1)
EIP is at __pollwait+0x9f/0xd2
eax: b0412008   ebx: 00000014   ecx: 00000000   edx: b0412000
esi: 00000000   edi: e9b5ec50   ebp: e9b5ebf8   esp: e9b5ebe4
ds: 007b   es: 007b   ss: 0068
Process dovecot (pid: 2235, threadinfo=e9b5e000 task=efc3e570)
Stack: <0>c290b000 d25b82c0 c290b000 e9b5ec50 d25b82c0 e9b5ec14 b0162a80 cf8b4254
        00000000 00000020 d25b82c0 00000014 e9b5efa0 b0168a80 e9b5ec50 e9b5efa8
        08073ed0 000000d0 08073fa0 e9b5ee90 e9b5ee90 0000001a e9b5ec50 00000000
Call Trace:
  [<b0103bf5>] show_stack_log_lvl+0xc5/0xea
  [<b0103db8>] show_registers+0x19e/0x22b
  [<b0103f61>] die+0x11c/0x22c
  [<b01137c4>] do_page_fault+0x27a/0x5de
  [<b0103737>] error_code+0x4f/0x54
  [<b0162a80>] pipe_poll+0x2c/0xae
  [<b0168a80>] do_sys_poll+0x25f/0x47d
  [<b0168cda>] sys_poll+0x3c/0x4e
  [<b0102b3f>] sysenter_past_esp+0x54/0x75
Code: 5d c3 85 f6 74 10 8b 56 04 83 c2 1c 8d 86 00 10 00 00 39 c2 76 1f 31 d2 b8 
d0 00 00 00 e8 35 69 fd ff 89 c2 85 c0 74 18 8d 40 08 <89> 42 04 89 32 89 57 04 
89 d6 8b 4e 04 8d 41 1c 89 46 04 eb 82
  <1> printing eip:
b013fe7a
*pde = 018e9163
*pte = 00445000
Oops: 0002 [#4]
SMP
last sysfs file: /devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e/vrm
Modules linked in: nfsd exportfs lockd sunrpc lm85 hwmon_vid eeprom ipv6 ip_gre 
iptable_filter iptable_nat ip_nat ip_conntrack nfnetlink iptable_mangle 
ip_tables binfmt_misc ide_cd cdrom serio_raw piix hw_random i2c_i801
CPU:    1
EIP:    0060:[<b013fe7a>]    Not tainted VLI
EFLAGS: 00010282   (2.6.16-rc1-mm5 #1)
EIP is at get_page_from_freelist+0x325/0x386
eax: 00000000   ebx: b10088a0   ecx: 00000400   edx: b03c2780
esi: 00000000   edi: b0445000   ebp: b3253cb0   esp: b3253c54
ds: 007b   es: 007b   ss: 0068
Process gdb (pid: 21399, threadinfo=b3253000 task=bedc8570)
Stack: <0>00000002 00000044 b0445000 b03c2900 00000001 00000001 00000000 b03c2780
        00000000 00000002 00000000 000280d2 b03c35ac b10088a0 00000000 00000000
        00000282 00000001 00000000 00000001 b03c35a8 bedc8570 000280d2 b3253cf0
Call Trace:
  [<b0103bf5>] show_stack_log_lvl+0xc5/0xea
  [<b0103db8>] show_registers+0x19e/0x22b
  [<b0103f61>] die+0x11c/0x22c
  [<b01137c4>] do_page_fault+0x27a/0x5de
  [<b0103737>] error_code+0x4f/0x54
  [<b013ff30>] __alloc_pages+0x55/0x2bf
  [<b0147a53>] __handle_mm_fault+0x6e5/0x7fb
  [<b0113917>] do_page_fault+0x3cd/0x5de
  [<b0103737>] error_code+0x4f/0x54
  [<b013b9b9>] do_generic_mapping_read+0x2a4/0x4bf
  [<b013c33b>] __generic_file_aio_read+0xe3/0x230
  [<b013d808>] generic_file_read+0x8e/0xae
  [<b0157dc1>] vfs_read+0x89/0x144
  [<b015828b>] sys_read+0x3d/0x64
  [<b0102b3f>] sysenter_past_esp+0x54/0x75
Code: db 0f 8e 2e ff ff ff 8b 5d d8 c7 45 dc 00 00 00 00 31 f6 ba 03 00 00 00 89 
d8 e8 4f 46 fd ff 89 45 ac b9 00 04 00 00 89 c7 89 f0 <f3> ab ba 03 00 00 00 8b 
45 ac e8 b2 46 fd ff 83 45 dc 01 83 c3
  <6>note: gdb[21399] exited with preempt_count 1
BUG: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
  [<b010412b>] show_trace+0xd/0xf
  [<b0104251>] dump_stack+0x17/0x19
  [<b0114eb1>] __might_sleep+0xa0/0xa7
  [<b011d386>] exit_mm+0x32/0x164
  [<b011e9ba>] do_exit+0x108/0x845
  [<b0104071>] do_trap+0x0/0x9e
  [<b01137c4>] do_page_fault+0x27a/0x5de
  [<b0103737>] error_code+0x4f/0x54
  [<b013ff30>] __alloc_pages+0x55/0x2bf
  [<b0147a53>] __handle_mm_fault+0x6e5/0x7fb
  [<b0113917>] do_page_fault+0x3cd/0x5de
  [<b0103737>] error_code+0x4f/0x54
  [<b013b9b9>] do_generic_mapping_read+0x2a4/0x4bf
  [<b013c33b>] __generic_file_aio_read+0xe3/0x230
  [<b013d808>] generic_file_read+0x8e/0xae
  [<b0157dc1>] vfs_read+0x89/0x144
  [<b015828b>] sys_read+0x3d/0x64
  [<b0102b3f>] sysenter_past_esp+0x54/0x75

The only patch applied to this release was this one in a thread started by 
Ulrich Drepper:

--- devel/fs/namei.c~nameic-unlock-missing-in-error-case        2006-02-04 15:57
:22.000000000 -0800
+++ devel-akpm/fs/namei.c       2006-02-04 16:07:56.000000000 -0800

I'll build an rc2-mm1 now and see how we go, but I guess it'd still be good to 
know if this one was ever fixed or not.

reuben
