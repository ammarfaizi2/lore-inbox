Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVEBSQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVEBSQR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 14:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVEBSQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 14:16:17 -0400
Received: from fire.osdl.org ([65.172.181.4]:5025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261527AbVEBSPy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 14:15:54 -0400
Date: Mon, 2 May 2005 11:14:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Damir Perisa <damir.perisa@solnet.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2 - kswapd0 keeps running
Message-Id: <20050502111452.0dca6625.akpm@osdl.org>
In-Reply-To: <200505021732.00590.damir.perisa@solnet.ch>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<20050501150624.7696fc31.akpm@osdl.org>
	<200505020801.31860.damir.perisa@solnet.ch>
	<200505021732.00590.damir.perisa@solnet.ch>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damir Perisa <damir.perisa@solnet.ch> wrote:
>
> Le Monday 02 May 2005 08:01, Damir Perisa a écrit :
> > sure. i recompiled the kernel with magic keys and debugger activated
> > [1], and kswapd0 does idle normally, now. it seems to solve my issue,
> > but i don't know why.
> 
> now, running the debug-enabled kernel for some time (the whole day - ~7h 
> uptime), kswapd0 shows same sympthoms (started at around 4h uptime). it 
> is triggered later than before (where it started almost immediately after 
> boot), but now i get something more interesting from Regs:
> 
> [4314013.408000] SysRq : Show Regs
> [4314013.408000]
> [4314013.408000] Pid: 156, comm:              kswapd0
> [4314013.408000] EIP: 0060:[<c05acc49>] CPU: 0
> [4314013.408000] EIP is at _write_lock_irqsave+0x79/0xb0
> [4314013.408000]  EFLAGS: 00000282    Not tainted  (2.6.12-rc3-mm2-ARCH)
> [4314013.408000] EAX: c15e8ec0 EBX: efb9586c ECX: c15e8ee0 EDX: 00000001
> [4314013.408000] ESI: efcc2000 EDI: efb9586c EBP: efcc3ee4 DS: 007b ES: 
> 007b
> [4314013.408000] CR0: 8005003b CR2: b58a4000 CR3: 254e6000 CR4: 00000690
> [4314013.408000]  [<c0375be4>] __cachefs_block_put+0x24/0x80
> [4314013.408000]  [<c037dae0>] cachefs_releasepage+0x60/0xc0
> [4314013.408000]  [<c0154be2>] shrink_list+0x492/0x560
> [4314013.408000]  [<c0154fc0>] shrink_cache+0xa0/0x1d0
> [4314013.408000]  [<c01555fe>] shrink_zone+0xae/0xe0
> [4314013.408000]  [<c0155af1>] balance_pgdat+0x261/0x3f0
> [4314013.408000]  [<c013c7e0>] prepare_to_wait+0x20/0x70
> [4314013.408000]  [<c0155d64>] kswapd+0xe4/0x140
> [4314013.408000]  [<c013c910>] autoremove_wake_function+0x0/0x60
> [4314013.408000]  [<c0103142>] ret_from_fork+0x6/0x14
> [4314013.408000]  [<c013c910>] autoremove_wake_function+0x0/0x60
> [4314013.408000]  [<c0155c80>] kswapd+0x0/0x140
> [4314013.408000]  [<c0101225>] kernel_thread_helper+0x5/0x10
> 

hm.  I wonder why you had any cachefs pages anyway.  Is the sysrq-P trace
always the same?

Does disabling cachefs in kerel config fix it?
