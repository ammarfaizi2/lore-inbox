Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUENWu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUENWu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 18:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUENWu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 18:50:28 -0400
Received: from florence.buici.com ([206.124.142.26]:40329 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263100AbUENWth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 18:49:37 -0400
Date: Fri, 14 May 2004 15:49:32 -0700
From: Marc Singer <elf@buici.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Message-ID: <20040514224932.GA8061@buici.com>
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <200405142323.19115.bzolnier@elka.pw.edu.pl> <20040514213332.GA12414@buici.com> <200405150019.46504.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405150019.46504.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 12:19:46AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > The most helpful thing to do is to a) provide best-practice examples,
> > and b) to include some documentation.  I'm not talking about anything
> > extensive, but statements like
> >
> >   "All references to linux/ide.h must reside in the ide tree."
> >
> > Are pretty darn helpful.
> 
> OK, will do (this can take a while).  Can I ask you to review it later?
> I think your comments will be very valuable.

It would be a pleasure.

> > > > > - you are setting IDE_NO_IRQ in ide_init_hwif_ports() which is used
> > > > >   in many places in generic IDE code - anybody wanting to understand
> > > > >   interactions with your code + generic code will have serious
> > > > >   problems (especially if knows _nothing_ about lpd7a40x)
> > > >
> > > > I don't know what you mean.  I grep for that constant and found it
> > > > nowhere except for ide-io.c and in my code.  It doesn't take much to
> > > > find the references.
> > >
> > > I'm talking about ide_init_hwif_ports() function.
> >
> > Most of the ARM arch's use it.  Perhaps all of them need a good once
> > over.
> 
> Since some time I have a patch killing <asm/arch-*/ide.h>. :)

OK.  That raises an interesting question.  If a) you as the IDE
maintainer want to make a policy change, and b) you have a concrete
action to take, then how do you go about it so that the right thing
(tm) happens?

One tack would be to post to the ARM list stating that there is
such-and-such, a new policy, and this requires a change to the
way-things-work (tm).  Then effect a patch that breaks the bad stuff
so that the users of such bad stuff must cope.

For example, the patch could edit each of the arm ide files so that
they don't compile when IDE is enabled.  This wouldn't clobber the
files as much as make them useless until the such-and-such policy is
followed.

> > So then we break anyone who is using the selectproc as a pre-select
> > proc?  I don't understand what you mean here.  There are several
> > drivers that use this function.  How do you propose that we provide
> > both types of behavior with one entry point?
> 
> You can add last line of SELECT_DRIVE() to all ->selectproc()
> implementations and add 'else' to SELECT_DRIVE().

Ah.  I see where you're going.  I can do that.  I cannot test it, but
I can do it.

BTW, thanks for you help and input.

Cheers.
