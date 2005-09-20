Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbVITJxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbVITJxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 05:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVITJxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 05:53:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:14302 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964951AbVITJxy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 05:53:54 -0400
Date: Tue, 20 Sep 2005 10:53:52 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Robert Love <rml@novell.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050920095352.GN7992@ftp.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127061146.6939.6.camel@phantasy> <84144f020509200153f0becf2@mail.gmail.com> <20050920093953.GM7992@ftp.linux.org.uk> <Pine.LNX.4.58.0509201245340.32086@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509201245340.32086@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 12:47:32PM +0300, Pekka J Enberg wrote:
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

"grep for kmallocs that do not have _either_ form and look for bugs among
them" is hardly usable as an argument in favour of one of them...
