Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbUFCHSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbUFCHSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 03:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUFCHSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 03:18:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:53401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261443AbUFCHSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 03:18:46 -0400
Date: Thu, 3 Jun 2004 00:18:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, vojtech@suse.cz
Subject: Re: [RFC] Changing SysRq - show registers handling
Message-Id: <20040603001804.750b7fa5.akpm@osdl.org>
In-Reply-To: <200406030208.19612.dtor_core@ameritech.net>
References: <200406030134.04121.dtor_core@ameritech.net>
	<20040602235306.1e6dd3fb.akpm@osdl.org>
	<200406030208.19612.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> > do_IRQ(...)
>  > {
>  > 	...
>  > 	struct pt_regs **cpu_regs_slot = __get_cpu_var(global_irq_regs);
>  > 	struct pt_regs *save = *cpu_regs_slot;
>  > 	*cpu_regs_slot = &regs;
>  > 	...
>  > 	*cpu_regs_slot = save;
>  > }
>  > 
>  > And to teach the sysrq code to grab *__get_cpu_var(global_irq_regs).
> 
>  Ok, so by making it a tad slower you can keep the old semantics - printing
>  registers right when keyboard interrupt is processed instead of waiting till
>  the next one arrives.
> 
>  Hmm... the path is pretty hot, I am not sure what is best.

Well bear in mind that we can then rip all the pt_regs passing out from
everywhere, so as long as you edit every IRQ handler in the kernel it's a
net win ;)

I _think_ it'll work - as long as all architectures go through a common
dispatch function like do_IRQ(), which surely they do.  The above code
could be an arch-neutral inline actually.

I'm not sure what's best really.  But something this general is more
attractive than something which is purely for sysrs-T.
