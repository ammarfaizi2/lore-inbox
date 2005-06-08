Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVFHLX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVFHLX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVFHLXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:23:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61387 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262172AbVFHLXu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:23:50 -0400
Date: Wed, 8 Jun 2005 16:53:46 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Morton Andrew Morton <akpm@osdl.org>, Bodo Eggert <7eggert@gmx.de>,
       stern@rowland.harvard.edu, Grant Grundler <grundler@parisc-linux.org>,
       awilliam@fc.hp.com, greg@kroah.com,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       bjorn.helgaas@hp.com, vgoyal@in.ibm.com
Subject: Re: [Fastboot] Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
Message-ID: <20050608112346.GB4082@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1118113637.42a50f65773eb@imap.linux.ibm.com> <20050607050727.GB12781@colo.lackof.org> <m1slzuwkqx.fsf@ebiederm.dsl.xmission.com> <20050607162143.GE29220@colo.lackof.org> <m1acm2vwil.fsf@ebiederm.dsl.xmission.com> <20050608063840.GA4082@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608063840.GA4082@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > > > Shared interrupts are an interesting case.  The simplest solution I can
> > > > think of for a crash dump capture kernel is to periodically poll
> > > > the hardware, as if all interrupts are shared.  At that level
> > > > I think we could get away with ignoring all hardware interrupt sources.
> > > 
> > > Yes, that's perfectly ok. We are no longer in a multitasking env.
> > 
> > Well we are at least capable of multitasking but that is no longer the
> > primary focus.  Having polling as at least an option should make
> > debugging easier.  Last I looked Andrews kernel hand an irqpoll option
> > to do something very like this.
> > 
> 
> If I understand this right, the idea is that let all irqs be masked (except
> timer one) and invoke all the irq handlers whenever a timer interrupt occurs.
> This will automatcally be equivalent to drivers polling their devices for
> any interrupt.
> 
> As you mentioned that irqpoll option comes close. If enabled, it invokes
> all the irq handlers on every timer interrupt (IRQ0). The only difference is 
> that irqs are not masked (until and unless kernel masks these due to excessive
> unhandled interrupts). 
> 
> I tried booting kdump kernel with irqpoll option. It seems to be going 
> little bit ahead than previous point of failure (boot without irqpoll) but
> panics later. Following is the stack trace.
> 

Second kernel booted fine with MPT_DEBUG_IRQ enabled (with irqpoll option). 
There were few warning messages though spitted by the code under MPT_DEBUG_IRQ.

Looks like drivers need to be hardened on case to case basis to initialize 
properly even if underlying device is not in a reset state.

Thanks
Vivek
