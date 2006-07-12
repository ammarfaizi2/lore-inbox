Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWGLV23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWGLV23 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWGLV23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:28:29 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:55709 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750788AbWGLV22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:28:28 -0400
Date: Wed, 12 Jul 2006 23:22:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Message-ID: <20060712212245.GB10944@elte.hu>
References: <20060630014050.GI19712@stusta.de> <20060630045228.GA14677@opteron.random> <20060630094753.GA14603@elte.hu> <20060630145825.GA10667@opteron.random> <20060711073625.GA4722@elte.hu> <20060711141709.GE7192@opteron.random> <1152628374.3128.66.camel@laptopd505.fenrus.org> <20060711153117.GJ7192@opteron.random> <1152635055.18028.32.camel@localhost.localdomain> <p73wtain80h.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73wtain80h.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> I liked the idea. While this can be done with LSM (e.g. apparmor) too 
> seccomp is definitely much easier and simpler and more "obviously 
> safe" than anything LSM based.

LSM is probably too heavy for this - but utrace (posted by Roland 
McGrath a few weeks ago) is alot more focused on modularizing ptrace 
features. utrace also solves a whole host of other issues that we have 
with ptrace!

for example the first sample utrace module that Roland posted was a 
'stop the task if it becomes undebugged, instead of letting the task run 
away'. That solves precisely the ptrace property that Andrea complained 
about most.

i think Andrea didnt even try to fix/generalize ptrace perhaps because 
that would make his 'security feature' too banal? It would also become 
unpatentable? Even though this decision hurts the 'reach' of his project 
fundamentally: ptrace support is everywhere, and users could very much 
and consciously decide to run 'compatible ptrace' or 'more secure 
ptrace' [provided by newer kernels].

Andrea's "ptrace is insecure" argument is just plain FUD: there's 
nothing inherently insecure about the _client side_ of the ptrace APIs 
or the client side of ptrace implementation. So my suggestion is to get 
utrace in, to implement an utrace module that implements untrusted code 
execution and then lets get rid of seccomp.

	Ingo
