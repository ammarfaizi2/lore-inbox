Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265440AbUEZKeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265440AbUEZKeJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265438AbUEZKeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:34:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:15499 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265440AbUEZKeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:34:04 -0400
Date: Wed, 26 May 2004 12:33:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: 4k stacks in 2.6
Message-ID: <20040526103303.GA7008@elte.hu>
References: <Pine.LNX.4.44.0405251549530.26157-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525211522.GF29378@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> On Tue, May 25, 2004 at 04:10:29PM -0400, Rik van Riel wrote:
> > Fragmentation causes fork trouble (gone with the 4k stacks)
> 
> btw, the 4k stacks sounds not safe to me, most people only tested with
> 8k stacks so far, I wouldn't make that change in a production tree
> without an unstable cycle of testing in between. I'd rather risk a an
> allocation failure than a stack memory corruption.

4k stacks is a cool and useful feature and tons of effort that went into
making them as safe as possible. Sure, we couldnt fix up bin-only
modules, but all the kernel drivers are audited for stack footprint, and
many months of beta testing has gone into this as well. Anyway, if you
prefer you can turn on 8k stacks - especially if you tree has lots of
not-yet-upstream driver patches.

> x86-64 has per-irq stacks that allowed to reduce the stack size to 8k
> (which is very similar to 4k for an x86, but without per-irq stack
> it's too risky).

do you realize that the 4K stacks feature also adds a separate softirq
and a separate hardirq stack? So the maximum footprint is 4K+4K+4K, with
a clear and sane limit for each type of context, while the 2.4 kernel
has 6.5K for all 3 contexts combined. (Also, in 2.4 irq contexts pretty
much assumed that there's 2K of stack for them - leaving a de-facto 4K
stack for the process and softirq contexts.) So in fact there is more
space in 2.6 for all, and i dont really understand your fears.

	Ingo
