Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbWIRPPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbWIRPPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 11:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbWIRPPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 11:15:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:62421 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751763AbWIRPPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 11:15:14 -0400
Date: Mon, 18 Sep 2006 17:06:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       In Cognito <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: Sysenter crash with Nested Task Bit set
Message-ID: <20060918150650.GA10336@elte.hu>
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com> <20060917222537.55241d19.akpm@osdl.org> <Pine.LNX.4.64.0609180741520.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609180741520.4388@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> And sysenter really is very special because of the weak trap 
> semantics. Damn. We could either fix it in the sysenter code-path, or 
> in the task-switch one, and both of them are timing-critical, but task 
> switching perhaps just a tad less so.

agreed. Context-switching is 10 times less frequent on most workloads 
than syscalls, so if it takes 10 cycles in the context-switch path to 
eliminate a 1 cycle overhead in the syscall-entry path then we are still 
break-even on average. In this case the overhead is similar i think, so 
the switch_to() fix is preferable.

	Ingo
