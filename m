Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUANVQu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbUANVQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:16:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:25533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264095AbUANVPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:15:18 -0500
Message-Id: <200401142115.i0ELFDo23784@mail.osdl.org>
Date: Wed, 14 Jan 2004 13:15:10 -0800 (PST)
From: markw@osdl.org
Subject: 2.6.1 oops w/ reiserfs + deadline elevator
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following oops with our DBT-2 workload.  It appears that
I can only reproduce the problem with a combination of an aacraid
controller, reiserfs, and the deadline elevator.  I'm also using lvm2
but I can't really try to do the same test without lvm2 though.  I have
seen everything behave properly with the AS elevator or without an
aacraid controller.

Let me know if there's anything else I can provide.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:                                                              
00000000      
*pde = 373ce001
*pte = 00000000
Oops: 0000 [#1]
CPU:    2      
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010046                        
EIP is at 0x0   
eax: f782e820   ebx: f7f9c000   ecx: f6f0c800   edx: c3afa6a0
esi: f782e800   edi: 00000086   ebp: 00000096   esp: f7f9ded0
ds: 007b   es: 007b   ss: 0068                               
Process swapper (pid: 0, threadinfo=f7f9c000 task=c38d2ca0)
Stack: f8919c7a c3afa6a0 f6fa1db0 f6f0c800 f782e9d0 f891df6d c3afa6a0 f6fa1db0 
       00000004 f782e800 f7f9c000 f7f9c000 f7f9c000 00000001 00000000 f6fbab88 
       f782e9d0 24000001 00000000 f7f9df80 f891e88b f7a9f180 c011c496 f71c8980 
Call Trace:                                                                    
 [<f8919c7a>] aac_io_done+0x3a/0x80 [aacraid]
 [<f891df6d>] aac_response_normal+0x18d/0x240 [aacraid]
 [<f891e88b>] aac_sa_intr+0x9b/0x120 [aacraid]         
 [<c011c496>] rebalance_tick+0x46/0xe0        
 [<c010bad9>] handle_IRQ_event+0x49/0x80
 [<c010becf>] do_IRQ+0xbf/0x1b0         
 [<c0106e70>] default_idle+0x0/0x40
 [<c0109f38>] common_interrupt+0x18/0x20
 [<c0106e70>] default_idle+0x0/0x40     
 [<c0106e9d>] default_idle+0x2d/0x40
 [<c0106f36>] cpu_idle+0x46/0x50    
 [<c0122768>] printk+0x178/0x1d0
 [<c040f0e6>] print_cpu_info+0x86/0xe0
                                      
Code:  Bad EIP value.
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing


-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
http://developer.osdl.org/markw/
