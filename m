Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263251AbRFEG1z>; Tue, 5 Jun 2001 02:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263252AbRFEG1f>; Tue, 5 Jun 2001 02:27:35 -0400
Received: from [62.231.2.151] ([62.231.2.151]:38922 "EHLO mail.ixcelerator.com")
	by vger.kernel.org with ESMTP id <S263251AbRFEG11>;
	Tue, 5 Jun 2001 02:27:27 -0400
Date: Tue, 5 Jun 2001 10:27:11 +0400
From: Oleg Drokin <green@iXcelerator.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: green@linuxhacker.ru, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac7 SMP crash (hotplug race?)
Message-ID: <20010605102711.A14848@iXcelerator.com>
In-Reply-To: <mailman.991678980.18162.linux-kernel2news@redhat.com> <200106042041.f54KfmY07533@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200106042041.f54KfmY07533@devserv.devel.redhat.com>; from zaitcev@redhat.com on Mon, Jun 04, 2001 at 04:41:48PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

On Mon, Jun 04, 2001 at 04:41:48PM -0400, Pete Zaitcev wrote:
> >    I told device to go to sleep, it reported (over serial console that I
> >    looked at with minicom), that it turned off internal devices
> >    (including USB client), reported it is going to sleep, and turned
> >    serial and itself off.
> What does it mean "I told device to go to sleep"?
It mean just it. I forced device to enter "suspend" mode.

> What device? How (what command line)?
Device is Compaq iPaq running Linux.
Command line is echo >/proc/sys/pm/suspend (on iPAQ prompt)
This even generates 2 simultaneous irqs: one is for serial (DCD clear)
and one is for USB (device detachment) (which iun turn should call 2
usermode helpers on is for net.hotplug helper (usb0 net device unregistering)
and one is usb.hotplug helper (USB device unregistering))

> > wait_on_irq, CPU 1
> > irq: 1 [1 0]
> > bh:  1 [0 1]
> > CPU 0: <unknown>
> > CPU 1: c167fe68 c01d805d ... (not recorded full stack)
> > Trace; c0108522 <__global_cli+e2/170>
> > Trace; c0170f97 <rs_timer+37/110>
> > Trace; c0170f60 <rs_timer+0/110>
> > Trace; c011d706 <timer_bh+256/2b0>
> > Trace; c011a56c <bh_action+4c/b0>
> > Trace; c011a423 <tasklet_hi_action+53/90>
> > Trace; c011a2ab <do_softirq+6b/a0>
> > Trace; c0108935 <do_IRQ+e5/f0>
> > Trace; c0108525 <__global_cli+e5/170>
> > Trace; c01617e8 <flush_to_ldisc+d8/120>
> > Trace; c011a67d <__run_task_queue+5d/70>
> > Trace; c0121c35 <context_thread+c5/200>
> > Trace; c0121670 <exec_usermodehelper+3c0/400>
> > Trace; c0105000 <prepare_namespace+0/10>
> > Trace; c0105556 <kernel_thread+26/30>
> > Trace; c0121670 <exec_usermodehelper+3c0/400>
> Curious. What host controller driver do you use?
I use uhci, but I saw no usb symbols in backtrace so I think it does not
matter.
Also I must say that this is 100% repeatable (and backtrace is almost the same,
except for last few items)

Bye,
    Oleg
