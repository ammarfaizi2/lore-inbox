Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261542AbTI3Opr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 10:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbTI3Opq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 10:45:46 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:2694 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261542AbTI3Opo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 10:45:44 -0400
Date: Tue, 30 Sep 2003 15:45:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Dave Jones <davej@redhat.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, richard.brunner@amd.com
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
Message-ID: <20030930144526.GC28876@mail.shareable.org>
References: <20030930073814.GA26649@mail.jlokier.co.uk> <20030930132211.GA23333@redhat.com> <20030930133936.GA28876@mail.shareable.org> <20030930135324.GC5507@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930135324.GC5507@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Sep 30, 2003 at 02:39:36PM +0100, Jamie Lokier wrote:
>  > Dave Jones wrote:
>  > > This looks to be completely gratuitous. Why disable it when we have the
>  > > ability to work around it ?
>  > 
>  > Because some people expressed a wish to have kernels that don't
>  > contain the workaround code, be they P4-optimised or 486-optimised
>  > kernels.
> 
> And those people are wrong. If they want to save bloat, instead of
> 'fixing' things by removing <1 page of .text, how about working on
> some of the real problems like shrinking some of the growth of various
> data structures that actually *matter*.

How about both?

> The "I don't want Athlon code in my kernel because I run a P4 and
> it makes it slow/bigger" argument is totally bogus. It's akin to
> the gentoo-esque "I compiled my distro with -march=p4 and now
> my /bin/ls is faster than yours" argument.

I'm talking about people with embedded 486s or old 486s donated.  P4s
are abundant in RAM, but 2MB is still not unheard of in the small
boxes, and in 2MB, 512 bytes of code (which is about the size of the
prefetch workaround) is more significant.  Not by itself, but by
virtue of being yet another unnecessary, and very clearly removable
chunk.  Diligence and all that.

>  > After all we have kernels that don't contain the F00F
>  > workaround too.  I'm not pushing this patch as is, it's for
>  > considering the pros and cons.
> 
> F00F workaround was enabled on every kernel that is possible
> to boot on affected hardware last time I looked.
> This is what you seem to be missing, it's not optional.
> If its possible to boot that kernel on affected hardware, 
> it needs errata workarounds.

We have a few confusing issues here.

1. First, your point about affected hardware.

   I see your point, and the new "alternative" macro is allowing things
   to develop along those lines even better: using fancier features (like
   prefetch) but not requiring them.  Most of the x86 kernel is like that now.
   All the stuff in arch/i386/kernel/cpu/* is mandatory.  Yet:

   - I don't see anything that prevents a PPro-compiled kernel from booting
     on a P5MMX with the F00F erratum.

   - Nor do I see anything that prevents a PII-compiled kernel from booting
     on a PPro with the store ordering erratum (X86_PPRO_FENCE).

   Those are both nasty bugs, and the latter can corrupt data on an SMP PPro.

   Currently, it seems quite hypocritical to treat the AMD workaround
   as, in effect, mandatory, while there are others which aren't.
   Perhaps it's this apparent hypocrisy which needs healing.

2. I'm not sure if you're criticising the other chap who wants
   rid of the AMD errata workaround, or my X86_PREFETCH_FIXUP code.

   In case you hadn't fully grokked it, my code doesn't disable the
   workaround!  It simply substitutes it for a smaller, slightly
   slower one, on kernels which are not optimised for AMD.  Those
   kernels continue to work just fine on AMD processors.

   Given that, I'm not sure what the thrust of your argument is.

>  > CONFIG_X86_PREFETCH_WORKAROUND makes more makes more sense with the
>  > recently available "split every x86 CPU into individually selectable
>  > options" patch, and, on reflection, that's probably where it belongs.
> 
> Said patch isn't included in mainline, so this argument is bogus.
> Relative merits of that patch were already discussed in another thread.

That wasn't an argument and the patch from me isn't in the mainline
either, but anyway I agree that topic has its own thread.  Let's
please leave it out of this one and focus on the merits, or otherwise,
of my patch and Andi's.

-- Jamie
