Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270732AbTGUWBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 18:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270734AbTGUWBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 18:01:45 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:8641 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S270732AbTGUWBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 18:01:43 -0400
Date: Tue, 22 Jul 2003 00:16:36 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Douglas J Hunley <doug@hunley.homeip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: illegal context call in slab.c
Message-ID: <20030721221636.GA12277@k3.hellgate.ch>
Mail-Followup-To: Douglas J Hunley <doug@hunley.homeip.net>,
	linux-kernel@vger.kernel.org
References: <200307211129.02337.doug@hunley.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307211129.02337.doug@hunley.homeip.net>
X-Operating-System: Linux 2.6.0-test1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003 11:28:55 -0400, Douglas J Hunley wrote:
> Issues with the kernel? Or is it the nvidia module? Thanks.

Not nvidia this time. It seems to be the kernel proper. My vanilla kernel
gave me the same warning:

Debug: sleeping function called from illegal context at mm/slab.c:1811
Call Trace:
 [<c011e85c>] __might_sleep+0x5c/0x60
 [<c0151204>] kmem_cache_alloc+0x184/0x190
 [<c026e098>] alloc_skb+0x48/0xf0
 [<c026e073>] alloc_skb+0x23/0xf0
 [<c026d596>] sock_alloc_send_pskb+0xd6/0x200
 [<c026d6ee>] sock_alloc_send_skb+0x2e/0x30
 [<fa8bcf20>] unix_dgram_sendmsg+0x160/0x5c0 [unix]
 [<c026a24d>] sock_aio_write+0xbd/0xe0
 [<c016ef59>] do_sync_write+0x89/0xc0
 [<c0238ea7>] taskfile_output_data+0x77/0x90
 [<c0239f81>] task_out_intr+0x181/0x260
 [<c0239e00>] task_out_intr+0x0/0x260
 [<c016f077>] vfs_write+0xe7/0x120
 [<c016f14f>] sys_write+0x3f/0x60
 [<c0109eff>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
 [<c011c510>] schedule+0x500/0x510
 [<c016f14f>] sys_write+0x3f/0x60
 [<c0109f26>] work_resched+0x5/0x16

Unable to handle kernel paging request at virtual address 491f3b50
 printing eip:
491f3b50
*pde = 37455067
*pte = 00000000
Oops: 0004 [#1]
CPU:    0
EIP:    0073:[<491f3b50>]    Not tainted
EFLAGS: 00010246
EIP is at 0x491f3b50
eax: 0804d2a6   ebx: 0000005b   ecx: 000003d8   edx: 00000008
esi: 0000031b   edi: 0804d708   ebp: 00000383   esp: bfff756c
ds: 007b   es: 007b   ss: 007b
Process klogd (pid: 3138, threadinfo=f7452000 task=f7be0740)
 <6>note: klogd[3138] exited with preempt_count 1
bad: scheduling while atomic!
Call Trace:
 [<c011c510>] schedule+0x500/0x510
 [<c0159a61>] unmap_page_range+0x41/0x70
 [<c0159c70>] unmap_vmas+0x1e0/0x340
 [<c015f259>] exit_mmap+0xc9/0x2a0
 [<c011f5c4>] mmput+0xa4/0x130
 [<c0125655>] do_exit+0x265/0x990
 [<c010a82c>] die+0x1fc/0x200
 [<c011a204>] do_page_fault+0x2c4/0x4aa
 [<c016f056>] vfs_write+0xc6/0x120
 [<c011c1fe>] schedule+0x1ee/0x510
 [<c016f14f>] sys_write+0x3f/0x60
 [<c0119f40>] do_page_fault+0x0/0x4aa
 [<c010a0a9>] error_code+0x2d/0x38

Linux 2.6.0-test1, gcc 3.2.3
