Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263045AbUENWUl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbUENWUl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 18:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUENWUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 18:20:40 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12753 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263019AbUENWUe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 18:20:34 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marc Singer <elf@buici.com>
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Date: Sat, 15 May 2004 00:19:46 +0200
User-Agent: KMail/1.5.3
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <200405142323.19115.bzolnier@elka.pw.edu.pl> <20040514213332.GA12414@buici.com>
In-Reply-To: <20040514213332.GA12414@buici.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405150019.46504.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 of May 2004 23:33, Marc Singer wrote:

> > > Listen.  It is not my intention to be clever.  All I want to do is get
> > > things working and to not break other people's code.  I'm certain that
> > > most people are working with the same assumptions.  Aside from some
> > > naive snippets I've see promulgated, the bulk of the kernel work I've
> > > see is sane given limited information.  Certainly, once one
> > > understands a sybsystem completely then the quality rises.  I hope
> > > you'll admit that the IDE code is overly intricate.
> >
> > With changes like this nobody will ever be able to understand
> > IDE subsystem completely. ;-)
>
> I get the feeling that you're blaming me and others for making the IDE
> code a mess.  Might I suggest that this isn't a very productive tack?

Yep, sorry.

> The most helpful thing to do is to a) provide best-practice examples,
> and b) to include some documentation.  I'm not talking about anything
> extensive, but statements like
>
>   "All references to linux/ide.h must reside in the ide tree."
>
> Are pretty darn helpful.

OK, will do (this can take a while).  Can I ask you to review it later?
I think your comments will be very valuable.

> > > > - you are setting IDE_NO_IRQ in ide_init_hwif_ports() which is used
> > > >   in many places in generic IDE code - anybody wanting to understand
> > > >   interactions with your code + generic code will have serious
> > > >   problems (especially if knows _nothing_ about lpd7a40x)
> > >
> > > I don't know what you mean.  I grep for that constant and found it
> > > nowhere except for ide-io.c and in my code.  It doesn't take much to
> > > find the references.
> >
> > I'm talking about ide_init_hwif_ports() function.
>
> Most of the ARM arch's use it.  Perhaps all of them need a good once
> over.

Since some time I have a patch killing <asm/arch-*/ide.h>. :)

> > > > > The OUTB breaks my interface because I don't really have byte-level
> > > > > access to the resgisters.  So, is selectproc a pre-select procedure
> > > > > or should it be a substitute?
> > > >
> > > > pre-select but you can change it to be substitute if you need
> > > > (just remember to update all users if you decide to do this)
> > >
> > > I'll have to search the kernel to see what uses it.  Maybe the better
> > > way would be to define a new select proc that *is* a substitute.
> >
> > Nope.
>
> So then we break anyone who is using the selectproc as a pre-select
> proc?  I don't understand what you mean here.  There are several
> drivers that use this function.  How do you propose that we provide
> both types of behavior with one entry point?

You can add last line of SELECT_DRIVE() to all ->selectproc()
implementations and add 'else' to SELECT_DRIVE().

> > > of the core code is fine.  It is that core code that is necessary to
> > > make the test possible.
> >
> > Stuff in arch-lh7a40x/ide.h is really a driver code but
> > abuses subsystem code instead - that's my complain.
>
> Right.  We agree.  I am talking about the core code.  Not the ide
> code.  The core is what supports the CPU.

Good.

Cheers,
Bartlomiej

