Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262723AbVA1Svp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbVA1Svp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbVA1Svo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:51:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:666 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262723AbVA1SvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:51:16 -0500
Date: Fri, 28 Jan 2005 19:51:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>,
       Benedikt Spranger <bene@linutronix.de>
Subject: Re: High resolution timers and BH processing on -RT
Message-ID: <20050128185101.GC25164@elte.hu>
References: <1106871192.21196.152.camel@tglx.tec.linutronix.de> <20050128044301.GD29751@elte.hu> <1106900411.21196.181.camel@tglx.tec.linutronix.de> <20050128082439.GA3984@elte.hu> <1106901013.21196.194.camel@tglx.tec.linutronix.de> <20050128084725.GB5004@elte.hu> <41FA85A7.4000805@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA85A7.4000805@mvista.com>
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


* George Anzinger <george@mvista.com> wrote:

> A quick comment here on the current RT code.  It looks to me like
> there is a race in timer delivery.  It looks like the softirq is
> "raised" by the PIT interrupt code and the jiffie is bumped by the
> timer thread.  If the softirq gets to run prior to the PIT interrupt
> thread we could end up in the run_timer list code with a stale jiffie
> value and do nothing.  This would delay normal timers for a jiffie and
> HRT timers for some time less than a jiffie, depending on when they
> were really due.
> 
> I thing we should move the raising of the timer softirq to the PIT
> interrupt thread after we release the xtime_lock.

ok - mind sending a patch for this?

	Ingo
