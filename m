Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbUK0BgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbUK0BgB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263047AbUKZTjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:39:23 -0500
Received: from zeus.kernel.org ([204.152.189.113]:18626 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262357AbUKZTVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:21:44 -0500
Date: Fri, 26 Nov 2004 01:34:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041126003425.GA5182@elte.hu>
References: <20041125165829.GA24121@elte.hu> <Pine.OSF.4.05.10411252305040.25041-100000@da410.ifa.au.dk> <20041126010841.GA3563@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041126010841.GA3563@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> the additional +1 msec comes from the fact that 1-deep lock/unlock of
> lock1 is an allowed operation too - 2 msec would be the limit if the
> only sequence is the 2-deep one.
> 
> so i think the numbers, at least in the 2-deep case, are quite close
> to the theoretical boundary.

in the generic case i think the theoretical boundary should be something
like:

   sum(i=1...n)(i) == (n+1) * n / 2

	n=1	limit=1
	n=2	limit=3
	n=3	limit=6
	n=4	limit=10

this is quite close to what you have measured for n=1,2,3, and i think
it's becoming exponentially harder to trigger the worst-case with higher
N, so the measured results will likely be lower than that.

	Ingo
