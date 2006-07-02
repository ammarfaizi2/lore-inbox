Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWGBKPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWGBKPH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 06:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWGBKPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 06:15:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6565 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751328AbWGBKPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 06:15:06 -0400
Date: Sun, 2 Jul 2006 03:14:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm5
Message-Id: <20060702031457.f5995b38.akpm@osdl.org>
In-Reply-To: <44A799E4.5010803@shadowen.org>
References: <20060701033524.3c478698.akpm@osdl.org>
	<44A799E4.5010803@shadowen.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 02 Jul 2006 11:03:16 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> Seems that we have some kind of schedular balance panic, I want to say
> back as this seems very familiar.  Seems to be affecting the multi-node
> NUMA-Q systems here.  The single node ones appear unaffected.
> 
> Nothing jumps out of the patch list.  Any suggestions as to what to rip
> out :)
> 
> -apw
> 
> divide error: 0000 [#1]
> 8K_STACKS SMP
> last sysfs file:
> Modules linked in:
> CPU:    3
> EIP:    0060:[<c0112b6e>]    Not tainted VLI
> EFLAGS: 00010046   (2.6.17-mm5-autokern1 #1)
> EIP is at find_busiest_group+0x1a3/0x47c
> eax: 00000000   ebx: 00000007   ecx: 00000000   edx: 00000000
> esi: 00000000   edi: e7677264   ebp: e74a3ec8   esp: e74a3e58
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, ti=e74a2000 task=e7485030 task.ti=e74a2000)
> Stack: e7677264 00000010 c0119020 00000000 00000000 00000000 00000000
> 00000000
>        ffffffff 00000000 00000000 00000001 00000001 00000001 00000080
> 00000000
>        00000000 00000200 00000020 00000080 00000000 00000000 e7677260
> c13dc960
> Call Trace:
>  [<c0119020>] vprintk+0x5f/0x213
>  [<c0112efb>] load_balance+0x54/0x1d6
>  [<c011332d>] rebalance_tick+0xc5/0xe3
>  [<c01137a3>] scheduler_tick+0x2cb/0x2d3
>  [<c01215b4>] update_process_times+0x51/0x5d
>  [<c010c224>] smp_apic_timer_interrupt+0x5a/0x61
>  [<c0102d5b>] apic_timer_interrupt+0x1f/0x24
>  [<c01006c0>] default_idle+0x0/0x59
>  [<c01006f1>] default_idle+0x31/0x59
>  [<c0100791>] cpu_idle+0x64/0x79
> Code: 00 5b 83 f8 1f 89 c6 5f 0f 8e 63 ff ff ff 8b 45 e0 8b 55 e8 01 45
> dc 8b 4a 08 89 c2 01 4d d4 c1 e2 07 89 d0 31 d2 89 ce c1 ee 07 <f7> f1
> 83 7d 9c 00 89 45 e0 74 17 89 45 d8 8b 55 e8 8b 4d a4 8b
> EIP: [<c0112b6e>] find_busiest_group+0x1a3/0x47c SS:ESP 0068:e74a3e58
>  <0>Kernel panic - not syncing: Fatal exception in interrupt

Well there are only a handful of divides in find_busiest_group().  Wanna
have a poke around in gdb and work out which one you're hitting?
