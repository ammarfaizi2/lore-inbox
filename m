Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317628AbSHCRoJ>; Sat, 3 Aug 2002 13:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317627AbSHCRoJ>; Sat, 3 Aug 2002 13:44:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19463 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317628AbSHCRoI>; Sat, 3 Aug 2002 13:44:08 -0400
Date: Sat, 3 Aug 2002 10:35:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: davidm@hpl.hp.com, <davidm@napali.hpl.hp.com>, <gh@us.ibm.com>,
       <frankeh@watson.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd) 
In-Reply-To: <20020802.222024.21061449.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0208031027330.3981-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, David S. Miller wrote:
>
> Now here's the thing.  To me, we should be adding these superpage
> syscalls to things like the implementation of malloc() :-) If you
> allocate enough anonymous pages together, you should get a superpage
> in the TLB if that is easy to do.

For architectures that have these "small" superpages, we can just do it
transparently. That's what the alpha patches did.

The problem space is roughly the same as just page coloring.

> At that point it's like "why the system call".  If it would rather be
> more of a large-page reservation system than a "optimization hint"
> then these syscalls would sit better with me.  Currently I think they
> are superfluous.  To me the hint to use large-pages is a given :-)

Yup.

David, you did page coloring once.

I bet your patches worked reasonably well to color into 4 or 8 colors.

How well do you think something like your old patches would work if

 - you _require_ 1024 colors in order to get the TLB speedup on some
   hypothetical machine (the same hypothetical machine that might
   hypothetically run on 95% of all hardware ;)

 - the machine is under heavy load, and heavy load is exactly when you
   want this optimization to trigger.

Can you explain this difficulty to people?

> Stated another way, if these syscalls said "gimme large pages for this
> area and lock them into memory", this would be fine.  If the syscalls
> say "use large pages if you can", that's crap.  And in fact we could
> use mmap() attribute flags if we really thought that stating this was
> necessary.

I agree 100%.

I think we can at some point do the small cases completely transparently,
with no need for a new system call, and not even any new hint flags. We'll
just silently do 4/8-page superpages and be done with it. Programs don't
need to know about it to take advantage of better TLB usage.

			Linus

