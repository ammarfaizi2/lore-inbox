Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVAKFgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVAKFgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 00:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVAKFgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 00:36:38 -0500
Received: from colin2.muc.de ([193.149.48.15]:11015 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262399AbVAKFgf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 00:36:35 -0500
Date: 11 Jan 2005 06:36:34 +0100
Date: Tue, 11 Jan 2005 06:36:34 +0100
From: Andi Kleen <ak@muc.de>
To: YhLu <YhLu@tyan.com>
Cc: "'Mikael Pettersson'" <mikpe@csd.uu.se>, jamesclv@us.ibm.com,
       Matt_Domsch@dell.com, discuss@x86-64.org, linux-kernel@vger.kernel.org,
       suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64
Message-ID: <20050111053634.GD73523@muc.de>
References: <3174569B9743D511922F00A0C9431423072913A7@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C9431423072913A7@TYANWEB>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 12:46:48PM -0800, YhLu wrote:
> With lifting cpu0 apic id to 0x10, on Nvidia chip set, it could pass the

Hmm, does it work with an APIC ID >0 <=8?

> calibrate_delay in bsp. But it can not start core1/node0.

It looks like the timer interrupt goes to the second CPU.

> APIC error on CPU1: 00(08)
> APIC error on CPU1: 08(08)
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at timer:416

This is a known race (fallout of the hotplug CPU code, fix is on my todo 
list), but fixing it would probably not help you when the timer goes to the 
wrong CPU.

Actually when it went through calibrate_delay it is likely
broadcast to all CPUs, which is definitely wrong.

-Andi


> invalid operand: 0000 [1] SMP 
> CPU 1 
> Modules linked in:
> Pid: 0, comm: swapper Not tainted 2.6.10-bk13
> RIP: 0010:[<ffffffff8013958d>] <ffffffff8013958d>{cascade+45}
> RSP: 0018:ffff81000221fed8  EFLAGS: 00010007
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff810001e15820
> RBP: ffff810001e16838 R08: 00000000fffffff2 R09: 0000000000000009
> R10: 00000000ffffffff R11: 0000000000000000 R12: ffff810001e15820
> R13: 0000000000000000 R14: ffff81000221ff08 R15: 0000000000000001
> FS:  0000000000000000(0000) GS:ffffffff80579080(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: 0000000000000000 CR3: 0000000000101000 CR4: 00000000000006a0
> Process swapper (pid: 0, threadinfo ffff810002216000, task ffff810002210dd0)
> Stack: 0000000000000000 0000000000000000 ffffffff8057a510 ffff810001e15820 
>        ffffffff80609900 ffffffff8013970e ffff81000221ff08 ffff81000221ff08 
>        ffffffff8057a764 fffffffffffffffe 
> Call Trace:<IRQ> <ffffffff8013970e>{run_timer_softirq+126}
> <ffffffff801361b1>{__do_softirq+113} 
>        <ffffffff80136265>{do_softirq+53} <ffffffff8010ff3f>{do_IRQ+63} 
>        <ffffffff8010d865>{ret_from_intr+0}  <EOI>
> <ffffffff805880e1>{calibrate_delay+289} 
>        <ffffffff8058d83b>{smp_callin+171}
> <ffffffff8058d92e>{start_secondary+14} 
>        
> 
