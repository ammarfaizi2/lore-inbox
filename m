Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275419AbTHIV6s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 17:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275421AbTHIV6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 17:58:48 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:50949 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S275419AbTHIV6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 17:58:44 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.0-test3 - loop oopses
Date: Sun, 10 Aug 2003 01:56:51 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308100156.51201.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot create initrd under 2.6.0-test3 anymore. It oopses in mount or 
unmount and shortly after system hangs due to oopses in bdflush. 

-andrey

Here are oopses I had:

Aug 10 00:16:35 localhost kernel: Unable to handle kernel paging request at 
virtual address c224d140
Aug 10 00:16:35 localhost kernel: printing eip:
Aug 10 00:16:35 localhost kernel: c014dfc9
Aug 10 00:16:35 localhost kernel: *pde = 0000a067
Aug 10 00:16:35 localhost kernel: *pte = 0224d000
Aug 10 00:16:35 localhost kernel: Oops: 0000 [#2]
Aug 10 00:16:35 localhost kernel: CPU:    0
Aug 10 00:16:35 localhost kernel: EIP:    0060:[<c014dfc9>]    Tainted: P
Aug 10 00:16:35 localhost kernel: EFLAGS: 00010246
Aug 10 00:16:35 localhost kernel: EIP is at file_ra_state_init+0x19/0x30
Aug 10 00:16:35 localhost kernel: eax: c224d140   ebx: c8679004   ecx: 
00000000   edx: c8679054
Aug 10 00:16:35 localhost kernel: esi: c6cb1004   edi: c8679078   ebp: 
c0f53f2c   esp: c0f53f28
Aug 10 00:16:35 localhost kernel: ds: 007b   es: 007b   ss: 0068
Aug 10 00:16:35 localhost kernel: Process mount (pid: 2693, 
threadinfo=c0f52000 task=c0a72000)
Aug 10 00:16:35 localhost kernel: Stack: cffaf224 c0f53f54 c0168404 c8679054 
c7d480a0 00000004 cc0c8004 ffffffe9
Aug 10 00:16:35 localhost kernel: 00008000 cebe1000 bfffec10 c0f53f9c c0168391 
cc0c8004 cffaf224 00008000
Aug 10 00:16:35 localhost kernel: cc0c8004 cffaf224 0000000a bfffec10 bfffec10 
00000101 00000001 00008001
Aug 10 00:16:35 localhost kernel: Call Trace:
Aug 10 00:16:35 localhost kernel: [<c0168404>] dentry_open+0x64/0x240
Aug 10 00:16:35 localhost kernel: [<c0168391>] filp_open+0x51/0x60
Aug 10 00:16:35 localhost kernel: [<c016893f>] sys_open+0x3f/0x70
Aug 10 00:16:35 localhost kernel: [<c010b7a7>] syscall_call+0x7/0xb
Aug 10 00:16:35 localhost kernel:
Aug 10 00:16:35 localhost kernel: Code: 8b 00 89 42 18 5f 5d c3 eb 0d 90 90 90 
90 90 90 90 90 90 90

next one

Aug 10 01:15:42 localhost kernel: Unable to handle kernel paging request at 
virtual address ccc55148
Aug 10 01:15:42 localhost kernel: printing eip:
Aug 10 01:15:42 localhost kernel: c0148b77
Aug 10 01:15:42 localhost kernel: *pde = 00035067
Aug 10 01:15:42 localhost kernel: *pte = 0cc55000
Aug 10 01:15:42 localhost kernel: Oops: 0000 [#1]
Aug 10 01:15:42 localhost kernel: CPU:    0
Aug 10 01:15:42 localhost kernel: EIP:    0060:[<c0148b77>]    Tainted: P
Aug 10 01:15:42 localhost kernel: EFLAGS: 00010246
Aug 10 01:15:42 localhost kernel: EIP is at __filemap_fdatawrite+0x77/0x140
Aug 10 01:15:42 localhost kernel: eax: ccc55140   ebx: 00000000   ecx: 
cf55db04   edx: 00000001
Aug 10 01:15:42 localhost kernel: esi: cb6290a0   edi: cf55daec   ebp: 
c4691f08   esp: c4691ea8
Aug 10 01:15:42 localhost kernel: ds: 007b   es: 007b   ss: 0068
Aug 10 01:15:42 localhost kernel: Process umount (pid: 21707, 
threadinfo=c4690000 task=c46b8000)
Aug 10 01:15:42 localhost kernel: Stack: 00000000 00000082 c4691ebc c013e6fb 
80010c00 00000000 00000001 00000000
Aug 10 01:15:42 localhost kernel: 00000000 00000000 00000000 00000000 00000000 
00000000 00000001 00000000
Aug 10 01:15:42 localhost kernel: 00000000 00000000 00000000 00000000 00000000 
00000000 cf55daec cf55daec
Aug 10 01:15:42 localhost kernel: Call Trace:
Aug 10 01:15:42 localhost kernel: [<c013e6fb>] kernel_text_address+0x3b/0x50
Aug 10 01:15:42 localhost kernel: [<c0148c59>] filemap_fdatawrite+0x19/0x20
Aug 10 01:15:42 localhost kernel: [<c016d9e6>] sync_blockdev+0x26/0x50
Aug 10 01:15:42 localhost kernel: [<c0176411>] blkdev_put+0x241/0x260
Aug 10 01:15:42 localhost kernel: [<c0176430>] blkdev_close+0x0/0x20
Aug 10 01:15:42 localhost kernel: [<c016d16d>] __fput+0x13d/0x150
Aug 10 01:15:42 localhost kernel: [<c016b44b>] filp_close+0x4b/0x80
Aug 10 01:15:42 localhost kernel: [<c016b510>] sys_close+0x90/0x110
Aug 10 01:15:42 localhost kernel: [<c010b97f>] syscall_call+0x7/0xb
Aug 10 01:15:42 localhost kernel:
Aug 10 01:15:42 localhost kernel: Code: 8b 50 08 31 c0 85 d2 75 7f bf 00 e0 ff 
ff 21 e7 ff 47 14 8d

next one

Aug 10 00:16:21 localhost kernel: loop: loaded (max 8 devices)
Aug 10 00:16:23 localhost kernel: Unable to handle kernel paging request at 
virtual address c224d148
Aug 10 00:16:23 localhost kernel: printing eip:
Aug 10 00:16:23 localhost kernel: c0147107
Aug 10 00:16:23 localhost kernel: *pde = 0000a067
Aug 10 00:16:23 localhost kernel: *pte = 0224d000
Aug 10 00:16:23 localhost kernel: Oops: 0000 [#1]
Aug 10 00:16:23 localhost kernel: CPU:    0
Aug 10 00:16:23 localhost kernel: EIP:    0060:[<c0147107>]    Tainted: P
Aug 10 00:16:23 localhost kernel: EFLAGS: 00010246
Aug 10 00:16:23 localhost kernel: EIP is at __filemap_fdatawrite+0x77/0x140
Aug 10 00:16:23 localhost kernel: eax: c224d140   ebx: cf55dce0   ecx: 
cf55dcf8   edx: 00000001
Aug 10 00:16:23 localhost kernel: esi: c7d480a0   edi: cf55dce0   ebp: 
c066bf04   esp: c066beac
Aug 10 00:16:23 localhost kernel: ds: 007b   es: 007b   ss: 0068
Aug 10 00:16:23 localhost kernel: Process umount (pid: 2523, 
threadinfo=c066a000 task=c0add000)
Aug 10 00:16:23 localhost kernel: Stack: c066bec0 c011e3e5 80010c00 00000000 
00000001 00000000 00000000 00000000
Aug 10 00:16:23 localhost kernel: 00000000 00000000 00000000 00000000 00000001 
00000000 00000000 00000000
Aug 10 00:16:23 localhost kernel: 00000000 00000000 00000000 cf55dce0 c7d480a0 
cf55dce0 c066bf14 c01471de
Aug 10 00:16:23 localhost kernel: Call Trace:
Aug 10 00:16:23 localhost kernel: [<c011e3e5>] 
smp_apic_timer_interrupt+0xe5/0x150
Aug 10 00:16:23 localhost kernel: [<c01471de>] filemap_fdatawrite+0xe/0x20
Aug 10 00:16:23 localhost kernel: [<c016ac4d>] sync_blockdev+0x1d/0x40
Aug 10 00:16:23 localhost kernel: [<c01730a2>] blkdev_put+0x232/0x250
Aug 10 00:16:23 localhost kernel: [<c016a437>] __fput+0x137/0x150
Aug 10 00:16:23 localhost kernel: [<c01689c8>] filp_close+0x38/0x60
Aug 10 00:16:23 localhost kernel: [<c0168a82>] sys_close+0x92/0x120
Aug 10 00:16:23 localhost kernel: [<c010b7a7>] syscall_call+0x7/0xb
Aug 10 00:16:23 localhost kernel:
Aug 10 00:16:23 localhost kernel: Code: 8b 50 08 31 c0 85 d2 0f 85 82 00 00 00 
bf 00 e0 ff ff 21 e7

and more

Aug 10 00:19:45 localhost kernel: loop: loaded (max 8 devices)
Aug 10 00:19:46 localhost kernel: Unable to handle kernel paging request at 
virtual address ce9fb148
Aug 10 00:19:46 localhost kernel: printing eip:
Aug 10 00:19:46 localhost kernel: c0147107
Aug 10 00:19:46 localhost kernel: *pde = 0003c067
Aug 10 00:19:46 localhost kernel: *pte = 0e9fb000
Aug 10 00:19:46 localhost kernel: Oops: 0000 [#1]
Aug 10 00:19:46 localhost kernel: CPU:    0
Aug 10 00:19:46 localhost kernel: EIP:    0060:[<c0147107>]    Not tainted
Aug 10 00:19:46 localhost kernel: EFLAGS: 00010246
Aug 10 00:19:46 localhost kernel: EIP is at __filemap_fdatawrite+0x77/0x140
Aug 10 00:19:46 localhost kernel: eax: ce9fb140   ebx: c8927830   ecx: 
c8927848   edx: 00000001
Aug 10 00:19:46 localhost kernel: esi: c3b010a0   edi: c8927830   ebp: 
c366ff04   esp: c366feac
Aug 10 00:19:46 localhost kernel: ds: 007b   es: 007b   ss: 0068
Aug 10 00:19:46 localhost kernel: Process umount (pid: 2253, 
threadinfo=c366e000 task=c3694000)
Aug 10 00:19:46 localhost kernel: Stack: c366fed4 c012208b c1248f38 00000000 
00000001 00000000 00000000 00000000
Aug 10 00:19:46 localhost kernel: 00000000 00000000 00000000 00000000 00000001 
00000000 00000000 00000000
Aug 10 00:19:46 localhost kernel: 00000000 00000000 00000000 c8927830 c3b010a0 
c8927830 c366ff14 c01471de
Aug 10 00:19:46 localhost kernel: Call Trace:
Aug 10 00:19:46 localhost kernel: [<c012208b>] change_page_attr+0xab/0xe0
Aug 10 00:19:46 localhost kernel: [<c01471de>] filemap_fdatawrite+0xe/0x20
Aug 10 00:19:46 localhost kernel: [<c016ac4d>] sync_blockdev+0x1d/0x40
Aug 10 00:19:46 localhost kernel: [<c01730a2>] blkdev_put+0x232/0x250
Aug 10 00:19:46 localhost kernel: [<c016a437>] __fput+0x137/0x150
Aug 10 00:19:46 localhost kernel: [<c01689c8>] filp_close+0x38/0x60
Aug 10 00:19:46 localhost kernel: [<c0168a82>] sys_close+0x92/0x120
Aug 10 00:19:46 localhost kernel: [<c010b7a7>] syscall_call+0x7/0xb
Aug 10 00:19:46 localhost kernel:
Aug 10 00:19:46 localhost kernel: Code: 8b 50 08 31 c0 85 d2 0f 85 82 00 00 00 
bf 00 e0 ff ff 21 e7

