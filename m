Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbTIWRbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTIWRbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:31:12 -0400
Received: from imap.gmx.net ([213.165.64.20]:36487 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262158AbTIWRbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:31:04 -0400
X-Authenticated: #555711
From: "Sebastian Piecha" <spi@gmxpro.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Date: Tue, 23 Sep 2003 19:31:10 +0200
MIME-Version: 1.0
Subject: Re: How to understand an oops?
Message-ID: <3F709F7E.28657.152F28ED@localhost>
In-reply-to: <20030923093607.54335f4c.rddunlap@osdl.org>
References: <3F703FAE.32215.13B8E21F@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>... 
> | Does the code section mean that the kernel panic occurred during 
> | execution of this code?
> 
> Yes.
> Are there a few informative lines missing before the Oops: line below?
> 
Only the following lines:
ksymoops 2.4.8 on i686 2.4.23pre1-usbtest.  Options used
     -V (specified)
     -k ksyms (specified)
     -l modules (specified)
     -o /lib/modules/2.4.23pre1-usbtest/ (default)
     -m System.map (specified)

> | How likely is it that a bug in net/core/skbuff.c is causing the 
> | kernel panic?
> 
> Dunno.  It's trying to access memory at (%ebx) == 00200000.
> That could be a single-bit error in memory which was supposed to be
> 0, which would have terminated the while loop in skb_drop_fraglist().
> 
> The common suggestion based on this would be to run memtest86
> (or memtst86 ?) overnight to check for memory errors.
> 

I already run memtest for about 25 hours without any error.
If it's not a memory error how can I find out what caused the error? 
Debugger?

> | How can I find other code/modules from which skb_drop_fraglist is 
> | called and used?
> 
> Use grep (or cscope, but that would be overkill in this case).
> I found it only in net/core/skbuff.c.
> 

What I found out in the meantime:
skb_drop_fraglist is part of sk_buff and sk_buff is used by network 
drivers and it seems also IDE drivers. There's a documentation how to 
use sk_buff (Network Buffers and Memory Management, Alan Cox, 
http://www.linuxjournal.com/article.php?sid=1312).

> | What is the best way interpreting such an oops?
> | 
> | ################## oops #####################
> | Oops: 0000
> | CPU:    0
> | EIP:    0010:[<c0219cd7>]    Not tainted
> | Using defaults from ksymoops -t elf32-i386 -a i386
> | EFLAGS: 00010206
> | eax: c40866a0   ebx: 00200000   ecx: c40866a0   edx: 00200000
> | esi: cec57360   edi: fffffff9   ebp: 00000046   esp: c0303f2c
> | ds: 0018   es: 0018   ss: 0018
> | Process swapper (pid: 0, stackpage=c0303000)
> | Stack: cec57360 c0219d6e cec57360 cec57360 cec57360 c0219dab cec57360 
> | cec57360
> |        c0219efc cec57360 cf49cb20 c021e173 cec57360 00000003 c032c568 
> | c0120629
> |        c032c568 00000006 0000000e c0303f98 d3e02e40 c010a091 c0106f40 
> | c0302000
> | Call Trace:    [<c0219d6e>] [<c0219dab>] [<c0219efc>] [<c021e173>] 
> | [<c0120629>]
> |   [<c010a091>] [<c0106f40>] [<c010c4e8>] [<c0106f40>] [<c0106f64>] 
> | [<c0106fd2>]
> |   [<c0105000>]
> | Code: 8b 1b 8b 42 74 48 74 0a ff 4a 74 0f 94 c0 84 c0 74 07 52 e8
> | 
> | 
> | >>EIP; c0219cd7 <skb_drop_fraglist+17/40>   <=====
>                    ^^^^^^^^^^^^^^^^^^^^^^^
> This is the faulting code location.
> 
> | >>eax; c40866a0 <_end+3cf81fc/14e64bbc>
> | >>ecx; c40866a0 <_end+3cf81fc/14e64bbc>
> | >>esi; cec57360 <_end+e8c8ebc/14e64bbc>
> | >>esp; c0303f2c <init_task_union+1f2c/2000>
> 
> This is the call stack.  skb_drop_fraglist() was called from here:
>                    vvvvvvvvvvvvvvvvvvvvvv
> | Trace; c0219d6e <skb_release_data+4e/80>

What does +4e/80 mean in the line above?

>...

Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

