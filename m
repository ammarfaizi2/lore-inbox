Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263121AbUK0CTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUK0CTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbUK0CKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:10:18 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262824AbUKZTha (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:30 -0500
Date: Thu, 25 Nov 2004 17:58:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041125165829.GA24121@elte.hu>
References: <20041124101854.GA686@elte.hu> <Pine.OSF.4.05.10411251159520.12827-101000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411251159520.12827-101000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> I finally got time to run the test on 2.6.10-rc2-mm2-V0.7.30-10.
> Conclusion: The bound on the locking time seems not to be bounded by
> depth*1ms as predicted: The more blocking tasks there is the higher
> the bound is.  There _is_ some kind of bound in that I don't see wild
> locking times. The distributions stops nicely at N *1ms N in is higher
> than depth.

i've fixed a couple of minor, priority-related bugs in kernels post
-30-10, the latest being -31-7 - there's some chance that one of them
might fix this final anomaly.

> which is depth 3 and 20 blocking tasks. There is a clean upper bound
> of 7ms (7.1 to be exact) but where does the 7 come from??? A formula
> like N=2*depth+1 might fit the results.

there's one thing i noticed, now that the blocker device is in the
kernel, you have to be really careful to compile the userspace loop()
code via the same gcc flags as the kernel did. Minor differences in
compiler options can skew the timing calibration.

but any such bug should at most cause a linear deviation via a constant
factor multiplication, while the data shows a systematic nonlinear
transformation.

> If we understand what is going on this might end up being "good
> enough" in the sense it is deterministic. The end result doesn't have
> to be the best case formula. But the maximum locking time have to
> independent of the number of lower priority tasks banging on the
> protected region as that is something uncontrolable. We have to be
> able to predict a bound based solely on the depth before we can say it
> is "good enough".

yeah, i agree that this has to be further investigated. What type of box
did you test it on - UP or SMP? (SMP scheduling of RT tasks only got
fully correct in the very latest -31-7 kernel.)

	Ingo
