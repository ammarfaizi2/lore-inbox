Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUBZNRl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbUBZNRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:17:41 -0500
Received: from metaroot.info ([217.160.213.180]:60598 "EHLO metaroot")
	by vger.kernel.org with ESMTP id S262784AbUBZNPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:15:08 -0500
Message-ID: <403DF12C.6030003@chobeiry.de>
Date: Thu, 26 Feb 2004 14:14:20 +0100
From: Parto Chobeiry <parto@chobeiry.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel 2.6.3 - Buffer Layer Error
X-Enigmail-Version: 0.83.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1
 
Hello List Members,

please cc me because I am not a member of this list...

*[1.] One line summary of the problem:*

When doing RSync (2.6.0) w/ approx. 150.000 files on /dev/hda3 (ext3
data journalling) and then another RSync w/ approx. 50 files to
/dev/hda1 (ext3 data journalling), a kernel error appears and machine
gets loaded heavily.

*[2.] Full description of the problem/report:*

I am maintaining several systems which I keep in sync with rsync.
Syncronizing the non-boot-area (/dev/hda3) always works fine, but then
syncronizing the boot-area (/dev/hda1) fails if lots of I/O (approx.
150MB) was done on /dev/hda3.

I reactivated 2.4.25 -- everything seems to be fine there; I cannot
reproduce the error.

The error occurred on 4 systems, all using the 2.6.3 kernel and being
syncronized with RSync.

*[3.] Keywords (i.e., modules, networking, kernel):*

Buffer Layer, Kernel, I/O

*[4.] Kernel version (from /proc/version):*

2.6.3 (compiled with GCC 2.95.3)
2.6.3 (compiled with GCC 3.3.3 although not recommended)

I tried both and both failed.

*[5.] Output of Oops.. message (if applicable) with symbolic information
~     resolved (see Documentation/oops-tracing.txt)*

