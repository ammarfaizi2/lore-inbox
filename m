Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbUDUEbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUDUEbb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 00:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264794AbUDUEbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 00:31:31 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:21775 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263000AbUDUEbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 00:31:24 -0400
Date: Mon, 19 Apr 2004 11:39:50 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: bitmap, cpumask_arith (was: 2.6.6-rc1-mm1)
Message-Id: <20040419113950.6f34f435.pj@sgi.com>
In-Reply-To: <20040419070643.GG743@holomorphy.com>
References: <20040418230131.285aa8ae.akpm@osdl.org>
	<20040419062914.GE743@holomorphy.com>
	<20040418234214.7bfb5392.akpm@osdl.org>
	<20040419064943.GF743@holomorphy.com>
	<20040419070643.GG743@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok ... lets see here.

This message is in reply to 4 messages from Bill Irwin, dated:
  Sat, 17 Apr 2004 19:26:38 -0700
  Sun, 18 Apr 2004 23:29:14 -0700
  Sun, 18 Apr 2004 23:49:43 -0700
  Mon, 19 Apr 2004 00:06:43 -0700


> I'm having enough trouble remembering what Paul Jackson's take on things

My take was that in my work-in-progress bitmap/cpumask patches, I have:

  1) Slightly strengthened the constraints (post-conditions) on
     bitmap ops to not set tail bits so long as none were set on
     input.  This mostly means that the complement operator zeros
     out the tail.  The operators that return scalar (weight,
     for example) or boolean (empty and full, for example) are
     still careful to avoid depending on the state of the tail.

     This changes Bill Irwin's "don't care" rule into a "don't
     care, but don't pollute further" rule.

  2) Removed cpumask_arith entirely, along with 30 odd other files,
     to be replaced by a single cpumask.h set of macros, layered
     rather thinly on top of bitmap/bitop.


> The important aspect of these is that they're pertinent to small SMP
> systems, ...

I tried making this point before, but failed to communicate.  Let me try
again.  So far as I know, there is no instance in current Linux kernel
code using this cpumask facility that is affected (currently broken) by
the cpumask_arith bugs addressed by Bill's patch.  Do you know of any
breakage in other _current_ code caused by these cpumask_arith bugs,
Bill?

As a consequence of my seeing nothing else yet overtly busted by this,
it was, and remains, my recommendation to Bill to hold off on these
patches.  Little sense in correcting the semantics of a piece of code
that I expected to remove shortly anyway, if nothing else cared for now.

However, I realize that Bill takes considerable pride in his work, and
would like to see this fixed.  It's not worth a big fuss, either way,
so far as I can tell.


> Paul, please remove akpm from the cc: list

I have removed akpm from this reply.


> the users of small SMP systems who are affected by the bug(s) you
> reported.

I am unaware that any user of any small SMP (or other) system
is affected by these bugs.


> If you could review and/or send approval or the like that would be
> very helpful ...

If we can agree on the actual state of affairs, then I will readily
agree to such to Andrew, and let him decide on the merits and
appropriate timing of this patch.

>From what I know now, this would mean telling Andrew, of Bill's patch:

  This patch fixes some bugs in the small SMP system (2 to 32 CPU) flavor
  of cpumasks.  From what we know now, these bugs aren't breaking any
  other existing code, but they are an accident waiting to happen.
  If Paul Jackson's bitmap/cpumask rework is adapted in the future,
  then this code being patched would be replaced anyway.  But for now,
  these fixes are a definite improvement.

If this does not seem like a correct statement of affairs, lets hash
that out.  Then when we agree, you should present your patch to him on
the lkml again, and I will gladly chime in with my endorsement.

Unless, of course, you change your mind and decide to hold off on this
patch, to which I would even more readily agree <grin>.


> I have taken issue only where I believe you need to acquire arch
> maintainer feedback.

And I have agreed that this is an excellent request.  I was out on
vacation last week, and hesitated to start the arch maintainer discussion
the week before, knowing that I would be on vacation, and not wanting to
start something I would not be around to follow through on.

But I am back now, and expect later this week to begin that discussion,
as you have recommended.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
