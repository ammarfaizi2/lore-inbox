Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUHJIq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUHJIq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUHJIp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:45:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:10222 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262450AbUHJIoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:44:14 -0400
Date: Tue, 10 Aug 2004 09:51:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
Message-ID: <20040810075130.GA25238@elte.hu>
References: <20040726083537.GA24948@elte.hu> <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de> <1092071169.13668.23.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092071169.13668.23.camel@mindpipe>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Ingo, do you plan to maintain the voluntary preempt patch against the
> -mm series?  From looking at Andrew's announcement yesterday it looks
> like many latency issues fixed in the voluntary preemption patches are
> also fixed in -mm, so it seems like the patch would be much smaller. 

yeah, and in addition we've already pushed 99% of our might_sleep()
additions to -mm too so that reduces the patch size too, quite
significantly.

time is the only limiting factor. Due to these partial merges (we are
trying to get all uncontroversial bits into -mm, hence into upstream)
the merge to -mm is hard. Especially for lock-breaks that i've done
differently than Andrew. I sent a consolidation patch yesterday but this
is still work in progress. So i'll do an -mm merge very time i get to do
it, but the primary testing still remains on the vanilla kernel (which
most people use).

> One thing that might be useful is breaking out the irq threading code
> as a patch against -mm.  Judging from all the -mm latency fixes it
> seems like this would work as well as the vanilla kernel+voluntary
> preempt.

both softirq threading and hardirq threading will be done separately,
yes. Also, most of the switches and source-level distinctions between
cond_resched and voluntary_resched variants can go away too. The
'-clean' patch in the voluntary-preempt directory shows how it would
look like in the end.

> This would also make it easier to identify which are the important
> latency fixes from -mm enabling them to be pushed into mainline
> sooner.  On some of my tests I got 10-20% better results using
> vol-preempt+mm vs vol-preempt+vanilla, it would be nice to identify
> what changes are responsible.

the plan right now is to push all the known-good stuff into 2.6.9 once
2.6.8 is out. That will unify all the improvements in a natural way. The
latest update kernel of FC2 also includes an earlier version of the
voluntary-preempt patch (sans any irq threading bits) - and it worked
out fine so far.

	Ingo
