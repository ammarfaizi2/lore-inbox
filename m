Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbSLIIqM>; Mon, 9 Dec 2002 03:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSLIIqL>; Mon, 9 Dec 2002 03:46:11 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:51896 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264690AbSLIIqK>; Mon, 9 Dec 2002 03:46:10 -0500
Date: Mon, 9 Dec 2002 03:53:47 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: george anzinger <george@mvista.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] High-res-timers part 1 (core) take 20
Message-ID: <20021209035347.C12524@devserv.devel.redhat.com>
References: <3DF2F8D9.6CA4DC85@mvista.com> <1039341009.1483.3.camel@laptop.fenrus.com> <3DF44031.58A12F66@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DF44031.58A12F66@mvista.com>; from george@mvista.com on Sun, Dec 08, 2002 at 11:03:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 11:03:13PM -0800, george anzinger wrote:
> Arjan van de Ven wrote:
> > 
> > On Sun, 2002-12-08 at 08:46, george anzinger wrote:
> > 
> > > +/*
> > > + * Here is an SMP helping macro...
> > > + */
> > > +#ifdef CONFIG_SMP
> > > +#define IF_SMP(a) a
> > > +#else
> > > +#define IF_SMP(a)
> > > +#endif
> > 
> > ehmmmmm personally I would consider any need of this ugly and evil
> > 
> > > +     IF_SMP(if (old_base && (new_base != old_base))
> > > +            spin_unlock(&old_base->lock);
> > > +             )
> > 
> > Like here..... SMP dependent ifdef's of spinlock usage... shudder
> > 
> Well it does seem like a waste to do spinlock ordering code
> on a UP system...

that's why spinlocks are effectively nops on UP.
What you say is true of just about every spinlock user, and no
they shouldn't all do some IF_SMP() thing; the spinlock itself should be
(and is) zero on UP
