Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263398AbTHBMrI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 08:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTHBMrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 08:47:08 -0400
Received: from [66.212.224.118] ([66.212.224.118]:3076 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S263398AbTHBMrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 08:47:05 -0400
Date: Sat, 2 Aug 2003 08:35:22 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@osdl.org>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/2] random: SMP locking
In-Reply-To: <20030802040015.0fcafda2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0308020832520.3473@montezuma.mastecende.com>
References: <20030802042445.GD22824@waste.org> <20030802040015.0fcafda2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Aug 2003, Andrew Morton wrote:

> Oliver Xymoron <oxymoron@waste.org> wrote:
> >
> > This patch adds locking for SMP. Apparently Willy never managed to
> > revive his laptop with his version so I revived mine.
> 
> hrm.  I'm a random ignoramus.   I'll look it over...
> 
> Are you really sure that all the decisions about where to use spin_lock()
> vs spin_lock_irq() vs spin_lock_irqsave() are correct?  They are
> non-obvious.
> 
> > @@ -1619,18 +1660,23 @@
> >  		if (!capable(CAP_SYS_ADMIN))
> >  			return -EPERM;
> >  		p = (int *) arg;
> > +		spin_lock(&random_state->lock);
> >  		ent_count = random_state->entropy_count;
> >  		if (put_user(ent_count, p++) ||
> >  		    get_user(size, p) ||
> >  		    put_user(random_state->poolinfo.poolwords, p++))
> 
> Cannot perform userspace access while holding a lock - a pagefault could
> occur, perform IO, schedule away and the same CPU tries to take the same
> lock via a different process.

Perhaps might_sleep() in *_user, copy_* etc is in order?

-- 
function.linuxpower.ca
