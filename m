Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWGFI1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWGFI1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 04:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbWGFI1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 04:27:40 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36816 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965012AbWGFI1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 04:27:39 -0400
Date: Thu, 6 Jul 2006 10:23:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060706082306.GA24643@elte.hu>
References: <20060705101059.66a762bf.akpm@osdl.org> <20060705193551.GA13070@elte.hu> <20060705131824.52fa20ec.akpm@osdl.org> <Pine.LNX.4.64.0607051332430.12404@g5.osdl.org> <20060705204727.GA16615@elte.hu> <Pine.LNX.4.64.0607051411460.12404@g5.osdl.org> <20060705214502.GA27597@elte.hu> <Pine.LNX.4.64.0607051458200.12404@g5.osdl.org> <Pine.LNX.4.64.0607051555140.12404@g5.osdl.org> <20060706081639.GA24179@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706081639.GA24179@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > I wonder if we should remove the "volatile". There really isn't 
> > anything _good_ that gcc can do with it, but we've seen gcc code 
> > generation do stupid things before just because "volatile" seems to 
> > just disable even proper normal working.
> 
> yeah. I tried this and it indeed slashed 42K off text size (0.2%):
> 
>  text            data    bss     dec             filename
>  20779489        6073834 3075176 29928499        vmlinux.volatile
>  20736884        6073834 3075176 29885894        vmlinux.non-volatile
> 
> i booted the resulting allyesconfig bzImage and everything seems to be 
> working fine. Find patch below.

btw., this effect accounted for roughly half of the per-callsite win of 
the wait.h uninlining patch. That still leaves 18 bytes of per-callsite 
win - i'll send that patch next.

	Ingo
