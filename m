Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264484AbUFJELP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUFJELP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 00:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUFJELP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 00:11:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:12738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264484AbUFJELN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 00:11:13 -0400
Date: Wed, 9 Jun 2004 21:10:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
cc: Al Viro <viro@math.psu.edu>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
In-Reply-To: <1086838266.32059.320.camel@dooby.cs.berkeley.edu>
Message-ID: <Pine.LNX.4.58.0406092059030.2050@ppc970.osdl.org>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jun 2004, Robert T. Johnson wrote:
> 
> Despite that, I found numerous bugs in seven drivers.  Only one of these
> drivers had any __user annotations, so sparse isn't able to provide any
> meaningful results on these source files yet.  Even worse, sparse missed
> bugs in drivers/usb/core/devio.c:proc_control() even though that
> function has been annotated (this is not the first time cqual has found
> bugs in code audited by sparse). 

Hmm.. That code has not been sparse-cleaned up, and as of today sparse 
gives 34 lines of warnings for that file. I assume the two you refer to is

	drivers/usb/core/devio.c:561:40: warning: cast removes address space of expression
	drivers/usb/core/devio.c:581:39: warning: cast removes address space of expression

and I assume those are the ones your thing finds too?

So I wanted to point out that sparse hasn't missed anything. It's just 
that the USB people haven't fixed the things it has found yet ;)

>			  I didn't write any annotations in any
> driver files -- just a few header files under include.  I've already
> submitted patches to fix these bugs.  This is 1 1/2 days work, with
> _very_ incomplete annotations.

And part of the reason I much prefer the sparse approach of doing proper C 
types is that it's (a) the C way and (b) it documents what is up.

What we do NOT want to have is to continue with these "implied rules". 
That's what caused the bugs in the first place. I really want the user 
pointers to be _explicit_, because not only does that mean that a stupid 
tool can figure it out with purely "local" knowledge, but more 
importantly, it means that a _programmer_ can figure it out with purely 
local knowledge.

Now, I'm obviously biased, and hey, two tools are better than one. I just 
wanted to point out that your claim that "sparse missed bugs" just isn't 
true. What _is_ true is that there is quite a bit of non-fixed code out 
there.

		Linus
