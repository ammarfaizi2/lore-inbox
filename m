Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSHaRKO>; Sat, 31 Aug 2002 13:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317772AbSHaRKO>; Sat, 31 Aug 2002 13:10:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43279 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317755AbSHaRKN>; Sat, 31 Aug 2002 13:10:13 -0400
Date: Sat, 31 Aug 2002 18:14:38 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.32-bug
Message-ID: <20020831181438.A2047@flint.arm.linux.org.uk>
References: <E17ktU0-00035E-00@flint.arm.linux.org.uk> <20020831140007.C781@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020831140007.C781@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Sat, Aug 31, 2002 at 02:00:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 02:00:08PM +0200, Ingo Oeser wrote:
> Hi Rusty,

Grr.

> On Fri, Aug 30, 2002 at 10:39:12PM +0100, Russell King wrote:
> > This patch appears not to be in 2.5.32, but applies cleanly.
> > 
> > This patch moves BUG() and PAGE_BUG() from asm/page.h into asm/bug.h.
> > 
> > We also fix up linux/dcache.h, which included asm/page.h for the sole
> > purpose of getting the BUG() definition.
> > 
> > Since linux/kernel.h makes use of BUG(), asm/bug.h is included there
> > as well.
> > --- orig/include/asm-cris/bug.h	Thu Jan  1 01:00:00 1970
> > +++ linux/include/asm-cris/bug.h	Sun Jan  6 11:46:09 2002
> > @@ -0,0 +1,12 @@
> > +#ifndef _CRIS_BUG_H
> > +#define _CRIS_BUG_H
> > +
> > +#define BUG() do { \
> > +  printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
> > +} while (0)
> > +
> > +#define PAGE_BUG(page) do { \
> > +         BUG(); \
> > +} while (0)
> > +
> > +#endif
> 
> These kind of implementation of BUG() is not very useful. Callers
> of BUG() and BUG_ON() assume, that the thread is aborted and do
> nothing to fixup after BUG(). 

Nevertheless, its not up to me to change the implementation that an
architecture has chosen.  That's for the individual port maintainers
to fix.

This patch only cleans up the include for the bug stuff so its in a
less silly place.  There are _zero_ functional code changes.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

