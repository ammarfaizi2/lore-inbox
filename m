Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268253AbUIKRxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268253AbUIKRxO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUIKRxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:53:13 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:46690 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S268253AbUIKRvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:51:10 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [patch 1/1] uml-update-2.6.8-finish
Date: Sat, 11 Sep 2004 19:47:51 +0200
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040908173855.68F518D0B@zion.localdomain> <200409111740.12121.blaisorblade_spam@yahoo.it> <20040911181550.GA2966@ccure.user-mode-linux.org>
In-Reply-To: <20040911181550.GA2966@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409111947.51205.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 September 2004 20:15, Jeff Dike wrote:
> On Sat, Sep 11, 2004 at 05:40:12PM +0200, BlaisorBlade wrote:
> > And making it compile with the hash code, rather than the rb_tree one? I
> > know ghash.h must be removed, but there is no reason at all to switch to
> > Red-Black trees.

> It is not just that ghash.h be removed.  It is that its contents have
> to vanish.  That code shouldn't be anywhere.

Ok, if that is the reason it's ok. When I asked "Why remove it" I've been said 
"look at the code and you'll see why". Probably I'm blind, then. (And it can 
be true, because I'm somehow a new-comer in kernel hacking).
The "Fuzzy retrieval" is probably useless, clearly, but it's not clear to me 
the problem with the other code.

> There are good reasons to switch to rbtrees -
> 	I need some sort of low-O lookup
> 	there is no generic hash tree in the kernel
> 	rbtree is O(lg n) and it's generic
> 	rbtree is the only generic low-O lookup in the kernel that I see

Hmm, everything is true, apart that we need some generic lookup way. That can 
be true for now - using something means using something tested.

However, for the future, hashing is lower-O than rb-trees (if the hash 
function is good), but while an empty rb-tree requires no memory (just the 
root node), an hash requires anyway the table. That's the difference. And 
there is no generic hash struct because (I guess) the developer prefer it not 
to be generic - hashing is used for many things, but developed individually.

> I'm not in the fancy data structure business, so I'll stick with the
> infrastructure that I find in the pool already, and rbtree is about it.

> > Even because, later, we will just see "Hey, I get a panic here" +
> > backtrace.

> No, because currently there are no users of this.  We can get this tested
> when UML starts mmapping into its page cache.

Yes, and I meant at that moment.
> > Doing things right in first place is better.

> And inlining the grunge is right?

It would be stabler, if it has been tested. But since I guess ubd-mmap was the 
only tester, (and it did not work), it's ok to shift to rb-trees.

Also, I still don't have clear why it's a "grunge".
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
