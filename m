Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbTJYWfy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 18:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbTJYWfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 18:35:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:9178 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262769AbTJYWfv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 18:35:51 -0400
Date: Sat, 25 Oct 2003 15:35:47 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test9
In-Reply-To: <20031025201427.GT7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0310251521360.4083-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 25 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Hmm...  Do you count the stuff like "driver foo dereferences after
> kfree()" as major when fix is to reorder two consequent lines in said
> driver?

The smaller and more obvious the change is, the less critical the bug has 
to be.

If it's a really unlikely bug, and fixing it requires some fundamental 
changes, I consider the fix to be potentially more dangerous than the bug. 
But if the fix is re-ordering two lines in really obvious ways, and the 
bug itself is potentially nasty, the fix obviously goes in.

It's a matter of balancing the potential downside of a fix (which is 
unknown, but tends to be relative to how big the patch is) with the 
benefits (which should be known).

> Proposed rules:
> 	a) all changes must be local and separate.  Anything that affects
> more than one place is either splittable, in which case it's more than
> one change, or doesn't belong there.
> 	b) chunks stay separate until they go into the main tree.  IOW,
> they are fed one by one (when merges are OK) and they become separate
> changesets.
> 	c) all chunks must be mergable into -STABLE.  IOW, the rules are
> the same as for 2.6.1 - as far as merging into that tree is concerned,
> we are not in -RC anymore.

Yes, but at this point I actually want to be _more_ strict that just (c).

There are things that I bet Andrew will be willing to apply to -STABLE:  
things like architecture updates etc that clearly fix stuff. But right now
I want to avoid even that kind of noise: if it doesn't clearly help
_testing_ of stability, I'm just not interested at this point.

So for example, in the last week I just dropped some S390 updates without
even looking at them. It was too late - and even if they fix bugs, I don't
see that applying those patches simply would matter for 2.6.0 any more.  

So for example: I am pretty happy with how the size of the -test8 and 
-test9 patches have been shrinking, but even -test9 was big enough that I 
couldn't say that we're clearly "asymptotically approaching a stable 
kernel". At some point "noise patches" are bad if only because they make 
it less clear what the general status of the tree is.

In particular, if the 2.6.0-test10 patch is just 30kB compressed, and I
can just page through it with "less" and see that every single small part
of the patch was pretty clear and not something really scary, I'll be a
_lot_ happier about passing the thing off to Andrew. In contrast, if the
patch is full of stuff that isn't really obvious, I'm going to be less
happy, and worry more about what the side effects are.

		Linus

