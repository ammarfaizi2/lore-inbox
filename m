Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262475AbUKZX5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262475AbUKZX5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 18:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbUKZX4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 18:56:46 -0500
Received: from zeus.kernel.org ([204.152.189.113]:26565 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263086AbUKZTnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:43:05 -0500
Date: Thu, 25 Nov 2004 18:14:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041125171430.GA25886@elte.hu>
References: <20041125165829.GA24121@elte.hu> <Pine.OSF.4.05.10411251706290.12827-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411251706290.12827-100000@da410.ifa.au.dk>
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

> 
> On Thu, 25 Nov 2004, Ingo Molnar wrote:
> 
> > [...] 
> > there's one thing i noticed, now that the blocker device is in the
> > kernel, you have to be really careful to compile the userspace loop()
> > code via the same gcc flags as the kernel did. Minor differences in
> > compiler options can skew the timing calibration.
> > 
> > but any such bug should at most cause a linear deviation via a constant
> > factor multiplication, while the data shows a systematic nonlinear
> > transformation.
> > 
> -g -Wall -O2 was on in userspace.

you can check the gcc options the kernel used via the
drivers/char/.blocker.o.cmd file. Mine has (only the
performance-relevant flags):

 -fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer -msoft-float
 -mpreferred-stack-boundary=2 -fno-unit-at-a-time -march=pentium3
 -mregparm=3

> > [...] 
> > yeah, i agree that this has to be further investigated. What type of box
> > did you test it on - UP or SMP? (SMP scheduling of RT tasks only got
> > fully correct in the very latest -31-7 kernel.)
> > 
> UP, PIII 697.143 Mhz

ok - some of the fixes affect UP too, but with less likelyhood. Might be
worth a try though.

	Ingo
