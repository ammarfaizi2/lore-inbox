Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVDVCzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVDVCzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 22:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbVDVCzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 22:55:08 -0400
Received: from pop.gmx.net ([213.165.64.20]:10218 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261927AbVDVCzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 22:55:03 -0400
X-Authenticated: #271361
Date: Fri, 22 Apr 2005 04:54:59 +0200
From: Edgar Toernig <froese@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Friesen <cfriesen@nortel.com>, Steven Rostedt <rostedt@goodmis.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, jdavis@accessline.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bad rounding in timeval_to_jiffies [was: Re: Odd Timer
 behavior in 2.6 vs 2.4  (1 extra tick)]
Message-Id: <20050422045459.37fb6c41.froese@gmx.de>
In-Reply-To: <Pine.LNX.4.58.0504210904450.2344@ppc970.osdl.org>
References: <E29E71BB437ED411B12A0008C7CF755B2BC9BE@mail.accessline.com>
	<1114052315.5058.13.camel@localhost.localdomain>
	<1114054816.5996.10.camel@localhost.localdomain>
	<20050421095109.A25431@flint.arm.linux.org.uk>
	<1114080708.5996.16.camel@localhost.localdomain>
	<Pine.LNX.4.58.0504210752560.2344@ppc970.osdl.org>
	<4267CC7C.10907@nortel.com>
	<Pine.LNX.4.58.0504210904450.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2005, Chris Friesen wrote:
>
> Does mainline have a high precision monotonic wallclock that is not 
> affected by time-of-day changes?  Something like "nano/mico seconds 
> since boot"?

On newer kernels with the posix timers (I think 2.6 - not sure though)
there's clock_gettime(CLOCK_MONOTONIC, ...).

Linus Torvalds wrote:
>
> Getting "approximate uptime" really really _really_ fast
> might be useful for some things, but I don't know how many.

I bet most users of gettimeofday actually want a strictly monotonic
increasing clock where the actual base time is irrelevant.  Just strace
some apps - those issuing hundreds and thousands of gettimeofday calls
are most likely in this class.  Those who only call gettimeofday once
or twice or the ones that really want the wall clock time.

How often does the kernel use jiffies (the monotonic clock) and how often
xtime (the wall clock)?

Ciao, ET.
