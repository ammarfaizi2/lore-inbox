Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUGIFrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUGIFrC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 01:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUGIFrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 01:47:02 -0400
Received: from colin2.muc.de ([193.149.48.15]:3088 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264371AbUGIFq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 01:46:58 -0400
Date: 9 Jul 2004 07:46:57 +0200
Date: Fri, 9 Jul 2004 07:46:57 +0200
From: Andi Kleen <ak@muc.de>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GCC 3.4 and broken inlining.
Message-ID: <20040709054657.GA52213@muc.de>
References: <2fFzK-3Zz-23@gated-at.bofh.it> <2fG2F-4qK-3@gated-at.bofh.it> <2fG2G-4qK-9@gated-at.bofh.it> <2fPfF-2Dv-21@gated-at.bofh.it> <2fPfF-2Dv-19@gated-at.bofh.it> <m34qohrdel.fsf@averell.firstfloor.org> <1089349003.4861.17.camel@nigel-laptop.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089349003.4861.17.camel@nigel-laptop.wpcb.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 02:56:43PM +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Fri, 2004-07-09 at 14:51, Andi Kleen wrote:
> > Nigel Cunningham <ncunningham@linuxmail.org> writes:
> 
> I'm not sure what I wrote that you're replying to.

It was just a general reply to the thread.

> > I think a better solution would be to apply the appended patch 
> 
> I'm going to be a pragmatist :> As long as it works. I do think that
> functions being declared inline when they can't be inlined is wrong, but
> there are more important things on which to spend my time.

Originally as written surely. The problem we have in Linux is that
people write some code, declare functions as inline and it usually
makes sense. But then years pass and people hack and enhance
the code and add more code to the inline functions. And even more
code. But they usually don't drop the inline marker and move it
out of headers when the function has become far too big to still be a 
good inlining candidate. So we end up with functions marked
inlined that should not really be inlined.

One reason is probably that patches are rated for "intrusiveness" 
based on the number of lines they change and when you move an inline
function out of a header even a small change can become quite big.
That's a unfortunate side effect of a normally sound policy.

Anyways, with that problem and the improved inliner in gcc 3.4 
I think it's a good idea to let the compiler decide.

It's too bad that i386 doesn't enable -funit-at-a-time, that improves
the inlining heuristics greatly.


> > And then just mark the function you know needs to be inlined
> > as __always_inline__. I did this on x86-64 for some functions
> > too that need to be always inlined (although using the attribute
> > directly because all x86-64 compilers support it)
> 
> Should that be __always_inline (no final __ in the patch below, so far
> as I can see)?

Yes. I originally wrote it with the final __, but it's better 
to not add it.

-AndI
