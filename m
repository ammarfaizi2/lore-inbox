Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbTIRQFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 12:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbTIRQFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 12:05:19 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:51093 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261903AbTIRQFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 12:05:15 -0400
Date: Thu, 18 Sep 2003 17:04:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       richard.brunner@amd.com
Subject: Re: [PATCH] Athlon/Opteron Prefetch Fix for 2.6.0test5 + numbers
Message-ID: <20030918160456.GC7548@mail.jlokier.co.uk>
References: <20030917202100.GC4723@wotan.suse.de> <Pine.LNX.4.44.0309171332200.2523-100000@laptop.osdl.org> <20030917211200.GA5997@wotan.suse.de> <20030918153831.GA7548@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030918153831.GA7548@mail.jlokier.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> > +	/* Don't check for LDT code segments because they could have
> > +	   non zero bases. Better would be to add in the base in this case. */
> > +	if (regs->xcs & (1<<2))
> > +		return 0;
> 
> It is possible to have a non-standard code segment in the GDT, too.
> Thus a better to check is "unlikely((regs->xcs & 0xffff) != __USER_CS)".

Ignore me here, I'm being dense - forgetting about __KERNEL_CS :)

My point is simply that non-zero base GDT segments are possible in
userspace, and whatever code you add later to add the base should
be aware of that.

-- Jamie
