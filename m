Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263672AbUDFJe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 05:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263676AbUDFJe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 05:34:27 -0400
Received: from mail36.messagelabs.com ([193.109.254.211]:10966 "HELO
	mail36.messagelabs.com") by vger.kernel.org with SMTP
	id S263672AbUDFJeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 05:34:22 -0400
X-VirusChecked: Checked
X-Env-Sender: okiddle@yahoo.co.uk
X-Msg-Ref: server-16.tower-36.messagelabs.com!1081244060!5215038
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [158.234.9.163]
X-VirusChecked: Checked
X-StarScan-Version: 5.1.13; banners=.,-,-
From: Oliver Kiddle <okiddle@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Subject: xfs and page allocation failures
Date: Tue, 06 Apr 2004 11:33:35 +0200
Message-ID: <22084.1081244015@trentino.logica.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted back in January about problems I was having with 2.6.1. Thanks
for the help back then. I'm still having problems with the same
machine, though.

2.6.3 is usable (just three page allocation failures printed when I run
xfsdump). xfsdump crashed 2.6.4 and I never got around to trying to
capture the console output. I tried 2.6.5 yesterday and have had two
issues. The first, relatively harmless problem was two page allocation
failures printed when running xfsdump (output is below).

Then, this morning, mountd was no longer working. NFS was still happily
working where clients had mounted the filesystems. rpcinfo -u was
getting a timeout for mountd. I tried first restarting rpc.mountd which
had no effect and then tried `/etc/init.d/nfs-kernel-server restart',
also to no effect.

I've attached the relevant part of the dmesg output below.

Thanks

Oliver

st0: Block limits 1 - 16777215 bytes.
xfsdump: page allocation failure. order:9, mode:0xd0
Call Trace:
 [<c012d79f>] __alloc_pages+0x2e0/0x325
 [<c02ad92d>] enlarge_buffer+0xcf/0x182
 [<c02aebfe>] st_map_user_pages+0x37/0x88
 [<c02aa43f>] setup_buffering+0xb9/0x13d
 [<c02aa6fe>] st_write+0x1fe/0x7d9
 [<c0276753>] ide_do_request+0x1c4/0x337
 [<c0111902>] recalc_task_prio+0x90/0x1aa
 [<c02aa500>] st_write+0x0/0x7d9
 [<c014241b>] vfs_write+0xb0/0x119
 [<c0142529>] sys_write+0x42/0x63
 [<c0106a8b>] syscall_call+0x7/0xb

xfsdump: page allocation failure. order:8, mode:0xd0
Call Trace:
 [<c012d79f>] __alloc_pages+0x2e0/0x325
 [<c02ad92d>] enlarge_buffer+0xcf/0x182
 [<c02aebfe>] st_map_user_pages+0x37/0x88
 [<c02aa43f>] setup_buffering+0xb9/0x13d
 [<c02aa6fe>] st_write+0x1fe/0x7d9
 [<c0276753>] ide_do_request+0x1c4/0x337
 [<c0111902>] recalc_task_prio+0x90/0x1aa
 [<c02aa500>] st_write+0x0/0x7d9
 [<c014241b>] vfs_write+0xb0/0x119
 [<c0142529>] sys_write+0x42/0x63
 [<c0106a8b>] syscall_call+0x7/0xb

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c01301d7
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01301d7>]    Not tainted
EFLAGS: 00010002   (2.6.5) 
EIP is at free_block+0x48/0xc8
eax: 00000000   ebx: c47d3000   ecx: c47d3500   edx: 5e050000
esi: c1b5799c   edi: 00000001   ebp: c1b579a8   esp: c1b75d60
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 7, threadinfo=c1b74000 task=c1b791e0)
Stack: c1b5799c d4e4b000 c1b579b8 c1bab590 00000282 dff2d500 0000001b c0130296 
       c1b5799c c1bab590 0000001b c1afa6c0 c1bab580 00000282 dff2d500 c0376320 
       c013045f c1b5799c c1bab580 dff2d51c c1b75e00 00000036 c02119fa c1b5799c 
Call Trace:
 [<c0130296>] cache_flusharray+0x3f/0xbc
 [<c013045f>] kmem_cache_free+0x48/0x4c
 [<c02119fa>] linvfs_destroy_inode+0x1b/0x1f
 [<c0157278>] destroy_inode+0x35/0x50
 [<c0157508>] dispose_list+0x49/0x7c
 [<c01577f5>] prune_icache+0xa5/0x1b1
 [<c0157924>] shrink_icache_memory+0x23/0x25
 [<c0131fdc>] shrink_slab+0x12a/0x16d
 [<c0133050>] balance_pgdat+0x1b6/0x1f0
 [<c013319c>] kswapd+0x112/0x122
 [<c01139f0>] autoremove_wake_function+0x0/0x4f
 [<c01139f0>] autoremove_wake_function+0x0/0x4f
 [<c013308a>] kswapd+0x0/0x122
 [<c0104d1d>] kernel_thread_helper+0x5/0xb

Code: 89 50 04 89 02 c7 43 04 00 02 20 00 2b 4b 0c c7 03 00 01 10 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 000007d4
 printing eip:
c01579a4
*pde = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c01579a4>]    Not tainted
EFLAGS: 00010206   (2.6.5) 
EIP is at find_inode_fast+0x18/0x55
eax: d4e4bb1c   ebx: 068be244   ecx: 000007d4   edx: 000007d4
esi: f7dd6a00   edi: c1a6964c   ebp: c1a6964c   esp: ea227d90
ds: 007b   es: 007b   ss: 0068
Process find (pid: 21684, threadinfo=ea226000 task=f72f87a0)
Stack: ced1c1fc 00000000 068be244 f7dd6a00 c0157e7b f7dd6a00 c1a6964c 068be244 
       00000000 0000000c 068be244 00000000 c01e2acb f7dd6a00 068be244 00000000 
       068be243 00000000 00000000 ea227e54 00000000 00000000 00000000 00000000 
Call Trace:
 [<c0157e7b>] iget_locked+0x4e/0x9d
 [<c01e2acb>] xfs_iget+0x41/0x14d
 [<c01fe166>] xfs_dir_lookup_int+0xb4/0x12b
 [<c0203917>] xfs_lookup+0x50/0x88
 [<c020f534>] linvfs_lookup+0x67/0x9f
 [<c014dae5>] real_lookup+0xc8/0xea
 [<c014dd38>] do_lookup+0x96/0xa1
 [<c014e151>] link_path_walk+0x40e/0x7e3
 [<c014e975>] __user_walk+0x49/0x5e
 [<c014a274>] vfs_lstat+0x1c/0x58
 [<c014a965>] sys_lstat64+0x1b/0x39
 [<c0106a8b>] syscall_call+0x7/0xb

Code: 8b 11 0f 18 02 90 39 59 18 89 c8 74 0f 85 d2 89 d1 75 ed 31 
 <4>pagebuf_get: warning, failed to lookup pages
pagebuf_get: warning, failed to lookup pages
pagebuf_get: warning, failed to lookup pages
svc: unknown version (0)
svc: unknown version (0)
nfsd: last server has exited
nfsd: unexporting all filesystems
rpciod: active tasks at shutdown?!
RPC: error 5 connecting to server localhost
RPC: failed to contact portmap (errno -5).
