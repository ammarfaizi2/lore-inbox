Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbTJAIUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 04:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTJAIUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 04:20:17 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:46470 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261967AbTJAIUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 04:20:12 -0400
Date: Wed, 1 Oct 2003 09:20:02 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata  patch
Message-ID: <20031001082002.GM1131@mail.shareable.org>
References: <7F740D512C7C1046AB53446D3720017304AFCF@scsmsx402.sc.intel.com.suse.lists.linux.kernel> <20031001053833.GB1131@mail.shareable.org.suse.lists.linux.kernel> <20030930224853.15073447.akpm@osdl.org.suse.lists.linux.kernel> <20031001061348.GE1131@mail.shareable.org.suse.lists.linux.kernel> <20030930233258.37ed9f7f.akpm@osdl.org.suse.lists.linux.kernel> <p73k77pzc69.fsf@oldwotan.suse.de> <20031001072011.GJ1131@mail.shareable.org> <20031001073922.GL15853@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001073922.GL15853@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Wed, Oct 01, 2003 at 08:20:11AM +0100, Jamie Lokier wrote:
> > I think the mmap_sem problems are fixed by an appropriate "address >=
> > TASK_SIZE" check at the beginning do_page_fault, which should jump
> 
> Assuming vsyscalls never contain prefetch. 

Fine as long as it doesn't need a vma.

> Imho that's the best way for 32bit too, non zero segment bases are
> just not worth caring about.

I could agree.  I was most concerned about the lack of limit check in
your last patch, allowing malicious code to trigger reads outside of
userspace x86 virtualisation jails which are built using segments.  An
obscure one, to be sure, but userspace assumptions broken by kernel
surprises is not good.

Just checking the standard segments is quite safe :)

Btw, I have a version of the segment code for x86_64 if you would take it.

> I had the same idea earlier, but discarded it because it would make
> the code much more ugly. It's better to just keep that stuff out of
> the fast path, not optimize it to the last cycle.

Personally think the code would be nicer, but opinions vary about my
coding style ;)

> > Fifth, the "if (regs->eip == addr)" check - is it helpful on 32-bit?
> 
> It avoids one fault recursion for the kernel jumping to zero.

You wrote before that it makes a prettier oops.  Does it?  AFAICT the
extra recursion is benign and doesn't change the oops.  Maybe I missed
something.

Thanks,
-- Jamie
