Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUCJWMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUCJWMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:12:40 -0500
Received: from fmr02.intel.com ([192.55.52.25]:56460 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263081AbUCJWM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:12:29 -0500
Subject: Re: ACPI PM Timer vs. C1 halt issue
From: Len Brown <len.brown@intel.com>
To: john stultz <johnstul@us.ibm.com>
Cc: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Dominik Brodowski <linux@brodo.de>
In-Reply-To: <1078955372.2696.23.camel@cog.beaverton.ibm.com>
References: <404E38B7.5080008@gmx.de>
	 <1078870289.12084.8.camel@cog.beaverton.ibm.com>  <404E4913.3020005@gmx.de>
	 <1078955372.2696.23.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1078956711.2557.72.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 10 Mar 2004 17:11:51 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, C1 is the name they gave for what the idle loop does automatically.

this should be monitor/mwait -- if available -- but currently in ACPI
mode C1 is hard-coded to use HALT -- a bug.

http://bugzilla.kernel.org/show_bug.cgi?id=2280

So if your processor has monitor/mwait, and C1 is the best idle state it
has, then you'll probably actually run cooler right now in idle if you
do not load the acpi processor driver.  (but if you've got C2, it should
do better than C1 anyway)

That said, I don't know what caused the regression you describe. 
Perhaps you can clarfiy the minimal changes necessary to switch between
correct and incorrect behaviour?

thanks,
-Len

On Wed, 2004-03-10 at 16:49, john stultz wrote:
> On Tue, 2004-03-09 at 14:45, Prakash K. Cheemplavam wrote:
> > john stultz wrote:
> > > On Tue, 2004-03-09 at 13:35, Prakash K. Cheemplavam wrote:
> > > 
> > >>I found out what causes higher idle temps when using mm-sources and 
> > >>2.6.4-rc vanilla sources: If I use PM Timer as timesource, it seems the 
> > >>C1 halt isn't properly called, at least CPU disconnect doesn't seem to 
> > >>work, thus leaving my CPU as hot as without disconnect.
> > [snip]
> > > 
> > > Sounds like a bug. I'm not very familiar w/ the ACPI cpu power states,
> > > is there anything you have to do to trigger C1 Halt? Or is it just
> > > called in the idle loop?
> > 
> > It should be called within the idle loop.
> 
> Hmm. I'm still stumped. Looking at acpi_processor_idle(), the C1 state
> doesn't touch the ACPI PM timer. The C2 and C3 states do, but they just
> read.  
> 
> Dominik: Do you have a clue on this?
> 
> thanks
> -john
> 

