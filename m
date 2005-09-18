Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbVIRRbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbVIRRbx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 13:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVIRRbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 13:31:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20126 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932131AbVIRRbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 13:31:52 -0400
Date: Sun, 18 Sep 2005 10:31:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Willy Tarreau <willy@w.ods.org>, Robert Love <rml@novell.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: p = kmalloc(sizeof(*p), )
In-Reply-To: <20050918171845.GL19626@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0509181028140.26803@g5.osdl.org>
References: <20050918100627.GA16007@flint.arm.linux.org.uk>
 <1127061146.6939.6.camel@phantasy> <20050918165219.GA595@alpha.home.local>
 <20050918171845.GL19626@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Sep 2005, Al Viro wrote:
> 
> That's why you do
> 	*p = (struct foo){....};
> instead of
> 	memset(p, 0, sizeof...);
> 	p->... =...;

Actually, some day that migth be a good idea, but at least historically, 
gcc has really really messed that kind of code up.

Last I looked, depending on what the initializer was, gcc would create a 
temporary struct on the stack first, and then do a "memcpy()" of the 
result. Not only does that obviously generate a lot of extra code, it also 
blows your kernel stack to kingdom come.

So be careful out there, and check what code it generates first. With at 
least a few versions of gcc.

(For _small_ structures it's wonderful. As far as I can tell, gcc does a
pretty good job on structs that are just a single long-word in size).

		Linus
