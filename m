Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUFCH1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUFCH1s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 03:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUFCH1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 03:27:48 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:38490 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261551AbUFCH1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 03:27:37 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] Changing SysRq - show registers handling
Date: Thu, 3 Jun 2004 02:27:22 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, vojtech@suse.cz
References: <200406030134.04121.dtor_core@ameritech.net> <200406030208.19612.dtor_core@ameritech.net> <20040603001804.750b7fa5.akpm@osdl.org>
In-Reply-To: <20040603001804.750b7fa5.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406030227.22178.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 June 2004 02:18 am, Andrew Morton wrote:
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> >
> > > do_IRQ(...)
> >  > {
> >  > 	...
> >  > 	struct pt_regs **cpu_regs_slot = __get_cpu_var(global_irq_regs);
> >  > 	struct pt_regs *save = *cpu_regs_slot;
> >  > 	*cpu_regs_slot = &regs;
> >  > 	...
> >  > 	*cpu_regs_slot = save;
> >  > }
> >  > 
> >  > And to teach the sysrq code to grab *__get_cpu_var(global_irq_regs).
> > 
> >  Ok, so by making it a tad slower you can keep the old semantics - printing
> >  registers right when keyboard interrupt is processed instead of waiting till
> >  the next one arrives.
> > 
> >  Hmm... the path is pretty hot, I am not sure what is best.
> 
> Well bear in mind that we can then rip all the pt_regs passing out from
> everywhere, so as long as you edit every IRQ handler in the kernel it's a
> net win ;)

Will you let me? :) USB and serio will at least not mess anyone else...

> 
> I _think_ it'll work - as long as all architectures go through a common
> dispatch function like do_IRQ(), which surely they do.  The above code
> could be an arch-neutral inline actually.
> 
> I'm not sure what's best really.  But something this general is more
> attractive than something which is purely for sysrs-T.
> 

I don't like the requirement of SysRq request processing being in hard
interrupt handler - that excludes uinput-generated events and precludes
moving keyboard handling to a tasklet for example.

-- 
Dmitry
