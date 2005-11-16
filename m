Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbVKPM5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbVKPM5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbVKPM5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:57:44 -0500
Received: from cantor.suse.de ([195.135.220.2]:22969 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965256AbVKPM5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:57:43 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: alex14641@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051116005034.73421.qmail@web50210.mail.yahoo.com>
	<1132128212.2834.17.camel@laptopd505.fenrus.org>
	<20051116111812.4a1ea18a.grundig@teleline.es>
	<1132137638.2834.29.camel@laptopd505.fenrus.org>
From: Andi Kleen <ak@suse.de>
Date: 16 Nov 2005 13:57:36 +0100
In-Reply-To: <1132137638.2834.29.camel@laptopd505.fenrus.org>
Message-ID: <p73oe4kpx6n.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:


> > I would like to contribute that listing with two non-technical reasons
> > more:
> > 
> >  * Encourages good code. Due to the 4 Kb stacks patch several parts of
> > 	the kernel have gone on diet, improving the quality of the code
> 
> this argument I agree with. especially since 64 bit platforms have a
> higher stack footprint by nature (bigger call frames and more to store
> on the stack) and if x86 allows stackbloat, the other architectures get
> in trouble and are going to need really large stacks.

I think it's in general risky. It's like balancing without a safety
net.  Might be a nice hobby, but for real production you want a safety
net.  That's simple because there are likely some code paths through
the code that need more stack space and that are rarely hit (and
cannot be easily found by static analysis, e.g. if they involve
indirect pointers or particularly complex configuration setups). With
very tight stack space you're much nearer a crash in extreme
situations than otherwise.

So I think it's a bad idea to change this.

-Andi (who prefers to have safety nets)
