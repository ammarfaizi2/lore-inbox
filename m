Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268464AbUHYHOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268464AbUHYHOC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 03:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268480AbUHYHOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 03:14:02 -0400
Received: from mailsc1.simcon-mt.com ([195.27.129.236]:43807 "EHLO
	mailsc1.simcon-mt.com") by vger.kernel.org with ESMTP
	id S268464AbUHYHN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 03:13:59 -0400
Date: Wed, 25 Aug 2004 09:17:37 +0200
From: Andrei Voropaev <avorop@mail.ru>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: with 2.6.7 setitimer called in sequence returns strange values on i686
Message-ID: <20040825071737.GB5653@avorop.local>
References: <20040824144241.GE1527@avorop.local> <21011.1093360296@www48.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21011.1093360296@www48.gmx.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 05:11:36PM +0200, Michael Kerrisk wrote:
> Hello Andrei,
> 
> > Sorry if I'm taking your time away but to me it looks like I have kernel
> > problem, so I hoped to find some help in this list. I'm not subscribed
> > so please CC me on replies.
> > 
> > I'm using setitimer(ITIMER_REAL...) to measure time intervals.
> > Everything was working fine untill I've installed 2.6.7 kernel. 
> > 
> > bash$ uname -a
> > Linux avorop 2.6.7 #5 Thu Aug 19 11:53:33 CEST 2004 i686 unknown
> > 
> > Here's little piece of code that reproduces problem on my machine.
> 
> There's a little problem with your code.  You're not
> displaying microseconds correctly.  That "10.479" below should really 
> be "10.000479".  I suspect that that sort of small rounding error 
> (smaller than HZ) is probably acceptable, but someone else might 
> have some input on this point.
> 
> Cheers,
> 
> Michael
> 
> PS The use of pthreads in this program has no relevance to the 
> behaviour you are seeing -- I removed the pthread stuff and saw 
> the same results.

Yep. You are right. I just had some old testing program that I used with
2.4.21 and there I wanted to make sure that things work in pthread. So I
just reused it without removing pthread stuff.

This "small rounding error" crashes my application pretty nice. Because
my application assumes that when I call setitimer second time, then the
timer will be either the same or smaller, not bigger. And definetely no
man page mentions this sudden growth. Quite opposit, man page says that
the value is decremented.

At least now I know that it's reproduceble on other machines.

Andrei
