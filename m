Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270079AbTG3Ko2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 06:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270094AbTG3Ko2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 06:44:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:39120 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270079AbTG3Ko0 (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 06:44:26 -0400
Date: Wed, 30 Jul 2003 12:44:21 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Bradford <john@grabjohn.com>
Cc: Riley@Williams.Name, Linux-Kernel@vger.kernel.org
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Message-ID: <20030730104421.GC28767@fs.tum.de>
References: <200307300911.h6U9BH2f000813@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307300911.h6U9BH2f000813@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 10:11:17AM +0100, John Bradford wrote:
>...
> >  * Driver does not work, and is thus disabled. If it is not
> >    fixed in the near future, it will be considered to be
> >    OBSOLETE as well.
> >
> > 		CONFIG_BROKEN
> 
> Please do _NOT_ do this - there is a far more important and worthwhile
> reason to have a CONFIG_BROKEN than to simply save the few minutes of
> inconvenience that including a non-compiling option in a kernel build
> causes.
> 
> Imagine the situation where a driver such as a SCSI driver builds
> successfully, but it silently corrupts data under certain, (possibly
> rare), circumstances.
> 
> In that case, it's important to warn people that it's broken, because
> it's not necessarily obvious, and could case significant data loss.
> If something doesn't compile, it already gives you an error message.
> The only problem is a few minutes of wasted time.

You forget one important thing:
If a _user_ of a stable kernel notices "it doesn't even compile" this 
gives a very bad impression of the quality of the Linux kernel.

> >  * Driver works on uniprocessor but not on SMP and is thus
> >    disabled when compiling for SMP. It is assumed that the
> >    driver will be fixed for SMP if relevant.
> >
> > 		CONFIG_BROKEN_ON_SMP
> 
> Please _don't_ do this either.  It implies that if
> CONFIG_BROKEN_ON_SMP isn't set, then it's SMP safe - a lot of drivers
> will NOT have been tested on SMP, so it's a bad thing to assume that
> is the case.
>...

My patch adds BROKEN_ON_SMP only to drivers that don't compile, but if a 
driver causes e.g. data corruption on SMP I don't see a reason against 
letting it depend on BROKEN_ON_SMP.

> John.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

