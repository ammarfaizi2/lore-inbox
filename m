Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWGRPFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWGRPFT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 11:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWGRPFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 11:05:18 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:59342
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932247AbWGRPFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 11:05:17 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Valdis.Kletnieks@vt.edu
Subject: Re: kernel/timer.c: next_timer_interrupt() strange/buggy(?) code (2.6.18-rc1-mm2)
Date: Tue, 18 Jul 2006 17:04:08 +0200
User-Agent: KMail/1.9.1
References: <20060717185330.GA32264@rhlx01.fht-esslingen.de> <200607181629.27933.mb@bu3sch.de> <200607181450.k6IEo4Rs022388@turing-police.cc.vt.edu>
In-Reply-To: <200607181450.k6IEo4Rs022388@turing-police.cc.vt.edu>
Cc: linux-kernel@vger.kernel.org, keir@xensource.com,
       Tony Lindgren <tony@atomide.com>, zach@vmware.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607181704.09438.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 July 2006 16:50, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 18 Jul 2006 16:29:27 +0200, Michael Buesch said:
> 
> > Continue is equal to:
> > 
> > LOOP {
> > 	/* foo */
> > 	goto continue; /* == continue */
> 	/* What the code actually had: */
>         goto found; /* Note placement of the label *AFTER* end of loop */
> > 	/* foo */
> > continue:
> > } LOOP
> 
> found: /* out of the loop entirely */
> 
> A 'continue' drops you *at* the end of the loop. The 'goto found:' in the
> original code drops you *after* the end of the loop.  One will potentially go
> around for another pass, the other you're *done*.

I did not say something else.
I just wanted to say the sentence
> A 'continue' instead would leave the do/while and then
> drive the i==2 and subsequent 'for' iterations....
is wrong. It would _not_ leave the do/while directly.
It will check condition first and _might_ leave it.

-- 
Greetings Michael.
