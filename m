Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316229AbSEKPCB>; Sat, 11 May 2002 11:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316231AbSEKPCB>; Sat, 11 May 2002 11:02:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46578 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316229AbSEKPB7>;
	Sat, 11 May 2002 11:01:59 -0400
Message-ID: <3CDD324E.4E1C4FB6@mvista.com>
Date: Sat, 11 May 2002 08:01:34 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2
In-Reply-To: <Pine.LNX.4.33.0205101538400.25826-100000@penguin.transmeta.com> <3CDC6906.B0288387@mvista.com> <20020511092935.A16828@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Fri, May 10, 2002 at 05:42:46PM -0700, george anzinger wrote:
> > diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/arm/vmlinux-armo.lds.in linux/arch/arm/vmlinux-armo.lds.in
> > --- linux-2.5.14-org/arch/arm/vmlinux-armo.lds.in     Tue May  7 15:59:35 2002
> > +++ linux/arch/arm/vmlinux-armo.lds.in        Fri May 10 17:07:31 2002
> > @@ -4,6 +4,7 @@
> >   */
> >  OUTPUT_ARCH(arm)
> >  ENTRY(stext)
> > +jiffies = jiffies_64 + 4;
> >  SECTIONS
> >  {
> >       . = TEXTADDR;
> > diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.14-org/arch/arm/vmlinux-armv.lds.in linux/arch/arm/vmlinux-armv.lds.in
> > --- linux-2.5.14-org/arch/arm/vmlinux-armv.lds.in     Tue May  7 15:59:35 2002
> > +++ linux/arch/arm/vmlinux-armv.lds.in        Fri May 10 17:07:34 2002
> > @@ -4,6 +4,7 @@
> >   */
> >  OUTPUT_ARCH(arm)
> >  ENTRY(stext)
> > +jiffies = jiffies_64 + 4;
> >  SECTIONS
> >  {
> >       . = TEXTADDR;
> 
> Eurgh.  This seems to be a popular misconception.  What makes you think
> ARM is big endian, or was it just a guess?
> 

>From byteorder.h:

#ifdef __ARMEB__
#include <linux/byteorder/big_endian.h>
#else
#include <linux/byteorder/little_endian.h>
#endif

So, yes, given no hints on who or what configures __ARMEB__.  Is it always little endian?
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
