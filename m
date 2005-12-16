Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbVLPCBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbVLPCBL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVLPCBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:01:11 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:5806 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751246AbVLPCBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:01:10 -0500
Subject: Re: [PATCH] ia64: disable preemption in udelay()
From: Lee Revell <rlrevell@joe-job.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: "Luck, Tony" <tony.luck@intel.com>, hawkes@sgi.com,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Keith Owens <kaos@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0512151750500.1678@montezuma.fsmlabs.com>
References: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com>
	 <20051215225040.GA9086@agluck-lia64.sc.intel.com>
	 <Pine.LNX.4.64.0512151750500.1678@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 21:03:55 -0500
Message-Id: <1134698636.12086.222.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 17:52 -0800, Zwane Mwaikambo wrote:
> On Thu, 15 Dec 2005, Luck, Tony wrote:
> 
> > On Wed, Dec 14, 2005 at 03:25:26PM -0800, hawkes@sgi.com wrote:
> > > Sending this to a wider audience:
> > > 
> > > The udelay() inline for ia64 uses the ITC.  If CONFIG_PREEMPT is enabled
> > > and the platform has unsynchronized ITCs and the calling task migrates
> > > to another CPU while doing the udelay loop, then the effective delay may
> > > be too short or very, very long.
> > > 
> > > The most simple fix is to disable preemption around the udelay looping.
> > > The downside is that this inhibits realtime preemption for cases of long
> > > udelays.  One datapoint:  an SGI realtime engineer reports that if
> > > CONFIG_PREEMPT is turned off, that no significant holdoffs are
> > > are attributed to udelay().
> > > 
> > > I am reluctant to propose a much more complicated patch (that disables
> > > preemption only for "short" delays, and uses the global RTC as the time
> > > base for longer, preemptible delays) unless this patch introduces
> > > significant and unacceptable preemption delays.
> > 
> > Stuck between a rock and the proverbial hard place.
> > 
> > I think that the more complex patch is needed though.  If some crazy
> > driver has a pre-emptible udelay(10000), then you really don't want
> > to spin for that long without allowing preemption.
> 
> If it's a preemptible sleep period it should just use msleep.

There are 10 drivers that udelay(10000) or more and a TON that
udelay(1000).  Turning those all into 1ms+ non preemptible sections will
be very bad.

Lee

