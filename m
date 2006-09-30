Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWI3WSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWI3WSS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 18:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWI3WSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 18:18:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:3222 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751452AbWI3WSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 18:18:16 -0400
Date: Sun, 1 Oct 2006 00:10:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Message-ID: <20060930221005.GA20839@elte.hu>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <200609302230.24070.ak@suse.de> <Pine.LNX.4.64.0609301449130.3952@g5.osdl.org> <200610010002.46634.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610010002.46634.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > Why not just add the simple validation?
> > 
> > A kernel stack is one page in size. If you move to another page, you 
> > terminate. It's that simple.
> 
> No, it's not. On x86-64 it can be three or more stacks nested in 
> complicated ways (process stack, interrupt stack, exception stack) The 
> exception stack can happen multiple times.

it could be cleanly handled though: in June i suggested to use the 
next-stack pointers at the end of exception pages. The only current 
complexity here is that the 'linking' of exception pages is non-uniform, 
it depends on the type of page. That's largely why that complex 
statemachine had to be implemented, to match up the type of the page. 
Since those pointers are put there by us, there's no real reason why we 
couldnt standardize them.

	Ingo
