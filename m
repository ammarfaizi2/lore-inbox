Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264839AbUEYJvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264839AbUEYJvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 05:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbUEYJvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 05:51:37 -0400
Received: from mx1.elte.hu ([157.181.1.137]:17301 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264827AbUEYJvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 05:51:35 -0400
Date: Tue, 25 May 2004 13:42:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-ID: <20040525114258.GA6674@elte.hu>
References: <20040524062754.GO1833@holomorphy.com> <20040524063959.5107.qmail@web90007.mail.scd.yahoo.com> <20040524005331.71465614.akpm@osdl.org> <20040525103238.GA4212@elte.hu> <20040525022941.62ab4cc4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525022941.62ab4cc4.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> >  with the patch below we will print a big fat warning. (I did not want to
> >  deny idle=poll altogether - future HT implementations might work fine
> >  with polling idle.)
> 
> idle=poll is handy when profiling the kernel with oprofile
> clock-unhalted events.  Because if you use the normal halt-based idle
> loop no profile "ticks" are accounted to idle time at all and the
> results are really hard to understand.

it makes it a bit more plausible, but kernel profiling based on ticks in
a HT environment is still quite unreliable, even with idle=poll. The HT
cores will yield to each other on various occasions - like spinlock
loops. This disproportionatly increases the hits of various looping
functions, creating false impressions of lock contention where there's
only little contention. Plus idle=poll is a constant ~20% performance
drain on the non-idle HT core, further distorting the profile. HT makes
profiling really hard, no matter what.

but ... we agree on the warning printk, right?

	Ingo
