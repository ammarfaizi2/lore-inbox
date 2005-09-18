Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbVIRRpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVIRRpx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 13:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVIRRpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 13:45:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30917 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932139AbVIRRpw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 13:45:52 -0400
Date: Sun, 18 Sep 2005 18:45:49 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Willy Tarreau <willy@w.ods.org>, Robert Love <rml@novell.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: p = kmalloc(sizeof(*p), )
Message-ID: <20050918174549.GN19626@ftp.linux.org.uk>
References: <20050918100627.GA16007@flint.arm.linux.org.uk> <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local> <20050918171845.GL19626@ftp.linux.org.uk> <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2005 at 10:31:36AM -0700, Linus Torvalds wrote:
> 
> 
> On Sun, 18 Sep 2005, Al Viro wrote:
> > 
> > That's why you do
> > 	*p = (struct foo){....};
> > instead of
> > 	memset(p, 0, sizeof...);
> > 	p->... =...;
> 
> Actually, some day that migth be a good idea, but at least historically, 
> gcc has really really messed that kind of code up.
> 
> Last I looked, depending on what the initializer was, gcc would create a 
> temporary struct on the stack first, and then do a "memcpy()" of the 
> result. Not only does that obviously generate a lot of extra code, it also 
> blows your kernel stack to kingdom come.

Ewwwww...  I'd say that it qualifies as one hell of a bug (and yes, at least
3.3 and 4.0.1 are still doing that).  What a mess...
 
> (For _small_ structures it's wonderful. As far as I can tell, gcc does a
> pretty good job on structs that are just a single long-word in size).
