Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbWITSZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbWITSZI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWITSZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:25:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:19669 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932176AbWITSZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:25:05 -0400
Date: Wed, 20 Sep 2006 11:25:53 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20060920182553.GC1292@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060920141907.GA30765@elte.hu> <200609201250.03750.gene.heskett@verizon.net> <1158771639.29177.5.camel@c-67-180-230-165.hsd1.ca.comcast.net> <20060920173858.GB1292@us.ibm.com> <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158774118.29177.13.camel@c-67-180-230-165.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 10:41:58AM -0700, Daniel Walker wrote:
> On Wed, 2006-09-20 at 10:38 -0700, Paul E. McKenney wrote:
> > On Wed, Sep 20, 2006 at 10:00:38AM -0700, Daniel Walker wrote:
> > > On Wed, 2006-09-20 at 12:50 -0400, Gene Heskett wrote:
> > > 
> > > >   LD      .tmp_vmlinux1
> > > > kernel/built-in.o(.text+0x16f25): In function `hrtimer_start':
> > > > : undefined reference to `hrtimer_update_timer_prio'
> > > > make: *** [.tmp_vmlinux1] Error 1
> > > > 
> > > > about half way thru the normal time.  config attached.  I don't think hires 
> > > > timers are enabled.
> > > > 
> > > > Comments?
> > > > 
> > > 
> > > Fix attached.
> > > 
> > > Daniel
> > 
> > Compiles for me with this patch.  Will try it out on a couple of machines.
> > 
> 
> Ingo actually updated with a similar fix , in
> 
> http://people.redhat.com/~mingo/realtime-preempt/patch-2.6.18-rt2

OK, using that instead.

I get the following at startup, which probably means that I need to use
some machine other than a NUMA-Q.  Trying a different machine...

						Thanx, Paul

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01151ff
*pde = 34d21001
*pte = 00000000
stopped custom tracer.
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    2
EIP:    0060:[<c01151ff>]    Not tainted VLI
EFLAGS: 00010246   (2.6.18-rt2-autokern1 #1) 
EIP is at __wake_up_common+0x10/0x55
eax: 00000000   ebx: 00000001   ecx: c113629c   edx: 00000000
esi: c113629c   edi: c113629c   ebp: dff25f34   esp: dff25f24
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process softirq-timer/2 (pid: 27, ti=dff24000 task=dff20e30 task.ti=dff24000)
Stack: 00000000 00000000 c113629c 00000001 dff25f60 c0115267 c113629c 00000006 
       00000001 00000001 00000000 00000006 00000007 dffd5e40 c1136270 c1136240 
       c012ecf6 00000000 00000001 c11360e4 00000001 00000000 dff12000 c043b2c0 
Call Trace:
 [<c0115267>] __wake_up+0x23/0x52
 [<c012ecf6>] hrtimer_run_queues+0xf6/0x10f
 [<c0123db3>] run_timer_softirq+0x13b/0x31b
 [<c011fba0>] ksoftirqd+0xff/0x194
 [<c011faa1>] ksoftirqd+0x0/0x194
 [<c012beee>] kthread+0x82/0xa7
 [<c012be6c>] kthread+0x0/0xa7
 [<c0101031>] kernel_thread_helper+0x5/0xb
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c02fd493>] .... __spin_lock_irqsave+0xe/0x35
.....[<00000000>] ..   ( <= _stext+0x3feffd68/0x41)

Code: 45 14 00 00 00 00 8b 45 08 83 ca 01 89 55 0c 8b 40 04 89 45 08 5d e9 62 e2 ff ff 55 89 e5 57 56 53 50 8b 7d 08 8b 5d 10 8b 57 20 <8b> 02 89 45 f0 8d 47 20 39 c2 74 31 8b 72 f4 8d 42 f4 ff 75 18 
EIP: [<c01151ff>] __wake_up_common+0x10/0x55 SS:ESP 0068:dff25f24
