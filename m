Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTIAQr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 12:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTIAQr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 12:47:29 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:10738
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S263017AbTIAQrX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 12:47:23 -0400
Date: Mon, 1 Sep 2003 16:16:44 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Robert Love <rml@tech9.net>, Ian Kumlien <pomac@vapor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [SHED] Questions.
Message-ID: <20030901141644.GA2359@wind.cocodriloo.com>
References: <1062324435.9959.56.camel@big.pomac.com> <1062369684.9959.166.camel@big.pomac.com> <1062373274.1313.28.camel@boobies.awol.org> <200309011707.20135.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309011707.20135.phillips@arcor.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 05:07:19PM +0200, Daniel Phillips wrote:
> On Monday 01 September 2003 01:41, Robert Love wrote:
> > Once a task "expires" (exhausts its timeslice), it will not run again
> > until all other tasks, even those of a lower priority, exhaust their
> > timeslice.
> >
> > ...
> >
> > Priority inversion is bad, but the priority inversion in this case is
> > intended.  Higher priority tasks cannot starve lower ones.  It is a
> > classic Unix philosophy that 'all tasks make some forward progress'
> 
> So if I have 1000 low priority tasks and one high priority task, all CPU 
> bound, the high priority task gets 0.1% CPU.  This is not the desirable or 
> expected behaviour.
> 
> My conclusion is, the strategy of expiring the whole active array before any 
> expired tasks are allowed to run again is incorrect.  Instead, each active 
> list should be refreshed from the expired list individually.  This does not 

AFAIK, this could be implemented with a "list swap" operation, taking
the list head for one priority and exchanging them between expired and
active, or perhaps more properly, taking the expired list and adding it
to the end of the active one. This would be O(1) since the task list for
each priority is double-linked and thus has a "last element" pointer on
the list header.

> affect the desirable O(1) scheduling property.  To prevent low priority 
> starvation, the high-to-low scan should be elaborated to skip some runnable, 
> high priority tasks occasionally in a *controlled* way.

Perhaps this could be done with a random but skewed proportion, similar
to the way you select the level to insert into on the "skip list"
datastructure.
 
> IMHO, this minor change will provide a more solid, predictable base for Con 
> and Nick's dynamic priority and dynamic timeslice experiments.
> 
> Regards,
> 
> Daniel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
winden/network

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
