Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261482AbRFAUa7>; Fri, 1 Jun 2001 16:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbRFAUaj>; Fri, 1 Jun 2001 16:30:39 -0400
Received: from front8.grolier.fr ([194.158.96.58]:63959 "EHLO
	front8.grolier.fr") by vger.kernel.org with ESMTP
	id <S261482AbRFAUag> convert rfc822-to-8bit; Fri, 1 Jun 2001 16:30:36 -0400
Date: Fri, 1 Jun 2001 19:18:38 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@club-internet.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Tim Hockin <thockin@sun.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alan@redhat.com
Subject: Re: [PATCH] sym53c8xx timer and smp fixes
In-Reply-To: <3B174E97.60DAA03E@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10106011849120.1769-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Jun 2001, Jeff Garzik wrote:

> Tim Hockin wrote:
> >  spinlock_t sym53c8xx_lock = SPIN_LOCK_UNLOCKED;
> > +spinlock_t sym53c8xx_host_lock = SPIN_LOCK_UNLOCKED;
> >  #define        NCR_LOCK_DRIVER(flags)     spin_lock_irqsave(&sym53c8xx_lock, flags)
> >  #define        NCR_UNLOCK_DRIVER(flags)   spin_unlock_irqrestore(&sym53c8xx_lock,flags)
> > +#define        NCR_LOCK_HOSTS(flags)     spin_lock_irqsave(&sym53c8xx_host_lock, flags)
> > +#define        NCR_UNLOCK_HOSTS(flags)   spin_unlock_irqrestore(&sym53c8xx_host_lock,flags)
> > 
> >  #define NCR_INIT_LOCK_NCB(np)      spin_lock_init(&np->smp_lock);
> >  #define        NCR_LOCK_NCB(np, flags)    spin_lock_irqsave(&np->smp_lock, flags)
> > @@ -650,6 +655,8 @@
> > 
> >  #define        NCR_LOCK_DRIVER(flags)     do { save_flags(flags); cli(); } while (0)
> >  #define        NCR_UNLOCK_DRIVER(flags)   do { restore_flags(flags); } while (0)
> > +#define        NCR_LOCK_HOSTS(flags)     do { save_flags(flags); cli(); } while (0)
> > +#define        NCR_UNLOCK_HOSTS(flags)   do { restore_flags(flags); } while (0)
> > 
> >  #define        NCR_INIT_LOCK_NCB(np)      do { } while (0)
> >  #define        NCR_LOCK_NCB(np, flags)    do { save_flags(flags); cli(); } while (0)
> > @@ -695,7 +702,7 @@
> 
> so, this driver is mixed spinlocks and save/restore_flags?  Any chance
> this can be converted to all spinlocks?

This has been done years ago for linux 2.1.93.
The save/restore flags locking methods are conditionnaly compiled for
earlier kernels. This makes the corresponding code very probably quite
useless nowadays and I should remove it from the source.

  Gérard.

