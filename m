Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbTEMOq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTEMOq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:46:57 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:64457 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261309AbTEMOqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:46:54 -0400
Subject: Re: 2.5.69+bk: "sleeping function called from illegal context" on
	card release while shutting down
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: alexander.riesen@synopsys.COM
Cc: David Hinds <dahinds@users.sourceforge.net>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030513135759.GG32559@Synopsys.COM>
References: <20030513135759.GG32559@Synopsys.COM>
Content-Type: text/plain
Message-Id: <1052837896.1000.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 13 May 2003 16:58:17 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 15:57, Alex Riesen wrote:
> Just tried to eject the card while the system was shutting down.
> 
> Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
> Call Trace:
>  [<c0118bc8>] __might_sleep+0x58/0x70
>  [<c6a31eb6>] +0x82/0x58c [pcmcia_core]
>  [<c6a2d193>] undo_irq+0x23/0x90 [pcmcia_core]
>  [<c6a31eb6>] +0x82/0x58c [pcmcia_core]
>  [<c6a302f8>] pcmcia_release_irq+0xb8/0xe0 [pcmcia_core]
>  [<c6a25e00>] pcnet_release+0x0/0x80 [pcnet_cs]
>  [<c6a312d5>] CardServices+0x155/0x260 [pcmcia_core]
>  [<c6a312c9>] CardServices+0x149/0x260 [pcmcia_core]
>  [<c6a25e56>] pcnet_release+0x56/0x80 [pcnet_cs]
>  [<c01224a4>] run_timer_softirq+0xc4/0x1a0
>  [<c010a8b3>] handle_IRQ_event+0x33/0xf0
>  [<c011e889>] do_softirq+0xa9/0xb0
>  [<c010abb5>] do_IRQ+0x125/0x150
>  [<c01093a8>] common_interrupt+0x18/0x20
>  [<c01a3dba>] strnlen_user+0x1a/0x40
>  [<c016fd42>] create_elf_tables+0x2d2/0x360
>  [<c01706cd>] load_elf_binary+0x4cd/0xba0
>  [<c0134379>] buffered_rmqueue+0xc9/0x160
>  [<c0170200>] load_elf_binary+0x0/0xba0
>  [<c015639b>] search_binary_handler+0xcb/0x2d0
>  [<c01566f9>] do_execve+0x159/0x1a0
>  [<c0157d28>] getname+0x78/0xc0
>  [<c0107a46>] sys_execve+0x36/0x70
>  [<c0109187>] syscall_call+0x7/0xb

Don't know if this is fixed by latest Russell patches, but vanilla and
-bk snapshots do *not* contain the latest PCMCIA/CardBus code. Is it
possible for you to try 2.5.69-mm4?

Thanks!


