Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264092AbTDJQ1y (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 12:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTDJQ1y (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 12:27:54 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:31637 "EHLO
	nessie.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S264092AbTDJQ1u (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 12:27:50 -0400
Date: Fri, 11 Apr 2003 02:38:58 +1000
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Cc: sct@redhat.com, akpm@zip.com.au, adilger@clusterfs.com, davem@redhat.com,
       jmorris@intercode.com.au
Subject: 2.5.67: ext3 and tcp BUG()/oops/error/whatnot?
Message-ID: <20030410163857.GB19129@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buggered if I know what triggered this exactly. At the time I was
abusing the living snot out of the system by compiling mplayer twice,
compiling the kernel, getting mozilla to load 50 or so pages and running
a program that allocs ram until it's oom-killed a few times.

These happened well after the last running of the memory eater and the
slab/tcp error happened 10 mins before the ext3/block error. The
slab/tcp happened just before the first of the mplayer compiles
finished. The ext3/block happened just before the 2nd mplayer compile
finished. Through both mplayer compiles the kernel was compiling and
mozilla was trying to do its thing. Also, mplayer compiles were
happening on the same partition as each other but on a different
partition to the kernel.

I think I'll run a fs check now... :)

Slab corruption: start=ce6130c4, expend=ce6131f3, problemat=ce613128
Last user: [<c032ff78>](destroy_conntrack+0x9c/0xac)
Data: ****************************************************************************************************28 31 61 CE 28 31 61 CE ***************************************************************************************************************************************************************************************************A5 
Next: 71 F0 2C .78 FF 32 C0 71 F0 2C .********************
slab error in check_poison_obj(): cache `ip_conntrack': object was modified after freeing
Call Trace:
 [<c0131d5d>] __slab_error+0x21/0x28
 [<c013214c>] check_poison_obj+0x174/0x180
 [<c01331b9>] kmem_cache_alloc+0x8d/0x128
 [<c033075f>] init_conntrack+0xcf/0x310
 [<c033075f>] init_conntrack+0xcf/0x310
 [<c0330ad8>] ip_conntrack_in+0x138/0x274
 [<c013e280>] shmem_readlink+0x64/0xc0
 [<c032fad6>] ip_conntrack_local+0x52/0x58
 [<c030bfc8>] dst_output+0x0/0x28
 [<c03013b0>] nf_iterate+0x34/0x88
 [<c030bfc8>] dst_output+0x0/0x28
 [<c0301676>] nf_hook_slow+0xb6/0x140
 [<c030bfc8>] dst_output+0x0/0x28
 [<c030a804>] ip_queue_xmit+0x400/0x458
 [<c030bfc8>] dst_output+0x0/0x28
 [<c0108e9d>] error_code+0x2d/0x38
 [<c031e4ba>] tcp_v4_send_check+0x6e/0xb0
 [<c031926c>] tcp_transmit_skb+0x424/0x588
 [<c0319320>] tcp_transmit_skb+0x4d8/0x588
 [<c031b8bf>] tcp_connect+0x3c3/0x45c
 [<c031dcb6>] tcp_v4_connect+0x432/0x4f8
 [<c032af17>] inet_stream_connect+0xd7/0x1f0
 [<c02f61cf>] sys_connect+0x5f/0x84
 [<c02f530a>] sock_map_fd+0xc2/0x120
 [<c02f5358>] sock_map_fd+0x110/0x120
 [<c02f5dc8>] sock_create+0xb4/0xe0
 [<c02f5e22>] sys_socket+0x2e/0x4c
 [<c02f6b8c>] sys_socketcall+0xa4/0x1c0
 [<c013a2b0>] sys_munmap+0x44/0x64
 [<c0108cf3>] syscall_call+0x7/0xb

buffer layer error at fs/buffer.c:127
Call Trace:
 [<c0143cea>] __buffer_error+0x2a/0x30
 [<c0143de6>] __wait_on_buffer+0x66/0xb0
 [<c0119088>] autoremove_wake_function+0x0/0x3c
 [<c0119088>] autoremove_wake_function+0x0/0x3c
 [<c014567f>] __block_prepare_write+0x2a3/0x3b0
 [<c0145eb4>] block_prepare_write+0x20/0x3c
 [<c016e84c>] ext3_get_block+0x0/0x68
 [<c016ec9c>] ext3_prepare_write+0x48/0xe0
 [<c016e84c>] ext3_get_block+0x0/0x68
 [<c012e90e>] generic_file_aio_write_nolock+0x5e2/0x9c8
 [<c012edfb>] generic_file_aio_write+0x7b/0x94
 [<c016cb1a>] ext3_file_write+0x2e/0xc4
 [<c0142fff>] do_sync_write+0x7f/0xb0
 [<c026fb0c>] do_rw_disk+0x440/0x67c
 [<c01207f0>] update_process_times+0x2c/0x38
 [<c01206d6>] update_wall_time+0xe/0x38
 [<c012096d>] do_timer+0x4d/0xd4
 [<c0142b11>] generic_file_llseek+0x31/0xd0
 [<c01430ce>] vfs_write+0x9e/0xd0
 [<c014316a>] sys_write+0x2a/0x40
 [<c0108cf3>] syscall_call+0x7/0xb

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
