Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272669AbTG3LXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 07:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272819AbTG3LXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 07:23:05 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:37249 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272669AbTG3LXA (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 07:23:00 -0400
Date: Wed, 30 Jul 2003 12:29:55 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200307301129.h6UBTtBD001245@81-2-122-30.bradfords.org.uk>
To: bunk@fs.tum.de, john@grabjohn.com
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Cc: Linux-Kernel@vger.kernel.org, Riley@Williams.Name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >  * Driver does not work, and is thus disabled. If it is not
> > >    fixed in the near future, it will be considered to be
> > >    OBSOLETE as well.
> > >
> > > 		CONFIG_BROKEN
> > 
> > Please do _NOT_ do this - there is a far more important and worthwhile
> > reason to have a CONFIG_BROKEN than to simply save the few minutes of
> > inconvenience that including a non-compiling option in a kernel build
> > causes.
> > 
> > Imagine the situation where a driver such as a SCSI driver builds
> > successfully, but it silently corrupts data under certain, (possibly
> > rare), circumstances.
> > 
> > In that case, it's important to warn people that it's broken, because
> > it's not necessarily obvious, and could case significant data loss.
> > If something doesn't compile, it already gives you an error message.
> > The only problem is a few minutes of wasted time.
>
> You forget one important thing:
> If a _user_ of a stable kernel notices "it doesn't even compile" this 
> gives a very bad impression of the quality of the Linux kernel.

I don't agree.  The stock kernel is a work in progress, and things get
broken from time to time as a normal part of development.  Experienced
users will realise that, and I wouldn't encourage inexperienced users
to compile their own kernel from the stock trees anyway, because they
could easily miss bugfixes, including data corruption and security
ones, simply because they assume that they are in the mainline
kernel.

Compiling your own kernel from the stock kernel trees is still
something that should be considered for experienced users only.

Besides, what's worse?  Possible data corruption or a bad impression?

> > >  * Driver works on uniprocessor but not on SMP and is thus
> > >    disabled when compiling for SMP. It is assumed that the
> > >    driver will be fixed for SMP if relevant.
> > >
> > > 		CONFIG_BROKEN_ON_SMP
> > 
> > Please _don't_ do this either.  It implies that if
> > CONFIG_BROKEN_ON_SMP isn't set, then it's SMP safe - a lot of drivers
> > will NOT have been tested on SMP, so it's a bad thing to assume that
> > is the case.
> >...
>
> My patch adds BROKEN_ON_SMP only to drivers that don't compile, but if a 
> driver causes e.g. data corruption on SMP I don't see a reason against 
> letting it depend on BROKEN_ON_SMP.

The name BROKEN_ON_SMP implies that if you don't set it, what's left
is known to work on SMP.  In a lot of cases, it'll actually be
untested on SMP.

John.
