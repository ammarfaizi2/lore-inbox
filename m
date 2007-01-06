Return-Path: <linux-kernel-owner+w=401wt.eu-S932096AbXAFTRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbXAFTRW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXAFTRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:17:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:54568 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932096AbXAFTRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:17:22 -0500
Date: Sat, 6 Jan 2007 20:13:21 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070106191321.GA20369@elte.hu>
References: <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070106111117.54bb2307.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> > FYI, the lock_cpu_hotplug() rewrite proposed by Gautham at 
> > http://lkml.org/lkml/2006/10/26/65 may still need refinement to 
> > avoid all the kind of deadlocks we have unearthed with workqueue 
> > example. I can review that design with Gautham if there is some 
> > interest to revive lock_cpu_hotplug() ..
> 
> Has anyone thought seriously about using the process freezer in the 
> cpu-down/cpu-up paths?  That way we don't need to lock anything 
> anywhere?

yes, yes, yes - lets please do that! The process freezer is already used 
for suspend, for hibernate and recently for kprobes - so its performance 
and robustness is being relied on and verified from multiple angles. I 
can see no reason why it couldnt be made really fast even on large 
boxes, if the need arises. (but even the current one is fast enough for 
any human-driven CPU hotplug stuff)

	Ingo
