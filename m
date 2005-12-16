Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVLPBql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVLPBql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbVLPBql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:46:41 -0500
Received: from fsmlabs.com ([168.103.115.128]:7603 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751277AbVLPBqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:46:40 -0500
X-ASG-Debug-ID: 1134697594-4654-95-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Thu, 15 Dec 2005 17:52:02 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Luck, Tony" <tony.luck@intel.com>
cc: hawkes@sgi.com, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Keith Owens <kaos@sgi.com>, Dimitri Sivanich <sivanich@sgi.com>
X-ASG-Orig-Subj: Re: [PATCH] ia64: disable preemption in udelay()
Subject: Re: [PATCH] ia64: disable preemption in udelay()
In-Reply-To: <20051215225040.GA9086@agluck-lia64.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0512151750500.1678@montezuma.fsmlabs.com>
References: <20051214232526.9039.15753.sendpatchset@tomahawk.engr.sgi.com>
 <20051215225040.GA9086@agluck-lia64.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6340
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Dec 2005, Luck, Tony wrote:

> On Wed, Dec 14, 2005 at 03:25:26PM -0800, hawkes@sgi.com wrote:
> > Sending this to a wider audience:
> > 
> > The udelay() inline for ia64 uses the ITC.  If CONFIG_PREEMPT is enabled
> > and the platform has unsynchronized ITCs and the calling task migrates
> > to another CPU while doing the udelay loop, then the effective delay may
> > be too short or very, very long.
> > 
> > The most simple fix is to disable preemption around the udelay looping.
> > The downside is that this inhibits realtime preemption for cases of long
> > udelays.  One datapoint:  an SGI realtime engineer reports that if
> > CONFIG_PREEMPT is turned off, that no significant holdoffs are
> > are attributed to udelay().
> > 
> > I am reluctant to propose a much more complicated patch (that disables
> > preemption only for "short" delays, and uses the global RTC as the time
> > base for longer, preemptible delays) unless this patch introduces
> > significant and unacceptable preemption delays.
> 
> Stuck between a rock and the proverbial hard place.
> 
> I think that the more complex patch is needed though.  If some crazy
> driver has a pre-emptible udelay(10000), then you really don't want
> to spin for that long without allowing preemption.

If it's a preemptible sleep period it should just use msleep.
