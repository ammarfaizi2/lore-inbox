Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSJHWbC>; Tue, 8 Oct 2002 18:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbSJHWaW>; Tue, 8 Oct 2002 18:30:22 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:36361 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261644AbSJHW2s>;
	Tue, 8 Oct 2002 18:28:48 -0400
Date: Tue, 8 Oct 2002 15:30:44 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: oops in 2.5.41-bk in tasklet_hi_action
Message-ID: <20021008223044.GB10837@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following oops on 2.5.41 + latest bk tree as of 3 pm PST under
heavy ide load:

It's a UP box running with SMP and preempt enabled.


Unable to handle kernel NULL pointer dereference at virtual address 00000004
*pde = 00000000
Oops: 0002
hid uhci-hcd usbcore  
CPU:    0
EIP:    0060:[<c0125292>]    Not tainted
EFLAGS: 00010016
EIP is at run_timer_tasklet+0x102/0x220
eax: 00000000   ebx: 00000000   ecx: cfd6c298   edx: 00000000
esi: c0348e80   edi: 00000000   ebp: 00000000   esp: c4e27f50
ds: 0068   es: 0068   ss: 0068
Process bk (pid: 1689, threadinfo=c4e26000 task=ce7477a0)
Stack: 00000246 c12830e8 00000001 00000000 c4e26000 c01215c0 00000000 c032dd24 
       c032dd24 00000001 c0348d60 fffffffe 00000000 c01212bb c0348d60 00000046 
       00000001 00000000 00000001 bfff9fe8 c01114d1 c0109b0f 40167e34 00000006 
Call Trace:
 [<c01215c0>] tasklet_hi_action+0x80/0xd0
 [<c01212bb>] do_softirq+0x5b/0xc0
 [<c01114d1>] smp_apic_timer_interrupt+0x111/0x140
 [<c0109b0f>] do_IRQ+0x18f/0x230
 [<c0108256>] apic_timer_interrupt+0x1a/0x20


