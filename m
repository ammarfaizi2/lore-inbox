Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290500AbSA3Tn0>; Wed, 30 Jan 2002 14:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290504AbSA3TnT>; Wed, 30 Jan 2002 14:43:19 -0500
Received: from waste.org ([209.173.204.2]:2756 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S290500AbSA3TnN>;
	Wed, 30 Jan 2002 14:43:13 -0500
Date: Wed, 30 Jan 2002 13:43:09 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] per-cpu areas for 2.5.3-pre6 
In-Reply-To: <Pine.LNX.4.44.0201292328530.25123-100000@waste.org>
Message-ID: <Pine.LNX.4.44.0201301259520.11802-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Oliver Xymoron wrote:

> On Wed, 30 Jan 2002, Rusty Russell wrote:
>
> > In message <Pine.LNX.4.44.0201291813110.25443-100000@waste.org> you write:
> >
> > > Nearly as good would be replacing the current logic for figuring out the
> > > current processor id through current with logic to access the per-cpu
> > > data. The primary use of that id is indexing that data anyway.
> >
> > And if you'd been reading this thread, you would have already seen
> > this idea, and if you'd read the x86 code, you'd have realised that
> > the tradeoff is arch-specific.
>
> Looking closer, I've found an issue with your patch related to the above,
> so I think it bears closer examination.

Looking closer again (and not at 1am), I see I missed this line in reading
your patch, sorry:

+#define this_cpu(var)	per_cpu(var,smp_processor_id())

I still think that tracking per_cpu_offset in task struct to eventually
replace current->processor is a win. Basically everyone except Sparc goes
through current anyway for smp_processor_id and Sparc caches current in a
register. Please elucidate your reference to "arch-specific tradeoffs".

Also, it'd be nice to unmap the original copy of the area or at least
poison it to catch silent references to var without going through
this_cpu, which will probably prove very hard to find. If there were a way
to do this at the C source level and catch such things at compile time,
that'd be even better, but I can't see a way to do it without grotty
macros.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

