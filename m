Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTIQI3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 04:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbTIQI3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 04:29:32 -0400
Received: from pop.gmx.net ([213.165.64.20]:16530 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262710AbTIQI3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 04:29:17 -0400
Date: Wed, 17 Sep 2003 10:29:15 +0200 (MEST)
From: "Daniel Engelschalt" <daniel.engelschalt@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: 2.6.0-test5: mm/slab.c kernel BUG and failure
X-Priority: 3 (Normal)
X-Authenticated: #1538274
Message-ID: <23377.1063787355@www40.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

with vanilla 2.6.0-test5 i get the following *2* errors:

Sep 17 08:07:43 A405a kernel: ------------[ cut here ]------------
Sep 17 08:07:43 A405a kernel: kernel BUG at mm/slab.c:1659!
Sep 17 08:07:43 A405a kernel: invalid operand: 0000 [#1]
Sep 17 08:07:43 A405a kernel: CPU:    0
Sep 17 08:07:43 A405a kernel: EIP:    0060:[kfree+484/676]    Tainted: PF 
Sep 17 08:07:43 A405a kernel: EIP:    0060:[<c0146f24>]    Tainted: PF 
Sep 17 08:07:43 A405a kernel: EFLAGS: 00010016
Sep 17 08:07:43 A405a kernel: EIP is at kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel: eax: 00b6e368   ebx: d1d5e060   ecx: 125fdc08 
 edx: 00000068
Sep 17 08:07:43 A405a kernel: esi: dffeb7b0   edi: d1d5ed50   ebp: dc5afef4 
 esp: dc5afecc
Sep 17 08:07:43 A405a kernel: ds: 007b   es: 007b   ss: 0068
Sep 17 08:07:43 A405a kernel: Process xawtv (pid: 3423, threadinfo=dc5ae000
task=d691c790)
Sep 17 08:07:43 A405a kernel: Stack: dcacb33c 001b0000 d32ac3ec 0000010c
00000108 e0926494 dffe62e8 d1d5ed54 
Sep 17 08:07:43 A405a kernel:        002c96b0 00000282 dc5aff14 e0926494
d1d5ed54 d32ac3ec d1d5ed54 dcacb33c 
Sep 17 08:07:43 A405a kernel:        00000000 001b0000 dc5aff4c e0926526
d32ac3ec dcacb33c 49070008 001b0000 
Sep 17 08:07:43 A405a kernel: Call Trace:
Sep 17 08:07:43 A405a kernel:  [_end+542669876/1069938592]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926494>]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542669876/1069938592]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926494>]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542670022/1069938592]
videobuf_read_one+0x7a/0x358 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926526>] videobuf_read_one+0x7a/0x358
[video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542841191/1069938592]
bttv_read+0x8b/0xe8 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e09501c7>] bttv_read+0x8b/0xe8 [bttv]
Sep 17 08:07:43 A405a kernel:  [vfs_read+187/244] vfs_read+0xbb/0xf4
Sep 17 08:07:43 A405a kernel:  [<c0161517>] vfs_read+0xbb/0xf4
Sep 17 08:07:43 A405a kernel:  [sys_read+48/80] sys_read+0x30/0x50
Sep 17 08:07:43 A405a kernel:  [<c0161720>] sys_read+0x30/0x50
Sep 17 08:07:43 A405a kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 17 08:07:43 A405a kernel:  [<c0109d77>] syscall_call+0x7/0xb
Sep 17 08:07:43 A405a kernel: 
Sep 17 08:07:43 A405a kernel: Code: 0f 0b 7b 06 b2 3a 2b c0 8d 74 26 00 0f
af 45 e4 01 c8 39 c7 
Sep 17 08:07:43 A405a kernel:  <3>slab error in cache_free_debugcheck():
cache `size-256': double free, or memory before object was overwritten
Sep 17 08:07:43 A405a kernel: Call Trace:
Sep 17 08:07:43 A405a kernel:  [__slab_error+36/40] __slab_error+0x24/0x28
Sep 17 08:07:43 A405a kernel:  [<c0144ad8>] __slab_error+0x24/0x28
Sep 17 08:07:43 A405a kernel:  [kfree+405/676] kfree+0x195/0x2a4
Sep 17 08:07:43 A405a kernel:  [<c0146ed5>] kfree+0x195/0x2a4
Sep 17 08:07:43 A405a kernel:  [_end+542842167/1069938592]
bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0950597>] bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [_end+542842167/1069938592]
bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0950597>] bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [__fput+70/276] __fput+0x46/0x114
Sep 17 08:07:43 A405a kernel:  [<c0162536>] __fput+0x46/0x114
Sep 17 08:07:43 A405a kernel:  [fput+22/28] fput+0x16/0x1c
Sep 17 08:07:43 A405a kernel:  [<c01624ea>] fput+0x16/0x1c
Sep 17 08:07:43 A405a kernel:  [filp_close+92/104] filp_close+0x5c/0x68
Sep 17 08:07:43 A405a kernel:  [<c0160a14>] filp_close+0x5c/0x68
Sep 17 08:07:43 A405a kernel:  [put_files_struct+88/192]
put_files_struct+0x58/0xc0
Sep 17 08:07:43 A405a kernel:  [<c0120d50>] put_files_struct+0x58/0xc0
Sep 17 08:07:43 A405a kernel:  [do_exit+1031/2104] do_exit+0x407/0x838
Sep 17 08:07:43 A405a kernel:  [<c0121f37>] do_exit+0x407/0x838
Sep 17 08:07:43 A405a kernel:  [do_divide_error+0/164]
do_divide_error+0x0/0xa4
Sep 17 08:07:43 A405a kernel:  [<c010a70c>] do_divide_error+0x0/0xa4
Sep 17 08:07:43 A405a kernel:  [do_invalid_op+0/140] do_invalid_op+0x0/0x8c
Sep 17 08:07:43 A405a kernel:  [<c010a90c>] do_invalid_op+0x0/0x8c
Sep 17 08:07:43 A405a kernel:  [do_invalid_op+125/140]
do_invalid_op+0x7d/0x8c
Sep 17 08:07:43 A405a kernel:  [<c010a989>] do_invalid_op+0x7d/0x8c
Sep 17 08:07:43 A405a kernel:  [kfree+484/676] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [<c0146f24>] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [_end+542855216/1069938592]
gcc2_compiled.+0x30/0x13c [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0953890>] gcc2_compiled.+0x30/0x13c [bttv]
Sep 17 08:07:43 A405a kernel:  [_end+542860285/1069938592]
bttv_buffer_risc+0x189/0x4c0 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0954c5d>] bttv_buffer_risc+0x189/0x4c0
[bttv]
Sep 17 08:07:43 A405a kernel:  [error_code+45/64] error_code+0x2d/0x40
Sep 17 08:07:43 A405a kernel:  [<c0109fdd>] error_code+0x2d/0x40
Sep 17 08:07:43 A405a kernel:  [kfree+484/676] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [<c0146f24>] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [_end+542669876/1069938592]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926494>]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542669876/1069938592]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926494>]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542670022/1069938592]
videobuf_read_one+0x7a/0x358 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926526>] videobuf_read_one+0x7a/0x358
[video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542841191/1069938592]
bttv_read+0x8b/0xe8 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e09501c7>] bttv_read+0x8b/0xe8 [bttv]
Sep 17 08:07:43 A405a kernel:  [vfs_read+187/244] vfs_read+0xbb/0xf4
Sep 17 08:07:43 A405a kernel:  [<c0161517>] vfs_read+0xbb/0xf4
Sep 17 08:07:43 A405a kernel:  [sys_read+48/80] sys_read+0x30/0x50
Sep 17 08:07:43 A405a kernel:  [<c0161720>] sys_read+0x30/0x50
Sep 17 08:07:43 A405a kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 17 08:07:43 A405a kernel:  [<c0109d77>] syscall_call+0x7/0xb
Sep 17 08:07:43 A405a kernel: 
Sep 17 08:07:43 A405a kernel: slab error in cache_free_debugcheck(): cache
`size-256': double free, or memory after  object was overwritten
Sep 17 08:07:43 A405a kernel: Call Trace:
Sep 17 08:07:43 A405a kernel:  [__slab_error+36/40] __slab_error+0x24/0x28
Sep 17 08:07:43 A405a kernel:  [<c0144ad8>] __slab_error+0x24/0x28
Sep 17 08:07:43 A405a kernel:  [kfree+443/676] kfree+0x1bb/0x2a4
Sep 17 08:07:43 A405a kernel:  [<c0146efb>] kfree+0x1bb/0x2a4
Sep 17 08:07:43 A405a kernel:  [_end+542842167/1069938592]
bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0950597>] bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [_end+542842167/1069938592]
bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0950597>] bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [__fput+70/276] __fput+0x46/0x114
Sep 17 08:07:43 A405a kernel:  [<c0162536>] __fput+0x46/0x114
Sep 17 08:07:43 A405a kernel:  [fput+22/28] fput+0x16/0x1c
Sep 17 08:07:43 A405a kernel:  [<c01624ea>] fput+0x16/0x1c
Sep 17 08:07:43 A405a kernel:  [filp_close+92/104] filp_close+0x5c/0x68
Sep 17 08:07:43 A405a kernel:  [<c0160a14>] filp_close+0x5c/0x68
Sep 17 08:07:43 A405a kernel:  [put_files_struct+88/192]
put_files_struct+0x58/0xc0
Sep 17 08:07:43 A405a kernel:  [<c0120d50>] put_files_struct+0x58/0xc0
Sep 17 08:07:43 A405a kernel:  [do_exit+1031/2104] do_exit+0x407/0x838
Sep 17 08:07:43 A405a kernel:  [<c0121f37>] do_exit+0x407/0x838
Sep 17 08:07:43 A405a kernel:  [do_divide_error+0/164]
do_divide_error+0x0/0xa4
Sep 17 08:07:43 A405a kernel:  [<c010a70c>] do_divide_error+0x0/0xa4
Sep 17 08:07:43 A405a kernel:  [do_invalid_op+0/140] do_invalid_op+0x0/0x8c
Sep 17 08:07:43 A405a kernel:  [<c010a90c>] do_invalid_op+0x0/0x8c
Sep 17 08:07:43 A405a kernel:  [do_invalid_op+125/140]
do_invalid_op+0x7d/0x8c
Sep 17 08:07:43 A405a kernel:  [<c010a989>] do_invalid_op+0x7d/0x8c
Sep 17 08:07:43 A405a kernel:  [kfree+484/676] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [<c0146f24>] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [_end+542855216/1069938592]
gcc2_compiled.+0x30/0x13c [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0953890>] gcc2_compiled.+0x30/0x13c [bttv]
Sep 17 08:07:43 A405a kernel:  [_end+542860285/1069938592]
bttv_buffer_risc+0x189/0x4c0 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0954c5d>] bttv_buffer_risc+0x189/0x4c0
[bttv]
Sep 17 08:07:43 A405a kernel:  [error_code+45/64] error_code+0x2d/0x40
Sep 17 08:07:43 A405a kernel:  [<c0109fdd>] error_code+0x2d/0x40
Sep 17 08:07:43 A405a kernel:  [kfree+484/676] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [<c0146f24>] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [_end+542669876/1069938592]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926494>]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542669876/1069938592]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926494>]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542670022/1069938592]
videobuf_read_one+0x7a/0x358 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926526>] videobuf_read_one+0x7a/0x358
[video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542841191/1069938592]
bttv_read+0x8b/0xe8 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e09501c7>] bttv_read+0x8b/0xe8 [bttv]
Sep 17 08:07:43 A405a kernel:  [vfs_read+187/244] vfs_read+0xbb/0xf4
Sep 17 08:07:43 A405a kernel:  [<c0161517>] vfs_read+0xbb/0xf4
Sep 17 08:07:43 A405a kernel:  [sys_read+48/80] sys_read+0x30/0x50
Sep 17 08:07:43 A405a kernel:  [<c0161720>] sys_read+0x30/0x50
Sep 17 08:07:43 A405a kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 17 08:07:43 A405a kernel:  [<c0109d77>] syscall_call+0x7/0xb
Sep 17 08:07:43 A405a kernel: 
Sep 17 08:07:43 A405a kernel: ------------[ cut here ]------------
Sep 17 08:07:43 A405a kernel: kernel BUG at mm/slab.c:1659!
Sep 17 08:07:43 A405a kernel: invalid operand: 0000 [#2]
Sep 17 08:07:43 A405a kernel: CPU:    0
Sep 17 08:07:43 A405a kernel: EIP:    0060:[kfree+484/676]    Tainted: PF 
Sep 17 08:07:43 A405a kernel: EIP:    0060:[<c0146f24>]    Tainted: PF 
Sep 17 08:07:43 A405a kernel: EFLAGS: 00010016
Sep 17 08:07:43 A405a kernel: EIP is at kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel: eax: 00b6e368   ebx: d1d5e060   ecx: 125fdc08 
 edx: 00000068
Sep 17 08:07:43 A405a kernel: esi: dffeb7b0   edi: d1d5ed50   ebp: dc5afd2c 
 esp: dc5afd04
Sep 17 08:07:43 A405a kernel: ds: 007b   es: 007b   ss: 0068
Sep 17 08:07:43 A405a kernel: Process xawtv (pid: 3423, threadinfo=dc5ae000
task=d691c790)
Sep 17 08:07:43 A405a kernel: Stack: dcacb330 e0963980 d32ac3ec 0000010c
00000108 e0950597 dffe62e8 d1d5ed54 
Sep 17 08:07:43 A405a kernel:        002c96b0 00000282 dc5afd4c e0950597
d1d5ed54 d32ac3ec d1d5ed54 d32ac3ec 
Sep 17 08:07:43 A405a kernel:        d32ac3ec def1520c dc5afd70 c0162536
def1520c d32ac3ec d32ac3ec 00000000 
Sep 17 08:07:43 A405a kernel: Call Trace:
Sep 17 08:07:43 A405a kernel:  [_end+542842167/1069938592]
bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0950597>] bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [_end+542842167/1069938592]
bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0950597>] bttv_release+0x6b/0xe0 [bttv]
Sep 17 08:07:43 A405a kernel:  [__fput+70/276] __fput+0x46/0x114
Sep 17 08:07:43 A405a kernel:  [<c0162536>] __fput+0x46/0x114
Sep 17 08:07:43 A405a kernel:  [fput+22/28] fput+0x16/0x1c
Sep 17 08:07:43 A405a kernel:  [<c01624ea>] fput+0x16/0x1c
Sep 17 08:07:43 A405a kernel:  [filp_close+92/104] filp_close+0x5c/0x68
Sep 17 08:07:43 A405a kernel:  [<c0160a14>] filp_close+0x5c/0x68
Sep 17 08:07:43 A405a kernel:  [put_files_struct+88/192]
put_files_struct+0x58/0xc0
Sep 17 08:07:43 A405a kernel:  [<c0120d50>] put_files_struct+0x58/0xc0
Sep 17 08:07:43 A405a kernel:  [do_exit+1031/2104] do_exit+0x407/0x838
Sep 17 08:07:43 A405a kernel:  [<c0121f37>] do_exit+0x407/0x838
Sep 17 08:07:43 A405a kernel:  [do_divide_error+0/164]
do_divide_error+0x0/0xa4
Sep 17 08:07:43 A405a kernel:  [<c010a70c>] do_divide_error+0x0/0xa4
Sep 17 08:07:43 A405a kernel:  [do_invalid_op+0/140] do_invalid_op+0x0/0x8c
Sep 17 08:07:43 A405a kernel:  [<c010a90c>] do_invalid_op+0x0/0x8c
Sep 17 08:07:43 A405a kernel:  [do_invalid_op+125/140]
do_invalid_op+0x7d/0x8c
Sep 17 08:07:43 A405a kernel:  [<c010a989>] do_invalid_op+0x7d/0x8c
Sep 17 08:07:43 A405a kernel:  [kfree+484/676] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [<c0146f24>] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [_end+542855216/1069938592]
gcc2_compiled.+0x30/0x13c [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0953890>] gcc2_compiled.+0x30/0x13c [bttv]
Sep 17 08:07:43 A405a kernel:  [_end+542860285/1069938592]
bttv_buffer_risc+0x189/0x4c0 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e0954c5d>] bttv_buffer_risc+0x189/0x4c0
[bttv]
Sep 17 08:07:43 A405a kernel:  [error_code+45/64] error_code+0x2d/0x40
Sep 17 08:07:43 A405a kernel:  [<c0109fdd>] error_code+0x2d/0x40
Sep 17 08:07:43 A405a kernel:  [kfree+484/676] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [<c0146f24>] kfree+0x1e4/0x2a4
Sep 17 08:07:43 A405a kernel:  [_end+542669876/1069938592]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926494>]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542669876/1069938592]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926494>]
videobuf_read_zerocopy+0x1f0/0x208 [video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542670022/1069938592]
videobuf_read_one+0x7a/0x358 [video_buf]
Sep 17 08:07:43 A405a kernel:  [<e0926526>] videobuf_read_one+0x7a/0x358
[video_buf]
Sep 17 08:07:43 A405a kernel:  [_end+542841191/1069938592]
bttv_read+0x8b/0xe8 [bttv]
Sep 17 08:07:43 A405a kernel:  [<e09501c7>] bttv_read+0x8b/0xe8 [bttv]
Sep 17 08:07:43 A405a kernel:  [vfs_read+187/244] vfs_read+0xbb/0xf4
Sep 17 08:07:43 A405a kernel:  [<c0161517>] vfs_read+0xbb/0xf4
Sep 17 08:07:43 A405a kernel:  [sys_read+48/80] sys_read+0x30/0x50
Sep 17 08:07:43 A405a kernel:  [<c0161720>] sys_read+0x30/0x50
Sep 17 08:07:43 A405a kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 17 08:07:43 A405a kernel:  [<c0109d77>] syscall_call+0x7/0xb
Sep 17 08:07:43 A405a kernel: 
Sep 17 08:07:43 A405a kernel: Code: 0f 0b 7b 06 b2 3a 2b c0 8d 74 26 00 0f
af 45 e4 01 c8 39 c7


