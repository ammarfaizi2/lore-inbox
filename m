Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269731AbTGKAs0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 20:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269734AbTGKAsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 20:48:25 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:38820 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S269731AbTGKAsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 20:48:17 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: 2.5.74-mm1
Date: Fri, 11 Jul 2003 03:04:11 +0200
User-Agent: KMail/1.5.2
Cc: Jamie Lokier <jamie@shareable.org>,
       Davide Libenzi <davidel@xmailserver.org>, Mel Gorman <mel@csn.ul.ie>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
References: <20030703023714.55d13934.akpm@osdl.org> <200307100059.57398.phillips@arcor.de> <16140.51447.73888.717087@wombat.chubb.wattle.id.au>
In-Reply-To: <16140.51447.73888.717087@wombat.chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307110304.11216.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 04:01, Peter Chubb wrote:
> I suspect that what's really wanted here is not SCHED_RR but
> guaranteed rate-of-forward progress.

I suspect you are right.  I'd also like to note that this is ground so 
thoroughly trodden that the grass is flat.  Realtime schedulers are a well 
researched topic, it's just too bad that committees don't design them as well 
as engineers would.

Thinking strictly about the needs of sound processing, what's needed is a 
guarantee of so much cpu time each time the timer fires, and a user limit to 
prevent cpu hogging.  It's worth pondering the difference between that and 
rate-of-forward-progress.  I suspect some simple improvements to the current 
scheduler can be made to do the job, and at the same time, avoid the 
priorty-based starvation issue that seems to have been practically mandated 
by POSIX.

> A dynamic-window-constrained
> scheduler (that guarantees not that you'll run until you sleep, but
> that in any (settable) time period you'll get the opportunity to run
> for at least (a smaller settable period)) is closer to what's wanted.

It's possible that may be equivalent to what I said :-)

> See http://www.cs.bu.edu/fac/richwest/dwcs.html

This is an interesting link.  One of the design rules has to be that O(1) 
performance is never degraded, at least when there are no realtime processes.  
Also, I want to be clear that I'm not suggesting this sort of thing has 
anything to do with the current cycle, unless tweaking of the incumbent 
sheduler fails for some reason, which it seems unlikely to do.

Regards,

Daniel
>
> --
> Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
> You are lost in a maze of BitKeeper repositories,   all slightly different.

