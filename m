Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbVCSHJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbVCSHJO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 02:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVCSHJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 02:09:14 -0500
Received: from mx1.elte.hu ([157.181.1.137]:4825 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262422AbVCSHJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 02:09:10 -0500
Date: Sat, 19 Mar 2005 08:08:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Jack O'Quin" <joq@io.com>
Subject: Re: Latency tests with 2.6.12-rc1
Message-ID: <20050319070810.GA20059@elte.hu>
References: <1111204984.12740.22.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111204984.12740.22.camel@mindpipe>
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

> I did the same quick latency tests with 2.6.12-rc1 that I posted about
> for 2.6.11 a few weeks ago.
> 
> 2.6.12-rc1 is significantly better than 2.6.11.  Running JACK at 64
> frames (1.3 ms) works very well.  I was not able to produce xruns even
> with "dbench 64", which slows the system to a crawl.  With 2.6.11, I
> could easily produce xruns with much lighter loads.
> 
> It would appear that the latency issues related to the 4 level page
> tables merge have been resolved.

great! The change in question is most likely the copy_page_range() fix
that Hugh resurrected:

ChangeSet 1.2037, 2005/03/08 09:26:46-08:00, hugh@veritas.com

	[PATCH] copy_pte_range latency fix
	
	Ingo's patch to reduce scheduling latencies, by checking for lockbreak in
	copy_page_range, was in the -VP and -mm patchsets some months ago; but got
	preempted by the 4level rework, and not reinstated since. Restore it now
	in copy_pte_range - which mercifully makes it easier.

are the ext3 related latencies are gone as well - or are you working it
around by not using data=ordered?

    Ingo
