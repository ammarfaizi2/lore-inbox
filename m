Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWHRVic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWHRVic (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 17:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWHRVic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 17:38:32 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:53421 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750893AbWHRVib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 17:38:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JGZQ4MFc1QThvN6JLaRfSOvosrWlzHgMm8MvJsnGAvtRsI0MCjQMNdK/pW9+8VI331GL89qAVMIv7ciwFr8Eqbat20t3LSa+QuBSkPU5+vKByIz5OsEuQ9dtGh9l/Uz5warN+WHUGl5Di1T0AH/H/hcv2PR8QTGWkm6uTeS4lQI=
Message-ID: <6bffcb0e0608181438m3406de08q9a168d486127aef@mail.gmail.com>
Date: Fri, 18 Aug 2006 23:38:30 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0608180957w60d22261k61b272c9b76505bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <b0943d9e0608170801v23592952scf12c2c0b4a7bf4@mail.gmail.com>
	 <b0943d9e0608171458l45b717bexbfb8fb2ba68228db@mail.gmail.com>
	 <6bffcb0e0608180528ocadc36ck8868ae1a33342bb9@mail.gmail.com>
	 <b0943d9e0608180627g61007207read993387bf0c0b4@mail.gmail.com>
	 <6bffcb0e0608180655j50332247m8ed393c37d570ee4@mail.gmail.com>
	 <6bffcb0e0608180715v27015481vb7c603c4be356a21@mail.gmail.com>
	 <b0943d9e0608180846s4ed560b7ld4e3081bdc754454@mail.gmail.com>
	 <6bffcb0e0608180942l12e342epd60dffbb5c5d4b3e@mail.gmail.com>
	 <b0943d9e0608180957w60d22261k61b272c9b76505bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
[snip]
> to radix_tree as well).

cat /sys/kernel/debug/memleak + LTP + patching repo = oops?

BUG: unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c0177468
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
Modules linked in: jfs nls_base xfs reiserfs ext2 loop ipv6 w83627hf
hwmon_vid hwmon i2c_isa af_packet ip_conntrack_netbios_
ns ipt_REJECT xt_state ip_conntrack nfnetlink xt_tcpudp iptable_filter
ip_tables x_tables cpufreq_userspace p4_clockmod spee
dstep_lib binfmt_misc thermal processor fan container evdev
snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_seq_dummy snd_seq_o
ss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss sk98lin
snd_mixer_oss snd_pcm skge snd_timer snd i2c_i801 intel_agp
 soundcore snd_page_alloc ide_cd agpgart cdrom rtc unix
CPU:    0
EIP:    0060:[<c0177468>]    Not tainted VLI
EFLAGS: 00010097   (2.6.18-rc4 #174)
EIP is at memleak_scan+0x58/0x54e
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 6b6b6b6b
esi: 6b6b6b67   edi: 00000000   ebp: de1aaf28   esp: de1aaf10
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 6409, ti=de1aa000 task=e23ee1b0 task.ti=de1aa000)
Stack: 00000000 00000282 00000000 00000000 00000000 c035e220 de1aaf3c c017797e
       00001000 e1ae03d8 c035e220 de1aaf74 c0196654 00000000 00000000 00001000
       0804f000 f08e0c9c c0120ac5 00000001 00000000 00000000 00001000 f08e0c9c
Call Trace:
 [<c017797e>] memleak_seq_start+0x20/0xaa
 [<c0196654>] seq_read+0xc8/0x246
 [<c017988b>] vfs_read+0xa9/0x151
 [<c0179bab>] sys_read+0x3b/0x60
 [<c0105f3d>] sysenter_past_esp+0x56/0x8d
 [<b7f7c410>] 0xb7f7c410
 [<c0106fe3>] show_stack_log_lvl+0x87/0x8f
 [<c0107148>] show_registers+0x11a/0x183
 [<c0107334>] die+0x10f/0x1da
 [<c0120c69>] do_page_fault+0x3ce/0x4a4
 [<c0106b41>] error_code+0x39/0x40
 [<c017797e>] memleak_seq_start+0x20/0xaa
 [<c0196654>] seq_read+0xc8/0x246
 [<c017988b>] vfs_read+0xa9/0x151
 [<c0179bab>] sys_read+0x3b/0x60
 [<c0105f3d>] sysenter_past_esp+0x56/0x8d
Code: 19 c0 85 c0 74 08 0f 0b f3 04 fe bd 31 c0 b8 01 00 00 00 e8 cb
cd fa ff b8 a0 e1 35 c0 e8 e8 32 18 00 8b 15 8c e1 35 c
0 8d 72 fc <8b> 46 04 0f 18 00 90 81 fa 8c e1 35 c0 0f 84 0a 03 00 00 8b 06
EIP: [<c0177468>] memleak_scan+0x58/0x54e SS:ESP 0068:de1aaf10
 <6>note: cat[6409] exited with preempt_count 3
