Return-Path: <linux-kernel-owner+w=401wt.eu-S1754495AbWLRT6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbWLRT6O (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbWLRT6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:58:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36441 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495AbWLRT6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:58:13 -0500
Date: Mon, 18 Dec 2006 20:56:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061218195604.GA32112@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com> <20061217085859.GB2938@elte.hu> <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com> <20061218072932.GA5624@elte.hu> <b0943d9e0612180228w142a7375obf33a0f42d1982ae@mail.gmail.com> <20061218112120.GA7599@elte.hu> <b0943d9e0612180426m3f320a3ah86631d1852a6b15@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0612180426m3f320a3ah86631d1852a6b15@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Catalin Marinas <catalin.marinas@gmail.com> wrote:

> >at freeing we only have to look up the tree belonging to object->cpu.
> 
> At freeing, kmemleak only gets a pointer value which has to be looked 
> up in the hash table for the corresponding memleak_object. Only after 
> that, we can know memleak_object->cpu. That's why I think we only need 
> to have a global hash table. The hash table look-up can be RCU.
> 
> It would work with per-CPU hash tables but we still need to look-up 
> the other hash tables in case the freeing happened on a different CPU 
> (i.e. look-up the current hash table and, if it fails, look-up the 
> other per-CPU hashes). Freeing would need to remove the entry from the 
> hash table and acquire a lock but this would be per-CPU. I'm not sure 
> how often you get this scenario (allocation and freeing on different 
> CPUs) but it might introduce an overhead to the memory freeing.
> 
> Do you have a better solution here?

hmm ... nasty. Would it be feasible to embedd the memleak info into the 
allocated object itself? That would remove quite some runtime overhead, 
besides eliminating the global hash.

	Ingo