-------------------------------------------------------------------------------------------
END ERROR
1
-------------------------------------------------------------------------------------------

Sep 16 18:05:11 A405a kernel: Debug: sleeping function called from invalid
context at mm/slab.c:1817
Sep 16 18:05:11 A405a kernel: Call Trace:
Sep 16 18:05:11 A405a kernel:  [__might_sleep+99/108]
__might_sleep+0x63/0x6c
Sep 16 18:05:11 A405a kernel:  [<c011b967>] __might_sleep+0x63/0x6c
Sep 16 18:05:11 A405a kernel:  [kmem_cache_alloc+37/308]
kmem_cache_alloc+0x25/0x134
Sep 16 18:05:11 A405a kernel:  [<c014686d>] kmem_cache_alloc+0x25/0x134
Sep 16 18:05:11 A405a kernel:  [alloc_inode+254/424] alloc_inode+0xfe/0x1a8
Sep 16 18:05:11 A405a kernel:  [<c018246e>] alloc_inode+0xfe/0x1a8
Sep 16 18:05:11 A405a kernel:  [__get_vm_area+31/256]
__get_vm_area+0x1f/0x100
Sep 16 18:05:11 A405a kernel:  [<c015a533>] __get_vm_area+0x1f/0x100
Sep 16 18:05:11 A405a kernel:  [get_vm_area+37/44] get_vm_area+0x25/0x2c
Sep 16 18:05:11 A405a kernel:  [<c015a639>] get_vm_area+0x25/0x2c
Sep 16 18:05:11 A405a kernel:  [__ioremap+168/228] __ioremap+0xa8/0xe4
Sep 16 18:05:11 A405a kernel:  [<c0117b48>] __ioremap+0xa8/0xe4
Sep 16 18:05:11 A405a kernel:  [ioremap_nocache+24/180]
ioremap_nocache+0x18/0xb4
Sep 16 18:05:11 A405a kernel:  [<c0117b9c>] ioremap_nocache+0x18/0xb4
Sep 16 18:05:11 A405a kernel:  [_end+546522911/1069938592]
os_map_kernel_space+0x53/0x58 [nvidia]
Sep 16 18:05:11 A405a kernel:  [<e0cd2f7f>] os_map_kernel_space+0x53/0x58
[nvidia]
Sep 16 18:05:11 A405a kernel:  [_end+546598151/1069938592]
__nvsym00568+0x1f/0x2c [nvidia]
Sep 16 18:05:11 A405a kernel:  [<e0ce5567>] __nvsym00568+0x1f/0x2c [nvidia]
Sep 16 18:05:11 A405a kernel:  [_end+546606630/1069938592]
__nvsym00775+0x6e/0xe0 [nvidia]
Sep 16 18:05:11 A405a kernel:  [<e0ce7686>] __nvsym00775+0x6e/0xe0 [nvidia]
Sep 16 18:05:11 A405a kernel:  [_end+546606774/1069938592]
__nvsym00781+0x1e/0x190 [nvidia]
Sep 16 18:05:11 A405a kernel:  [<e0ce7716>] __nvsym00781+0x1e/0x190 [nvidia]
Sep 16 18:05:11 A405a kernel:  [_end+546613564/1069938592]
rm_init_adapter+0xc/0x10 [nvidia]
Sep 16 18:05:11 A405a kernel:  [<e0ce919c>] rm_init_adapter+0xc/0x10
[nvidia]
Sep 16 18:05:11 A405a kernel:  [_end+546506393/1069938592]
nv_kern_open+0x185/0x320 [nvidia]
Sep 16 18:05:11 A405a kernel:  [<e0cceef9>] nv_kern_open+0x185/0x320
[nvidia]
Sep 16 18:05:11 A405a kernel:  [chrdev_open+1095/1292]
chrdev_open+0x447/0x50c
Sep 16 18:05:11 A405a kernel:  [<c016dc27>] chrdev_open+0x447/0x50c
Sep 16 18:05:11 A405a kernel:  [devfs_open+528/544] devfs_open+0x210/0x220
Sep 16 18:05:11 A405a kernel:  [<c01b1a18>] devfs_open+0x210/0x220
Sep 16 18:05:11 A405a kernel:  [dentry_open+256/488] dentry_open+0x100/0x1e8
Sep 16 18:05:11 A405a kernel:  [<c016037c>] dentry_open+0x100/0x1e8
Sep 16 18:05:11 A405a kernel:  [filp_open+71/80] filp_open+0x47/0x50
Sep 16 18:05:11 A405a kernel:  [<c0160273>] filp_open+0x47/0x50
Sep 16 18:05:11 A405a kernel:  [sys_open+55/124] sys_open+0x37/0x7c
Sep 16 18:05:11 A405a kernel:  [<c0160957>] sys_open+0x37/0x7c
Sep 16 18:05:11 A405a kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 16 18:05:11 A405a kernel:  [<c0109d77>] syscall_call+0x7/0xb
Sep 16 18:05:11 A405a kernel: 
Sep 16 18:05:12 A405a kernel: Debug: sleeping function called from invalid
context at mm/slab.c:1817
Sep 16 18:05:12 A405a kernel: Call Trace:
Sep 16 18:05:12 A405a kernel:  [__might_sleep+99/108]
__might_sleep+0x63/0x6c
Sep 16 18:05:12 A405a kernel:  [<c011b967>] __might_sleep+0x63/0x6c
Sep 16 18:05:12 A405a kernel:  [kmem_cache_alloc+37/308]
kmem_cache_alloc+0x25/0x134
Sep 16 18:05:12 A405a kernel:  [<c014686d>] kmem_cache_alloc+0x25/0x134
Sep 16 18:05:12 A405a kernel:  [update_process_times+44/56]
update_process_times+0x2c/0x38
Sep 16 18:05:12 A405a kernel:  [<c01285c8>] update_process_times+0x2c/0x38
Sep 16 18:05:12 A405a kernel:  [__get_vm_area+31/256]
__get_vm_area+0x1f/0x100
Sep 16 18:05:12 A405a kernel:  [<c015a533>] __get_vm_area+0x1f/0x100
Sep 16 18:05:12 A405a kernel:  [get_vm_area+37/44] get_vm_area+0x25/0x2c
Sep 16 18:05:12 A405a kernel:  [<c015a639>] get_vm_area+0x25/0x2c
Sep 16 18:05:12 A405a kernel:  [__ioremap+168/228] __ioremap+0xa8/0xe4
Sep 16 18:05:12 A405a kernel:  [<c0117b48>] __ioremap+0xa8/0xe4
Sep 16 18:05:12 A405a kernel:  [ioremap_nocache+24/180]
ioremap_nocache+0x18/0xb4
Sep 16 18:05:12 A405a kernel:  [<c0117b9c>] ioremap_nocache+0x18/0xb4
Sep 16 18:05:12 A405a kernel:  [_end+546522911/1069938592]
os_map_kernel_space+0x53/0x58 [nvidia]
Sep 16 18:05:12 A405a kernel:  [<e0cd2f7f>] os_map_kernel_space+0x53/0x58
[nvidia]
Sep 16 18:05:12 A405a kernel:  [_end+546598151/1069938592]
__nvsym00568+0x1f/0x2c [nvidia]
Sep 16 18:05:12 A405a kernel:  [<e0ce5567>] __nvsym00568+0x1f/0x2c [nvidia]
Sep 16 18:05:12 A405a kernel:  [_end+546606630/1069938592]
__nvsym00775+0x6e/0xe0 [nvidia]
Sep 16 18:05:12 A405a kernel:  [<e0ce7686>] __nvsym00775+0x6e/0xe0 [nvidia]
Sep 16 18:05:12 A405a kernel:  [_end+546606774/1069938592]
__nvsym00781+0x1e/0x190 [nvidia]
Sep 16 18:05:12 A405a kernel:  [<e0ce7716>] __nvsym00781+0x1e/0x190 [nvidia]
Sep 16 18:05:12 A405a kernel:  [_end+546613564/1069938592]
rm_init_adapter+0xc/0x10 [nvidia]
Sep 16 18:05:12 A405a kernel:  [<e0ce919c>] rm_init_adapter+0xc/0x10
[nvidia]
Sep 16 18:05:12 A405a kernel:  [_end+546506393/1069938592]
nv_kern_open+0x185/0x320 [nvidia]
Sep 16 18:05:12 A405a kernel:  [<e0cceef9>] nv_kern_open+0x185/0x320
[nvidia]
Sep 16 18:05:12 A405a kernel:  [chrdev_open+1095/1292]
chrdev_open+0x447/0x50c
Sep 16 18:05:12 A405a kernel:  [<c016dc27>] chrdev_open+0x447/0x50c
Sep 16 18:05:12 A405a kernel:  [devfs_open+528/544] devfs_open+0x210/0x220
Sep 16 18:05:12 A405a kernel:  [<c01b1a18>] devfs_open+0x210/0x220
Sep 16 18:05:12 A405a kernel:  [dentry_open+256/488] dentry_open+0x100/0x1e8
Sep 16 18:05:12 A405a kernel:  [<c016037c>] dentry_open+0x100/0x1e8
Sep 16 18:05:12 A405a kernel:  [filp_open+71/80] filp_open+0x47/0x50
Sep 16 18:05:12 A405a kernel:  [<c0160273>] filp_open+0x47/0x50
Sep 16 18:05:12 A405a kernel:  [sys_open+55/124] sys_open+0x37/0x7c
Sep 16 18:05:12 A405a kernel:  [<c0160957>] sys_open+0x37/0x7c
Sep 16 18:05:12 A405a kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 16 18:05:12 A405a kernel:  [<c0109d77>] syscall_call+0x7/0xb


