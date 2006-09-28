Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWI1VBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWI1VBa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 17:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWI1VBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 17:01:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750879AbWI1VB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 17:01:29 -0400
Date: Thu, 28 Sep 2006 14:01:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Steve Fox" <drfickle@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm2
Message-Id: <20060928140124.5f7154e3.akpm@osdl.org>
In-Reply-To: <efh217$8au$1@sea.gmane.org>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	<efh217$8au$1@sea.gmane.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please always do reply-to-all)

On Thu, 28 Sep 2006 17:50:31 +0000 (UTC)
"Steve Fox" <drfickle@us.ibm.com> wrote:

> On Thu, 28 Sep 2006 01:46:23 -0700, Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm2/
> 
> Panic on boot. This machine booted 2.6.18-mm1 fine. em64t machine.
> 
> TCP bic registered
> TCP westwood registered
> TCP htcp registered
> NET: Registered protocol family 1
> NET: Registered protocol family 17
> Unable to handle kernel paging request at ffffffffffffffff RIP: 
>  [<ffffffff8047ef93>] packet_notifier+0x163/0x1a0
> PGD 203027 PUD 2b031067 PMD 0 
> Oops: 0000 [1] SMP 
> last sysfs file: 
> CPU 0 
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.18-mm2-autokern1 #1
> RIP: 0010:[<ffffffff8047ef93>]  [<ffffffff8047ef93>] packet_notifier+0x163/0x1a0
> RSP: 0000:ffff810bffcbde90  EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff810bff4a1000 RCX: 2222222222222222
> RDX: ffff810bff4a1000 RSI: 0000000000000005 RDI: ffffffff8055f5e0
> RBP: ffffffffffffffff R08: 0000000000007616 R09: 000000000000000e
> R10: 0000000000000006 R11: ffffffff803373f0 R12: 0000000000000000
> R13: 0000000000000005 R14: ffff810bff4a1000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff805d8000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: ffffffffffffffff CR3: 0000000000201000 CR4: 00000000000006e0
> Process swapper (pid: 1, threadinfo ffff810bffcbc000, task ffff810bffcbb510)
> Stack:  ffff810bff4a1000 ffffffff8055f4c0 0000000000000000 ffff810bffcbdef0
>  0000000000000000 ffffffff8042736e 0000000000000000 0000000000000000
>  0000000000000000 ffffffff8061c68d ffffffff806260f0 ffffffff80207182
> Call Trace:
>  [<ffffffff8042736e>] register_netdevice_notifier+0x3e/0x70
>  [<ffffffff8061c68d>] packet_init+0x2d/0x53
>  [<ffffffff80207182>] init+0x162/0x330
>  [<ffffffff8020a9d8>] child_rip+0xa/0x12
>  [<ffffffff8033c2a2>] acpi_ds_init_one_object+0x0/0x82
>  [<ffffffff80207020>] init+0x0/0x330
>  [<ffffffff8020a9ce>] child_rip+0x0/0x12
> 
> 
> Code: 48 8b 45 00 0f 18 08 49 83 fd 02 4c 8d 65 f8 0f 84 f8 fe ff 
> RIP  [<ffffffff8047ef93>] packet_notifier+0x163/0x1a0
>  RSP <ffff810bffcbde90>
> CR2: ffffffffffffffff
>  <0>Kernel panic - not syncing: Attempted to kill init!
> 

I'm really struggling to work out what went wrong there.  Comparing your
miserable 20 bytes of code to my object code makes me think that this:

		struct packet_sock *po = pkt_sk(sk);

returned -1, perhaps in %ebp.  But it's all very crude.

Perhaps you could compile that kernel with CONFIG_DEBUG_INFO, rerun it (the
addresses might change) then have a poke around with `gdb vmlinux' (or
maybe just addr2line) to work out where it's really oopsing?

I don't see much which has changed in that area recently.