BUG: sleeping function called from invalid context at
/usr/src/linux-work8/mm/slab.c:2904
in_atomic():1, irqs_disabled():1
 [<c0106e59>] show_trace_log_lvl+0x58/0x14c
 [<c0106f5a>] show_trace+0xd/0xf
 [<c010702c>] dump_stack+0x17/0x19
 [<c0126dc6>] __might_sleep+0x92/0x9a
 [<c01745dc>] kmem_cache_zalloc+0x28/0xf5
 [<c0159eee>] taskstats_exit_alloc+0x30/0x6e
 [<c012c844>] do_exit+0x10e/0x46a
 [<c01073f7>] die+0x1d2/0x1da
 [<c0120c69>] do_page_fault+0x3ce/0x4a4
 [<c0106b41>] error_code+0x39/0x40
 [<c0177468>] memleak_scan+0x58/0x54e
 [<c017797e>] memleak_seq_start+0x20/0xaa
 [<c0196654>] seq_read+0xc8/0x246
 [<c017988b>] vfs_read+0xa9/0x151
 [<c0179bab>] sys_read+0x3b/0x60
 [<c0105f3d>] sysenter_past_esp+0x56/0x8d
 [<b7f7c410>] 0xb7f7c410
 [<c0106f5a>] show_trace+0xd/0xf
 [<c010702c>] dump_stack+0x17/0x19
 [<c0126dc6>] __might_sleep+0x92/0x9a
 [<c01745dc>] kmem_cache_zalloc+0x28/0xf5
 [<c0159eee>] taskstats_exit_alloc+0x30/0x6e
 [<c012c844>] do_exit+0x10e/0x46a
 [<c01073f7>] die+0x1d2/0x1da
 [<c0120c69>] do_page_fault+0x3ce/0x4a4
 [<c0106b41>] error_code+0x39/0x40
 [<c017797e>] memleak_seq_start+0x20/0xaa
 [<c0196654>] seq_read+0xc8/0x246
 [<c017988b>] vfs_read+0xa9/0x151
 [<c0179bab>] sys_read+0x3b/0x60
 [<c0105f3d>] sysenter_past_esp+0x56/0x8d
BUG: spinlock lockup on CPU#1, growfiles/6257, c035e1a0
 [<c0106e59>] show_trace_log_lvl+0x58/0x14c
 [<c0106f5a>] show_trace+0xd/0xf
 [<c010702c>] dump_stack+0x17/0x19
 [<c01fedbd>] __spin_lock_debug+0x86/0x93
 [<c01fee28>] _raw_spin_lock+0x5e/0x73
 [<c02fa771>] _spin_lock+0x2a/0x2f
 [<c0176877>] memleak_alloc+0x17b/0x277
 [<c01745a6>] kmem_cache_alloc+0xc0/0xce
 [<c018bc1a>] locks_alloc_lock+0x12/0x14
 [<c018c7ce>] __posix_lock_file_conf+0x64/0x439
 [<c018cbb3>] posix_lock_file+0x10/0x12
 [<c018d8c4>] fcntl_setlk+0x114/0x20e
 [<c0189a94>] do_fcntl+0xf0/0x140
 [<c0189bad>] sys_fcntl64+0x6e/0x82
 [<c0105f3d>] sysenter_past_esp+0x56/0x8d
 [<b7f10410>] 0xb7f10410
 [<c0106f5a>] show_trace+0xd/0xf
 [<c010702c>] dump_stack+0x17/0x19
 [<c01fedbd>] __spin_lock_debug+0x86/0x93
 [<c01fee28>] _raw_spin_lock+0x5e/0x73
 [<c02fa771>] _spin_lock+0x2a/0x2f
 [<c0176877>] memleak_alloc+0x17b/0x277
 [<c01745a6>] kmem_cache_alloc+0xc0/0xce
 [<c018bc1a>] locks_alloc_lock+0x12/0x14
 [<c018c7ce>] __posix_lock_file_conf+0x64/0x439
 [<c018cbb3>] posix_lock_file+0x10/0x12
 [<c018d8c4>] fcntl_setlk+0x114/0x20e
 [<c0189a94>] do_fcntl+0xf0/0x140
 [<c0189bad>] sys_fcntl64+0x6e/0x82
 [<c0105f3d>] sysenter_past_esp+0x56/0x8d

A few minutes later system has died. list *0xc0177468 in gdb shows nothing.

(gdb) l *0xc0177468
0xc0177468 is in memleak_scan (include2/asm/processor.h:1276).
Line number 1271 out of range; include2/asm/processor.h has 746 lines.

(gdb) l *memleak_scan+0x58/0x54e
0xc0177410 is in memleak_scan (/usr/src/linux-work8/mm/memleak.c:1252).
1247            spin_unlock_irqrestore(&memleak_lock, flags);
1248    }
1249
1250    /* Scan the memory and print the orphan pointers */
1251    static void memleak_scan(void)
1252    {
1253            unsigned long flags;
1254            struct memleak_pointer *pointer, *tmp;
1255    #ifdef CONFIG_DEBUG_MEMLEAK_TASK_STACKS
1256            struct task_struct *task;

http://www.stardust.webpages.pl/files/o_bugs/kmemleak-0.9/kml-dmesg3

>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
