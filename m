Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTJNWjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 18:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTJNWjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 18:39:19 -0400
Received: from imap.gmx.net ([213.165.64.20]:14293 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261956AbTJNWjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 18:39:15 -0400
X-Authenticated: #555711
From: "Sebastian Piecha" <spi@gmxpro.de>
To: linux-kernel@vger.kernel.org
Date: Wed, 15 Oct 2003 00:39:01 +0200
MIME-Version: 1.0
Subject: Re: oops in skbuff.c in 2.4.22-ac4, but not2.6.0-test7
Message-ID: <3F8C9725.30722.1774B670@localhost>
In-reply-to: <3F8ADA85.8256.10ABE6B1@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> several times I got an OOPS in skb_drop_fraglist or alloc_skb. Here's 
> a description of what has happened. Any help would be appreciated. 
> Please CC me on all further mail traffic.
> 
> ...

There are modifications in skbuff.c in kernel 2.6.0-test7. For what 
reason skbuff.c was changed? Due to bug fixes or general changes in 
the kernel? Could skbuff.c easily be backported to 2.4.20 or 2.4.22?


> kernel 2.4.22-ac4
> 
> EIP c02518a3 refers to alloc_skb in vmlinux

it also refers to skb_drop_fraglist

> 
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c02518a3>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010206
> eax: c525e660   ebx: 00200000   ecx: 00000000   edx: 00200000
> esi: c5c97d40   edi: c5c97da0   ebp: c038ba24   esp: c034ff18
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c034f000)
> Stack: c5c97d40 c025194b c5c97d40 c5c97d40 c5c97d40 c025196c c5c97d40 
> c5c97d40
>        c5c97d40 c0251ab4 c5c97d40 c57acd00 00000000 c0255103 c5c97d40 
> c038b4c8
>        00000001 fffffffd c03ac328 d3051000 c011e2cd c038b4c8 c03ac320 
> c03729c0
> Call Trace:    [<c025194b>] [<c025196c>] [<c0251ab4>] [<c0255103>] 
> [<c011e2cd>]
>   [<c010a32d>] [<c0106d70>] [<c0105000>] [<c010c7d8>] [<c0106d70>] 
> [<c0105000>]
>   [<c0106d9c>] [<c0106deb>] [<c0105049>]
> Code: 8b 1b 8b 42 74 83 f8 01 74 0b f0 ff 4a 74 0f 94 c0 84 c0 74
> 
> 
> >>EIP; c02518a3 <skb_drop_fraglist+17/3c>   <=====
> 
> >>eax; c525e660 <_end+4e6fe3c/14cc883c>
> >>esi; c5c97d40 <_end+58a951c/14cc883c>
> >>edi; c5c97da0 <_end+58a957c/14cc883c>
> >>ebp; c038ba24 <softnet_data+24/3400>
> >>esp; c034ff18 <init_task_union+1f18/2000>
> 
> Trace; c025194b <skb_release_data+5f/74>
> Trace; c025196c <kfree_skbmem+c/68>
> Trace; c0251ab4 <__kfree_skb+ec/f4>
> Trace; c0255103 <net_tx_action+5f/11c>
> Trace; c011e2cd <do_softirq+7d/dc>
> Trace; c010a32d <do_IRQ+dd/ec>
> Trace; c0106d70 <default_idle+0/34>
> Trace; c0105000 <_stext+0/0>
> Trace; c010c7d8 <call_do_IRQ+5/d>
> Trace; c0106d70 <default_idle+0/34>
> Trace; c0105000 <_stext+0/0>
> Trace; c0106d9c <default_idle+2c/34>
> Trace; c0106deb <cpu_idle+27/34>
> Trace; c0105049 <rest_init+49/4c>
> 
> Code;  c02518a3 <skb_drop_fraglist+17/3c>
> 00000000 <_EIP>:
> Code;  c02518a3 <skb_drop_fraglist+17/3c>   <=====
>    0:   8b 1b                     mov    (%ebx),%ebx   <=====
> Code;  c02518a5 <skb_drop_fraglist+19/3c>
>    2:   8b 42 74                  mov    0x74(%edx),%eax
> Code;  c02518a8 <skb_drop_fraglist+1c/3c>
>    5:   83 f8 01                  cmp    $0x1,%eax
> Code;  c02518ab <skb_drop_fraglist+1f/3c>
>    8:   74 0b                     je     15 <_EIP+0x15>
> Code;  c02518ad <skb_drop_fraglist+21/3c>
>    a:   f0 ff 4a 74               lock decl 0x74(%edx)
> Code;  c02518b1 <skb_drop_fraglist+25/3c>
>    e:   0f 94 c0                  sete   %al
> Code;  c02518b4 <skb_drop_fraglist+28/3c>
>   11:   84 c0                     test   %al,%al
> Code;  c02518b6 <skb_drop_fraglist+2a/3c>
>   13:   74 00                     je     15 <_EIP+0x15>
> 
>  <0>Kernel panic: Aiee, killing interrupt handler!
> ...



Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

