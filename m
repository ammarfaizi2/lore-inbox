Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269146AbUIBWYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269146AbUIBWYb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269189AbUIBWRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:17:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46061 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269121AbUIBWNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:13:08 -0400
Date: Fri, 3 Sep 2004 00:14:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
Message-ID: <20040902221402.GA29434@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com> <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu> <1094162812.1347.54.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094162812.1347.54.camel@krustophenia.net>
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

> > i've given up on the netdev_backlog_granularity approach, and as a
> > replacement i've modified specific network drivers to return at a safe
> > point if softirq preemption is requested.
> 
> Makes sense, netdev_max_backlog never made a difference on my system
> (via-rhine driver).

via-rhine does RX processing from the hardirq handler, this codepath is
harder to break up. The NAPI ->poll functions used by e100 and 8193too
are much easier to break up because RX throttling and re-trying is a
basic property of NAPI.

	Ingo
