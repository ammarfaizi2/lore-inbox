Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbSLIMUo>; Mon, 9 Dec 2002 07:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbSLIMUn>; Mon, 9 Dec 2002 07:20:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:27642 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265378AbSLIMUm>;
	Mon, 9 Dec 2002 07:20:42 -0500
Message-ID: <3DF48C4C.3F056661@mvista.com>
Date: Mon, 09 Dec 2002 04:27:56 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 20
References: <3DF2F8D9.6CA4DC85@mvista.com> <1039341009.1483.3.camel@laptop.fenrus.com> <3DF44031.58A12F66@mvista.com> <20021209035347.C12524@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> On Sun, Dec 08, 2002 at 11:03:13PM -0800, george anzinger wrote:
> > Arjan van de Ven wrote:
> > >
> > > On Sun, 2002-12-08 at 08:46, george anzinger wrote:
> > >
> > > > +/*
> > > > + * Here is an SMP helping macro...
> > > > + */
> > > > +#ifdef CONFIG_SMP
> > > > +#define IF_SMP(a) a
> > > > +#else
> > > > +#define IF_SMP(a)
> > > > +#endif
> > >
> > > ehmmmmm personally I would consider any need of this ugly and evil
> > >
> > > > +     IF_SMP(if (old_base && (new_base != old_base))
> > > > +            spin_unlock(&old_base->lock);
> > > > +             )
> > >
> > > Like here..... SMP dependent ifdef's of spinlock usage... shudder
> > >
> > Well it does seem like a waste to do spinlock ordering code
> > on a UP system...
> 
> that's why spinlocks are effectively nops on UP.
> What you say is true of just about every spinlock user, and no
> they shouldn't all do some IF_SMP() thing; the spinlock itself should be
> (and is) zero on UP

But with preemption, they really are not nops on UP...
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
