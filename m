Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVARXSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVARXSM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 18:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVARXSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 18:18:11 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:1433 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261471AbVARXRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 18:17:54 -0500
Message-ID: <41ED991F.2080805@dgreaves.com>
Date: Tue, 18 Jan 2005 23:17:51 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: crash on 2.6.10rc2 xfs/nfs
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Just had a crash on 2.6.10rc2
xfs,nfs,lvm2,raid5 server doing fairly low level I/O with fairly big 
(2-3Gb) files.

I'm aware of 2.6.11-rc1-mm1 - but as reported previously that's not 
working right now.

So, just in case this may be useful.

David

Jan 18 22:36:48 cu kernel: c016d577
Jan 18 22:36:48 cu kernel: Modules linked in: nfs af_packet ipv6 
ehci_hcd usblp uhci_hcd usbcore nfsd exportfs lockd sunrpc sk98lin unix
Jan 18 22:36:48 cu kernel: CPU:    0
Jan 18 22:36:48 cu kernel: EIP:    0060:[mpage_readpages+71/336]    Not 
tainted VLI
Jan 18 22:36:48 cu kernel: EFLAGS: 00010283   (2.6.10-rc2cu-041208-01)
Jan 18 22:36:48 cu kernel: EIP is at mpage_readpages+0x47/0x150
Jan 18 22:36:48 cu kernel: eax: f5381db0   ebx: c16500d8   ecx: 
00000000   edx: 006500f8
Jan 18 22:36:48 cu kernel: esi: c16500c0   edi: 0000015f   ebp: 
000001c8   esp: f5381cc4
Jan 18 22:36:48 cu kernel: ds: 007b   es: 007b   ss: 0068
Jan 18 22:36:48 cu kernel: Process nfsd (pid: 2507, threadinfo=f5380000 
task=f60715a0)
Jan 18 22:36:48 cu kernel: Stack: c16500a0 ef1ea454 0005680f 000000d0 
c0204730 cef62c60 0727ec96 00000000
Jan 18 22:36:48 cu kernel:        00000000 c125ad20 c125ad40 c125ad60 
c125ad80 c125ada0 c125adc0 c125ade0
Jan 18 22:36:48 cu kernel:        c134f000 c134f020 c134f040 c134f060 
c134f080 c134f0a0 c134f0c0 00056878
Jan 18 22:36:48 cu kernel: Call Trace:
Jan 18 22:36:48 cu kernel:  [linvfs_get_block+0/80] 
linvfs_get_block+0x0/0x50
Jan 18 22:36:48 cu kernel:  [read_pages+299/320] read_pages+0x12b/0x140
Jan 18 22:36:48 cu kernel:  [linvfs_get_block+0/80] 
linvfs_get_block+0x0/0x50
Jan 18 22:36:48 cu kernel:  [__alloc_pages+458/864] 
__alloc_pages+0x1ca/0x360
Jan 18 22:36:48 cu kernel:  [common_interrupt+26/32] 
common_interrupt+0x1a/0x20
Jan 18 22:36:48 cu kernel:  [do_page_cache_readahead+207/304] 
do_page_cache_readahead+0xcf/0x130
Jan 18 22:36:48 cu kernel:  [page_cache_readahead+388/480] 
page_cache_readahead+0x184/0x1e0
Jan 18 22:36:48 cu kernel:  [do_generic_mapping_read+284/1232] 
do_generic_mapping_read+0x11c/0x4d0
Jan 18 22:36:48 cu kernel:  [generic_file_sendfile+98/112] 
generic_file_sendfile+0x62/0x70
Jan 18 22:36:48 cu kernel:  [pg0+952380864/1069196288] 
nfsd_read_actor+0x0/0xb0 [nfsd]
Jan 18 22:36:48 cu kernel:  [xfs_sendfile+177/432] xfs_sendfile+0xb1/0x1b0
Jan 18 22:36:48 cu kernel:  [pg0+952380864/1069196288] 
nfsd_read_actor+0x0/0xb0 [nfsd]
Jan 18 22:36:48 cu kernel:  [dentry_open+219/448] dentry_open+0xdb/0x1c0
Jan 18 22:36:48 cu kernel:  [linvfs_sendfile+87/96] 
linvfs_sendfile+0x57/0x60
Jan 18 22:36:48 cu kernel:  [pg0+952380864/1069196288] 
nfsd_read_actor+0x0/0xb0 [nfsd]
Jan 18 22:36:48 cu kernel:  [pg0+952381593/1069196288] 
nfsd_read+0x229/0x350 [nfsd]
Jan 18 22:36:48 cu kernel:  [pg0+952380864/1069196288] 
nfsd_read_actor+0x0/0xb0 [nfsd]
Jan 18 22:36:48 cu kernel:  [pg0+952410892/1069196288] 
nfsd3_proc_read+0xdc/0x170 [nfsd]
Jan 18 22:36:48 cu kernel:  [pg0+952366537/1069196288] 
nfsd_dispatch+0xd9/0x210 [nfsd]
Jan 18 22:36:48 cu kernel:  [pg0+952695636/1069196288] 
svc_process+0x4a4/0x690 [sunrpc]
Jan 18 22:36:48 cu kernel:  [default_wake_function+0/32] 
default_wake_function+0x0/0x20
Jan 18 22:36:48 cu kernel:  [pg0+952365964/1069196288] nfsd+0x18c/0x2f0 
[nfsd]
Jan 18 22:36:48 cu kernel:  [pg0+952365568/1069196288] nfsd+0x0/0x2f0 [nfsd]
Jan 18 22:36:48 cu kernel:  [kernel_thread_helper+5/20] 
kernel_thread_helper+0x5/0x14
Jan 18 22:36:48 cu kernel: Code: 00 c7 44 24 1c 00 00 00 00 c7 44 24 20 
00 00 00 00 39 ef 73 66 8b 44 24 74 8b 58 04 8d 73 e8 0f 0d 0e 90 8b 03 
8b 53 04 89 50 04 <89> 02 c7 43 04 00 02 20 00 c7 03 00 01 10 00 8b 54 
24 70 c7 44

