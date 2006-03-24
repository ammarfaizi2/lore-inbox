Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWCXBGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWCXBGM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWCXBGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:06:12 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:43674 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932473AbWCXBGK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:06:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-mm1
Date: Fri, 24 Mar 2006 02:04:42 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
References: <20060323014046.2ca1d9df.akpm@osdl.org> <20060323160426.153fbea9.akpm@osdl.org> <1143161390.2299.36.camel@leatherman>
In-Reply-To: <1143161390.2299.36.camel@leatherman>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603240204.43294.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 01:49, john stultz wrote:
> On Thu, 2006-03-23 at 16:04 -0800, Andrew Morton wrote:
> > "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl> wrote:
> > >
> > > On Thursday 23 March 2006 10:40, Andrew Morton wrote:
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16/2.6.16-mm1/
> > > 
> > > On a uniprocessor AMD64 w/ CONFIG_SMP unset (2.6.16-rc6-mm2 works on this box
> > > just fine, .config attached):
> > 
> > hm, uniproc x86_64 seems to cause problems sometimes.  I should test it more.
> > 
> > > }-- snip --{
> > > PID hash table entries: 4096 (order: 12, 32768 bytes)
> > > time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
> > > time.c: Detected 1795.400 MHz processor.
> > > disabling early console
> > > Console: colour dummy device 80x25
> > > time.c: Lost 103 timer tick(s)! rip 10:start_kernel+0x121/0x220
> > > last cli 0x0
> > > last cli caller 0x0
> > > time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
> > > last cli 0x0
> > > last cli caller 0x0
> > > time.c: Lost 3 timer tick(s)! rip 10:__do_softirq+0x44/0xc0
> 
> It seems report_lost_ticks has been set to one w/ 2.6.16-mm1, thus these
> debug messages will be shown.
> 
> Rafael: To properly compare, could you boot 2.6.16-rc6-mm2 w/ the
> "report_lost_ticks" boot option and see if the same sort of messages do
> not appear?

It looks similar but not the same:

}-- snip --{
Kernel command line: root=/dev/hdc6 vga=792 selinux=0 noapic resume=/dev/hdc3 console=ttyS0,57600 console=tty0 earlyprintk=serial,ttyS0,5760
0 debug report_lost_ticks init=/bin/bash
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 1795.371 MHz processor.
disabling early console
Console: colour dummy device 80x25
time.c: Lost 104 timer tick(s)! rip start_kernel+0x11d/0x210)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x44/0xb0)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x44/0xb0)
time.c: Lost 1 timer tick(s)! rip __do_softirq+0x50/0xb0)
time.c: Lost 2 timer tick(s)! rip run_timer_softirq+0x0/0x1f0)
time.c: Lost 2 timer tick(s)! rip run_timer_softirq+0x1/0x1f0)
time.c: Lost 1 timer tick(s)! rip hrtimer_run_queues+0x1/0x120)
time.c: Lost 2 timer tick(s)! rip hrtimer_run_queues+0x43/0x120)
time.c: Lost 2 timer tick(s)! rip hrtimer_run_queues+0x58/0x120)
time.c: Lost 2 timer tick(s)! rip _spin_lock_irq+0x1/0x30)
time.c: Lost 2 timer tick(s)! rip _spin_lock_irq+0x1/0x30)
time.c: Lost 1 timer tick(s)! rip _spin_lock_irq+0x4/0x30)
time.c: Lost 2 timer tick(s)! rip _spin_unlock_irq+0xf/0x40)
time.c: Lost 2 timer tick(s)! rip _spin_unlock_irq+0x30/0x40)
time.c: Lost 1 timer tick(s)! rip hrtimer_run_queues+0x77/0x120)
time.c: Lost 2 timer tick(s)! rip hrtimer_run_queues+0x77/0x120)
time.c: Lost 2 timer tick(s)! rip _spin_lock_irq+0x8/0x30)
time.c: Lost 2 timer tick(s)! rip _spin_unlock_irq+0xf/0x40)
time.c: Lost 1 timer tick(s)! rip sub_preempt_count+0x26/0x60)
time.c: Lost 2 timer tick(s)! rip _spin_unlock_irq+0x31/0x40)
time.c: Lost 2 timer tick(s)! rip hrtimer_run_queues+0x112/0x120)
time.c: Lost 2 timer tick(s)! rip _spin_lock_irq+0x1/0x30)
time.c: Lost 1 timer tick(s)! rip _spin_unlock_irq+0xf/0x40)
time.c: Lost 2 timer tick(s)! rip run_timer_softirq+0x1da/0x1f0)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x44/0xb0)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x50/0xb0)
time.c: Lost 1 timer tick(s)! rip hrtimer_run_queues+0x58/0x120)
}-- cut --{

Rafael
