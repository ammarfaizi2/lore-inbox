Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261565AbTCOVLG>; Sat, 15 Mar 2003 16:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261569AbTCOVLG>; Sat, 15 Mar 2003 16:11:06 -0500
Received: from mx01.nexgo.de ([151.189.8.96]:35463 "EHLO mx01.nexgo.de")
	by vger.kernel.org with ESMTP id <S261565AbTCOVLB>;
	Sat, 15 Mar 2003 16:11:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Sat, 15 Mar 2003 22:25:40 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200303151502.h2FF2ai1002919@eeyore.valparaiso.cl>
In-Reply-To: <200303151502.h2FF2ai1002919@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030315212151.82D4F3DA8A@mx01.nexgo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 15 Mar 03 16:02, Horst von Brand wrote:
> Daniel Phillips <phillips@arcor.de> said:
>
> [...]
>
> > You confused semantic dependencies with structural dependencies that
> > govern whether or not deltas conflict in the reject sense.  Detailed
> > reply is off-list.
>
> In both cases hand fixup is needed. The "overlapping patch" partial order
> is a (small, or even very small) subset of the "depends on" partial order
> which you really want.

But it's a very irritating subset and much of the work involved can be 
handled automatically, so it should be.

> It would be nice to be able to get a much better
> approximation than "conflicting patch" automatically, but I fail to see
> how.

I suppose automatic syntactic analysis could be worked in there, or trial 
builds could be done automatically (check out how Visual Age aka Eclipse does 
it).  I'd put that in the "extra credit" category, and for starters I'd be 
entirely satisfied with:

  - Automatic handling of most structural conflicts, which would result
    in multiple possible deltas between two objects involved in a merge.
    These would be marked by the UI as "conflicts", and the system could
    helpfully point your editor at the relevant source texts.

  - Manual handling of semantic conflicts, but good support for navigating
    your editor to where the problems likely are (e.g., probably involves
    a changeset you recently merged).

> Giving dependencies by hand is a possibility,

Very useful, and not hard to do.

> but it will most of the
> time give as bad an approximation as the above (Do you really know _all_
> patches on which your latest and greatest depends?

You don't need to, you just provide a little help to the system.  When you 
don't provide enough help, you'll get extra compile/run errors, which isn't 
worse than what happens now.

Chances are, the same dependencies will carry over from version to version, 
so it's largely a one-time effort.  When you do put in a manual dependency, 
you can also put a notation on it, explaining why it's there in case that 
needs clarification.

> Some (or even most) of
> them will be old patches, that by now will be just part of the general
> landscape. And this can happen even with direct dependencies: Think of
> "disabling IRQs doesn't ensure mutual exclusion" or some such pervasive
> change that will affect a small part of any patch, and now move an old
> patch forward...).

Eventually, a changeset that the system is carrying forward could become 
moot, because it's unlikely ever to be backed out.  In that case, just merge 
it permanently and stop carrying it forward.  And if you happen to be wrong 
about needing to carry it forward, it just means you have to bring it forward 
from where you ended it.

Regards,

Daniel
