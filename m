Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUENVdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUENVdq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 17:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUENVdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 17:33:46 -0400
Received: from florence.buici.com ([206.124.142.26]:30345 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S262932AbUENVde
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 17:33:34 -0400
Date: Fri, 14 May 2004 14:33:32 -0700
From: Marc Singer <elf@buici.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Message-ID: <20040514213332.GA12414@buici.com>
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <200405142045.51875.bzolnier@elka.pw.edu.pl> <20040514194726.GA21194@buici.com> <200405142323.19115.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405142323.19115.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2004 at 11:23:19PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday 14 of May 2004 21:47, Marc Singer wrote:
> 
> > > [ you used 'struct ide_hwif_s' in arch-lh7a40x/ide.h to workaround this
> > > 8) ]
> 
> struct hwif_s actually
> 
> > Copied from elsewhere.
> 
> superio.h, superio.c

I don't think I ever looked at that code.

> EEK, added to TODO
> 
> > Listen.  It is not my intention to be clever.  All I want to do is get
> > things working and to not break other people's code.  I'm certain that
> > most people are working with the same assumptions.  Aside from some
> > naive snippets I've see promulgated, the bulk of the kernel work I've
> > see is sane given limited information.  Certainly, once one
> > understands a sybsystem completely then the quality rises.  I hope
> > you'll admit that the IDE code is overly intricate.
> 
> With changes like this nobody will ever be able to understand
> IDE subsystem completely. ;-)

I get the feeling that you're blaming me and others for making the IDE
code a mess.  Might I suggest that this isn't a very productive tack?
The most helpful thing to do is to a) provide best-practice examples,
and b) to include some documentation.  I'm not talking about anything
extensive, but statements like

  "All references to linux/ide.h must reside in the ide tree."

Are pretty darn helpful. 

> > > - you are setting IDE_NO_IRQ in ide_init_hwif_ports() which is used
> > >   in many places in generic IDE code - anybody wanting to understand
> > >   interactions with your code + generic code will have serious
> > >   problems (especially if knows _nothing_ about lpd7a40x)
> >
> > I don't know what you mean.  I grep for that constant and found it
> > nowhere except for ide-io.c and in my code.  It doesn't take much to
> > find the references.
> 
> I'm talking about ide_init_hwif_ports() function.

Most of the ARM arch's use it.  Perhaps all of them need a good once
over.

> > What is it that you want changed?
> >
> > > - hwif->mmio is set to 2 but resource handling is missed
> >
> > Can you be more specific?  Did you notice the comment?  I didn't know
> > what it was for, but I set it because I thought that that was the
> > right way to go.
> >
> > Are you talking about reserving the address space?  At the moment,
> 
> Yes.

Easily done.

> > this is done in the arch setup.  I can certainly move it to the IDE
> > driver.
> 
> OK
> 
> > > > The OUTB breaks my interface because I don't really have byte-level
> > > > access to the resgisters.  So, is selectproc a pre-select procedure or
> > > > should it be a substitute?
> > >
> > > pre-select but you can change it to be substitute if you need
> > > (just remember to update all users if you decide to do this)
> >
> > I'll have to search the kernel to see what uses it.  Maybe the better
> > way would be to define a new select proc that *is* a substitute.
> 
> Nope.

So then we break anyone who is using the selectproc as a pre-select
proc?  I don't understand what you mean here.  There are several
drivers that use this function.  How do you propose that we provide
both types of behavior with one entry point?

> > of the core code is fine.  It is that core code that is necessary to
> > make the test possible.
> 
> Stuff in arch-lh7a40x/ide.h is really a driver code but
> abuses subsystem code instead - that's my complain.

Right.  We agree.  I am talking about the core code.  Not the ide
code.  The core is what supports the CPU.