Feb 25 09:53:32 myhost kernel: buffer layer error at fs/buffer.c:430
Feb 25 09:53:32 myhost kernel: Call Trace:
Feb 25 09:53:32 myhost kernel:  [__buffer_error+41/48]
__buffer_error+0x29/0x30
Feb 25 09:53:32 myhost kernel:  [<c0148c49>] __buffer_error+0x29/0x30
Feb 25 09:53:32 myhost kernel:  [__find_get_block_slow+164/384]
__find_get_block
_slow+0xa4/0x180
Feb 25 09:53:32 myhost kernel:  [<c01492b4>]
__find_get_block_slow+0xa4/0x180
Feb 25 09:53:32 myhost kernel:  [__find_get_block+193/228]
__find_get_block+0xc1
/0xe4
Feb 25 09:53:32 myhost kernel:  [<c014a239>] __find_get_block+0xc1/0xe4
Feb 25 09:53:32 myhost kernel:  [__getblk+29/56] __getblk+0x1d/0x38
Feb 25 09:53:32 myhost kernel:  [<c014a279>] __getblk+0x1d/0x38
Feb 25 09:53:32 myhost kernel:  [__bread+25/52] __bread+0x19/0x34
Feb 25 09:53:32 myhost kernel:  [<c014a2f1>] __bread+0x19/0x34
Feb 25 09:53:32 myhost kernel:  [read_block_bitmap+54/96]
read_block_bitmap+0x36
/0x60
Feb 25 09:53:32 myhost kernel:  [<c019c786>] read_block_bitmap+0x36/0x60
Feb 25 09:53:32 myhost kernel:  [ext3_new_block+476/1080]
ext3_new_block+0x1dc/0
x438
Feb 25 09:53:32 myhost kernel:  [<c019d3b8>] ext3_new_block+0x1dc/0x438
Feb 25 09:53:32 myhost kernel:  [ext3_alloc_block+30/36]
ext3_alloc_block+0x1e/0
x24
Feb 25 09:53:32 myhost kernel:  [<c019f56e>] ext3_alloc_block+0x1e/0x24
Feb 25 09:53:32 myhost kernel:  [ext3_alloc_branch+63/620]
ext3_alloc_branch+0x3
f/0x26c
Feb 25 09:53:32 myhost kernel:  [<c019f8db>] ext3_alloc_branch+0x3f/0x26c
Feb 25 09:53:32 myhost kernel:  [ext3_find_goal+88/116]
ext3_find_goal+0x58/0x74
Feb 25 09:53:32 myhost kernel:  [<c019f880>] ext3_find_goal+0x58/0x74
Feb 25 09:53:32 myhost kernel:  [ext3_get_block_handle+470/688]
ext3_get_block_h
andle+0x1d6/0x2b0
Feb 25 09:53:32 myhost kernel:  [<c019fe62>]
ext3_get_block_handle+0x1d6/0x2b0
Feb 25 09:53:32 myhost kernel:  [do_no_page+83/1212] do_no_page+0x53/0x4bc
Feb 25 09:53:32 myhost kernel:  [<c013ad07>] do_no_page+0x53/0x4bc
Feb 25 09:53:32 myhost kernel:  [alloc_buffer_head+48/68]
alloc_buffer_head+0x30
/0x44
Feb 25 09:53:32 myhost kernel:  [<c014c568>] alloc_buffer_head+0x30/0x44
Feb 25 09:53:32 myhost kernel:  [create_buffers+88/148]
create_buffers+0x58/0x94
Feb 25 09:53:32 myhost kernel:  [<c0149bc0>] create_buffers+0x58/0x94
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+101/108]
ext3_get_block+0x65/0x6
c
Feb 25 09:53:32 myhost kernel:  [<c019ffa1>] ext3_get_block+0x65/0x6c
Feb 25 09:53:32 myhost kernel:  [__block_prepare_write+338/988]
__block_prepare_
write+0x152/0x3dc
Feb 25 09:53:32 myhost kernel:  [<c014aa3e>]
__block_prepare_write+0x152/0x3dc
Feb 25 09:53:32 myhost kernel:  [block_prepare_write+33/56]
block_prepare_write+
0x21/0x38
Feb 25 09:53:32 myhost kernel:  [<c014b5d5>] block_prepare_write+0x21/0x38
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [ext3_prepare_write+69/216]
ext3_prepare_write+0
x45/0xd8
Feb 25 09:53:32 myhost kernel:  [<c01a03e5>] ext3_prepare_write+0x45/0xd8
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:
[generic_file_aio_write_nolock+1680/2916] generi
c_file_aio_write_nolock+0x690/0xb64
Feb 25 09:53:32 myhost kernel:  [<c0130108>]
generic_file_aio_write_nolock+0x690
/0xb64
Feb 25 09:53:32 myhost kernel:  [do_generic_mapping_read+1255/1268]
do_generic_m
apping_read+0x4e7/0x4f4
Feb 25 09:53:32 myhost kernel:  [<c012e6b7>]
do_generic_mapping_read+0x4e7/0x4f4
Feb 25 09:53:32 myhost kernel:  [generic_file_aio_write+103/124]
generic_file_ai
o_write+0x67/0x7c
Feb 25 09:53:32 myhost kernel:  [<c01306d3>]
generic_file_aio_write+0x67/0x7c
Feb 25 09:53:32 myhost kernel:  [ext3_file_write+43/188]
ext3_file_write+0x2b/0x
bc
Feb 25 09:53:32 myhost kernel:  [<c019e1af>] ext3_file_write+0x2b/0xbc
Feb 25 09:53:32 myhost kernel:  [do_sync_write+129/184]
do_sync_write+0x81/0xb8
Feb 25 09:53:32 myhost kernel:  [<c0147c85>] do_sync_write+0x81/0xb8
Feb 25 09:53:32 myhost kernel:  [rcu_check_callbacks+83/84]
rcu_check_callbacks+
0x53/0x54
Feb 25 09:53:32 myhost kernel:  [<c01294d3>] rcu_check_callbacks+0x53/0x54
Feb 25 09:53:32 myhost kernel:  [update_process_times+42/48]
update_process_time
s+0x2a/0x30
Feb 25 09:53:32 myhost kernel:  [<c0121f0e>]
update_process_times+0x2a/0x30
Feb 25 09:53:32 myhost kernel:  [update_wall_time+11/52]
update_wall_time+0xb/0x
34
Feb 25 09:53:32 myhost kernel:  [<c0121dfb>] update_wall_time+0xb/0x34
Feb 25 09:53:32 myhost kernel:  [do_timer+75/192] do_timer+0x4b/0xc0
Feb 25 09:53:32 myhost kernel:  [<c01220e3>] do_timer+0x4b/0xc0
Feb 25 09:53:32 myhost kernel:  [rcu_check_quiescent_state+95/124]
rcu_check_qui
escent_state+0x5f/0x7c
Feb 25 09:53:32 myhost kernel:  [<c0129367>]
rcu_check_quiescent_state+0x5f/0x7c
Feb 25 09:53:32 myhost kernel:  [rcu_process_callbacks+226/252]
rcu_process_call
backs+0xe2/0xfc
Feb 25 09:53:32 myhost kernel:  [<c0129466>]
rcu_process_callbacks+0xe2/0xfc
Feb 25 09:53:32 myhost kernel:  [vfs_write+185/232] vfs_write+0xb9/0xe8
Feb 25 09:53:32 myhost kernel:  [<c0147d75>] vfs_write+0xb9/0xe8
Feb 25 09:53:32 myhost kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Feb 25 09:53:32 myhost kernel:  [<c0147e21>] sys_write+0x31/0x4c
Feb 25 09:53:32 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 25 09:53:32 myhost kernel:  [<c0108b87>] syscall_call+0x7/0xb
Feb 25 09:53:32 myhost kernel:
Feb 25 09:53:32 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:32 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:32 myhost kernel: buffer layer error at fs/buffer.c:430
Feb 25 09:53:32 myhost kernel: Call Trace:
Feb 25 09:53:32 myhost kernel:  [__buffer_error+41/48]
__buffer_error+0x29/0x30
Feb 25 09:53:32 myhost kernel:  [<c0148c49>] __buffer_error+0x29/0x30
Feb 25 09:53:32 myhost kernel:  [__find_get_block_slow+164/384]
__find_get_block
_slow+0xa4/0x180
Feb 25 09:53:32 myhost kernel:  [<c01492b4>]
__find_get_block_slow+0xa4/0x180
Feb 25 09:53:32 myhost kernel:  [__find_get_block+193/228]
__find_get_block+0xc1
/0xe4
Feb 25 09:53:32 myhost kernel:  [<c014a239>] __find_get_block+0xc1/0xe4
Feb 25 09:53:32 myhost kernel:  [__getblk_slow+33/364]
__getblk_slow+0x21/0x16c
Feb 25 09:53:32 myhost kernel:  [<c0149e0d>] __getblk_slow+0x21/0x16c
Feb 25 09:53:32 myhost kernel:  [__getblk+45/56] __getblk+0x2d/0x38
Feb 25 09:53:32 myhost kernel:  [<c014a289>] __getblk+0x2d/0x38
Feb 25 09:53:32 myhost kernel:  [__bread+25/52] __bread+0x19/0x34
Feb 25 09:53:32 myhost kernel:  [<c014a2f1>] __bread+0x19/0x34
Feb 25 09:53:32 myhost kernel:  [read_block_bitmap+54/96]
read_block_bitmap+0x36
/0x60
Feb 25 09:53:32 myhost kernel:  [<c019c786>] read_block_bitmap+0x36/0x60
Feb 25 09:53:32 myhost kernel:  [ext3_new_block+476/1080]
ext3_new_block+0x1dc/0
x438
Feb 25 09:53:32 myhost kernel:  [<c019d3b8>] ext3_new_block+0x1dc/0x438
Feb 25 09:53:32 myhost kernel:  [ext3_alloc_block+30/36]
ext3_alloc_block+0x1e/0
x24
Feb 25 09:53:32 myhost kernel:  [<c019f56e>] ext3_alloc_block+0x1e/0x24
Feb 25 09:53:32 myhost kernel:  [ext3_alloc_branch+63/620]
ext3_alloc_branch+0x3
f/0x26c
Feb 25 09:53:32 myhost kernel:  [<c019f8db>] ext3_alloc_branch+0x3f/0x26c
Feb 25 09:53:32 myhost kernel:  [ext3_find_goal+88/116]
ext3_find_goal+0x58/0x74
Feb 25 09:53:32 myhost kernel:  [<c019f880>] ext3_find_goal+0x58/0x74
Feb 25 09:53:32 myhost kernel:  [ext3_get_block_handle+470/688]
ext3_get_block_h
andle+0x1d6/0x2b0
Feb 25 09:53:32 myhost kernel:  [<c019fe62>]
ext3_get_block_handle+0x1d6/0x2b0
Feb 25 09:53:32 myhost kernel:  [do_no_page+83/1212] do_no_page+0x53/0x4bc
Feb 25 09:53:32 myhost kernel:  [<c013ad07>] do_no_page+0x53/0x4bc
Feb 25 09:53:32 myhost kernel:  [alloc_buffer_head+48/68]
alloc_buffer_head+0x30
/0x44
Feb 25 09:53:32 myhost kernel:  [<c014c568>] alloc_buffer_head+0x30/0x44
Feb 25 09:53:32 myhost kernel:  [create_buffers+88/148]
create_buffers+0x58/0x94
Feb 25 09:53:32 myhost kernel:  [<c0149bc0>] create_buffers+0x58/0x94
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+101/108]
ext3_get_block+0x65/0x6
c
Feb 25 09:53:32 myhost kernel:  [<c019ffa1>] ext3_get_block+0x65/0x6c
Feb 25 09:53:32 myhost kernel:  [__block_prepare_write+338/988]
__block_prepare_
write+0x152/0x3dc
Feb 25 09:53:32 myhost kernel:  [<c014aa3e>]
__block_prepare_write+0x152/0x3dc
Feb 25 09:53:32 myhost kernel:  [block_prepare_write+33/56]
block_prepare_write+
0x21/0x38
Feb 25 09:53:32 myhost kernel:  [<c014b5d5>] block_prepare_write+0x21/0x38
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [ext3_prepare_write+69/216]
ext3_prepare_write+0
x45/0xd8
Feb 25 09:53:32 myhost kernel:  [<c01a03e5>] ext3_prepare_write+0x45/0xd8
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:
[generic_file_aio_write_nolock+1680/2916] generi
c_file_aio_write_nolock+0x690/0xb64
Feb 25 09:53:32 myhost kernel:  [<c0130108>]
generic_file_aio_write_nolock+0x690
/0xb64
Feb 25 09:53:32 myhost kernel:  [do_generic_mapping_read+1255/1268]
do_generic_m
apping_read+0x4e7/0x4f4
Feb 25 09:53:32 myhost kernel:  [<c012e6b7>]
do_generic_mapping_read+0x4e7/0x4f4
Feb 25 09:53:32 myhost kernel:  [generic_file_aio_write+103/124]
generic_file_ai
o_write+0x67/0x7c
Feb 25 09:53:32 myhost kernel:  [<c01306d3>]
generic_file_aio_write+0x67/0x7c
Feb 25 09:53:32 myhost kernel:  [ext3_file_write+43/188]
ext3_file_write+0x2b/0x
bc
Feb 25 09:53:32 myhost kernel:  [<c019e1af>] ext3_file_write+0x2b/0xbc
Feb 25 09:53:32 myhost kernel:  [do_sync_write+129/184]
do_sync_write+0x81/0xb8
Feb 25 09:53:32 myhost kernel:  [<c0147c85>] do_sync_write+0x81/0xb8
Feb 25 09:53:32 myhost kernel:  [rcu_check_callbacks+83/84]
rcu_check_callbacks+
0x53/0x54
Feb 25 09:53:32 myhost kernel:  [<c01294d3>] rcu_check_callbacks+0x53/0x54
Feb 25 09:53:32 myhost kernel:  [update_process_times+42/48]
update_process_time
s+0x2a/0x30
Feb 25 09:53:32 myhost kernel:  [<c0121f0e>]
update_process_times+0x2a/0x30
Feb 25 09:53:32 myhost kernel:  [update_wall_time+11/52]
update_wall_time+0xb/0x
34
Feb 25 09:53:32 myhost kernel:  [<c0121dfb>] update_wall_time+0xb/0x34
Feb 25 09:53:32 myhost kernel:  [do_timer+75/192] do_timer+0x4b/0xc0
Feb 25 09:53:32 myhost kernel:  [<c01220e3>] do_timer+0x4b/0xc0
Feb 25 09:53:32 myhost kernel:  [rcu_check_quiescent_state+95/124]
rcu_check_qui
escent_state+0x5f/0x7c
Feb 25 09:53:32 myhost kernel:  [<c0129367>]
rcu_check_quiescent_state+0x5f/0x7c
Feb 25 09:53:32 myhost kernel:  [rcu_process_callbacks+226/252]
rcu_process_call
backs+0xe2/0xfc
Feb 25 09:53:32 myhost kernel:  [<c0129466>]
rcu_process_callbacks+0xe2/0xfc
Feb 25 09:53:32 myhost kernel:  [vfs_write+185/232] vfs_write+0xb9/0xe8
Feb 25 09:53:32 myhost kernel:  [<c0147d75>] vfs_write+0xb9/0xe8
Feb 25 09:53:32 myhost kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Feb 25 09:53:32 myhost kernel:  [<c0147e21>] sys_write+0x31/0x4c
Feb 25 09:53:32 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 25 09:53:32 myhost kernel:  [<c0108b87>] syscall_call+0x7/0xb
Feb 25 09:53:32 myhost kernel:
Feb 25 09:53:32 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:32 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:32 myhost kernel: buffer layer error at fs/buffer.c:430
Feb 25 09:53:32 myhost kernel: Call Trace:
Feb 25 09:53:32 myhost kernel:  [__buffer_error+41/48]
__buffer_error+0x29/0x30
Feb 25 09:53:32 myhost kernel:  [<c0148c49>] __buffer_error+0x29/0x30
Feb 25 09:53:32 myhost kernel:  [__find_get_block_slow+164/384]
__find_get_block
_slow+0xa4/0x180
Feb 25 09:53:32 myhost kernel:  [<c01492b4>]
__find_get_block_slow+0xa4/0x180
Feb 25 09:53:32 myhost kernel:  [__find_get_block+193/228]
__find_get_block+0xc1
/0xe4
Feb 25 09:53:32 myhost kernel:  [<c014a239>] __find_get_block+0xc1/0xe4
Feb 25 09:53:32 myhost kernel:  [__getblk_slow+33/364]
__getblk_slow+0x21/0x16c
Feb 25 09:53:32 myhost kernel:  [<c0149e0d>] __getblk_slow+0x21/0x16c
Feb 25 09:53:32 myhost kernel:  [__getblk+45/56] __getblk+0x2d/0x38
Feb 25 09:53:32 myhost kernel:  [<c014a289>] __getblk+0x2d/0x38
Feb 25 09:53:32 myhost kernel:  [__bread+25/52] __bread+0x19/0x34
Feb 25 09:53:32 myhost kernel:  [<c014a2f1>] __bread+0x19/0x34
Feb 25 09:53:32 myhost kernel:  [read_block_bitmap+54/96]
read_block_bitmap+0x36
/0x60
Feb 25 09:53:32 myhost kernel:  [<c019c786>] read_block_bitmap+0x36/0x60
Feb 25 09:53:32 myhost kernel:  [ext3_new_block+476/1080]
ext3_new_block+0x1dc/0
x438
Feb 25 09:53:32 myhost kernel:  [<c019d3b8>] ext3_new_block+0x1dc/0x438
Feb 25 09:53:32 myhost kernel:  [ext3_alloc_block+30/36]
ext3_alloc_block+0x1e/0
x24
Feb 25 09:53:32 myhost kernel:  [<c019f56e>] ext3_alloc_block+0x1e/0x24
Feb 25 09:53:32 myhost kernel:  [ext3_alloc_branch+63/620]
ext3_alloc_branch+0x3
f/0x26c
Feb 25 09:53:32 myhost kernel:  [<c019f8db>] ext3_alloc_branch+0x3f/0x26c
Feb 25 09:53:32 myhost kernel:  [ext3_find_goal+88/116]
ext3_find_goal+0x58/0x74
Feb 25 09:53:32 myhost kernel:  [<c019f880>] ext3_find_goal+0x58/0x74
Feb 25 09:53:32 myhost kernel:  [ext3_get_block_handle+470/688]
ext3_get_block_h
andle+0x1d6/0x2b0
Feb 25 09:53:32 myhost kernel:  [<c019fe62>]
ext3_get_block_handle+0x1d6/0x2b0
Feb 25 09:53:32 myhost kernel:  [do_no_page+83/1212] do_no_page+0x53/0x4bc
Feb 25 09:53:32 myhost kernel:  [<c013ad07>] do_no_page+0x53/0x4bc
Feb 25 09:53:32 myhost kernel:  [alloc_buffer_head+48/68]
alloc_buffer_head+0x30
/0x44
Feb 25 09:53:32 myhost kernel:  [<c014c568>] alloc_buffer_head+0x30/0x44
Feb 25 09:53:32 myhost kernel:  [create_buffers+88/148]
create_buffers+0x58/0x94
Feb 25 09:53:32 myhost kernel:  [<c0149bc0>] create_buffers+0x58/0x94
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+101/108]
ext3_get_block+0x65/0x6
c
Feb 25 09:53:32 myhost kernel:  [<c019ffa1>] ext3_get_block+0x65/0x6c
Feb 25 09:53:32 myhost kernel:  [__block_prepare_write+338/988]
__block_prepare_
write+0x152/0x3dc
Feb 25 09:53:32 myhost kernel:  [<c014aa3e>]
__block_prepare_write+0x152/0x3dc
Feb 25 09:53:32 myhost kernel:  [block_prepare_write+33/56]
block_prepare_write+
0x21/0x38
Feb 25 09:53:32 myhost kernel:  [<c014b5d5>] block_prepare_write+0x21/0x38
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [ext3_prepare_write+69/216]
ext3_prepare_write+0
x45/0xd8
Feb 25 09:53:32 myhost kernel:  [<c01a03e5>] ext3_prepare_write+0x45/0xd8
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:
[generic_file_aio_write_nolock+1680/2916] generi
c_file_aio_write_nolock+0x690/0xb64
Feb 25 09:53:32 myhost kernel:  [<c0130108>]
generic_file_aio_write_nolock+0x690
/0xb64
Feb 25 09:53:32 myhost kernel:  [do_generic_mapping_read+1255/1268]
do_generic_m
apping_read+0x4e7/0x4f4
Feb 25 09:53:32 myhost kernel:  [<c012e6b7>]
do_generic_mapping_read+0x4e7/0x4f4
Feb 25 09:53:32 myhost kernel:  [generic_file_aio_write+103/124]
generic_file_ai
o_write+0x67/0x7c
Feb 25 09:53:32 myhost kernel:  [<c01306d3>]
generic_file_aio_write+0x67/0x7c
Feb 25 09:53:32 myhost kernel:  [ext3_file_write+43/188]
ext3_file_write+0x2b/0x
bc
Feb 25 09:53:32 myhost kernel:  [<c019e1af>] ext3_file_write+0x2b/0xbc
Feb 25 09:53:32 myhost kernel:  [do_sync_write+129/184]
do_sync_write+0x81/0xb8
Feb 25 09:53:32 myhost kernel:  [<c0147c85>] do_sync_write+0x81/0xb8
Feb 25 09:53:32 myhost kernel:  [rcu_check_callbacks+83/84]
rcu_check_callbacks+
0x53/0x54
Feb 25 09:53:32 myhost kernel:  [<c01294d3>] rcu_check_callbacks+0x53/0x54
Feb 25 09:53:32 myhost kernel:  [update_process_times+42/48]
update_process_time
s+0x2a/0x30
Feb 25 09:53:32 myhost kernel:  [<c0121f0e>]
update_process_times+0x2a/0x30
Feb 25 09:53:32 myhost kernel:  [update_wall_time+11/52]
update_wall_time+0xb/0x
34
Feb 25 09:53:32 myhost kernel:  [<c0121dfb>] update_wall_time+0xb/0x34
Feb 25 09:53:32 myhost kernel:  [do_timer+75/192] do_timer+0x4b/0xc0
Feb 25 09:53:32 myhost kernel:  [<c01220e3>] do_timer+0x4b/0xc0
Feb 25 09:53:32 myhost kernel:  [rcu_check_quiescent_state+95/124]
rcu_check_qui
escent_state+0x5f/0x7c
Feb 25 09:53:32 myhost kernel:  [<c0129367>]
rcu_check_quiescent_state+0x5f/0x7c
Feb 25 09:53:32 myhost kernel:  [rcu_process_callbacks+226/252]
rcu_process_call
backs+0xe2/0xfc
Feb 25 09:53:32 myhost kernel:  [<c0129466>]
rcu_process_callbacks+0xe2/0xfc
Feb 25 09:53:32 myhost kernel:  [vfs_write+185/232] vfs_write+0xb9/0xe8
Feb 25 09:53:32 myhost kernel:  [<c0147d75>] vfs_write+0xb9/0xe8
Feb 25 09:53:32 myhost kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Feb 25 09:53:32 myhost kernel:  [<c0147e21>] sys_write+0x31/0x4c
Feb 25 09:53:32 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 25 09:53:32 myhost kernel:  [<c0108b87>] syscall_call+0x7/0xb
Feb 25 09:53:32 myhost kernel:
Feb 25 09:53:32 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:32 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:32 myhost kernel: buffer layer error at fs/buffer.c:430
Feb 25 09:53:32 myhost kernel: Call Trace:
Feb 25 09:53:32 myhost kernel:  [__buffer_error+41/48]
__buffer_error+0x29/0x30
Feb 25 09:53:32 myhost kernel:  [<c0148c49>] __buffer_error+0x29/0x30
Feb 25 09:53:32 myhost kernel:  [__find_get_block_slow+164/384]
__find_get_block
_slow+0xa4/0x180
Feb 25 09:53:32 myhost kernel:  [<c01492b4>]
__find_get_block_slow+0xa4/0x180
Feb 25 09:53:32 myhost kernel:  [__find_get_block+193/228]
__find_get_block+0xc1
/0xe4
Feb 25 09:53:32 myhost kernel:  [<c014a239>] __find_get_block+0xc1/0xe4
Feb 25 09:53:32 myhost kernel:  [__getblk_slow+33/364]
__getblk_slow+0x21/0x16c
Feb 25 09:53:32 myhost kernel:  [<c0149e0d>] __getblk_slow+0x21/0x16c
Feb 25 09:53:32 myhost kernel:  [__getblk+45/56] __getblk+0x2d/0x38
Feb 25 09:53:32 myhost kernel:  [<c014a289>] __getblk+0x2d/0x38
Feb 25 09:53:32 myhost kernel:  [__bread+25/52] __bread+0x19/0x34
Feb 25 09:53:32 myhost kernel:  [<c014a2f1>] __bread+0x19/0x34
Feb 25 09:53:32 myhost kernel:  [read_block_bitmap+54/96]
read_block_bitmap+0x36
/0x60
Feb 25 09:53:32 myhost kernel:  [<c019c786>] read_block_bitmap+0x36/0x60
Feb 25 09:53:32 myhost kernel:  [ext3_new_block+476/1080]
ext3_new_block+0x1dc/0
x438
Feb 25 09:53:32 myhost kernel:  [<c019d3b8>] ext3_new_block+0x1dc/0x438
Feb 25 09:53:32 myhost kernel:  [ext3_alloc_block+30/36]
ext3_alloc_block+0x1e/0
x24
Feb 25 09:53:32 myhost kernel:  [<c019f56e>] ext3_alloc_block+0x1e/0x24
Feb 25 09:53:32 myhost kernel:  [ext3_alloc_branch+63/620]
ext3_alloc_branch+0x3
f/0x26c
Feb 25 09:53:32 myhost kernel:  [<c019f8db>] ext3_alloc_branch+0x3f/0x26c
Feb 25 09:53:32 myhost kernel:  [ext3_find_goal+88/116]
ext3_find_goal+0x58/0x74
Feb 25 09:53:32 myhost kernel:  [<c019f880>] ext3_find_goal+0x58/0x74
Feb 25 09:53:32 myhost kernel:  [ext3_get_block_handle+470/688]
ext3_get_block_h
andle+0x1d6/0x2b0
Feb 25 09:53:32 myhost kernel:  [<c019fe62>]
ext3_get_block_handle+0x1d6/0x2b0
Feb 25 09:53:32 myhost kernel:  [do_no_page+83/1212] do_no_page+0x53/0x4bc
Feb 25 09:53:32 myhost kernel:  [<c013ad07>] do_no_page+0x53/0x4bc
Feb 25 09:53:32 myhost kernel:  [alloc_buffer_head+48/68]
alloc_buffer_head+0x30
/0x44
Feb 25 09:53:32 myhost kernel:  [<c014c568>] alloc_buffer_head+0x30/0x44
Feb 25 09:53:32 myhost kernel:  [create_buffers+88/148]
create_buffers+0x58/0x94
Feb 25 09:53:32 myhost kernel:  [<c0149bc0>] create_buffers+0x58/0x94
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+101/108]
ext3_get_block+0x65/0x6
c
Feb 25 09:53:32 myhost kernel:  [<c019ffa1>] ext3_get_block+0x65/0x6c
Feb 25 09:53:32 myhost kernel:  [__block_prepare_write+338/988]
__block_prepare_
write+0x152/0x3dc
Feb 25 09:53:32 myhost kernel:  [<c014aa3e>]
__block_prepare_write+0x152/0x3dc
Feb 25 09:53:32 myhost kernel:  [block_prepare_write+33/56]
block_prepare_write+
0x21/0x38
Feb 25 09:53:32 myhost kernel:  [<c014b5d5>] block_prepare_write+0x21/0x38
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [ext3_prepare_write+69/216]
ext3_prepare_write+0
x45/0xd8
Feb 25 09:53:32 myhost kernel:  [<c01a03e5>] ext3_prepare_write+0x45/0xd8
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:
[generic_file_aio_write_nolock+1680/2916] generi
c_file_aio_write_nolock+0x690/0xb64
Feb 25 09:53:32 myhost kernel:  [<c0130108>]
generic_file_aio_write_nolock+0x690
/0xb64
Feb 25 09:53:32 myhost kernel:  [do_generic_mapping_read+1255/1268]
do_generic_m
apping_read+0x4e7/0x4f4
Feb 25 09:53:32 myhost kernel:  [<c012e6b7>]
do_generic_mapping_read+0x4e7/0x4f4
Feb 25 09:53:32 myhost kernel:  [generic_file_aio_write+103/124]
generic_file_ai
o_write+0x67/0x7c
Feb 25 09:53:32 myhost kernel:  [<c01306d3>]
generic_file_aio_write+0x67/0x7c
Feb 25 09:53:32 myhost kernel:  [ext3_file_write+43/188]
ext3_file_write+0x2b/0x
bc
Feb 25 09:53:32 myhost kernel:  [<c019e1af>] ext3_file_write+0x2b/0xbc
Feb 25 09:53:32 myhost kernel:  [do_sync_write+129/184]
do_sync_write+0x81/0xb8
Feb 25 09:53:32 myhost kernel:  [<c0147c85>] do_sync_write+0x81/0xb8
Feb 25 09:53:32 myhost kernel:  [rcu_check_callbacks+83/84]
rcu_check_callbacks+
0x53/0x54
Feb 25 09:53:32 myhost kernel:  [<c01294d3>] rcu_check_callbacks+0x53/0x54
Feb 25 09:53:32 myhost kernel:  [update_process_times+42/48]
update_process_time
s+0x2a/0x30
Feb 25 09:53:32 myhost kernel:  [<c0121f0e>]
update_process_times+0x2a/0x30
Feb 25 09:53:32 myhost kernel:  [update_wall_time+11/52]
update_wall_time+0xb/0x
34
Feb 25 09:53:32 myhost kernel:  [<c0121dfb>] update_wall_time+0xb/0x34
Feb 25 09:53:32 myhost kernel:  [do_timer+75/192] do_timer+0x4b/0xc0
Feb 25 09:53:32 myhost kernel:  [<c01220e3>] do_timer+0x4b/0xc0
Feb 25 09:53:32 myhost kernel:  [rcu_check_quiescent_state+95/124]
rcu_check_qui
escent_state+0x5f/0x7c
Feb 25 09:53:32 myhost kernel:  [<c0129367>]
rcu_check_quiescent_state+0x5f/0x7c
Feb 25 09:53:32 myhost kernel:  [rcu_process_callbacks+226/252]
rcu_process_call
backs+0xe2/0xfc
Feb 25 09:53:32 myhost kernel:  [<c0129466>]
rcu_process_callbacks+0xe2/0xfc
Feb 25 09:53:32 myhost kernel:  [vfs_write+185/232] vfs_write+0xb9/0xe8
Feb 25 09:53:32 myhost kernel:  [<c0147d75>] vfs_write+0xb9/0xe8
Feb 25 09:53:32 myhost kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Feb 25 09:53:32 myhost kernel:  [<c0147e21>] sys_write+0x31/0x4c
Feb 25 09:53:32 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 25 09:53:32 myhost kernel:  [<c0108b87>] syscall_call+0x7/0xb
Feb 25 09:53:32 myhost kernel:
Feb 25 09:53:32 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:32 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:32 myhost kernel: buffer layer error at fs/buffer.c:430
Feb 25 09:53:32 myhost kernel: Call Trace:
Feb 25 09:53:32 myhost kernel:  [__buffer_error+41/48]
__buffer_error+0x29/0x30
Feb 25 09:53:32 myhost kernel:  [<c0148c49>] __buffer_error+0x29/0x30
Feb 25 09:53:32 myhost kernel:  [__find_get_block_slow+164/384]
__find_get_block
_slow+0xa4/0x180
Feb 25 09:53:32 myhost kernel:  [<c01492b4>]
__find_get_block_slow+0xa4/0x180
Feb 25 09:53:32 myhost kernel:  [__find_get_block+193/228]
__find_get_block+0xc1
/0xe4
Feb 25 09:53:32 myhost kernel:  [<c014a239>] __find_get_block+0xc1/0xe4
Feb 25 09:53:32 myhost kernel:  [__getblk_slow+33/364]
__getblk_slow+0x21/0x16c
Feb 25 09:53:32 myhost kernel:  [<c0149e0d>] __getblk_slow+0x21/0x16c
Feb 25 09:53:32 myhost kernel:  [__getblk+45/56] __getblk+0x2d/0x38
Feb 25 09:53:32 myhost kernel:  [<c014a289>] __getblk+0x2d/0x38
Feb 25 09:53:32 myhost kernel:  [__bread+25/52] __bread+0x19/0x34
Feb 25 09:53:32 myhost kernel:  [<c014a2f1>] __bread+0x19/0x34
Feb 25 09:53:32 myhost kernel:  [read_block_bitmap+54/96]
read_block_bitmap+0x36
/0x60
Feb 25 09:53:32 myhost kernel:  [<c019c786>] read_block_bitmap+0x36/0x60
Feb 25 09:53:32 myhost kernel:  [ext3_new_block+476/1080]
ext3_new_block+0x1dc/0
x438
Feb 25 09:53:32 myhost kernel:  [<c019d3b8>] ext3_new_block+0x1dc/0x438
Feb 25 09:53:32 myhost kernel:  [ext3_alloc_block+30/36]
ext3_alloc_block+0x1e/0
x24
Feb 25 09:53:32 myhost kernel:  [<c019f56e>] ext3_alloc_block+0x1e/0x24
Feb 25 09:53:32 myhost kernel:  [ext3_alloc_branch+63/620]
ext3_alloc_branch+0x3
f/0x26c
Feb 25 09:53:32 myhost kernel:  [<c019f8db>] ext3_alloc_branch+0x3f/0x26c
Feb 25 09:53:32 myhost kernel:  [ext3_find_goal+88/116]
ext3_find_goal+0x58/0x74
Feb 25 09:53:32 myhost kernel:  [<c019f880>] ext3_find_goal+0x58/0x74
Feb 25 09:53:32 myhost kernel:  [ext3_get_block_handle+470/688]
ext3_get_block_h
andle+0x1d6/0x2b0
Feb 25 09:53:32 myhost kernel:  [<c019fe62>]
ext3_get_block_handle+0x1d6/0x2b0
Feb 25 09:53:32 myhost kernel:  [do_no_page+83/1212] do_no_page+0x53/0x4bc
Feb 25 09:53:32 myhost kernel:  [<c013ad07>] do_no_page+0x53/0x4bc
Feb 25 09:53:32 myhost kernel:  [alloc_buffer_head+48/68]
alloc_buffer_head+0x30
/0x44
Feb 25 09:53:32 myhost kernel:  [<c014c568>] alloc_buffer_head+0x30/0x44
Feb 25 09:53:32 myhost kernel:  [create_buffers+88/148]
create_buffers+0x58/0x94
Feb 25 09:53:32 myhost kernel:  [<c0149bc0>] create_buffers+0x58/0x94
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+101/108]
ext3_get_block+0x65/0x6
c
Feb 25 09:53:32 myhost kernel:  [<c019ffa1>] ext3_get_block+0x65/0x6c
Feb 25 09:53:32 myhost kernel:  [__block_prepare_write+338/988]
__block_prepare_
write+0x152/0x3dc
Feb 25 09:53:32 myhost kernel:  [<c014aa3e>]
__block_prepare_write+0x152/0x3dc
Feb 25 09:53:32 myhost kernel:  [block_prepare_write+33/56]
block_prepare_write+
0x21/0x38
Feb 25 09:53:32 myhost kernel:  [<c014b5d5>] block_prepare_write+0x21/0x38
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [ext3_prepare_write+69/216]
ext3_prepare_write+0
x45/0xd8
Feb 25 09:53:32 myhost kernel:  [<c01a03e5>] ext3_prepare_write+0x45/0xd8
Feb 25 09:53:32 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:32 myhost kernel:
[generic_file_aio_write_nolock+1680/2916] generi
c_file_aio_write_nolock+0x690/0xb64
Feb 25 09:53:32 myhost kernel:  [<c0130108>]
generic_file_aio_write_nolock+0x690
/0xb64
Feb 25 09:53:32 myhost kernel:  [do_generic_mapping_read+1255/1268]
do_generic_m
apping_read+0x4e7/0x4f4
Feb 25 09:53:32 myhost kernel:  [<c012e6b7>]
do_generic_mapping_read+0x4e7/0x4f4
Feb 25 09:53:32 myhost kernel:  [generic_file_aio_write+103/124]
generic_file_ai
o_write+0x67/0x7c
Feb 25 09:53:32 myhost kernel:  [<c01306d3>]
generic_file_aio_write+0x67/0x7c
Feb 25 09:53:32 myhost kernel:  [ext3_file_write+43/188]
ext3_file_write+0x2b/0x
bc
Feb 25 09:53:32 myhost kernel:  [<c019e1af>] ext3_file_write+0x2b/0xbc
Feb 25 09:53:32 myhost kernel:  [do_sync_write+129/184]
do_sync_write+0x81/0xb8
Feb 25 09:53:32 myhost kernel:  [<c0147c85>] do_sync_write+0x81/0xb8
Feb 25 09:53:32 myhost kernel:  [rcu_check_callbacks+83/84]
rcu_check_callbacks+
0x53/0x54
Feb 25 09:53:32 myhost kernel:  [<c01294d3>] rcu_check_callbacks+0x53/0x54
Feb 25 09:53:32 myhost kernel:  [update_process_times+42/48]
update_process_time
s+0x2a/0x30
Feb 25 09:53:32 myhost kernel:  [<c0121f0e>]
update_process_times+0x2a/0x30
Feb 25 09:53:32 myhost kernel:  [update_wall_time+11/52]
update_wall_time+0xb/0x
34
Feb 25 09:53:32 myhost kernel:  [<c0121dfb>] update_wall_time+0xb/0x34
Feb 25 09:53:32 myhost kernel:  [do_timer+75/192] do_timer+0x4b/0xc0
Feb 25 09:53:32 myhost kernel:  [<c01220e3>] do_timer+0x4b/0xc0
Feb 25 09:53:32 myhost kernel:  [rcu_check_quiescent_state+95/124]
rcu_check_qui
escent_state+0x5f/0x7c
Feb 25 09:53:32 myhost kernel:  [<c0129367>]
rcu_check_quiescent_state+0x5f/0x7c
Feb 25 09:53:32 myhost kernel:  [rcu_process_callbacks+226/252]
rcu_process_call
backs+0xe2/0xfc
Feb 25 09:53:32 myhost kernel:  [<c0129466>]
rcu_process_callbacks+0xe2/0xfc
Feb 25 09:53:32 myhost kernel:  [vfs_write+185/232] vfs_write+0xb9/0xe8
Feb 25 09:53:32 myhost kernel:  [<c0147d75>] vfs_write+0xb9/0xe8
Feb 25 09:53:32 myhost kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Feb 25 09:53:32 myhost kernel:  [<c0147e21>] sys_write+0x31/0x4c
Feb 25 09:53:32 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 25 09:53:32 myhost kernel:  [<c0108b87>] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: buffer layer error at fs/buffer.c:430
Feb 25 09:53:33 myhost kernel: Call Trace:
Feb 25 09:53:33 myhost kernel:  [__buffer_error+41/48]
__buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [<c0148c49>] __buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [__find_get_block_slow+164/384]
__find_get_block
_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [<c01492b4>]
__find_get_block_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [__find_get_block+193/228]
__find_get_block+0xc1
/0xe4
Feb 25 09:53:33 myhost kernel:  [<c014a239>] __find_get_block+0xc1/0xe4
Feb 25 09:53:33 myhost kernel:  [__getblk_slow+33/364]
__getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [<c0149e0d>] __getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [__getblk+45/56] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [<c014a289>] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [__bread+25/52] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [<c014a2f1>] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [read_block_bitmap+54/96]
read_block_bitmap+0x36
/0x60
Feb 25 09:53:33 myhost kernel:  [<c019c786>] read_block_bitmap+0x36/0x60
Feb 25 09:53:33 myhost kernel:  [ext3_new_block+476/1080]
ext3_new_block+0x1dc/0
x438
Feb 25 09:53:33 myhost kernel:  [<c019d3b8>] ext3_new_block+0x1dc/0x438
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_block+30/36]
ext3_alloc_block+0x1e/0
x24
Feb 25 09:53:33 myhost kernel:  [<c019f56e>] ext3_alloc_block+0x1e/0x24
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_branch+63/620]
ext3_alloc_branch+0x3
f/0x26c
Feb 25 09:53:33 myhost kernel:  [<c019f8db>] ext3_alloc_branch+0x3f/0x26c
Feb 25 09:53:33 myhost kernel:  [ext3_find_goal+88/116]
ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [<c019f880>] ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [ext3_get_block_handle+470/688]
ext3_get_block_h
andle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [<c019fe62>]
ext3_get_block_handle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [do_no_page+83/1212] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [<c013ad07>] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [alloc_buffer_head+48/68]
alloc_buffer_head+0x30
/0x44
Feb 25 09:53:33 myhost kernel:  [<c014c568>] alloc_buffer_head+0x30/0x44
Feb 25 09:53:33 myhost kernel:  [create_buffers+88/148]
create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [<c0149bc0>] create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+101/108]
ext3_get_block+0x65/0x6
c
Feb 25 09:53:33 myhost kernel:  [<c019ffa1>] ext3_get_block+0x65/0x6c
Feb 25 09:53:33 myhost kernel:  [__block_prepare_write+338/988]
__block_prepare_
write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [<c014aa3e>]
__block_prepare_write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [block_prepare_write+33/56]
block_prepare_write+
0x21/0x38
Feb 25 09:53:33 myhost kernel:  [<c014b5d5>] block_prepare_write+0x21/0x38
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [ext3_prepare_write+69/216]
ext3_prepare_write+0
x45/0xd8
Feb 25 09:53:33 myhost kernel:  [<c01a03e5>] ext3_prepare_write+0x45/0xd8
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:
[generic_file_aio_write_nolock+1680/2916] generi
c_file_aio_write_nolock+0x690/0xb64
Feb 25 09:53:33 myhost kernel:  [<c0130108>]
generic_file_aio_write_nolock+0x690
/0xb64
Feb 25 09:53:33 myhost kernel:  [do_generic_mapping_read+1255/1268]
do_generic_m
apping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [<c012e6b7>]
do_generic_mapping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [generic_file_aio_write+103/124]
generic_file_ai
o_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [<c01306d3>]
generic_file_aio_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [ext3_file_write+43/188]
ext3_file_write+0x2b/0x
bc
Feb 25 09:53:33 myhost kernel:  [<c019e1af>] ext3_file_write+0x2b/0xbc
Feb 25 09:53:33 myhost kernel:  [do_sync_write+129/184]
do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [<c0147c85>] do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [rcu_check_callbacks+83/84]
rcu_check_callbacks+
0x53/0x54
Feb 25 09:53:33 myhost kernel:  [<c01294d3>] rcu_check_callbacks+0x53/0x54
Feb 25 09:53:33 myhost kernel:  [update_process_times+42/48]
update_process_time
s+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [<c0121f0e>]
update_process_times+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [update_wall_time+11/52]
update_wall_time+0xb/0x
34
Feb 25 09:53:33 myhost kernel:  [<c0121dfb>] update_wall_time+0xb/0x34
Feb 25 09:53:33 myhost kernel:  [do_timer+75/192] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [<c01220e3>] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [rcu_check_quiescent_state+95/124]
rcu_check_qui
escent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [<c0129367>]
rcu_check_quiescent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [rcu_process_callbacks+226/252]
rcu_process_call
backs+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [<c0129466>]
rcu_process_callbacks+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [vfs_write+185/232] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [<c0147d75>] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [<c0147e21>] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:  [<c0108b87>] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: buffer layer error at fs/buffer.c:430
Feb 25 09:53:33 myhost kernel: Call Trace:
Feb 25 09:53:33 myhost kernel:  [__buffer_error+41/48]
__buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [<c0148c49>] __buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [__find_get_block_slow+164/384]
__find_get_block
_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [<c01492b4>]
__find_get_block_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [__find_get_block+193/228]
__find_get_block+0xc1
/0xe4
Feb 25 09:53:33 myhost kernel:  [<c014a239>] __find_get_block+0xc1/0xe4
Feb 25 09:53:33 myhost kernel:  [__getblk_slow+33/364]
__getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [<c0149e0d>] __getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [__getblk+45/56] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [<c014a289>] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [__bread+25/52] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [<c014a2f1>] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [read_block_bitmap+54/96]
read_block_bitmap+0x36
/0x60
Feb 25 09:53:33 myhost kernel:  [<c019c786>] read_block_bitmap+0x36/0x60
Feb 25 09:53:33 myhost kernel:  [ext3_new_block+476/1080]
ext3_new_block+0x1dc/0
x438
Feb 25 09:53:33 myhost kernel:  [<c019d3b8>] ext3_new_block+0x1dc/0x438
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_block+30/36]
ext3_alloc_block+0x1e/0
x24
Feb 25 09:53:33 myhost kernel:  [<c019f56e>] ext3_alloc_block+0x1e/0x24
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_branch+63/620]
ext3_alloc_branch+0x3
f/0x26c
Feb 25 09:53:33 myhost kernel:  [<c019f8db>] ext3_alloc_branch+0x3f/0x26c
Feb 25 09:53:33 myhost kernel:  [ext3_find_goal+88/116]
ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [<c019f880>] ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [ext3_get_block_handle+470/688]
ext3_get_block_h
andle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [<c019fe62>]
ext3_get_block_handle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [do_no_page+83/1212] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [<c013ad07>] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [alloc_buffer_head+48/68]
alloc_buffer_head+0x30
/0x44
Feb 25 09:53:33 myhost kernel:  [<c014c568>] alloc_buffer_head+0x30/0x44
Feb 25 09:53:33 myhost kernel:  [create_buffers+88/148]
create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [<c0149bc0>] create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+101/108]
ext3_get_block+0x65/0x6
c
Feb 25 09:53:33 myhost kernel:  [<c019ffa1>] ext3_get_block+0x65/0x6c
Feb 25 09:53:33 myhost kernel:  [__block_prepare_write+338/988]
__block_prepare_
write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [<c014aa3e>]
__block_prepare_write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [block_prepare_write+33/56]
block_prepare_write+
0x21/0x38
Feb 25 09:53:33 myhost kernel:  [<c014b5d5>] block_prepare_write+0x21/0x38
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [ext3_prepare_write+69/216]
ext3_prepare_write+0
x45/0xd8
Feb 25 09:53:33 myhost kernel:  [<c01a03e5>] ext3_prepare_write+0x45/0xd8
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:
[generic_file_aio_write_nolock+1680/2916] generi
c_file_aio_write_nolock+0x690/0xb64
Feb 25 09:53:33 myhost kernel:  [<c0130108>]
generic_file_aio_write_nolock+0x690
/0xb64
Feb 25 09:53:33 myhost kernel:  [do_generic_mapping_read+1255/1268]
do_generic_m
apping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [<c012e6b7>]
do_generic_mapping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [generic_file_aio_write+103/124]
generic_file_ai
o_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [<c01306d3>]
generic_file_aio_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [ext3_file_write+43/188]
ext3_file_write+0x2b/0x
bc
Feb 25 09:53:33 myhost kernel:  [<c019e1af>] ext3_file_write+0x2b/0xbc
Feb 25 09:53:33 myhost kernel:  [do_sync_write+129/184]
do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [<c0147c85>] do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [rcu_check_callbacks+83/84]
rcu_check_callbacks+
0x53/0x54
Feb 25 09:53:33 myhost kernel:  [<c01294d3>] rcu_check_callbacks+0x53/0x54
Feb 25 09:53:33 myhost kernel:  [update_process_times+42/48]
update_process_time
s+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [<c0121f0e>]
update_process_times+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [update_wall_time+11/52]
update_wall_time+0xb/0x
34
Feb 25 09:53:33 myhost kernel:  [<c0121dfb>] update_wall_time+0xb/0x34
Feb 25 09:53:33 myhost kernel:  [do_timer+75/192] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [<c01220e3>] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [rcu_check_quiescent_state+95/124]
rcu_check_qui
escent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [<c0129367>]
rcu_check_quiescent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [rcu_process_callbacks+226/252]
rcu_process_call
backs+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [<c0129466>]
rcu_process_callbacks+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [vfs_write+185/232] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [<c0147d75>] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [<c0147e21>] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:  [<c0108b87>] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: buffer layer error at fs/buffer.c:430
Feb 25 09:53:33 myhost kernel: Call Trace:
Feb 25 09:53:33 myhost kernel:  [__buffer_error+41/48]
__buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [<c0148c49>] __buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [__find_get_block_slow+164/384]
__find_get_block
_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [<c01492b4>]
__find_get_block_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [__find_get_block+193/228]
__find_get_block+0xc1
/0xe4
Feb 25 09:53:33 myhost kernel:  [<c014a239>] __find_get_block+0xc1/0xe4
Feb 25 09:53:33 myhost kernel:  [__getblk_slow+33/364]
__getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [<c0149e0d>] __getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [__getblk+45/56] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [<c014a289>] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [__bread+25/52] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [<c014a2f1>] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [read_block_bitmap+54/96]
read_block_bitmap+0x36
/0x60
Feb 25 09:53:33 myhost kernel:  [<c019c786>] read_block_bitmap+0x36/0x60
Feb 25 09:53:33 myhost kernel:  [ext3_new_block+476/1080]
ext3_new_block+0x1dc/0
x438
Feb 25 09:53:33 myhost kernel:  [<c019d3b8>] ext3_new_block+0x1dc/0x438
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_block+30/36]
ext3_alloc_block+0x1e/0
x24
Feb 25 09:53:33 myhost kernel:  [<c019f56e>] ext3_alloc_block+0x1e/0x24
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_branch+63/620]
ext3_alloc_branch+0x3
f/0x26c
Feb 25 09:53:33 myhost kernel:  [<c019f8db>] ext3_alloc_branch+0x3f/0x26c
Feb 25 09:53:33 myhost kernel:  [ext3_find_goal+88/116]
ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [<c019f880>] ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [ext3_get_block_handle+470/688]
ext3_get_block_h
andle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [<c019fe62>]
ext3_get_block_handle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [do_no_page+83/1212] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [<c013ad07>] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [alloc_buffer_head+48/68]
alloc_buffer_head+0x30
/0x44
Feb 25 09:53:33 myhost kernel:  [<c014c568>] alloc_buffer_head+0x30/0x44
Feb 25 09:53:33 myhost kernel:  [create_buffers+88/148]
create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [<c0149bc0>] create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+101/108]
ext3_get_block+0x65/0x6
c
Feb 25 09:53:33 myhost kernel:  [<c019ffa1>] ext3_get_block+0x65/0x6c
Feb 25 09:53:33 myhost kernel:  [__block_prepare_write+338/988]
__block_prepare_
write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [<c014aa3e>]
__block_prepare_write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [block_prepare_write+33/56]
block_prepare_write+
0x21/0x38
Feb 25 09:53:33 myhost kernel:  [<c014b5d5>] block_prepare_write+0x21/0x38
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [ext3_prepare_write+69/216]
ext3_prepare_write+0
x45/0xd8
Feb 25 09:53:33 myhost kernel:  [<c01a03e5>] ext3_prepare_write+0x45/0xd8
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:
[generic_file_aio_write_nolock+1680/2916] generi
c_file_aio_write_nolock+0x690/0xb64
Feb 25 09:53:33 myhost kernel:  [<c0130108>]
generic_file_aio_write_nolock+0x690
/0xb64
Feb 25 09:53:33 myhost kernel:  [do_generic_mapping_read+1255/1268]
do_generic_m
apping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [<c012e6b7>]
do_generic_mapping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [generic_file_aio_write+103/124]
generic_file_ai
o_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [<c01306d3>]
generic_file_aio_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [ext3_file_write+43/188]
ext3_file_write+0x2b/0x
bc
Feb 25 09:53:33 myhost kernel:  [<c019e1af>] ext3_file_write+0x2b/0xbc
Feb 25 09:53:33 myhost kernel:  [do_sync_write+129/184]
do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [<c0147c85>] do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [rcu_check_callbacks+83/84]
rcu_check_callbacks+
0x53/0x54
Feb 25 09:53:33 myhost kernel:  [<c01294d3>] rcu_check_callbacks+0x53/0x54
Feb 25 09:53:33 myhost kernel:  [update_process_times+42/48]
update_process_time
s+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [<c0121f0e>]
update_process_times+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [update_wall_time+11/52]
update_wall_time+0xb/0x
34
Feb 25 09:53:33 myhost kernel:  [<c0121dfb>] update_wall_time+0xb/0x34
Feb 25 09:53:33 myhost kernel:  [do_timer+75/192] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [<c01220e3>] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [rcu_check_quiescent_state+95/124]
rcu_check_qui
escent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [<c0129367>]
rcu_check_quiescent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [rcu_process_callbacks+226/252]
rcu_process_call
backs+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [<c0129466>]
rcu_process_callbacks+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [vfs_write+185/232] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [<c0147d75>] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [<c0147e21>] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:  [<c0108b87>] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: buffer layer error at fs/buffer.c:430
Feb 25 09:53:33 myhost kernel: Call Trace:
Feb 25 09:53:33 myhost kernel:  [__buffer_error+41/48]
__buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [<c0148c49>] __buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [__find_get_block_slow+164/384]
__find_get_block
_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [<c01492b4>]
__find_get_block_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [__find_get_block+193/228]
__find_get_block+0xc1
/0xe4
Feb 25 09:53:33 myhost kernel:  [<c014a239>] __find_get_block+0xc1/0xe4
Feb 25 09:53:33 myhost kernel:  [__getblk_slow+33/364]
__getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [<c0149e0d>] __getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [__getblk+45/56] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [<c014a289>] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [__bread+25/52] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [<c014a2f1>] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [read_block_bitmap+54/96]
read_block_bitmap+0x36
/0x60
Feb 25 09:53:33 myhost kernel:  [<c019c786>] read_block_bitmap+0x36/0x60
Feb 25 09:53:33 myhost kernel:  [ext3_new_block+476/1080]
ext3_new_block+0x1dc/0
x438
Feb 25 09:53:33 myhost kernel:  [<c019d3b8>] ext3_new_block+0x1dc/0x438
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_block+30/36]
ext3_alloc_block+0x1e/0
x24
Feb 25 09:53:33 myhost kernel:  [<c019f56e>] ext3_alloc_block+0x1e/0x24
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_branch+63/620]
ext3_alloc_branch+0x3
f/0x26c
Feb 25 09:53:33 myhost kernel:  [<c019f8db>] ext3_alloc_branch+0x3f/0x26c
Feb 25 09:53:33 myhost kernel:  [ext3_find_goal+88/116]
ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [<c019f880>] ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [ext3_get_block_handle+470/688]
ext3_get_block_h
andle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [<c019fe62>]
ext3_get_block_handle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [do_no_page+83/1212] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [<c013ad07>] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [alloc_buffer_head+48/68]
alloc_buffer_head+0x30
/0x44
Feb 25 09:53:33 myhost kernel:  [<c014c568>] alloc_buffer_head+0x30/0x44
Feb 25 09:53:33 myhost kernel:  [create_buffers+88/148]
create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [<c0149bc0>] create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+101/108]
ext3_get_block+0x65/0x6
c
Feb 25 09:53:33 myhost kernel:  [<c019ffa1>] ext3_get_block+0x65/0x6c
Feb 25 09:53:33 myhost kernel:  [__block_prepare_write+338/988]
__block_prepare_
write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [<c014aa3e>]
__block_prepare_write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [block_prepare_write+33/56]
block_prepare_write+
0x21/0x38
Feb 25 09:53:33 myhost kernel:  [<c014b5d5>] block_prepare_write+0x21/0x38
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [ext3_prepare_write+69/216]
ext3_prepare_write+0
x45/0xd8
Feb 25 09:53:33 myhost kernel:  [<c01a03e5>] ext3_prepare_write+0x45/0xd8
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:
[generic_file_aio_write_nolock+1680/2916] generi
c_file_aio_write_nolock+0x690/0xb64
Feb 25 09:53:33 myhost kernel:  [<c0130108>]
generic_file_aio_write_nolock+0x690
/0xb64
Feb 25 09:53:33 myhost kernel:  [do_generic_mapping_read+1255/1268]
do_generic_m
apping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [<c012e6b7>]
do_generic_mapping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [generic_file_aio_write+103/124]
generic_file_ai
o_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [<c01306d3>]
generic_file_aio_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [ext3_file_write+43/188]
ext3_file_write+0x2b/0x
bc
Feb 25 09:53:33 myhost kernel:  [<c019e1af>] ext3_file_write+0x2b/0xbc
Feb 25 09:53:33 myhost kernel:  [do_sync_write+129/184]
do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [<c0147c85>] do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [rcu_check_callbacks+83/84]
rcu_check_callbacks+
0x53/0x54
Feb 25 09:53:33 myhost kernel:  [<c01294d3>] rcu_check_callbacks+0x53/0x54
Feb 25 09:53:33 myhost kernel:  [update_process_times+42/48]
update_process_time
s+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [<c0121f0e>]
update_process_times+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [update_wall_time+11/52]
update_wall_time+0xb/0x
34
Feb 25 09:53:33 myhost kernel:  [<c0121dfb>] update_wall_time+0xb/0x34
Feb 25 09:53:33 myhost kernel:  [do_timer+75/192] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [<c01220e3>] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [rcu_check_quiescent_state+95/124]
rcu_check_qui
escent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [<c0129367>]
rcu_check_quiescent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [rcu_process_callbacks+226/252]
rcu_process_call
backs+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [<c0129466>]
rcu_process_callbacks+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [vfs_write+185/232] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [<c0147d75>] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [<c0147e21>] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:  [<c0108b87>] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: buffer layer error at fs/buffer.c:430
Feb 25 09:53:33 myhost kernel: Call Trace:
Feb 25 09:53:33 myhost kernel:  [__buffer_error+41/48]
__buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [<c0148c49>] __buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [__find_get_block_slow+164/384]
__find_get_block
_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [<c01492b4>]
__find_get_block_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [__find_get_block+193/228]
__find_get_block+0xc1
/0xe4
Feb 25 09:53:33 myhost kernel:  [<c014a239>] __find_get_block+0xc1/0xe4
Feb 25 09:53:33 myhost kernel:  [__getblk_slow+33/364]
__getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [<c0149e0d>] __getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [__getblk+45/56] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [<c014a289>] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [__bread+25/52] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [<c014a2f1>] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [read_block_bitmap+54/96]
read_block_bitmap+0x36
/0x60
Feb 25 09:53:33 myhost kernel:  [<c019c786>] read_block_bitmap+0x36/0x60
Feb 25 09:53:33 myhost kernel:  [ext3_new_block+476/1080]
ext3_new_block+0x1dc/0
x438
Feb 25 09:53:33 myhost kernel:  [<c019d3b8>] ext3_new_block+0x1dc/0x438
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_block+30/36]
ext3_alloc_block+0x1e/0
x24
Feb 25 09:53:33 myhost kernel:  [<c019f56e>] ext3_alloc_block+0x1e/0x24
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_branch+63/620]
ext3_alloc_branch+0x3
f/0x26c
Feb 25 09:53:33 myhost kernel:  [<c019f8db>] ext3_alloc_branch+0x3f/0x26c
Feb 25 09:53:33 myhost kernel:  [ext3_find_goal+88/116]
ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [<c019f880>] ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [ext3_get_block_handle+470/688]
ext3_get_block_h
andle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [<c019fe62>]
ext3_get_block_handle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [do_no_page+83/1212] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [<c013ad07>] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [alloc_buffer_head+48/68]
alloc_buffer_head+0x30
/0x44
Feb 25 09:53:33 myhost kernel:  [<c014c568>] alloc_buffer_head+0x30/0x44
Feb 25 09:53:33 myhost kernel:  [create_buffers+88/148]
create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [<c0149bc0>] create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+101/108]
ext3_get_block+0x65/0x6
c
Feb 25 09:53:33 myhost kernel:  [<c019ffa1>] ext3_get_block+0x65/0x6c
Feb 25 09:53:33 myhost kernel:  [__block_prepare_write+338/988]
__block_prepare_
write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [<c014aa3e>]
__block_prepare_write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [block_prepare_write+33/56]
block_prepare_write+
0x21/0x38
Feb 25 09:53:33 myhost kernel:  [<c014b5d5>] block_prepare_write+0x21/0x38
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [ext3_prepare_write+69/216]
ext3_prepare_write+0
x45/0xd8
Feb 25 09:53:33 myhost kernel:  [<c01a03e5>] ext3_prepare_write+0x45/0xd8
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:
[generic_file_aio_write_nolock+1680/2916] generi
c_file_aio_write_nolock+0x690/0xb64
Feb 25 09:53:33 myhost kernel:  [<c0130108>]
generic_file_aio_write_nolock+0x690
/0xb64
Feb 25 09:53:33 myhost kernel:  [do_generic_mapping_read+1255/1268]
do_generic_m
apping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [<c012e6b7>]
do_generic_mapping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [generic_file_aio_write+103/124]
generic_file_ai
o_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [<c01306d3>]
generic_file_aio_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [ext3_file_write+43/188]
ext3_file_write+0x2b/0x
bc
Feb 25 09:53:33 myhost kernel:  [<c019e1af>] ext3_file_write+0x2b/0xbc
Feb 25 09:53:33 myhost kernel:  [do_sync_write+129/184]
do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [<c0147c85>] do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [rcu_check_callbacks+83/84]
rcu_check_callbacks+
0x53/0x54
Feb 25 09:53:33 myhost kernel:  [<c01294d3>] rcu_check_callbacks+0x53/0x54
Feb 25 09:53:33 myhost kernel:  [update_process_times+42/48]
update_process_time
s+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [<c0121f0e>]
update_process_times+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [update_wall_time+11/52]
update_wall_time+0xb/0x
34
Feb 25 09:53:33 myhost kernel:  [<c0121dfb>] update_wall_time+0xb/0x34
Feb 25 09:53:33 myhost kernel:  [do_timer+75/192] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [<c01220e3>] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [rcu_check_quiescent_state+95/124]
rcu_check_qui
escent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [<c0129367>]
rcu_check_quiescent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [rcu_process_callbacks+226/252]
rcu_process_call
backs+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [<c0129466>]
rcu_process_callbacks+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [vfs_write+185/232] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [<c0147d75>] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [<c0147e21>] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:  [<c0108b87>] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: buffer layer error at fs/buffer.c:430
Feb 25 09:53:33 myhost kernel: Call Trace:
Feb 25 09:53:33 myhost kernel:  [__buffer_error+41/48]
__buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [<c0148c49>] __buffer_error+0x29/0x30
Feb 25 09:53:33 myhost kernel:  [__find_get_block_slow+164/384]
__find_get_block
_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [<c01492b4>]
__find_get_block_slow+0xa4/0x180
Feb 25 09:53:33 myhost kernel:  [__find_get_block+193/228]
__find_get_block+0xc1
/0xe4
Feb 25 09:53:33 myhost kernel:  [<c014a239>] __find_get_block+0xc1/0xe4
Feb 25 09:53:33 myhost kernel:  [__getblk_slow+33/364]
__getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [<c0149e0d>] __getblk_slow+0x21/0x16c
Feb 25 09:53:33 myhost kernel:  [__getblk+45/56] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [<c014a289>] __getblk+0x2d/0x38
Feb 25 09:53:33 myhost kernel:  [__bread+25/52] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [<c014a2f1>] __bread+0x19/0x34
Feb 25 09:53:33 myhost kernel:  [read_block_bitmap+54/96]
read_block_bitmap+0x36
/0x60
Feb 25 09:53:33 myhost kernel:  [<c019c786>] read_block_bitmap+0x36/0x60
Feb 25 09:53:33 myhost kernel:  [ext3_new_block+476/1080]
ext3_new_block+0x1dc/0
x438
Feb 25 09:53:33 myhost kernel:  [<c019d3b8>] ext3_new_block+0x1dc/0x438
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_block+30/36]
ext3_alloc_block+0x1e/0
x24
Feb 25 09:53:33 myhost kernel:  [<c019f56e>] ext3_alloc_block+0x1e/0x24
Feb 25 09:53:33 myhost kernel:  [ext3_alloc_branch+63/620]
ext3_alloc_branch+0x3
f/0x26c
Feb 25 09:53:33 myhost kernel:  [<c019f8db>] ext3_alloc_branch+0x3f/0x26c
Feb 25 09:53:33 myhost kernel:  [ext3_find_goal+88/116]
ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [<c019f880>] ext3_find_goal+0x58/0x74
Feb 25 09:53:33 myhost kernel:  [ext3_get_block_handle+470/688]
ext3_get_block_h
andle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [<c019fe62>]
ext3_get_block_handle+0x1d6/0x2b0
Feb 25 09:53:33 myhost kernel:  [do_no_page+83/1212] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [<c013ad07>] do_no_page+0x53/0x4bc
Feb 25 09:53:33 myhost kernel:  [alloc_buffer_head+48/68]
alloc_buffer_head+0x30
/0x44
Feb 25 09:53:33 myhost kernel:  [<c014c568>] alloc_buffer_head+0x30/0x44
Feb 25 09:53:33 myhost kernel:  [create_buffers+88/148]
create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [<c0149bc0>] create_buffers+0x58/0x94
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+101/108]
ext3_get_block+0x65/0x6
c
Feb 25 09:53:33 myhost kernel:  [<c019ffa1>] ext3_get_block+0x65/0x6c
Feb 25 09:53:33 myhost kernel:  [__block_prepare_write+338/988]
__block_prepare_
write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [<c014aa3e>]
__block_prepare_write+0x152/0x3dc
Feb 25 09:53:33 myhost kernel:  [block_prepare_write+33/56]
block_prepare_write+
0x21/0x38
Feb 25 09:53:33 myhost kernel:  [<c014b5d5>] block_prepare_write+0x21/0x38
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [ext3_prepare_write+69/216]
ext3_prepare_write+0
x45/0xd8
Feb 25 09:53:33 myhost kernel:  [<c01a03e5>] ext3_prepare_write+0x45/0xd8
Feb 25 09:53:33 myhost kernel:  [ext3_get_block+0/108]
ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:  [<c019ff3c>] ext3_get_block+0x0/0x6c
Feb 25 09:53:33 myhost kernel:
[generic_file_aio_write_nolock+1680/2916] generi
c_file_aio_write_nolock+0x690/0xb64
Feb 25 09:53:33 myhost kernel:  [<c0130108>]
generic_file_aio_write_nolock+0x690
/0xb64
Feb 25 09:53:33 myhost kernel:  [do_generic_mapping_read+1255/1268]
do_generic_m
apping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [<c012e6b7>]
do_generic_mapping_read+0x4e7/0x4f4
Feb 25 09:53:33 myhost kernel:  [generic_file_aio_write+103/124]
generic_file_ai
o_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [<c01306d3>]
generic_file_aio_write+0x67/0x7c
Feb 25 09:53:33 myhost kernel:  [ext3_file_write+43/188]
ext3_file_write+0x2b/0x
bc
Feb 25 09:53:33 myhost kernel:  [<c019e1af>] ext3_file_write+0x2b/0xbc
Feb 25 09:53:33 myhost kernel:  [do_sync_write+129/184]
do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [<c0147c85>] do_sync_write+0x81/0xb8
Feb 25 09:53:33 myhost kernel:  [rcu_check_callbacks+83/84]
rcu_check_callbacks+
0x53/0x54
Feb 25 09:53:33 myhost kernel:  [<c01294d3>] rcu_check_callbacks+0x53/0x54
Feb 25 09:53:33 myhost kernel:  [update_process_times+42/48]
update_process_time
s+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [<c0121f0e>]
update_process_times+0x2a/0x30
Feb 25 09:53:33 myhost kernel:  [update_wall_time+11/52]
update_wall_time+0xb/0x
34
Feb 25 09:53:33 myhost kernel:  [<c0121dfb>] update_wall_time+0xb/0x34
Feb 25 09:53:33 myhost kernel:  [do_timer+75/192] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [<c01220e3>] do_timer+0x4b/0xc0
Feb 25 09:53:33 myhost kernel:  [rcu_check_quiescent_state+95/124]
rcu_check_qui
escent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [<c0129367>]
rcu_check_quiescent_state+0x5f/0x7c
Feb 25 09:53:33 myhost kernel:  [rcu_process_callbacks+226/252]
rcu_process_call
backs+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [<c0129466>]
rcu_process_callbacks+0xe2/0xfc
Feb 25 09:53:33 myhost kernel:  [vfs_write+185/232] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [<c0147d75>] vfs_write+0xb9/0xe8
Feb 25 09:53:33 myhost kernel:  [sys_write+49/76] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [<c0147e21>] sys_write+0x31/0x4c
Feb 25 09:53:33 myhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:  [<c0108b87>] syscall_call+0x7/0xb
Feb 25 09:53:33 myhost kernel:
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
Feb 25 09:53:33 myhost kernel: block=8195, b_blocknr=18446744073709551615
Feb 25 09:53:33 myhost kernel: b_state=0x00000000, b_size=1024
[...]

