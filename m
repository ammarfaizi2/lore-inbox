Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbTBBVZd>; Sun, 2 Feb 2003 16:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTBBVZd>; Sun, 2 Feb 2003 16:25:33 -0500
Received: from dot.freshdot.net ([195.64.80.165]:65292 "EHLO dot.freshdot.net")
	by vger.kernel.org with ESMTP id <S265612AbTBBVZb>;
	Sun, 2 Feb 2003 16:25:31 -0500
Date: Sun, 2 Feb 2003 22:35:00 +0100
From: Sander Smeenk <ssmeenk@freshdot.net>
To: linux-kernel@vger.kernel.org
Subject: KernelPanic with 2.5.53 & 59 in tcp_v4_get_port?
Message-ID: <20030202213500.GH2630@freshdot.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I run exim 4.12 on my system, and while doing a restart of that service
on a system running 2.5.53 at that moment...

: Unable to handle kernel paging request at virtual address 5a5a5aa3
:  printing eip:
: c02df929
: *pde = 00000000
: Oops: 0000
: CPU:    0
: EIP:    0060:[tcp_v4_get_port+377/720]    Not tainted
: EFLAGS: 00010246
: EIP is at tcp_v4_get_port+0x179/0x2d0
: eax: 5a5a5a5a   ebx: 00000019   ecx: deb6fb00   edx: dadba844
: esi: df71b2cc   edi: 00000001   ebp: deb6fc4c   esp: db64feb0
: ds: 0068   es: 0068   ss: 0068
: Process exim4 (pid: 11613, threadinfo=db64e000 task=c525c180)
: Stack: db64e000 deb6fb00 deb6fc4c ffffffea 00000000 c01ddd4b 00000001 dfc000c8 
:        c02ef3ee deb6fb00 00000019 c916d2f0 db64ff14 00000010 bffff1c8 00000003 
:        00190010 c02b55b4 c916d2f0 db64ff14 00000010 00000001 bffff190 00000010 
: Call Trace:
:  [capable+27/64] capable+0x1b/0x40
:  [inet_bind+398/720] inet_bind+0x18e/0x2d0
:  [sys_bind+84/128] sys_bind+0x54/0x80
:  [sock_setsockopt+48/1488] sock_setsockopt+0x30/0x5d0
:  [inet_setsockopt+42/64] inet_setsockopt+0x2a/0x40
:  [sys_setsockopt+97/128] sys_setsockopt+0x61/0x80
:  [copy_from_user+51/64] copy_from_user+0x33/0x40
:  [sys_socketcall+124/512] sys_socketcall+0x7c/0x200
:  [syscall_call+7/11] syscall_call+0x7/0xb
: 
: Code: f6 40 49 20 75 31 8b 4c 24 24 8b 42 04 39 41 04 75 25 85 ff 
:  <0>Kernel panic: Aiee, killing interrupt handler!
: In interrupt handler - not syncing

Does anyone have any idea why this happened? It looks like there's
something in exim that binds to port 25 but also makes the kernel panic.

But that's not all... 

I try to "save what's left to save" by doing MagicSysRQ to unmount my
disks and that resulted in this huge loop-ish kernel-oops. I have pasted
only one section of them, the complete log (1068 lines!) is at:
  http://www.hoho.nl/~ssmeenk/kernelpanic.txt

:  <6>SysRq : Emergency Remount R/O
: Remounting device ide0(3,2) ... <3>bad: scheduling while atomic!
: Call Trace:
:  [schedule+61/704] schedule+0x3d/0x2c0
:  [sleep_on+91/144] sleep_on+0x5b/0x90
:  [default_wake_function+0/64] default_wake_function+0x0/0x40
:  [log_wait_commit+193/272] log_wait_commit+0xc1/0x110
:  [ext3_sync_fs+76/144] ext3_sync_fs+0x4c/0x90
:  [fsync_super+81/128] fsync_super+0x51/0x80
:  [fsync_bdev+27/64] fsync_bdev+0x1b/0x40
:  [go_sync+204/352] go_sync+0xcc/0x160
:  [do_emergency_sync+94/256] do_emergency_sync+0x5e/0x100
:  [panic+222/224] panic+0xde/0xe0
:  [do_exit+32/928] do_exit+0x20/0x3a0
:  [die+119/128] die+0x77/0x80
:  [do_page_fault+743/1044] do_page_fault+0x2e7/0x414
:  [do_page_fault+0/1044] do_page_fault+0x0/0x414
:  [do_generic_mapping_read+854/880] do_generic_mapping_read+0x356/0x370
:  [__generic_file_aio_read+445/480] __generic_file_aio_read+0x1bd/0x1e0
:  [error_code+45/56] error_code+0x2d/0x38
:  [tcp_v4_get_port+377/720] tcp_v4_get_port+0x179/0x2d0
:  [capable+27/64] capable+0x1b/0x40
:  [inet_bind+398/720] inet_bind+0x18e/0x2d0
:  [sys_bind+84/128] sys_bind+0x54/0x80
:  [sock_setsockopt+48/1488] sock_setsockopt+0x30/0x5d0
:  [inet_setsockopt+42/64] inet_setsockopt+0x2a/0x40
:  [sys_setsockopt+97/128] sys_setsockopt+0x61/0x80
:  [copy_from_user+51/64] copy_from_user+0x33/0x40
:  [sys_socketcall+124/512] sys_socketcall+0x7c/0x200
:  [syscall_call+7/11] syscall_call+0x7/0xb

< .. and more .. >

Nothing to do now but reboot Ctrl-Alt-SysRQ-B ...

I hope this helps and that someone will be able to spot a possible
cause? I only experience this behaviour with exim4 ...

i'm running lvm2, with ext3, i'm telling you because I see stuff about
device mapper, ext3 and syncing.

With regards,
Sander.

-- 
| Today is the first day of the rest of your life
| 1024D/08CEC94D - 34B3 3314 B146 E13C 70C8  9BDB D463 7E41 08CE C94D
