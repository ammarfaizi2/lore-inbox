Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264181AbRFMCFc>; Tue, 12 Jun 2001 22:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264210AbRFMCFW>; Tue, 12 Jun 2001 22:05:22 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:10759 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S264181AbRFMCFF>; Tue, 12 Jun 2001 22:05:05 -0400
Date: Tue, 12 Jun 2001 20:04:57 -0600
From: Michal Jaegermann <michal@harddata.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Minor "cleanup" patches for 2.4.5-ac kernels
Message-ID: <20010612200457.A30127@mail.harddata.com>
In-Reply-To: <20010612183832.A29923@mail.harddata.com> <3B26BBDB.1EF70F79@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B26BBDB.1EF70F79@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Tue, Jun 12, 2001 at 09:03:23PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2001 at 09:03:23PM -0400, Jeff Garzik wrote:
> Michal Jaegermann wrote:
> > --- linux-2.4.5ac/drivers/pci/quirks.c~ Tue Jun 12 16:31:12 2001
> > +++ linux-2.4.5ac/drivers/pci/quirks.c  Tue Jun 12 17:13:18 2001
> > @@ -18,6 +18,7 @@
> >  #include <linux/pci.h>
> >  #include <linux/init.h>
> >  #include <linux/delay.h>
> > +#include <linux/sched.h>
> > 
> >  #undef DEBUG
> > 
> > There is no problem if SMP is not configured.
> 
> no the better place for this is include/asm-i386/delay.h.

You mean to put "#include <linux/sched.h>" into include/linux/delay.h?
Otherwise this will not help very much on Alpha when I run into
the problem; or other architectures. :-)  Works for me and indeed
it may be a better place.

> Otherwise you
> wind up solving the same problem over and over again in each similar
> driver.

'quirks.c' was the only trouble spot which tripped compilation
after changes to it.  So I kept my patch local.

> I --just-- went through on Alpha, and included linux/sched.h in
> include/asm-alpha/delay.h.  Not an hour ago :)

This was probably this hour when I was looking for that error. :-)

> Then Andrea suggested to
> simply un-inline udelay, which solved the compile problem in an even
> better way.  (we cannot un-inline udelay on x86 I think)

How about other architectures?  Each will need an individual treatment?

> > --- 2.4.5-ac11/include/linux/binfmts.h  Mon Jun  4 14:19:00 2001
> > +++ linux/include/linux/binfmts.h       Mon Jun  4 20:24:50 2001
> > @@ -32,6 +32,9 @@ struct linux_binprm{
> >         unsigned long loader, exec;
> >  };
> > 
> > +/* Forward declaration */
> > +struct mm_struct;
> > +
> 
> I added this one to the MDK kernel compile.  I think it is an 'ac'
> thing, I don't get these warnings on vanilla 2.4.[56]-pre.

Indeed it is.  All three actually are (as I wrote).  The last one,
if not present, has a very unpleasant effect of drowning compilation
warnings in a flood as wailing happens in a header which is included
mostly everywhere.  It is very easy then to miss something where one
should pay a closer attention.

I suggested earlier some other patch for that but Alan apparently
did not like that one.  Quite possibly he was right.

  Michal

