Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbTLXUhM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 15:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbTLXUhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 15:37:12 -0500
Received: from mail.gmx.de ([213.165.64.20]:16267 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263823AbTLXUhG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 15:37:06 -0500
X-Authenticated: #3270670
From: "Thomas Babut" <thomas.babut@gmx.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: PPP ooopses on 2.6.0-mm1
Date: Wed, 24 Dec 2003 21:38:52 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcPKXfFoEgkxehhpRpaeTGIJmucidA==
Message-Id: <S263823AbTLXUhG/20031224203706Z+14997@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> ismail 'cartman' dönmez
> Sent: Wednesday, December 24, 2003 10:22 AM
> To: linux-kernel@vger.kernel.org
> Subject: PPP ooopses on 2.6.0-mm1
> 
> Hi all,
> 
> Here is what I get from syslog :
> 
> 
> Dec 24 11:09:51 southpark kernel: Unable to handle kernel 
> NULL pointer dereference at virtual address 00000065
> Dec 24 11:09:51 southpark kernel: Unable to handle kernel 
> NULL pointer dereference at virtual address 00000065
> Dec 24 11:09:51 southpark kernel:  printing eip:
> Dec 24 11:09:51 southpark kernel: e500dfcb
> Dec 24 11:09:51 southpark kernel: *pde = 00000000
> Dec 24 11:09:51 southpark kernel: *pde = 00000000
> Dec 24 11:09:51 southpark kernel: Oops: 0000 [#1]
> Dec 24 11:09:51 southpark kernel: PREEMPT
> Dec 24 11:09:51 southpark kernel: CPU:    0
> Dec 24 11:09:51 southpark kernel: EIP:    
> 0060:[_end+617343539/1070258792]    Not tainted VLI
> Dec 24 11:09:51 southpark kernel: EFLAGS: 00010002
> Dec 24 11:09:51 southpark kernel: EIP is at 
> process_input_packet+0x6b/0x230 [ppp_async]
> Dec 24 11:09:51 southpark kernel: eax: d5156c00   ebx: 
> 0000007e   ecx: dae99310   edx: 00000000
> Dec 24 11:09:51 southpark kernel: esi: 00000001   edi: 
> dae99710   ebp: d5156c00   esp: e3f8dee8
> Dec 24 11:09:51 southpark kernel: ds: 007b   es: 007b   ss: 0068
> Dec 24 11:09:51 southpark kernel: Process events/0 (pid: 3, 
> threadinfo=e3f8c000 task=c15cecc0)
> Dec 24 11:09:51 southpark kernel: Stack: c02a151c c15cecc0 
> e3fedc28 dae990bc e3f8df70 0000007e 00000001 dae99710
> Dec 24 11:09:51 southpark kernel:        00000002 e500e34c 
> d5156c00 0000f18b c029fa60 e3f8c000 00000286 d5156c00
> Dec 24 11:09:51 southpark kernel:        dae99000 e500d522 
> d5156c00 dae99310 dae99710 00000008 dae99000 00000008
> Dec 24 11:09:51 southpark kernel: Call Trace:
> Dec 24 11:09:51 southpark kernel:  
> [_end+617344436/1070258792] ppp_async_input+0x1bc/0x340 [ppp_async]
> Dec 24 11:09:51 southpark kernel:  
> [_end+617340810/1070258792] ppp_asynctty_receive+0x52/0xd0 [ppp_async]
> Dec 24 11:09:51 southpark kernel:  [flush_to_ldisc+156/272] 
> flush_to_ldisc+0x9c/0x110
> Dec 24 11:09:51 southpark kernel:  [worker_thread+477/720] 
> worker_thread+0x1dd/0x2d0
> Dec 24 11:09:51 southpark kernel:  [flush_to_ldisc+0/272] 
> flush_to_ldisc+0x0/0x110
> Dec 24 11:09:51 southpark kernel:  
> [default_wake_function+0/32] default_wake_function+0x0/0x20
> Dec 24 11:09:51 southpark kernel:  [ret_from_fork+6/20] 
> ret_from_fork+0x6/0x14
> Dec 24 11:09:51 southpark kernel:  
> [default_wake_function+0/32] default_wake_function+0x0/0x20
> Dec 24 11:09:51 southpark kernel:  [worker_thread+0/720] 
> worker_thread+0x0/0x2d0
> Dec 24 11:09:51 southpark kernel:  
> [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
> Dec 24 11:09:51 southpark kernel:
> Dec 24 11:09:51 southpark kernel: Code: 89 d0 c1 e8 08 32 13 
> 43 0f b6 d2 0f b7 94 12 40 f3 00 e5 31 c2 49 75 e8 81 fa b8 
> f0 00 00 74 4e c7 45 08 04 00 00 00 85 f6 74 25 <8b> 4e 64 85 
> c9 74 1e 8b 56 68 85 d2 75 1f c7 46 64 00 00 00 00
> Dec 24 11:09:51 southpark kernel:  <6>note: events/0[3] 
> exited with preempt_count 1
> 
> 
> This somehow freezes X too. Anyone seen similar problems?
> -- 
> Joe Random Hacker Since 2002

I've got the same problem. ppp seems to be broken with 2.6.0-mm1. But not in
2.6.0 vanilla. There ppp runs without any problems.
It's a Fedora Core 1 Linux Kernel:
Linux version 2.6.0-1.21 (bhcompile@bugs.devel.redhat.com) (gcc version
3.3.2 20031202 (Red Hat Lin
ux 3.3.2-3)) #1 Tue Dec 23 19:31:42 EST 2003

Since this version Red Hat the Kernel 2.6.0 ist patched with -mm1.

Bye
Thomas

