Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264933AbTFYTGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 15:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264940AbTFYTGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 15:06:31 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:55967 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264933AbTFYTGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 15:06:12 -0400
Date: Wed, 25 Jun 2003 20:45:10 +0200
From: Pavel Machek <pavel@suse.cz>
To: Martin Diehl <lists@mdiehl.de>
Cc: Jean Tourrilhes <jt@hpl.hp.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Provide refrigerator support for irda
Message-ID: <20030625184509.GB5028@elf.ucw.cz>
References: <20030625021042.GA15753@bougret.hpl.hp.com> <Pine.LNX.4.44.0306250754150.1634-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306250754150.1634-100000@notebook.home.mdiehl.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Without this patch, kIrDAd prevents my notebook from entering suspend
> > > mode.
> 
> Are you talking about normal apm or acpi suspend or this swsusp
> thing?

ACPI and swsusp uses same mechanism. apm is different.

> > 	Wow ! I knew about microwave for 802.11b, but not about
> > refrigerator for IrDA.
> 
> Inclined to say "me too".

:-).

> > 	The man for sir_kthread is Martin Diehl. He is much more
> > intimate with kernel tasks than me, and he has other sir_dev updates
> > in the pipeline.
> 
> Admittedly I didn't care about swsusp so far. Given the big fat warning on 
> top of Documentation/swsusp.txt I would not even try and i personally 
> don't see what I would miss without swsusp.

That's okay... Just support your DMA-ing devices are supported.

> But of course, if we can make all parties happy, why not.
> 
> > > +		if (current->flags & PF_FREEZE)
> > > +			refrigerator(PF_IOTHREAD);
> > > +
> 
> I've tried to find some documentation about this - without success. So I 
> have no idea why this might be needed and what it will do. Grepping for 
> other kernel threads it looks like most of them use the same two lines.
> OTOH the irda thread is very similar to keventd's workqueue which do not
> use this. Not sure about the reason.

> Well, I'm thinking about making the irda thread using workqueue anyway, in 
> which case the issue would either disappear or get shifted to 
> kernel/workqueue.c.

> For the meantime, I think we should apply this if somebody would explain 
> what's going on here.

We need kernel thread to sleep at defined place. Process running
userspace can be stopped any time, but processes running in kernel can
be only stopped at defined places, to avoid unexpected surprises.

If it is possible to sleep at place "a", and no locks needed for
suspend are held at "a", inserting 

	if (current->flags & PF_FREEZE)
		refrigerator(PF_IOTHREAD);

is the right thing to do.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
