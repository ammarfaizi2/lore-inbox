Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSFOIUA>; Sat, 15 Jun 2002 04:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315170AbSFOIT7>; Sat, 15 Jun 2002 04:19:59 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54977 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315168AbSFOIT7>;
	Sat, 15 Jun 2002 04:19:59 -0400
Date: Sat, 15 Jun 2002 10:19:52 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020615081952.GD1359@suse.de>
In-Reply-To: <20020614151703.GB1120@suse.de> <Pine.LNX.4.44.0206140940240.2576-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14 2002, Linus Torvalds wrote:
> 
> 
> On Fri, 14 Jun 2002, Jens Axboe wrote:
> >
> > - current 2.5 bk deadlocks reading partition info off disk. Again a
> >   locking problem I suppose, to be honest I just got very tired when
> >   seeing it happen and didn't want to spend tim looking into it.
> 
> Hmm. There's a bug in "balance_irq()" if you are trying to run a SMP
> kernel on an UP machine right now, and it _might_ be that the lockup has
> nothing to do with the IDE layer, but simple with the first PCI interrupt
> (as opposed to local timer interrupt) coming in.
> 
> One-liner from Zwane Mwaikambo (cut-and-paste, so space is wrong, please
> apply by hand).
> 
> --- linux-2.5.19/arch/i386/kernel/io_apic.c.orig        Fri Jun 14 17:43:20 2002
> +++ linux-2.5.19/arch/i386/kernel/io_apic.c     Fri Jun 14 17:42:23 2002
> @@ -251,7 +251,7 @@
>         irq_balance_t *entry = irq_balance + irq;
>         unsigned long now = jiffies;
> 
> -       if (unlikely(entry->timestamp != now)) {
> +       if ((entry->timestamp != now) && (smp_num_cpus > 1)) {
>                 unsigned long allowed_mask;
>                 int random_number;
> 
> I don't know. Might be the IDE code too, of course.

If it's just a SMP kernel on UP, then that's not the problem here. This
was SMP kernel on SMP machine.

-- 
Jens Axboe

