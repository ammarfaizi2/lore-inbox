Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269135AbUICDEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269135AbUICDEb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 23:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269119AbUICDDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 23:03:46 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:50571 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269252AbUIBWGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:06:53 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
In-Reply-To: <20040902215728.GA28571@elte.hu>
References: <OF04883085.9C3535D2-ON86256F00.0065652B@raytheon.com>
	 <20040902063335.GA17657@elte.hu> <20040902065549.GA18860@elte.hu>
	 <20040902111003.GA4256@elte.hu>  <20040902215728.GA28571@elte.hu>
Content-Type: text/plain
Message-Id: <1094162812.1347.54.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 02 Sep 2004 18:06:53 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 17:57, Ingo Molnar wrote:
> i've released the -R0 patch:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-R0
>  
> ontop of:
> 
>   http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2
> 
> i've given up on the netdev_backlog_granularity approach, and as a
> replacement i've modified specific network drivers to return at a safe
> point if softirq preemption is requested.

Makes sense, netdev_max_backlog never made a difference on my system
(via-rhine driver).

If you read that Microsoft paper I posted a link to earlier, they
describe all of the main categories of latencies we have dealt with. 
They give special mention to network driver DPCs/softirqs.

The worst offender was a driver that used a DPC/softirq to reset the
card if there was no traffic in 10 seconds, to work around a hardware
lockup bug in some versions.  Since the reset path was never designed to
be fast this caused problems.  They also mention a similar problem to
the one that still exists with the via-rhine driver (fixed in -mm) where
it uses a DPC to poll for link status.

Lee



