Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbVL2X4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVL2X4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 18:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbVL2X4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 18:56:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45023 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751161AbVL2X4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 18:56:10 -0500
Date: Thu, 29 Dec 2005 15:52:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: userspace breakage
In-Reply-To: <20051229232548.GT3811@stusta.de>
Message-ID: <Pine.LNX.4.64.0512291544310.3298@g5.osdl.org>
References: <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org>
 <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu>
 <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com>
 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <20051229224103.GF12056@redhat.com>
 <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org> <20051229232548.GT3811@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Dec 2005, Adrian Bunk wrote:
> > 
> > Now, I'm not saying that we can always support everything that goes on in 
> > user space forever, but dammit, we can try damn hard.
> 
> Was it a mistake to drop support for ipfwadm and ipchains?
> Was it a mistake to drop support for devsfs?
> Will it be a mistake to drop support for gcc < 3.2?

Those things at least were brewing for _years_. People had lots of 
heads-up warning.

> Will it be a mistake to remove the obsolete raw driver?
> Will it be a mistake to drop the Video4Linux API 1 ioctls?
> Will it be a mistake to drop support for pcmcia-cs?

And again, this is something that we've been warnign about. We have.

I'm not talking about never obsoleting bad interfaces at all. I'm talking 
about the unnecessary breakage that comes from changes that simply aren't 
needed, and that isn't given proper heads-up for. 

We used to have a fairly clear point where we could break things, when we 
had major kernel releases (ie 2.4 -> 2.6 broke the module loader. It was 
documented, and it was unavoidable). 

> The fundamental problem is that the current development model 
> contains no well-defined points where breakages of the kernel-related 
> userspace were allowed and expected by users.

The basic rule should be "never". For example, we now have three different 
generations of the "stat()" system call, and yes, we wrote the code to 
maintain all three interfaces. Breaking an old one for a new better one 
simply wasn't an option.

Now, the more specialized the usage is, the less strict the "never" 
becomes. But if something becomes a pain for distribution managers (and 
from Dave, it sounds like we've hit that way too often), that definitely 
means that we've broken too many things.

In short: I don't think anybody can complain about devfs-like things. 
We've kept it up for a _long_ time, and there was tons of help for the 
migration. But clearly DaveJ is unhappy, and that implies that we're not 
doing as well as we should.

(Which is not to say that we should necessarily bend over backwards to 
make sure that DaveJ is _never_ unhappy. We should just try harder).

			Linus
