Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWEZI7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWEZI7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 04:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWEZI7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 04:59:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:5792 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751289AbWEZI7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 04:59:02 -0400
Date: Fri, 26 May 2006 10:59:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Catalin Marinas <catalin.marinas@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.17-rc4 1/6] Base support for kmemleak
Message-ID: <20060526085916.GA14388@elte.hu>
References: <20060513155757.8848.11980.stgit@localhost.localdomain> <20060513160541.8848.2113.stgit@localhost.localdomain> <p73u07t5x6f.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73u07t5x6f.fsf@bragg.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > From: Catalin Marinas <catalin.marinas@arm.com>
> > 
> > This patch adds the base support for the kernel memory leak detector. It
> > traces the memory allocation/freeing in a way similar to the Boehm's
> > conservative garbage collector, the difference being that the orphan
> > pointers are not freed but only shown in /proc/memleak. Enabling this
> > feature would introduce an overhead to memory allocations.
> 
> Interesting approach. Did you actually find any leaks with this?

we should be very careful here, since 'low hanging fruit' memory leaks 
have already been clean-sweeped by a proprietary tool (Coverity), so the 
utility of this free (GPL-ed) tool is artificially depressed!

What kmemleak will find are all the cases that Coverity does not check: 
developer's own trees, uncommon architectures/drivers.

Also, kmemleak guarantees (assuming the implementation is correct) that 
if a leak happens in practice, it will be detected immediately. 
Coverity, being a static analyzer, wont find leaks that are obscured by 
some sort of complex codepath.

All in one, i'm very much in favor of adding kmemleak to the upstream 
kernel, once it gets clean enough and has seen some exposure on -mm.

	Ingo
