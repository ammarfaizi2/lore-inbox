Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422806AbWJRUyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422806AbWJRUyg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 16:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWJRUyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 16:54:36 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:30536 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1030281AbWJRUyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 16:54:35 -0400
Subject: Re: [PATCH -rt] powerpc update
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
       mgreer@mvista.com, sshtylyov@ru.mvista.com, sshtylyov@ru.mvista.com
In-Reply-To: <20061018143318.GB25141@elte.hu>
References: <20061003155358.756788000@dwalker1.mvista.com>
	 <20061018072858.GA29576@elte.hu>
	 <1161181941.23082.32.camel@c-67-180-230-165.hsd1.ca.comcast.net>
	 <20061018143318.GB25141@elte.hu>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 13:54:33 -0700
Message-Id: <1161204873.19590.14.camel@dwalker1.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 16:33 +0200, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > On Wed, 2006-10-18 at 09:28 +0200, Ingo Molnar wrote:
> > > * Daniel Walker <dwalker@mvista.com> wrote:
> > > 
> > > > Pay close attention to the fasteoi interrupt threading. I added usage 
> > > > of mask/unmask instead of using level handling, which worked well on 
> > > > PPC.
> > > 
> > > this is wrong - it should be doing mask+ack.
> > 
> > The main reason I did it this way is cause the current threaded eoi 
> > expected the line to be masked. So if you happen to have a eoi that's 
> > threaded you get a warning then the interrupt hangs.
> 
> does that in fact happen on -rt6? If yes, could you send the warning 
> that is produced?

Here's the kernel messages (from Sergei who is CC'd)
---
Subject: 2.6.18-rt6 failure on MPC8540ADS

   My PPC32 board doesn't boot with 2.6.18-rt6, I'm getting this nice trace:

Time: timebase clocksource has been installed.
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0x00000000
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT
Modules linked in:
NIP: 00000000 LR: C0051AA8 CTR: 00000000
REGS: c0615cf0 TRAP: 0400   Not tainted  (2.6.18_dev)
MSR: 00021000 <ME>  CR: 42028088  XER: 20000000
TASK = cffea600[4] 'softirq-timer/0' THREAD: c0614000
GPR00: C0051A94 C0615DA0 CFFEA600 00000035 C0339CC0 00000035 00000013 00000003
GPR08: 00010000 00000000 FCFED080 C0480035 28028084 00000000 0FFFE700 FFFFFFFF
GPR16: FFFD7C1E FFFFFFFF FFFD7B78 C02E5930 00000000 00028488 00000000 FFFFFFFF
GPR24: C033FB1C C0699498 00008000 C0615DE0 C06BBCA0 C0614000 00000035 C0323AC0
NIP [00000000] _start+0x40000000/0x20
LR [C0051AA8] handle_fasteoi_irq+0x170/0x1b8
Call Trace:
[C0615DA0] [C0051A94] handle_fasteoi_irq+0x15c/0x1b8 (unreliable)
[C0615DC0] [C00045A4] do_IRQ+0x9c/0xbc
[C0615DD0] [C000E0C8] ret_from_except+0x0/0x18
[C0615E90] [C01B4A90] phy_write+0x2c/0x6c
[C0615EC0] [C01B6450] marvell_config_aneg+0x24/0xc8
[C0615ED0] [C01B48F8] phy_start_aneg+0x44/0xcc
[C0615EF0] [C01B50E8] phy_timer+0xd8/0x588
[C0615F10] [C0031EC4] run_timer_softirq+0x224/0x1048
[C0615F80] [C002D1EC] ksoftirqd+0x100/0x1ac
[C0615FC0] [C003F36C] kthread+0xc0/0xfc
[C0615FF0] [C000EC4C] original_kernel_thread+0x44/0x60
Instruction dump:
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
  <0>Kernel panic - not syncing: Fatal exception in interrupt
Call Trace:
[C0615C30] [C0006DA8] show_stack+0x3c/0x1a0 (unreliable)
[C0615C60] [C0026484] panic+0x98/0x170
[C0615CB0] [C000BF60] die+0x120/0x130
[C0615CD0] [C0010D38] bad_page_fault+0xcc/0xe8
[C0615CE0] [C000DF24] handle_page_fault+0x7c/0x80
[C0615DA0] [C0051A94] handle_fasteoi_irq+0x15c/0x1b8
[C0615DC0] [C00045A4] do_IRQ+0x9c/0xbc
[C0615DD0] [C000E0C8] ret_from_except+0x0/0x18
[C0615E90] [C01B4A90] phy_write+0x2c/0x6c
[C0615EC0] [C01B6450] marvell_config_aneg+0x24/0xc8
[C0615ED0] [C01B48F8] phy_start_aneg+0x44/0xcc
[C0615EF0] [C01B50E8] phy_timer+0xd8/0x588
[C0615F10] [C0031EC4] run_timer_softirq+0x224/0x1048
[C0615F80] [C002D1EC] ksoftirqd+0x100/0x1ac
[C0615FC0] [C003F36C] kthread+0xc0/0xfc
[C0615FF0] [C000EC4C] original_kernel_thread+0x44/0x60

    After looking into the source, I figured out that handle_fasteoi_irq() is 
trying to call ack() handler for the irq_chip but arch/powerpc/sysdev/mpic.c 
(driving OpenPIC-compatible chips) doesn't have it (and I suppose is not 
obliged to since it's using the "fasteoi" flow)...

WBR, Sergei