[6.] A small shell script or example program which triggers the
~     problem (if possible)

Motd:
~        @-/usr/bin/pod2text /var/Config/Changes >
/var/Config/GLOBAL/etc/motd

Keys:
~        @-/usr/bin/rm -f /root/.ssh/known_hosts
~        @-/usr/bin/rsync --archive --progress /root $(Node):/

Config:
~        @-/usr/bin/rsync --archive --progress /root
/var/Config/GLOBAL/* \
~        /var/Config/$(Node)/* /boot $(Node):/

Software:
~        @-/usr/bin/rsync --archive --progress --delete /var/Helpers \
~        /var/Archive /var/Install /var/Config /var/Build /var/Utils \
~        /var/Scripts $(Node):/var

Links:
~        @-/usr/bin/rsync --archive --progress --delete /usr /bin /sbin \
~        /lib /dev $(Node):/

Boot:
~        @-/usr/bin/ssh $(Node) "/sbin/lilo"

Tunefs:
~        @-/usr/bin/ssh $(Node) "/usr/sbin/tune2fs -c 0 -i 0 -m 0
/dev/hda3"
~        @-/usr/bin/ssh $(Node) "/usr/sbin/tune2fs -c 0 -i 0 -m 0
/dev/hda1"

Ldconfig:
~        @-/usr/bin/ssh $(Node) \
~        "/usr/sbin/ldconfig -f /etc/ld.so.conf -C /etc/ld.so.cache"

Crontab:
~        @-/usr/bin/cat /var/Config/$(Node)/etc/Crontab \
~        /var/Config/GLOBAL/etc/Crontab \
~        | /usr/bin/ssh $(Node) "cat - > /etc/crontab; /usr/bin/crontab
/etc/crontab"

Dirs:
~        @-/usr/bin/ssh $(Node) \
~        "/usr/bin/mkdir -p /var/Volumes /var/Messages /var/empty
/var/Services"

Restart:
~        @-/usr/bin/ssh $(Node) \
~        "kill \`cat /var/run/sshd.pid\`; /etc/rc.d/sshd start"

Sync:
~        @-/usr/bin/ssh $(Node) "/usr/bin/sync; /usr/bin/sync;
/usr/bin/sync"

All:
~        @make Keys
~        @make Motd
~        @make Software
~        @make Sync
~        @make Links
~        @make Sync
~        @make Tunefs
~        @make Sync
~        @make Ldconfig
~        @make Crontab
~        @make Dirs
~        @make Config
~        @make Boot
~        @make Sync
~        @make Restart
~        @make Sync

myhost:
~        @Node=myhost make All

*[7.] Environment*

*[7.1.] Software (add the output of the ver_linux script here)*

Linux myhost 2.6.3 #6 Wed Feb 25 17:28:11 CET 2004 i686 unknown
unknown GNU/Linux

Gnu C                  2.95.3
Gnu make               3.80
util-linux             2.11u
mount                  2.11u
module-init-tools      implemented
e2fsprogs              1.34
jfsutils               1.1.4
xfsprogs               2.5.6
quota-tools            3.03.
Linux C Library        2.3.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      ..
Procps                 3.2.0
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.2.0

*[7.2.] Processor information (from /proc/cpuinfo):*

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Celeron(R) CPU 2.40GHz
stepping        : 9
cpu MHz         : 2400.057
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4734.97

*[7.3.] Module information (from /proc/modules):*

Monolithic kernel.

*[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)*

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0500-050f : 0000:00:1f.3
0cf8-0cff : PCI conf1
c000-c03f : 0000:02:06.0
~  c000-c03f : e100
c400-c43f : 0000:02:07.0
~  c400-c43f : e100
c800-c8ff : 0000:02:08.0
f000-f00f : 0000:00:1f.1
~  f000-f007 : ide0
~  f008-f00f : ide1

00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c8000-000c8fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
~  00100000-0032da51 : Kernel code
~  0032da52-003d2dff : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e1000000-e1ffffff : 0000:02:08.0
e2000000-e20fffff : 0000:02:07.0
~  e2000000-e20fffff : e100
e2100000-e21fffff : 0000:02:06.0
~  e2100000-e21fffff : e100
e2200000-e2200fff : 0000:02:06.0
~  e2200000-e2200fff : e100
e2201000-e2201fff : 0000:02:07.0
~  e2201000-e2201fff : e100
e2202000-e2202fff : 0000:02:08.0
e3000000-e33fffff : 0000:00:00.0
ffb00000-ffffffff : reserved

*[7.5.] PCI information ('lspci -vvv' as root)*

00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
Bridge (rev 04)
~        Subsystem: Super Micro Computer Inc: Unknown device 3280
~        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
~        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
~        Latency: 0
~        Region 0: Memory at e3000000 (32-bit, prefetchable) [size=4M]
~        Capabilities: [e4] #09 [9104]
~        Capabilities: [a0] AGP version 2.0
~                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
~                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP
Bridge (rev 04) (prog-if 00 [Normal decode])
~        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
~        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
~        Latency: 64
~        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
~        I/O behind bridge: 0000f000-00000fff
~        Memory behind bridge: fff00000-000fffff
~        Prefetchable memory behind bridge: fff00000-000fffff
~        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 05)
(prog-if 00 [Normal decode])
~        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
~        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
~        Latency: 0
~        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
~        I/O behind bridge: 0000c000-0000cfff
~        Memory behind bridge: e0000000-e2ffffff
~        Prefetchable memory behind bridge: fff00000-000fffff
~        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
~        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
~        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
| TAbort- <TAbort- <MAbort- >SERR- <PERR-
~        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if
80 [Master])
~        Subsystem: Super Micro Computer Inc: Unknown device 3280
~        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
~        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
| TAbort- <TAbort- <MAbort- >SERR- <PERR-
~        Latency: 0
~        Region 4: I/O ports at f000 [size=16]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
~        Subsystem: Super Micro Computer Inc: Unknown device 3280
~        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
~        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
| TAbort- <TAbort- <MAbort- >SERR- <PERR-
~        Interrupt: pin B routed to IRQ 5
~        Region 4: I/O ports at 0500 [size=16]

02:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
~        Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter
(PILA8470B)
~        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
~        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
| TAbort- <TAbort- <MAbort- >SERR- <PERR-
~        Latency: 85 (2000ns min, 14000ns max), cache line size 08
~        Interrupt: pin A routed to IRQ 12
~        Region 0: Memory at e2200000 (32-bit, non-prefetchable) [size=4K]
~        Region 1: I/O ports at c000 [size=64]
~        Region 2: Memory at e2100000 (32-bit, non-prefetchable) [size=1M]
~        Expansion ROM at <unassigned> [disabled] [size=1M]
~        Capabilities: [dc] Power Management version 2
~                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
~                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
~        Subsystem: Intel Corp. EtherExpress PRO/100+ Server Adapter
(PILA8470B)
~        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
~        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
| TAbort- <TAbort- <MAbort- >SERR- <PERR-
~        Latency: 85 (2000ns min, 14000ns max), cache line size 08
~        Interrupt: pin A routed to IRQ 12
~        Region 0: Memory at e2201000 (32-bit, non-prefetchable) [size=4K]
~        Region 1: I/O ports at c400 [size=64]
~        Region 2: Memory at e2000000 (32-bit, non-prefetchable) [size=1M]
~        Expansion ROM at <unassigned> [disabled] [size=1M]
~        Capabilities: [dc] Power Management version 2
~                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
~                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:08.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
27) (prog-if 00 [VGA])
~        Subsystem: ATI Technologies Inc Rage XL
~        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
~        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
| TAbort- <TAbort- <MAbort- >SERR- <PERR-
~        Latency: 85 (2000ns min), cache line size 08
~        Interrupt: pin A routed to IRQ 12
~        Region 0: Memory at e1000000 (32-bit, non-prefetchable)
[size=16M]
~        Region 1: I/O ports at c800 [size=256]
~        Region 2: Memory at e2202000 (32-bit, non-prefetchable) [size=4K]
~        Expansion ROM at <unassigned> [disabled] [size=128K]
~        Capabilities: [5c] Power Management version 2
~                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
~                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

*[7.6.] SCSI information (from /proc/scsi/scsi)*

Not in use.

*[7.7.] Other information that might be relevant to the problem
~       (please look in /proc and include all information that you
~       think to be relevant):*

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_HPET_TIMER=y
# CONFIG_HPET_EMULATE_RTC is not set
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_EDD is not set
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y

#
# Power management options (ACPI, APM)
#
# CONFIG_PM is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
# CONFIG_ACPI is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_USE_VECTOR is not set
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
# CONFIG_HOTPLUG is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_AOUT is not set
# CONFIG_BINFMT_MISC is not set

#
# Device Drivers
#

#
# Generic Driver Options
#

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
CONFIG_BLK_DEV_NBD=y
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_SVW is not set
CONFIG_SCSI_ATA_PIIX=y
# CONFIG_SCSI_SATA_PROMISE is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_IOCTL_V4=y

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Macintosh device drivers
#

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
CONFIG_IP_NF_MATCH_RECENT=y
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
# CONFIG_IP_NF_NAT_LOCAL is not set
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
CONFIG_IP_NF_ARP_MANGLE=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=y

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=y
CONFIG_NET_SCH_HTB=y
CONFIG_NET_SCH_HFSC=y
CONFIG_NET_SCH_CSZ=y
CONFIG_NET_SCH_PRIO=y
CONFIG_NET_SCH_RED=y
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
CONFIG_NET_SCH_TBF=y
CONFIG_NET_SCH_GRED=y
CONFIG_NET_SCH_DSMARK=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_CLS=y
CONFIG_NET_CLS_TCINDEX=y
CONFIG_NET_CLS_ROUTE4=y
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_FW=y
CONFIG_NET_CLS_U32=y
CONFIG_NET_CLS_RSVP=y
# CONFIG_NET_CLS_RSVP6 is not set
CONFIG_NET_CLS_POLICE=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_B44 is not set
# CONFIG_FORCEDETH is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
CONFIG_E100=y
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
# CONFIG_SERIAL_8250_SHARE_IRQ is not set
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set
# CONFIG_VIDEO_SELECT is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_DEVPTS_FS_SECURITY=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_CIFS=y
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
CONFIG_SECURITY=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_CAPABILITIES=y
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
# CONFIG_SECURITY_SELINUX_MLS is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

[X.] Other notes, patches, fixes, workarounds:

