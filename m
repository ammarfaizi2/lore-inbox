Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUENVW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUENVW3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 17:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUENVW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 17:22:29 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59335 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262874AbUENVWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 17:22:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marc Singer <elf@buici.com>
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Date: Fri, 14 May 2004 23:23:19 +0200
User-Agent: KMail/1.5.3
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <200405142045.51875.bzolnier@elka.pw.edu.pl> <20040514194726.GA21194@buici.com>
In-Reply-To: <20040514194726.GA21194@buici.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405142323.19115.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 of May 2004 21:47, Marc Singer wrote:

> > [ you used 'struct ide_hwif_s' in arch-lh7a40x/ide.h to workaround this
> > 8) ]

struct hwif_s actually

> Copied from elsewhere.

superio.h, superio.c

EEK, added to TODO

> Listen.  It is not my intention to be clever.  All I want to do is get
> things working and to not break other people's code.  I'm certain that
> most people are working with the same assumptions.  Aside from some
> naive snippets I've see promulgated, the bulk of the kernel work I've
> see is sane given limited information.  Certainly, once one
> understands a sybsystem completely then the quality rises.  I hope
> you'll admit that the IDE code is overly intricate.

With changes like this nobody will ever be able to understand
IDE subsystem completely. ;-)

> > - you are setting IDE_NO_IRQ in ide_init_hwif_ports() which is used
> >   in many places in generic IDE code - anybody wanting to understand
> >   interactions with your code + generic code will have serious
> >   problems (especially if knows _nothing_ about lpd7a40x)
>
> I don't know what you mean.  I grep for that constant and found it
> nowhere except for ide-io.c and in my code.  It doesn't take much to
> find the references.

I'm talking about ide_init_hwif_ports() function.

> What is it that you want changed?
>
> > - hwif->mmio is set to 2 but resource handling is missed
>
> Can you be more specific?  Did you notice the comment?  I didn't know
> what it was for, but I set it because I thought that that was the
> right way to go.
>
> Are you talking about reserving the address space?  At the moment,

Yes.

> this is done in the arch setup.  I can certainly move it to the IDE
> driver.

OK

> > > The OUTB breaks my interface because I don't really have byte-level
> > > access to the resgisters.  So, is selectproc a pre-select procedure or
> > > should it be a substitute?
> >
> > pre-select but you can change it to be substitute if you need
> > (just remember to update all users if you decide to do this)
>
> I'll have to search the kernel to see what uses it.  Maybe the better
> way would be to define a new select proc that *is* a substitute.

Nope.

> > IMO it is better to fix it correctly than to do hacks like this
> > in lpd7a40x_ide_outb() (which is minor performance hit btw)
>
> Of course.
>
> > > Anyway, that is what I did in a nutshell.  I plan to get back to this
> > > in a week or so.  Since Russell King already integrated the lh7a40x
> > > code into the kernel, this stuff should be easy to test.
> >
> > That's what I'm talking about - it shouldn't have been integrated. :-)
>
> I think we are talking about two things here.  I agree that the
> ide-lpd7a400 code should not have been integrated.  However, the rest

OK

> of the core code is fine.  It is that core code that is necessary to
> make the test possible.

Stuff in arch-lh7a40x/ide.h is really a driver code but
abuses subsystem code instead - that's my complain.

OK, lets move things forward and just fix it.

Cheers.

