Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbTH0IVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 04:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbTH0IVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 04:21:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:18099 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263049AbTH0IVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 04:21:07 -0400
Date: Wed, 27 Aug 2003 01:23:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Okrain Genady <mafteah@mafteah.co.il>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Some errors with 2.6.0-test4-mm2
Message-Id: <20030827012346.50d4955a.akpm@osdl.org>
In-Reply-To: <200308271047.47794.mafteah@mafteah.co.il>
References: <200308271047.47794.mafteah@mafteah.co.il>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okrain Genady <mafteah@mafteah.co.il> wrote:
>
> 1)
> On reboot:
> 
> Debug: sleeping function called from invalid context at 
> include/linux/rwsem.h:43
> Call Trace:
>  [<c011cc3f>] __might_sleep+0x5f/0x70
>  [<c0119eff>] do_page_fault+0x19f/0x4ca
>  [<c0121e20>] it_real_fn+0x0/0x70
>  [<c0126f82>] run_timer_softirq+0x112/0x1c0
>  [<c0127120>] do_timer+0xe0/0xf0
>  [<c011b5b2>] schedule+0x1b2/0x3c0
>  [<c010cff6>] do_IRQ+0x116/0x160
>  [<c0119d60>] do_page_fault+0x0/0x4ca
>  [<c010b4e5>] error_code+0x2d/0x38
>
> btw I had it on 2.6.0-test4 and on -bk2 and on -mm1

Not sure what that is.

> 
> 2)
> This error started with -mm2:
> 
> # lilo
> <1>Unable to handle kernel NULL pointer dereference at virtual address 
> 00000000
>  printing eip:
> c029f9b2
> *pde = 00000000
> Oops: 0000 [#4]
> PREEMPT
> CPU:    0
> EIP:    0060:[<c029f9b2>]    Tainted: PF  VLI

What's the taint?

> EFLAGS: 00010246
> EIP is at generic_ide_ioctl+0x352/0x8b0
> eax: 00000000   ebx: bfffec70   ecx: 0000e7a2   edx: 00000000
> esi: bfffec68   edi: c87ca000   ebp: c87cbf68   esp: c87cbf2c
> ds: 007b   es: 007b   ss: 0068
> Process lilo (pid: 5503, threadinfo=c87ca000 task=c8eac080)
> Stack: c03c76db 0000064e c7853200 fffffff2 00000000 00000000 e7a20003 c04ccb8c
>        cfa7e000 c87cbf9c c0153b66 cf5ae6c0 cfd33e40 c02a3a60 cf619680 c87cbf90
>        c0268235 cfd33e40 00000301 bfffec68 bfffec68 00000001 00000301 c7853200
> Call Trace:
>  [<c0153b66>] filp_open+0x66/0x70
>  [<c02a3a60>] idedisk_ioctl+0x0/0x30
>  [<c0268235>] blkdev_ioctl+0xa5/0x447
>  [<c0167b84>] sys_ioctl+0xf4/0x290
>  [<c0397e07>] syscall_call+0x7/0xb

Works OK here.  Could you please do `strace lilo', see what the offending
ioctl args are?

> setfont sets font only for the current tty and not for all ttys like 2.4 do.

hm, I wonder who to blame that on.

