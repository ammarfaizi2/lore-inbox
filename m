Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbULQEY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbULQEY7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 23:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbULQEY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 23:24:59 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:52446 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262491AbULQEYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 23:24:48 -0500
Subject: Re: [patch] [RFC] make WANT_PAGE_VIRTUAL a config option
From: Dave Hansen <haveblue@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       geert@linux-m68k.org, ralf@linux-mips.org,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.61.0412170256500.793@scrub.home>
References: <E1Cf3bP-0002el-00@kernel.beaverton.ibm.com>
	 <Pine.LNX.4.61.0412170133560.793@scrub.home>
	 <1103244171.13614.2525.camel@localhost>
	 <Pine.LNX.4.61.0412170150080.793@scrub.home>
	 <1103246050.13614.2571.camel@localhost>
	 <Pine.LNX.4.61.0412170256500.793@scrub.home>
Content-Type: text/plain
Message-Id: <1103257482.13614.2817.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 16 Dec 2004 20:24:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 18:50, Roman Zippel wrote:
> On Thu, 16 Dec 2004, Dave Hansen wrote:
> > > Could you explain a bit more, what exactly the problem is?
> > The symptom is that you'll add some new function to a header, say
> > mmzone.h.  You get some kind of compile error that a structure that you
> > need is not fully defined (usually because it is predeclared "struct
> > foo;").  This happens when you do either a structure dereference on a
> > pointer, or do some other kind of pointer arithmetic on it outside of a
> > macro.
> 
> I know this problem and I hoped you would provide a complete header 
> dependency example.

Sorry I didn't provide this.  My recent effort started to clean up some
ugliness in some current patches that worked around this actually
happening a few months ago.  The original example didn't survive :)

> Anyway, I'm not against fixing this, I think that 
> you're starting somewhere in the middle.

I don't disagree.  But, I do think that getting the core
(include/linux/*) files to stop depending on architecture-specific ones
is a step.  Most other cleanups aren't as obviously correct, or have
such obviously limited impact.  So, I'm starting by patches that have
the least impact rather than actual bottom or top of the problem.

> I'd prefer to fix this problem at the core first, some time ago I posted a 
> few patches to separate out core data structures from the functions.

Especially with the vm headers, I have also seen quite a few
dependencies on simple macro variables.  I'd also like to see some
constant macro only files. 

> This 
> allows further cleanups, I just did a quick check with linux/mm.h and 
> easily reduced the dependencies by half. I need to update the patches 
> soon, so there are ready once 2.6.10 is out.

I'll eagerly await your post :)

> If you change the header dependencies, there is a big risk you break some 
> architecture, the current system is rather fragile. Moving a random 
> structure into a new header file doesn't always fix the problem, this 
> structure might still need some other definitions and so can pull in 
> different headers on every arch. Splitting a header is easy, getting the 
> whole thing working again in the end is the hard part.

The nice part about detecting and fixing these kinds of changes is that
they're not very subtle.  I'd much rather fix an include problem than an
SMP race any day :)

I certainly agree that their correct place for anything pervasive is in
the beginning of a development series.

-- Dave

