Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263634AbTI2Pwu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTI2Pwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:52:49 -0400
Received: from citrine.spiritone.com ([216.99.193.133]:2956 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S263634AbTI2Pvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:51:55 -0400
Date: Mon, 29 Sep 2003 08:50:44 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: cesarb@nitnet.com.br
Subject: [Bug 1284] New: Asus P5AB broken BIOS reading ESCD 
Message-ID: <42150000.1064850644@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Asus P5AB broken BIOS reading ESCD
    Kernel Version: 2.6.0-test6
            Status: NEW
          Severity: normal
             Owner: mbligh@aracnet.com
         Submitter: cesarb@nitnet.com.br


Distribution: Debian testing/unstable
Hardware Environment: Asus P5AB
Software Environment:
Problem Description:

Trying to read /proc/bus/pnp/escd causes an oops. Looks like the PnPBIOS is
broken. However, it's not exploding_pnp_bios, since only reading the escd causes
it (the boot probe works fine).

I think a new function should be added to the DMI blacklist to block trying to
read the ESCD.

Steps to reproduce:
cat /proc/bus/pnp/escd

Oops output:
Sep 28 23:57:00 seed kernel: PnPBIOS: get_stat_res: use ESCD instead
Sep 29 00:20:30 seed kernel: Unable to handle kernel paging request at virtual
address ffffd000
Sep 29 00:20:30 seed kernel:  printing eip:
Sep 29 00:20:30 seed kernel: 00007ba4
Sep 29 00:20:30 seed kernel: *pde = 00002067
Sep 29 00:20:30 seed kernel: *pte = 00000000
Sep 29 00:20:30 seed kernel: Oops: 0000 [#1]
Sep 29 00:20:30 seed kernel: CPU:    0
Sep 29 00:20:30 seed kernel: EIP:    0098:[<00007ba4>]    Not tainted
Sep 29 00:20:30 seed kernel: EFLAGS: 00010003
Sep 29 00:20:30 seed kernel: EIP is at 0x7ba4
Sep 29 00:20:30 seed kernel: eax: 000000b0   ebx: 00b0d07b   ecx: 00000400  
edx: 00000000
Sep 29 00:20:30 seed kernel: esi: 0000d000   edi: c34a0000   ebp: c34a3eac  
esp: c34a3e84
Sep 29 00:20:30 seed kernel: ds: 00b0   es: 00a8   ss: 0068
Sep 29 00:20:30 seed kernel: Process lsescd (pid: 1971, threadinfo=c34a2000
task=c4751360)
Sep 29 00:20:30 seed kernel: Stack: 00000000 00a0d000 00a07bb9 d049d4eb 00002000
007b007b 0202d016 008600a8 
Sep 29 00:20:30 seed kernel:        00000000 0090000b 00000042 00b000a8 000000a0
00000000 c0280768 00000060 
Sep 29 00:20:30 seed kernel:        00000082 00000000 00000000 0000007b 0000007b
00000202 c34a2000 00000000 
Sep 29 00:20:30 seed kernel: Call Trace:
Sep 29 00:20:30 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:20:30 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:20:30 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:20:30 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:20:30 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:20:30 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:20:30 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:20:30 seed kernel: 
Sep 29 00:20:30 seed kernel: Code:  Bad EIP value.
Sep 29 00:20:30 seed kernel:  <6>note: lsescd[1971] exited with preempt_count 2
Sep 29 00:20:30 seed kernel: bad: scheduling while atomic!
Sep 29 00:20:30 seed kernel: Call Trace:
Sep 29 00:20:30 seed kernel:  [schedule+1395/1408] schedule+0x573/0x580
Sep 29 00:20:30 seed kernel:  [unmap_vmas+464/576] unmap_vmas+0x1d0/0x240
Sep 29 00:20:30 seed kernel:  [exit_mmap+98/384] exit_mmap+0x62/0x180
Sep 29 00:20:30 seed kernel:  [mmput+89/160] mmput+0x59/0xa0
Sep 29 00:20:30 seed kernel:  [do_exit+281/992] do_exit+0x119/0x3e0
Sep 29 00:20:30 seed kernel:  [die+187/192] die+0xbb/0xc0
Sep 29 00:20:30 seed kernel:  [do_page_fault+267/1031] do_page_fault+0x10b/0x407
Sep 29 00:20:30 seed kernel:  [journal_end+19/32] journal_end+0x13/0x20
Sep 29 00:20:30 seed kernel:  [proc_alloc_inode+68/128] proc_alloc_inode+0x44/0x80
Sep 29 00:20:30 seed kernel:  [proc_alloc_inode+68/128] proc_alloc_inode+0x44/0x80
Sep 29 00:20:30 seed kernel:  [get_new_inode_fast+46/224]
get_new_inode_fast+0x2e/0xe0
Sep 29 00:20:30 seed kernel:  [do_page_fault+0/1031] do_page_fault+0x0/0x407
Sep 29 00:20:30 seed kernel:  [error_code+45/64] error_code+0x2d/0x40
Sep 29 00:20:30 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:20:30 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:20:30 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:20:30 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:20:30 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:20:30 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:20:30 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:20:30 seed kernel: 
Sep 29 00:20:39 seed kernel: Unable to handle kernel paging request at virtual
address ffffd000
Sep 29 00:20:39 seed kernel:  printing eip:
Sep 29 00:20:39 seed kernel: 00007ba4
Sep 29 00:20:39 seed kernel: *pde = 00002067
Sep 29 00:20:39 seed kernel: *pte = 00000000
Sep 29 00:20:39 seed kernel: Oops: 0000 [#2]
Sep 29 00:20:39 seed kernel: CPU:    0
Sep 29 00:20:39 seed kernel: EIP:    0098:[<00007ba4>]    Not tainted
Sep 29 00:20:39 seed kernel: EFLAGS: 00010003
Sep 29 00:20:39 seed kernel: EIP is at 0x7ba4
Sep 29 00:20:39 seed kernel: eax: 000000b0   ebx: 00b0d07b   ecx: 00000400  
edx: 00000000
Sep 29 00:20:39 seed kernel: esi: 0000d000   edi: c18b0000   ebp: c18b7eac  
esp: c18b7e84
Sep 29 00:20:39 seed kernel: ds: 00b0   es: 00a8   ss: 0068
Sep 29 00:20:39 seed kernel: Process lsescd (pid: 1974, threadinfo=c18b6000
task=c4751980)
Sep 29 00:20:39 seed kernel: Stack: 00000000 00a0d000 00a07bb9 d049d4eb 00006000
007b007b 0202d016 008600a8 
Sep 29 00:20:39 seed kernel:        00000000 0090000b 00000042 00b000a8 000000a0
00000000 c0280768 00000060 
Sep 29 00:20:39 seed kernel:        00000082 00000000 00000000 0000007b 0000007b
00000202 c18b6000 00000000 
Sep 29 00:20:39 seed kernel: Call Trace:
Sep 29 00:20:39 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:20:39 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:20:39 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:20:39 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:20:39 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:20:39 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:20:39 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:20:39 seed kernel: 
Sep 29 00:20:39 seed kernel: Code:  Bad EIP value.
Sep 29 00:20:39 seed kernel:  <6>note: lsescd[1974] exited with preempt_count 2
Sep 29 00:20:39 seed kernel: bad: scheduling while atomic!
Sep 29 00:20:39 seed kernel: Call Trace:
Sep 29 00:20:39 seed kernel:  [schedule+1395/1408] schedule+0x573/0x580
Sep 29 00:20:39 seed kernel:  [unmap_vmas+464/576] unmap_vmas+0x1d0/0x240
Sep 29 00:20:39 seed kernel:  [exit_mmap+98/384] exit_mmap+0x62/0x180
Sep 29 00:20:39 seed kernel:  [mmput+89/160] mmput+0x59/0xa0
Sep 29 00:20:39 seed kernel:  [do_exit+281/992] do_exit+0x119/0x3e0
Sep 29 00:20:39 seed kernel:  [die+187/192] die+0xbb/0xc0
Sep 29 00:20:39 seed kernel:  [do_page_fault+267/1031] do_page_fault+0x10b/0x407
Sep 29 00:20:39 seed kernel:  [kmem_cache_alloc+44/64] kmem_cache_alloc+0x2c/0x40
Sep 29 00:20:39 seed kernel:  [proc_alloc_inode+68/128] proc_alloc_inode+0x44/0x80
Sep 29 00:20:39 seed kernel:  [proc_alloc_inode+68/128] proc_alloc_inode+0x44/0x80
Sep 29 00:20:39 seed kernel:  [buffered_rmqueue+187/384] buffered_rmqueue+0xbb/0x180
Sep 29 00:20:39 seed kernel:  [do_page_fault+0/1031] do_page_fault+0x0/0x407
Sep 29 00:20:39 seed kernel:  [error_code+45/64] error_code+0x2d/0x40
Sep 29 00:20:39 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:20:39 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:20:39 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:20:39 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:20:39 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:20:39 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:20:39 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:20:39 seed kernel: 
Sep 29 00:21:07 seed kernel: Unable to handle kernel paging request at virtual
address ffffd000
Sep 29 00:21:07 seed kernel:  printing eip:
Sep 29 00:21:07 seed kernel: 00007ba4
Sep 29 00:21:07 seed kernel: *pde = 00002067
Sep 29 00:21:07 seed kernel: *pte = 00000000
Sep 29 00:21:07 seed kernel: Oops: 0000 [#3]
Sep 29 00:21:07 seed kernel: CPU:    0
Sep 29 00:21:07 seed kernel: EIP:    0098:[<00007ba4>]    Not tainted
Sep 29 00:21:07 seed kernel: EFLAGS: 00010003
Sep 29 00:21:07 seed kernel: EIP is at 0x7ba4
Sep 29 00:21:07 seed kernel: eax: 000000b0   ebx: 00b0d07b   ecx: 00000400  
edx: 00000000
Sep 29 00:21:07 seed kernel: esi: 0000d000   edi: c18b0000   ebp: c18b7eac  
esp: c18b7e84
Sep 29 00:21:07 seed kernel: ds: 00b0   es: 00a8   ss: 0068
Sep 29 00:21:07 seed kernel: Process lsescd (pid: 1984, threadinfo=c18b6000
task=c4751360)
Sep 29 00:21:07 seed kernel: Stack: 00000000 00a0d000 00a07bb9 d049d4eb 00006000
007b007b 0202d016 008600a8 
Sep 29 00:21:07 seed kernel:        00000000 0090000b 00000042 00b000a8 000000a0
00000000 c0280768 00000060 
Sep 29 00:21:07 seed kernel:        00000082 00000000 00000000 0000007b 0000007b
00000202 c18b6000 00000000 
Sep 29 00:21:07 seed kernel: Call Trace:
Sep 29 00:21:07 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:21:07 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:21:07 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:21:07 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:21:07 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:21:07 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:21:07 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:21:07 seed kernel: 
Sep 29 00:21:07 seed kernel: Code:  Bad EIP value.
Sep 29 00:21:07 seed kernel:  <6>note: lsescd[1984] exited with preempt_count 2
Sep 29 00:21:07 seed kernel: bad: scheduling while atomic!
Sep 29 00:21:07 seed kernel: Call Trace:
Sep 29 00:21:07 seed kernel:  [schedule+1395/1408] schedule+0x573/0x580
Sep 29 00:21:07 seed kernel:  [unmap_vmas+464/576] unmap_vmas+0x1d0/0x240
Sep 29 00:21:07 seed kernel:  [exit_mmap+98/384] exit_mmap+0x62/0x180
Sep 29 00:21:07 seed kernel:  [mmput+89/160] mmput+0x59/0xa0
Sep 29 00:21:07 seed kernel:  [do_exit+281/992] do_exit+0x119/0x3e0
Sep 29 00:21:07 seed kernel:  [die+187/192] die+0xbb/0xc0
Sep 29 00:21:07 seed kernel:  [do_page_fault+267/1031] do_page_fault+0x10b/0x407
Sep 29 00:21:08 seed kernel:  [journal_end+19/32] journal_end+0x13/0x20
Sep 29 00:21:08 seed kernel:  [proc_alloc_inode+68/128] proc_alloc_inode+0x44/0x80
Sep 29 00:21:08 seed kernel:  [proc_alloc_inode+68/128] proc_alloc_inode+0x44/0x80
Sep 29 00:21:08 seed kernel:  [pty_write+422/448] pty_write+0x1a6/0x1c0
Sep 29 00:21:08 seed kernel:  [do_page_fault+0/1031] do_page_fault+0x0/0x407
Sep 29 00:21:08 seed kernel:  [error_code+45/64] error_code+0x2d/0x40
Sep 29 00:21:08 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:21:08 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:21:08 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:21:08 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:21:08 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:21:08 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:21:08 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:21:08 seed kernel: 
Sep 29 00:21:14 seed kernel: Unable to handle kernel paging request at virtual
address ffffd000
Sep 29 00:21:14 seed kernel:  printing eip:
Sep 29 00:21:14 seed kernel: 00007ba4
Sep 29 00:21:14 seed kernel: *pde = 00002067
Sep 29 00:21:14 seed kernel: *pte = 00000000
Sep 29 00:21:14 seed kernel: Oops: 0000 [#4]
Sep 29 00:21:14 seed kernel: CPU:    0
Sep 29 00:21:14 seed kernel: EIP:    0098:[<00007ba4>]    Not tainted
Sep 29 00:21:14 seed kernel: EFLAGS: 00010003
Sep 29 00:21:14 seed kernel: EIP is at 0x7ba4
Sep 29 00:21:14 seed kernel: eax: 000000b0   ebx: 00b0d07b   ecx: 00000400  
edx: 00000000
Sep 29 00:21:14 seed kernel: esi: 0000d000   edi: c18b0000   ebp: c18b7eac  
esp: c18b7e84
Sep 29 00:21:14 seed kernel: ds: 00b0   es: 00a8   ss: 0068
Sep 29 00:21:14 seed kernel: Process lsescd (pid: 1987, threadinfo=c18b6000
task=c4750720)
Sep 29 00:21:14 seed kernel: Stack: 00000000 00a0d000 00a07bb9 d049d4eb 00006000
007b007b 0202d016 008600a8 
Sep 29 00:21:14 seed kernel:        00000000 0090000b 00000042 00b000a8 000000a0
00000000 c0280768 00000060 
Sep 29 00:21:14 seed kernel:        00000082 00000000 00000000 0000007b 0000007b
00000202 c18b6000 00000000 
Sep 29 00:21:14 seed kernel: Call Trace:
Sep 29 00:21:14 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:21:14 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:21:14 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:21:14 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:21:14 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:21:14 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:21:14 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:21:14 seed kernel: 
Sep 29 00:21:14 seed kernel: Code:  Bad EIP value.
Sep 29 00:21:14 seed kernel:  <6>note: lsescd[1987] exited with preempt_count 2
Sep 29 00:21:14 seed kernel: bad: scheduling while atomic!
Sep 29 00:21:14 seed kernel: Call Trace:
Sep 29 00:21:14 seed kernel:  [schedule+1395/1408] schedule+0x573/0x580
Sep 29 00:21:14 seed kernel:  [unmap_vmas+464/576] unmap_vmas+0x1d0/0x240
Sep 29 00:21:14 seed kernel:  [exit_mmap+98/384] exit_mmap+0x62/0x180
Sep 29 00:21:14 seed kernel:  [mmput+89/160] mmput+0x59/0xa0
Sep 29 00:21:14 seed kernel:  [do_exit+281/992] do_exit+0x119/0x3e0
Sep 29 00:21:14 seed kernel:  [die+187/192] die+0xbb/0xc0
Sep 29 00:21:14 seed kernel:  [do_page_fault+267/1031] do_page_fault+0x10b/0x407
Sep 29 00:21:14 seed kernel:  [journal_end+19/32] journal_end+0x13/0x20
Sep 29 00:21:14 seed kernel:  [proc_alloc_inode+68/128] proc_alloc_inode+0x44/0x80
Sep 29 00:21:14 seed kernel:  [proc_alloc_inode+68/128] proc_alloc_inode+0x44/0x80
Sep 29 00:21:14 seed kernel:  [pty_write+422/448] pty_write+0x1a6/0x1c0
Sep 29 00:21:14 seed kernel:  [do_page_fault+0/1031] do_page_fault+0x0/0x407
Sep 29 00:21:14 seed kernel:  [error_code+45/64] error_code+0x2d/0x40
Sep 29 00:21:14 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:21:14 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:21:14 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:21:14 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:21:14 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:21:14 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:21:14 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:21:14 seed kernel: 
Sep 29 00:21:27 seed kernel: Unable to handle kernel paging request at virtual
address ffffd000
Sep 29 00:21:27 seed kernel:  printing eip:
Sep 29 00:21:27 seed kernel: 00007ba4
Sep 29 00:21:27 seed kernel: *pde = 00002067
Sep 29 00:21:27 seed kernel: *pte = 00000000
Sep 29 00:21:27 seed kernel: Oops: 0000 [#5]
Sep 29 00:21:27 seed kernel: CPU:    0
Sep 29 00:21:27 seed kernel: EIP:    0098:[<00007ba4>]    Not tainted
Sep 29 00:21:27 seed kernel: EFLAGS: 00010003
Sep 29 00:21:27 seed kernel: EIP is at 0x7ba4
Sep 29 00:21:27 seed kernel: eax: 000000b0   ebx: 00b0d07b   ecx: 00000400  
edx: 00000000
Sep 29 00:21:27 seed kernel: esi: 0000d000   edi: c35f0000   ebp: c35f9eac  
esp: c35f9e84
Sep 29 00:21:27 seed kernel: ds: 00b0   es: 00a8   ss: 0068
Sep 29 00:21:27 seed kernel: Process lsescd (pid: 1989, threadinfo=c35f8000
task=c4751980)
Sep 29 00:21:27 seed kernel: Stack: 00000000 00a0d000 00a07bb9 d049d4eb 00008000
007b007b 0202d016 008600a8 
Sep 29 00:21:27 seed kernel:        00000000 0090000b 00000042 00b000a8 000000a0
00000000 c0280768 00000060 
Sep 29 00:21:27 seed kernel:        00000082 00000000 00000000 0000007b 0000007b
00000202 c35f8000 00000000 
Sep 29 00:21:27 seed kernel: Call Trace:
Sep 29 00:21:27 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:21:27 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:21:27 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:21:27 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:21:27 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:21:27 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:21:27 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:21:27 seed kernel: 
Sep 29 00:21:27 seed kernel: Code:  Bad EIP value.
Sep 29 00:21:27 seed kernel:  <6>note: lsescd[1989] exited with preempt_count 2
Sep 29 00:21:27 seed kernel: bad: scheduling while atomic!
Sep 29 00:21:27 seed kernel: Call Trace:
Sep 29 00:21:27 seed kernel:  [schedule+1395/1408] schedule+0x573/0x580
Sep 29 00:21:27 seed kernel:  [unmap_vmas+464/576] unmap_vmas+0x1d0/0x240
Sep 29 00:21:27 seed kernel:  [exit_mmap+98/384] exit_mmap+0x62/0x180
Sep 29 00:21:27 seed kernel:  [mmput+89/160] mmput+0x59/0xa0
Sep 29 00:21:27 seed kernel:  [do_exit+281/992] do_exit+0x119/0x3e0
Sep 29 00:21:27 seed kernel:  [die+187/192] die+0xbb/0xc0
Sep 29 00:21:27 seed kernel:  [do_page_fault+267/1031] do_page_fault+0x10b/0x407
Sep 29 00:21:27 seed kernel:  [journal_end+19/32] journal_end+0x13/0x20
Sep 29 00:21:27 seed kernel:  [proc_alloc_inode+68/128] proc_alloc_inode+0x44/0x80
Sep 29 00:21:27 seed kernel:  [proc_alloc_inode+68/128] proc_alloc_inode+0x44/0x80
Sep 29 00:21:27 seed kernel:  [buffered_rmqueue+187/384] buffered_rmqueue+0xbb/0x180
Sep 29 00:21:27 seed kernel:  [do_page_fault+0/1031] do_page_fault+0x0/0x407
Sep 29 00:21:27 seed kernel:  [error_code+45/64] error_code+0x2d/0x40
Sep 29 00:21:27 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:21:27 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:21:27 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:21:27 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:21:27 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:21:27 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:21:27 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:21:27 seed kernel: 
Sep 29 00:21:57 seed kernel: Unable to handle kernel paging request at virtual
address ffffd000
Sep 29 00:21:57 seed kernel:  printing eip:
Sep 29 00:21:57 seed kernel: 00007ba4
Sep 29 00:21:57 seed kernel: *pde = 00002067
Sep 29 00:21:57 seed kernel: *pte = 00000000
Sep 29 00:21:57 seed kernel: Oops: 0000 [#6]
Sep 29 00:21:57 seed kernel: CPU:    0
Sep 29 00:21:57 seed kernel: EIP:    0098:[<00007ba4>]    Not tainted
Sep 29 00:21:57 seed kernel: EFLAGS: 00010003
Sep 29 00:21:57 seed kernel: EIP is at 0x7ba4
Sep 29 00:21:57 seed kernel: eax: 000000b0   ebx: 00b0d07b   ecx: 00000400  
edx: 00000000
Sep 29 00:21:57 seed kernel: esi: 0000d000   edi: c1c10000   ebp: c1c17eac  
esp: c1c17e84
Sep 29 00:21:57 seed kernel: ds: 00b0   es: 00a8   ss: 0068
Sep 29 00:21:57 seed kernel: Process lsescd (pid: 1996, threadinfo=c1c16000
task=c4750100)
Sep 29 00:21:57 seed kernel: Stack: 00000000 00a0d000 00a07bb9 d049d4eb 00006000
007b007b 0202d016 008600a8 
Sep 29 00:21:57 seed kernel:        00000000 0090000b 00000042 00b000a8 000000a0
00000000 c0280768 00000060 
Sep 29 00:21:57 seed kernel:        00000082 00000000 00000000 0000007b 0000007b
00000202 c1c16000 00000000 
Sep 29 00:21:57 seed kernel: Call Trace:
Sep 29 00:21:57 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:21:57 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:21:57 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:21:57 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:21:57 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:21:57 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:21:57 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:21:57 seed kernel: 
Sep 29 00:21:57 seed kernel: Code:  Bad EIP value.
Sep 29 00:21:57 seed kernel:  <6>note: lsescd[1996] exited with preempt_count 2
Sep 29 00:22:21 seed kernel: Unable to handle kernel paging request at virtual
address ffffd000
Sep 29 00:22:21 seed kernel:  printing eip:
Sep 29 00:22:21 seed kernel: 00007ba4
Sep 29 00:22:21 seed kernel: *pde = 00002067
Sep 29 00:22:21 seed kernel: *pte = 00000000
Sep 29 00:22:21 seed kernel: Oops: 0000 [#7]
Sep 29 00:22:21 seed kernel: CPU:    0
Sep 29 00:22:21 seed kernel: EIP:    0098:[<00007ba4>]    Not tainted
Sep 29 00:22:21 seed kernel: EFLAGS: 00010003
Sep 29 00:22:21 seed kernel: EIP is at 0x7ba4
Sep 29 00:22:21 seed kernel: eax: 000000b0   ebx: 00b0d07b   ecx: 00000400  
edx: 00000000
Sep 29 00:22:21 seed kernel: esi: 0000d000   edi: c18b0000   ebp: c18b7eac  
esp: c18b7e84
Sep 29 00:22:21 seed kernel: ds: 00b0   es: 00a8   ss: 0068
Sep 29 00:22:21 seed kernel: Process cat (pid: 1999, threadinfo=c18b6000
task=c4751360)
Sep 29 00:22:21 seed kernel: Stack: 00000000 00a0d000 00a07bb9 d049d4eb 00006000
007b007b 0202d016 008600a8 
Sep 29 00:22:21 seed kernel:        00000000 0090000b 00000042 00b000a8 000000a0
00000000 c0280768 00000060 
Sep 29 00:22:21 seed kernel:        00000082 00000000 00000000 0000007b 0000007b
00000202 c18b6000 00000000 
Sep 29 00:22:21 seed kernel: Call Trace:
Sep 29 00:22:21 seed kernel:  [__pnp_bios_read_escd+264/416]
__pnp_bios_read_escd+0x108/0x1a0
Sep 29 00:22:21 seed kernel:  [pnp_bios_read_escd+14/64] pnp_bios_read_escd+0xe/0x40
Sep 29 00:22:21 seed kernel:  [proc_read_escd+100/256] proc_read_escd+0x64/0x100
Sep 29 00:22:21 seed kernel:  [proc_file_read+176/608] proc_file_read+0xb0/0x260
Sep 29 00:22:21 seed kernel:  [vfs_read+169/256] vfs_read+0xa9/0x100
Sep 29 00:22:21 seed kernel:  [sys_read+43/96] sys_read+0x2b/0x60
Sep 29 00:22:21 seed kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 29 00:22:21 seed kernel: 
Sep 29 00:22:21 seed kernel: Code:  Bad EIP value.
Sep 29 00:22:21 seed kernel:  <6>note: cat[1999] exited with preempt_count 2

DMI:
# dmidecode 2.2
Legacy DMI 2.0 present.
29 structures occupying 946 bytes.
Table at 0x000F545A.
Handle 0x0000
	DMI type 0, 18 bytes.
	BIOS Information
		Vendor: Award Software, Inc.
		Version: ASUS P5A-B ACPI BIOS Revision 1004 .............................
		Release Date: 10/14/98
		Address: 0xF0000
		Runtime Size: 64 kB
		ROM Size: 128 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PNP is supported
			APM is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			Selectable boot is supported
			BIOS ROM is socketed
			EDD is supported
			Japanese floppy for NEC 9800 1.2 MB is supported (int 13h)
			5.25"/360 KB floppy services are supported (int 13h)
			5.25"/1.2 MB floppy services are supported (int 13h)
			3.5"/720 KB floppy services are supported (int 13h)
			3.5"/2.88 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			Printer services are supported (int 17h)
			CGA/mono video services are supported (int 10h)
Handle 0x0001
	DMI type 1, 8 bytes.
	System Information
		Manufacturer: System Manufacturer
		Product Name: System Name
		Version: System Version
		Serial Number: SYS-1234567890
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: ASUSTeK Computer INC.
		Product Name: P5A-B
		Version: REV 1.XX
		Serial Number: MB-1234567890
Handle 0x0003
	DMI type 3, 9 bytes.
	Chassis Information
		Manufacturer: Chassis Manufacture
		Type: Unknown
		Lock: Not Present
		Version: Chassis Version
		Serial Number: Chassis Serial Number
		Asset Tag: Asset-1234567890
Handle 0x0004
	DMI type 4, 26 bytes.
	Processor Information
		Socket Designation: SOCKET 7
		Type: Central Processor
		Family: K5
		Manufacturer: AMD
		ID: 8C 05 00 00 BF 21 80 00
		Signature: Type 0, Family 5, Model 8, Stepping C
		Flags:
			FPU (Floating-point unit on-chip)
			VME (Virtual mode extension)
			DE (Debugging extension)
			PSE (Page size extension)
			TSC (Time stamp counter)
			MSR (Model specific registers)
			MCE (Machine check exception)
			CX8 (CMPXCHG8 instruction supported)
			PGE (Page global enable)
			MMX (MMX technology supported)
		Version: AMD K6-2
		Voltage: 3.3 V
		External Clock: 100 MHz
		Max Speed: 400 MHz
		Current Speed: 350 MHz
		Status: Populated, Enabled
		Upgrade: ZIF Socket
Handle 0x0005
	DMI type 5, 27 bytes.
	Memory Controller Information
		Error Detecting Method: None
		Error Correcting Capabilities:
			None
		Supported Interleave: One-way Interleave
		Current Interleave: One-way Interleave
		Maximum Memory Module Size: 128 MB
		Maximum Total Memory Size: 768 MB
		Supported Speeds:
			70 ns
			60 ns
			50 ns
		Supported Memory Types:
			Other
			FPM
			EDO
			Parity
			DIMM
			SDRAM
		Memory Module Voltage: 5.0 V 3.3 V
		Associated Memory Slots: 6
			0x0006
			0x0007
			0x0008
			0x0009
			0x000A
			0x000B
Handle 0x0007
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM1-2  
		Bank Connections: 0 1
		Current Speed: 70 ns
		Type: Other DIMM
		Installed Size: 32 MB (Double-bank Connection)
		Enabled Size: 32 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0008
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM2-1  
		Bank Connections: 2 3
		Current Speed: 70 ns
		Type: Other DIMM
		Installed Size: 32 MB (Double-bank Connection)
		Enabled Size: 32 MB (Double-bank Connection)
		Error Status: OK
Handle 0x0009
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM2-2  
		Bank Connections: 2 3
		Current Speed: 70 ns
		Type: Other DIMM
		Installed Size: 32 MB (Double-bank Connection)
		Enabled Size: 32 MB (Double-bank Connection)
		Error Status: OK
Handle 0x000A
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM3-1  
		Bank Connections: 4 5
		Current Speed: 70 ns
		Type: EDO DIMM
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x000B
	DMI type 6, 12 bytes.
	Memory Module Information
		Socket Designation: DIMM3-2  
		Bank Connections: 4 5
		Current Speed: 70 ns
		Type: EDO DIMM
		Installed Size: Not Installed (Single-bank Connection)
		Enabled Size: Not Installed (Single-bank Connection)
		Error Status: OK
Handle 0x000C
	DMI type 7, 15 bytes.
	Cache Information
		Socket Designation: L1 Cache
		Configuration: Enabled, Not Socketed, Level 1
		Operational Mode: Write Back
		Location: Internal
		Installed Size: 64 KB
		Maximum Size: 64 KB
		Supported SRAM Types: None
		Installed SRAM Type: None
Handle 0x000D
	DMI type 7, 15 bytes.
	Cache Information
		Socket Designation: L2 Cache
		Configuration: Enabled, Not Socketed, Level 2
		Operational Mode: Write Back
		Location: External
		Installed Size: 0 KB
		Maximum Size: 1024 KB
		Supported SRAM Types:
			Pipeline Burst
		Installed SRAM Type: Pipeline Burst
Handle 0x000E
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: COM1
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator: COM A
		External Connector Type: DB-9 male
		Port Type: Serial Port 16550A Compatible
Handle 0x000F
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: COM2
		Internal Connector Type: 9 Pin Dual Inline (pin 10 cut)
		External Reference Designator: COM B
		External Connector Type: DB-25 male
		Port Type: Serial Port 16550A Compatible
Handle 0x0010
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: PRINTER
		Internal Connector Type: 25 Pin Dual Inline (pin 26 cut)
		External Reference Designator: LPT
		External Connector Type: DB-25 female
		Port Type: Parallel Port ECP/EPP
Handle 0x0011
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: KEY
		Internal Connector Type: None
		External Reference Designator: KEYBOARD
		External Connector Type: Micro DIN
		Port Type: Keyboard Port
Handle 0x0012
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: PRIMARY IDE
		Internal Connector Type: On Board IDE
		External Reference Designator: IDE-1
		External Connector Type: None
		Port Type: None
Handle 0x0013
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: SECONDARY IDE
		Internal Connector Type: On Board IDE
		External Reference Designator: IDE-2
		External Connector Type: None
		Port Type: None
Handle 0x0014
	DMI type 8, 9 bytes.
	Port Connector Information
		Internal Reference Designator: FLOPPY
		Internal Connector Type: On Board Floppy
		External Reference Designator: FLOPPY
		External Connector Type: None
		Port Type: None
Handle 0x0015
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: PCI Slot1
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Long
		ID: 11
		Characteristics:
			5.0 V is provided
Handle 0x0016
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: PCI Slot2
		Type: 32-bit PCI
		Current Usage: In Use
		Length: Long
		ID: 10
		Characteristics:
			5.0 V is provided
Handle 0x0017
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: PCI Slot3
		Type: 32-bit PCI
		Current Usage: Available
		Length: Long
		ID: 9
		Characteristics:
			5.0 V is provided
			Opening is shared
Handle 0x0018
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: ISA Slot1
		Type: 16-bit ISA
		Current Usage: Unknown
		Length: Long
		Characteristics:
			5.0 V is provided
			Opening is shared
Handle 0x0019
	DMI type 9, 12 bytes.
	System Slot Information
		Designation: ISA Slot2
		Type: 16-bit ISA
		Current Usage: Unknown
		Length: Long
		Characteristics:
			5.0 V is provided
Handle 0x001A
	DMI type 11, 5 bytes.
	OEM Strings
		String 1: OEM String
Handle 0x001B
	DMI type 12, 5 bytes.
	System Configuration Options
		Option 1: System String
Handle 0x001C
	DMI type 13, 22 bytes.
	BIOS Language Information
		Installable Languages: 1
			ENGLISH
		Currently Installed Language: ENGLISH
Wrong DMI structures count: 29 announced, only 28 decoded.

