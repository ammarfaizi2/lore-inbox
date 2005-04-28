Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbVD1XA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbVD1XA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 19:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVD1XA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 19:00:27 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:27866 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262328AbVD1XAH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 19:00:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sld+gxeYremTOTLglhTEdEZ/s09YTLHqOTobnH5N/ZJGO10NwR4olFhDjvA8eulbTDbuMx29UFQaX1LMcA1feZ+rnsdnkieFPq46ovxvPotVWQnksPn488jIkOhaa8m+6FM7lxQ4XBHjo9VasR1A2TN3ZCKPhithtX/I2w1eFUY=
Message-ID: <58cb370e05042816003c2ca4be@mail.gmail.com>
Date: Fri, 29 Apr 2005 01:00:06 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Multiple functionality breakages in 2.6.12rc3 IDE layer
Cc: linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1114727522.18355.242.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1114703284.18809.208.camel@localhost.localdomain>
	 <58cb370e05042813414af5bc1e@mail.gmail.com>
	 <1114727522.18355.242.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2005-04-28 at 21:41, Bartlomiej Zolnierkiewicz wrote:
> > On 4/28/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > Ages ago we added an ide_default driver to clean up all the corner cases
> >
> > s/clean up/hide/
> 
> Matter of opinion.

No, it hided holes in the locking which is getting fixed finally.

> > > for most users. You can no longer
> > >         - Control the bus state of an interface
> > >         - Reset an interface
> > >         - Add an interface if none exist
> > >         - Issue raw commands
> > >         - Get an objects bios geometry
> > >         - Read the identify data by ioctl (its still in proc but may be stale)
> >
> > Details please.
> 
> If you need details you shouldn't be maintaining that code. Its obvious

Give details or quit whining.

> why. You've disabled open() of a device with no bound driver.

Guess what open() for ide-default was doing in 2.6?

return -ENXIO;

and no it wasn't my change - it was the effect of fixing
locking of the higher layers.

> > No functionality was removed AFAIK, see the patches.  I spend quite
> > a bit of time making sure that nothing breaks up (I missed one special
> > case but somebody already posted patch to LKML fixing it).
> 
> Build a kernel without ide-cd. Now try and issue ioctls on it. Doesn't
> work any more does it.
> 
> >
> > These patches were posted at least two times to both linux-ide and
> > linux-kernel, they were in -mm for ages - were you hiding under the
> > rock?
> 
> No, just doing an MBA thesis, a job, learning a second language and
> trying to beat sense into our politicians. Now I come back to look at

It seems that they influenced you heavily...

> the ide layer ready for a 2.6.12 merge and its all a bit messy. The open
> code was clean and is now duplicated. Copies of subtly different per

You must be joking.

> driver gendisk/disk layer open routines have appeared that should be

Each change was given rationale and detailed changelog, 
maybe you should get familiar with them.  Also look for
patch converting device drivers to sysfs (posted few times).

> shared. The default driver handling has been removed and half the
> options for obscure systems have been marked obsolete in some Gnome like
> purge of functionality that might scare small children.
> 
> > > The ability to specify the IDE ports on the command line as needed for
> > > some Sony laptop installs have also become "obsolete" over time. They
> > > still appear to work but spew a warning that the user will soon be
> > > screwed.
> >
> > This was discussed few times already.
> 
> And the discussion lead to no fixes

So fix the real bugs and leave debugging stuff alone.

> > Alan, seriously, what is your problem?
> 
> The fact that the IDE layer appears to be getting worse not better,
> which given the starting point is a remarkable achievement.

Personal insults are easy, get technical facts.

Bartlomiej
