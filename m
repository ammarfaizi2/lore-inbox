Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271819AbTGRUeD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 16:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271787AbTGRUbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 16:31:46 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:62177 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270373AbTGRUac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:30:32 -0400
X-AuthUser: davidel@xmailserver.org
Date: Fri, 18 Jul 2003 13:38:10 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Mike Galbraith <efault@gmx.de>
cc: Valdis.Kletnieks@vt.edu,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] O6int for interactivity 
In-Reply-To: <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net>
Message-ID: <Pine.LNX.4.55.0307181333520.5608@bigblue.dev.mcafeelabs.com>
References: <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net> <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <200307170030.25934.kernel@kolivas.org> <200307170030.25934.kernel@kolivas.org>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net> <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
 <5.2.1.1.2.20030718174433.01b12878@pop.gmx.net>
 <Pine.LNX.4.55.0307180951050.5608@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307181004200.5608@bigblue.dev.mcafeelabs.com>
 <200307181739.h6IHdFq3006996@turing-police.cc.vt.edu>
 <5.2.1.1.2.20030718221052.01a88eb8@pop.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003, Mike Galbraith wrote:

> >I'm sorry to say that guys, but I'm afraid it's what we have to do. We did
> >not think about it when this scheduler was dropped inside 2.5 sadly. The
> >interactivity concept is based on the fact that a particular class of
> >tasks characterized by certain sleep->burn patterns are never expired and
> >eventually, only oscillate between two (pretty high) priorities. Without
> >applying a global CPU throttle for interactive tasks, you can create a
> >small set of processes (like irman does) that hit the coded sleep->burn
> >pattern and that make everything is running with priority lower than the
> >lower of the two of the oscillation range, to almost completely starve.
> >Controlled unfairness would mean throttling the CPU time we reserve to
> >interactive tasks so that we always reserve a minimum time to non
> >interactive processes.
>
> I'd like to find a way to prevent that instead.  There's got to be a way.

Remember that this is computer science, that is, for every problem there
"at least" one solution ;)



> It's easy to prevent irman type things from starving others permanently (i
> call this active starvation, or wakeup starvation), and this does something
> fairly similar to what you're talking about.  Just crawl down the queue
> heads looking for the oldest task periodically instead of always taking the
> highest queue.  You can do that very fast, and it does prevent active
> starvation.

Everything that will make the scheduler to say "ok, I gave enough time to
interactive tasks, now I'm really going to spin one from the masses" will
work. Having a clean solution would not be an option here.




- Davide

