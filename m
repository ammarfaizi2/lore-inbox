Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSGUTfu>; Sun, 21 Jul 2002 15:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSGUTfu>; Sun, 21 Jul 2002 15:35:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:48878 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S313181AbSGUTfu>; Sun, 21 Jul 2002 15:35:50 -0400
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
From: Robert Love <rml@tech9.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0207212111300.24336-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0207212111300.24336-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Jul 2002 12:38:54 -0700
Message-Id: <1027280334.1086.1027.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 12:14, Ingo Molnar wrote:
> 
> On Sun, 21 Jul 2002, Linus Torvalds wrote:
> 
> > This seems to have tons of stuff which makes it compile, but which is
> > just broken. Randomly changing "cli()" to "__cli()" apparently just to
> > make it compile, with no warning that its now buggy.
> 
> indeed ...
> 
> fixed these, and have categorized every change whether it's safe,
> known-unsafe or unknown-effect, and commented the latter two.

Good.

I have brought up a machine with a config similar but not identical to
yours and I am putting it through the paces (SMP+preempt machine).  I
really think you nailed this dead on - you did it right - we just need
to clean up the mess you left behind ;)

Ingo, looking over the FIXMEs in the tty layer I think they are
definitely _broke_.  At least some of these paths have no global
synchronization now.  Someone really needs to go through this cruft and
clean it up and do some proper locking.

	Robert Love

