Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265569AbUEZMvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265569AbUEZMvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265568AbUEZMvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:51:03 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:28329 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265569AbUEZMup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:50:45 -0400
Date: Wed, 26 May 2004 14:50:14 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040526125014.GE12142@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040526103303.GA7008@elte.hu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2004 12:33:03 +0200, Ingo Molnar wrote:
> * Andrea Arcangeli <andrea@suse.de> wrote:
> > On Tue, May 25, 2004 at 04:10:29PM -0400, Rik van Riel wrote:
> > > Fragmentation causes fork trouble (gone with the 4k stacks)
> > 
> > btw, the 4k stacks sounds not safe to me, most people only tested with
> > 8k stacks so far, I wouldn't make that change in a production tree
> > without an unstable cycle of testing in between. I'd rather risk a an
> > allocation failure than a stack memory corruption.
> 
> 4k stacks is a cool and useful feature and tons of effort that went into
> making them as safe as possible. Sure, we couldnt fix up bin-only
> modules, but all the kernel drivers are audited for stack footprint, and
> many months of beta testing has gone into this as well. Anyway, if you
> prefer you can turn on 8k stacks - especially if you tree has lots of
> not-yet-upstream driver patches.
> 
> > x86-64 has per-irq stacks that allowed to reduce the stack size to 8k
> > (which is very similar to 4k for an x86, but without per-irq stack
> > it's too risky).
> 
> do you realize that the 4K stacks feature also adds a separate softirq
> and a separate hardirq stack? So the maximum footprint is 4K+4K+4K, with
> a clear and sane limit for each type of context, while the 2.4 kernel
> has 6.5K for all 3 contexts combined. (Also, in 2.4 irq contexts pretty
> much assumed that there's 2K of stack for them - leaving a de-facto 4K
> stack for the process and softirq contexts.) So in fact there is more
> space in 2.6 for all, and i dont really understand your fears.

Experience indicates that for whatever reason, big stack consumers for
all three contexts never hit at the same time.  Big stack consumers
for one context happen too often, though.  "Too often" may be quite
rare, but considering the result of a stack overflow, even "quite
rare" is too much.  "Never" is the only acceptable target.

Change gcc to catch stack overflows before the fact and disallow
module load unless modules have those checks as well.  If that is
done, a stack overflow will merely cause a kernel panic.  Until then,
I am just as conservative as Andreas.

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
