Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUHNMk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUHNMk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 08:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUHNMk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 08:40:57 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22713 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261405AbUHNMky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 08:40:54 -0400
Date: Sat, 14 Aug 2004 14:42:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc4-O7
Message-ID: <20040814124227.GA10586@elte.hu>
References: <20040726124059.GA14005@elte.hu> <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe> <20040813104817.GI8135@elte.hu> <1092446273.803.43.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092446273.803.43.camel@mindpipe>
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

> >  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O7
> > 
> 
> Some more interesting results.  I am not seeing much of a difference in performance, but
> the shape of the distribution changes quite a bit:
> 
> http://krustophenia.net/testresults.php?dataset=2.6.8-rc3-O5
> http://krustophenia.net/testresults.php?dataset=2.6.8-rc4-bk3-O7

nice graphs - i suspect the shape difference is due to the tracing overhead: it adds visible
(and measurable) overhead to all kernel execution paths, but since the overwhelming majority
of paths have very low latencies it doesnt degrade the max_latency results visibly. This is
good empirical data - it means what we are after a few offenders who are more than a
magnitude slower than the common paths. It also shows that most of the extra overhead is
rather in isolated functions (e.g. the memcpy's), not in some big latency path involving
many small functions.

i also suspect that if you magnified the 'sharp' nontracing graphs near zero they'd show a
similar shape to the tracing graphs.

	Ingo
