Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVKTAaf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVKTAaf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 19:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVKTAaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 19:30:35 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:46189 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750714AbVKTAaf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 19:30:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SukmG+jU0L6iYrkrDd8VrcAFqg/GH6eLJPyUnFCszjkYx4GgbD2Dsnnlg1meEkExFj3rKLn4Pdip+0Ke1XgLoS2PneeSBbZLimedNjaxiLei/E4ArL+oiThjmfBTL+FoTG3j8AjedeZnkfYqVhOeAPmZxV2A7dfRKaBedlhYo9s=
Message-ID: <9a8748490511191630r3ad3e24w4e6d21b3f3b0c3a7@mail.gmail.com>
Date: Sun, 20 Nov 2005 01:30:34 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386, nmi: signed vs unsigned mixup
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <20051119162805.47796de9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200511200010.33658.jesper.juhl@gmail.com>
	 <20051119162805.47796de9.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/05, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > In arch/i386/kernel/nmi.c::nmi_watchdog_tick(), the variable `sum' is
> > of type "int" but it's used to store the result of
> > per_cpu(irq_stat, cpu).apic_timer_irqs which is an "unsigned int", it's
> > also later compared to last_irq_sums[cpu] which is also an
> > "unsigned int", so `sum' really ought to be unsigned itself.
> > This small patch makes that change.
> >
> > ...
> >
> > --- linux-2.6.15-rc1-git7-orig/arch/i386/kernel/nmi.c 2005-11-12 18:07:14.000000000 +0100
> > +++ linux-2.6.15-rc1-git7/arch/i386/kernel/nmi.c      2005-11-19 23:58:17.000000000 +0100
> > @@ -528,9 +528,10 @@ void nmi_watchdog_tick (struct pt_regs *
> >        * Since current_thread_info()-> is always on the stack, and we
> >        * always switch the stack NMI-atomically, it's safe to use
> >        * smp_processor_id().
> >        */
> > -     int sum, cpu = smp_processor_id();
> > +     unsigned int sum;
> > +     int cpu = smp_processor_id();
> >
> >       sum = per_cpu(irq_stat, cpu).apic_timer_irqs;
> >
> >       if (last_irq_sums[cpu] == sum) {
> >
>
> -ETOOTRIVIAL.  The code as-is works OK, and we have these sorts of things
> all over the tee.
>
Fair enough.

Would a patch to clean this sort of stuff up in bulk all over be of
interrest or should I just leave it alone?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
