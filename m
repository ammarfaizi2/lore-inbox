Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWJBUjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWJBUjz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWJBUjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:39:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964973AbWJBUjy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:39:54 -0400
Date: Mon, 2 Oct 2006 13:39:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>,
       "Moore, Eric Dean" <Eric.Moore@lsil.com>, linux-scsi@vger.kernel.org
Subject: Re: Panic from mptspi_dv_renegotiate_work in 2.6.18-mm2
Message-Id: <20061002133937.112cb245.akpm@osdl.org>
In-Reply-To: <45217232.2010805@google.com>
References: <45217232.2010805@google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Oct 2006 13:10:26 -0700
Martin Bligh <mbligh@google.com> wrote:

> Panics on boot.
> 
> http://test.kernel.org/abat/50728/debug/console.log
> 
> Unable to handle kernel NULL pointer dereference at 0000000000000500 RIP:
>   [<ffffffff803fa9af>] mptspi_dv_renegotiate_work+0x10/0x4a
> PGD 0
> Oops: 0000 [1] SMP
> last sysfs file:
> CPU 0
> Modules linked in:
> Pid: 14, comm: events/0 Not tainted 2.6.18-mm2-autokern1 #1
> RIP: 0010:[<ffffffff803fa9af>]  [<ffffffff803fa9af>] 
> mptspi_dv_renegotiate_work+0x10/0x4a
> RSP: 0000:ffff8101000e1e20  EFLAGS: 00010286
> RAX: 0000000000000001 RBX: ffff810001fea8c0 RCX: 000000000000001f
> RDX: 0000000000000000 RSI: ffff810001fea8c0 RDI: 0000000000001fea
> RBP: ffff8101000e1e30 R08: ffff8101000e0000 R09: 0000000000000011
> R10: ffff810001014820 R11: ffff810001014820 R12: 0000000000000500
> R13: ffff810001ef1640 R14: 0000000000000202 R15: ffff810001fea8c0
> FS:  0000000000000000(0000) GS:ffffffff80582000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000500 CR3: 0000000000201000 CR4: 00000000000006e0
> Process events/0 (pid: 14, threadinfo ffff8101000e0000, task 
> ffff8100816b1040)
> Stack:  ffff810001fea8c0 ffff810001fea8c8 ffff8101000e1e70 ffffffff802387e3
>   ffffffff803fa99f ffff810001ef1640 ffff810001f0dd40 ffffffff80238827
>   00000000fffffffc ffffffff804b0298 ffff8101000e1f00 ffffffff8023891a
> Call Trace:
>   [<ffffffff802387e3>] run_workqueue+0xa2/0xe6
>   [<ffffffff803fa99f>] mptspi_dv_renegotiate_work+0x0/0x4a
>   [<ffffffff80238827>] worker_thread+0x0/0x126
>   [<ffffffff8023891a>] worker_thread+0xf3/0x126
>   [<ffffffff80224498>] default_wake_function+0x0/0xf
>   [<ffffffff80224498>] default_wake_function+0x0/0xf
>   [<ffffffff80238827>] worker_thread+0x0/0x126
>   [<ffffffff8023b984>] kthread+0xd0/0xfc
>   [<ffffffff8020a658>] child_rip+0xa/0x12
>   [<ffffffff8023b8b4>] kthread+0x0/0xfc

Yeah, Bryce@osdl is hitting this.  Apparently it can be worked around
by compiling the driver as a module.
