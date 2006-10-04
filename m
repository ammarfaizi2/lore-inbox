Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161606AbWJDQ5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161606AbWJDQ5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161607AbWJDQ5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:57:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161606AbWJDQ5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:57:07 -0400
Date: Wed, 4 Oct 2006 09:57:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Fox <drfickle@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.18-mm3 oops in xfrm_register_mode
Message-Id: <20061004095703.5c843514.akpm@osdl.org>
In-Reply-To: <4523CFEF.6000007@us.ibm.com>
References: <20061003001115.e898b8cb.akpm@osdl.org>
	<4523CFEF.6000007@us.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 10:14:55 -0500
Steve Fox <drfickle@us.ibm.com> wrote:

> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18/2.6.18-mm3/
> 
> This is on the same x86_64 box which I reported the -mm2 boot problem. I 
> have confirmed that CONFIG_DEBUG_INFO was on for the -mm2 oops as well 
> as this one. I'll begin a bisection on this issue as well and post the 
> results when finished.
> 
> Fusion MPT base driver 3.04.01
> Copyright (c) 1999-2005 LSI Logic Corporation
> Fusion MPT SPI Host driver 3.04.01
> Fusion MPT FC Host driver 3.04.01
> Fusion MPT misc device (ioctl) driver 3.04.01
> mptctl: Registered with Fusion MPT base driver
> mptctl: /dev/mptctl @ (major,minor=10,220)
> PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> serio: i8042 KBD port at 0x60,0x64 irq 1
> serio: i8042 AUX port at 0x60,0x64 irq 12
> mice: PS/2 mouse device common for all mice
> Unable to handle kernel NULL pointer dereference at 0000000000000807 RIP:
>   [<ffffffff80471196>] xfrm_register_mode+0x36/0x60
> PGD 0
> Oops: 0000 [1] SMP
> last sysfs file:
> CPU 0
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.18-mm3 #2
> RIP: 0010:[<ffffffff80471196>]  [<ffffffff80471196>] 
> xfrm_register_mode+0x36/0x60
> RSP: 0000:ffff810bffcbded0  EFLAGS: 00010286
> RAX: 00000000000007ff RBX: ffffffff8056a1a0 RCX: 0000000000000000
> RDX: ffffffffffffffff RSI: 0000000000000002 RDI: ffffffff8056ae10
> RBP: 00000000ffffffef R08: 00000000ade70d2e R09: 0000000000000000
> R10: ffff810bffcbdcb0 R11: 0000000000000154 R12: 0000000000000000
> R13: ffff810bffcbdef0 R14: 0000000000000000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffffffff805e8000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000807 CR3: 0000000000201000 CR4: 00000000000006e0
> Process swapper (pid: 1, threadinfo ffff810bffcbc000, task ffff810bffcbb510)
> Stack:  0000000000000000 ffffffff806363f0 0000000000000000 ffffffff80207182
>   0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   0000000000000000 0000000000000000 0000000000000000 0000000000090000
> Call Trace:
>   [<ffffffff80207182>] init+0x162/0x330
>   [<ffffffff8020a9d5>] child_rip+0xa/0x15
>   [<ffffffff8033a932>] acpi_ds_init_one_object+0x0/0x82
>   [<ffffffff80207020>] init+0x0/0x330
>   [<ffffffff8020a9cb>] child_rip+0x0/0x15
> 
> 
> Code: 48 83 78 08 00 75 06 48 89 58 08 31 ed 48 89 d7 e8 e5 fe ff
> RIP  [<ffffffff80471196>] xfrm_register_mode+0x36/0x60
>   RSP <ffff810bffcbded0>
> CR2: 0000000000000807
>   <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
> 

Thanks, Steve.

You might well find this bisection lands you on origin.patch.  ie: a
mainline bug.  I note that David merged a few more xfrm fixes this morning.

So to confirm that, first test just origin.patch and if that fails, test
git-of-the-moment.  If that doesn't fail, they fixed it.
