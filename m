Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbVLOBlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbVLOBlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 20:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVLOBlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 20:41:40 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:419 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030279AbVLOBlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 20:41:39 -0500
Subject: Re: 2.6.14-rt21: slow-running clock
From: john stultz <johnstul@us.ibm.com>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512140122.jBE1MZlE024707@auster.physics.adelaide.edu.au>
References: <200512140122.jBE1MZlE024707@auster.physics.adelaide.edu.au>
Content-Type: text/plain
Date: Wed, 14 Dec 2005 17:41:36 -0800
Message-Id: <1134610897.27117.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-14 at 11:52 +1030, Jonathan Woithe wrote:
> Hi John
> 
> > On Fri, 2005-12-09 at 12:49 +1030, Jonathan Woithe wrote:
> > > > Ok, I went digging further and found the c3tsc selection is correct on
> > > > your hardware. I'm just too used to my own laptop where the TSC varies
> > > > with cpu speed and we lower the rating value. So that should be ok.
> > > 
> > > Ok, good.  That leaves the c3tsc slowdown as the only outstanding issue at
> > > this stage.
> > > 
> > > > I'm now working on why we mis-compensate the c3tsc clocksource in the
> > > > -RT tree. 
> > > 
> > > No problem.  Let me know when you have something to test or need further
> > > info.
> > 
> > 	Attached is a test patch to see if it doesn't resolve the issue for
> > you. I get a maximum change in drift of 30ppm when idling between C3
> > states by being more careful with the C3 TSC compensation and I also
> > force timekeeping updates when cpufreq events occur. 
> 
> Unfortunately there's still an issue.

Ah, drat. 

I'm just going to dump the c3tsc clocksource for now. If C3 mode is
available, the ACPI PM timer is available (since it is used for C3
timing), so we'll just fall back to ACPI PM if we see the cpu entering
C3 mode.

I'm working to respin a new release tonight, hopefully that will make it
upstream to -rt soon and that should take care of it. Later I can look
at reworking the c3tsc clocksource, but for now things need to just
work.

Thanks again for the testing and feedback, I really appreciate your
help!
-john

