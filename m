Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVITPOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVITPOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 11:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVITPOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 11:14:20 -0400
Received: from xenotime.net ([66.160.160.81]:33178 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964952AbVITPOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 11:14:19 -0400
Date: Tue, 20 Sep 2005 08:14:18 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
cc: Al Viro <viro@ftp.linux.org.uk>, Robert Love <rml@novell.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
In-Reply-To: <Pine.LNX.4.58.0509201245340.32086@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.58.0509200809430.22777@shark.he.net>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
 <1127061146.6939.6.camel@phantasy> <84144f020509200153f0becf2@mail.gmail.com>
 <20050920093953.GM7992@ftp.linux.org.uk> <Pine.LNX.4.58.0509201245340.32086@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2005, Pekka J Enberg wrote:

> On Tue, 20 Sep 2005, Al Viro wrote:
>
> > On Tue, Sep 20, 2005 at 11:53:42AM +0300, Pekka Enberg wrote:
> > > On 9/18/05, Robert Love <rml@novell.com> wrote:
> > > > 5.  Contrary to the above statement, such coding style does not help,
> > > >     but in fact hurts, readability.  How on Earth is sizeof(*p) more
> > > >     readable and information-rich than sizeof(struct foo)?  It looks
> > > >     like the remains of a 5,000 year old wolverine's spleen and
> > > >     conveys no information about the type of the object that is being
> > > >     created.
> > >
> > > Yes it does. The semantics are clearly "I want enough memory to hold
> > > the type this pointer points to." While sizeof(struct foo) might seem
> > > more readable, it is in fact not as you have no way of knowing whether
> > > the allocation is correct or not by looking at the line. So for
> > > spotting allocation errors with grep, the shorter form is better (and
> > > arguably less error-prone).
> >
> > Huh???   How do you use grep to find something of that sort?
>
> To find candidates, something like:
>
> grep "kmalloc(sizeof([^*]" -r drivers/ | grep -v "sizeof(struct"
>
> And then use my eyes to find real bugs.

ugh.

I guess I'm old-fashioned:  I think that the real answer is
to do the due diligence when making a patch.  Don't assume
that you/I/we can make a one-line change without checking
around/above/below it, where it's declared, allocated, etc.

I once worked with someone whose attitude was to "let the
compiler find all of the problems," so he threw quite the
garbage at it and iterated until the compiler no longer
complained.  I think that's the wrong way to do it, but
maybe it was his version of release early, release often.

-- 
~Randy
