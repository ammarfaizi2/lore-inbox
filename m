Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264827AbUEEWaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264827AbUEEWaE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264824AbUEEWaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:30:04 -0400
Received: from nodns-212-69-243-51.first4it.co.uk ([212.69.243.51]:38668 "HELO
	linuxoutlaws.co.uk") by vger.kernel.org with SMTP id S264828AbUEEW34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:29:56 -0400
Date: Wed, 5 May 2004 23:24:08 +0100
From: Rob Shakir <rob@rshk.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at fs/ext3/balloc.c:942!
Message-ID: <20040505222408.GA10030@rshk.co.uk>
References: <Pine.LNX.4.58.0405051729140.2284@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405051729140.2284@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen something vaguely similar to this problem, but rather than running 
ext3 I'm running ReiserFS. 

This problem has occured twice, but I've just got the machine back running to
report the bug properly.


kernel BUG at fs/reiserfs/prints.c:339!
invalid operand: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
CPU:    1
EIP:    0060:[<c01c9f88>]    Not tainted
EFLAGS: 00010286   (2.6.5)
EIP is at reiserfs_panic+0x38/0x70
eax: 0000003c   ebx: f518edf8   ecx: f556e000   edx: c045c5a0
esi: 00000001   edi: 00000003   ebp: f3923a30   esp: f3923a20
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 122, threadinfo=f3922000 task=f394ba30)
Stack: c03f7212 c052abe0 c03fbfd0 f396b7c0 f3923b34 c01d44fd f518edf8 c040dc00
       00000000 00001000 eb1d8e88 eb1d8e88 00000001 f3923a68 00011f70 00000000
       c0460040 d4294f58 d3356638 00000062 00000063 00000062 f3923b8c 00000010
Call Trace:
 [<c01d44fd>] search_by_key+0x211d/0x2120
 [<c01bad09>] reiserfs_read_locked_inode+0x69/0x100
 [<c01bae6d>] reiserfs_iget+0x9d/0xb0
 [<c01bada0>] reiserfs_find_actor+0x0/0x30
 [<c01bac80>] reiserfs_init_locked_inode+0x0/0x20
 [<c01baeac>] reiserfs_get_dentry+0x2c/0xa0
 [<c0226cab>] find_exported_dentry+0x3b/0xb20
 [<c034f857>] dev_queue_xmit+0x3b7/0x490
 [<c035d6e0>] pfifo_fast_enqueue+0x0/0x90
 [<c035850c>] neigh_resolve_output+0x13c/0x260
 [<c036c1c4>] ip_finish_output2+0xe4/0x1e6
 [<c035c42d>] nf_hook_slow+0xed/0x140
 [<c036c0e0>] ip_finish_output2+0x0/0x1e6
 [<c0369afb>] ip_finish_output+0x23b/0x240
 [<c036c0e0>] ip_finish_output2+0x0/0x1e6
 [<c036c0c5>] dst_output+0x15/0x30
 [<c035c42d>] nf_hook_slow+0xed/0x140
 [<c036c0b0>] dst_output+0x0/0x30
 [<c036bb6b>] ip_push_pending_frames+0x3db/0x440
 [<c036c0b0>] dst_output+0x0/0x30
 [<c011cab4>] __change_page_attr+0x24/0x1e0
 [<c013a47b>] kernel_text_address+0x3b/0x50
 [<c011cef1>] kernel_map_pages+0x31/0x6c
 [<c01bafd3>] reiserfs_decode_fh+0xb3/0xe0
 [<c0229ee0>] nfsd_acceptable+0x0/0x1a0
 [<c022a274>] fh_verify+0x1f4/0x5c0
 [<c0229ee0>] nfsd_acceptable+0x0/0x1a0
 [<c03c592a>] svc_udp_recvfrom+0xda/0x290
 [<c0228eb3>] nfsd_proc_getattr+0x73/0xa0
 [<c02283f7>] nfsd_dispatch+0xd7/0x1e0
 [<c0228320>] nfsd_dispatch+0x0/0x1e0
 [<c03c4abb>] svc_process+0x4bb/0x61d
 [<c011f660>] default_wake_function+0x0/0x20
 [<c0228096>] nfsd+0x276/0x500
 [<c0227e20>] nfsd+0x0/0x500
 [<c01052e5>] kernel_thread_helper+0x5/0x10

Code: 0f 0b 53 01 40 be 3f c0 c7 04 24 c0 83 40 c0 b8 e1 b9 3f c0

I'm not sure if this is directly related to the behaviour that Zwane's reported
above, but the similarities seemed to be enough to warrant this being posted as
a reply to his post.

Thanks,
Rob
