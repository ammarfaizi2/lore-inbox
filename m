Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262626AbRFNNlQ>; Thu, 14 Jun 2001 09:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262649AbRFNNlG>; Thu, 14 Jun 2001 09:41:06 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:22670 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262626AbRFNNkx>;
	Thu, 14 Jun 2001 09:40:53 -0400
Message-ID: <3B28BEDE.738A2BF9@mandrakesoft.com>
Date: Thu, 14 Jun 2001 09:40:46 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michal Jaegermann <michal@harddata.com>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Minor "cleanup" patches for 2.4.5-ac kernels
In-Reply-To: <20010612183832.A29923@mail.harddata.com> <3B26BBDB.1EF70F79@mandrakesoft.com> <20010612200457.A30127@mail.harddata.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Jaegermann wrote:
> 
> On Tue, Jun 12, 2001 at 09:03:23PM -0400, Jeff Garzik wrote:
> > Michal Jaegermann wrote:
> > > --- linux-2.4.5ac/drivers/pci/quirks.c~ Tue Jun 12 16:31:12 2001
> > > +++ linux-2.4.5ac/drivers/pci/quirks.c  Tue Jun 12 17:13:18 2001
> > > @@ -18,6 +18,7 @@
> > >  #include <linux/pci.h>
> > >  #include <linux/init.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/sched.h>
> > >
> > >  #undef DEBUG
> > >
> > > There is no problem if SMP is not configured.
> >
> > no the better place for this is include/asm-i386/delay.h.
> 
> You mean to put "#include <linux/sched.h>" into include/linux/delay.h?
> Otherwise this will not help very much on Alpha when I run into
> the problem; or other architectures. :-)  Works for me and indeed
> it may be a better place.

This is an architecture-level thing.  include/asm-$arch/delay not
include/linux/delay.h

Currently, Alpha does not need to include sched.h at all...


> > Then Andrea suggested to
> > simply un-inline udelay, which solved the compile problem in an even
> > better way.  (we cannot un-inline udelay on x86 I think)
> 
> How about other architectures?  Each will need an individual treatment?

Each arch will need individual treatment, but each alpha should decide
for itself whether or not to un-inline udelay.  It may not be possible
on some archs.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
