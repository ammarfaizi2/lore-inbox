Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269130AbUIBWTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269130AbUIBWTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269161AbUIBWSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:18:18 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33420 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269167AbUIBWPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:15:09 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
In-Reply-To: <20040902221402.GA29434@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <20040902111003.GA4256@elte.hu> <20040902215728.GA28571@elte.hu>
	 <1094162812.1347.54.camel@krustophenia.net>
	 <20040902221402.GA29434@elte.hu>
Content-Type: text/plain
Message-Id: <1094163308.1347.59.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 18:15:08 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 18:14, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > i've given up on the netdev_backlog_granularity approach, and as a
> > > replacement i've modified specific network drivers to return at a safe
> > > point if softirq preemption is requested.
> > 
> > Makes sense, netdev_max_backlog never made a difference on my system
> > (via-rhine driver).
> 
> via-rhine does RX processing from the hardirq handler, this codepath is
> harder to break up. The NAPI ->poll functions used by e100 and 8193too
> are much easier to break up because RX throttling and re-trying is a
> basic property of NAPI.
> 

What I meant was, I did not consider the latencies from via-rhine to be
a problem.  The other posters reported 300-500 usec latencies in the
network driver, I did not see this.

Lee

