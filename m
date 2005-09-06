Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVIFSEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVIFSEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVIFSEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:04:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:6117 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750748AbVIFSEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:04:22 -0400
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick
	calculation in timer_pm.c
From: john stultz <johnstul@us.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, arjan@infradead.org,
       s0348365@sms.ed.ac.uk, kernel@kolivas.org, tytso@mit.edu,
       cfriesen@nortel.com, trenn@suse.de, george@mvista.com, akpm@osdl.org
In-Reply-To: <1125720301.4991.41.camel@mindpipe>
References: <20050831165843.GA4974@in.ibm.com>
	 <20050831171211.GB4974@in.ibm.com>  <1125720301.4991.41.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 11:04:06 -0700
Message-Id: <1126029846.22448.36.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-09-03 at 00:05 -0400, Lee Revell wrote:
> On Wed, 2005-08-31 at 22:42 +0530, Srivatsa Vaddagiri wrote:
> > With this patch, time had kept up really well on one particular
> > machine (Intel 4way Pentium 3 box) overnight, while
> > on another newer machine (Intel 4way Xeon with HT) it didnt do so
> > well (time sped up after 3 or 4 hours). Hence I consider this
> > particular patch will need more review/work.
> > 
> 
> Are lost ticks really that common?  If so, any idea what's disabling
> interrupts for so long (or if it's a hardware issue)?  And if not, it
> seems like you'd need an artificial way to simulate lost ticks in order
> to test this stuff.

Pavel came up with a pretty good test for this awhile back.

http://marc.theaimsgroup.com/?l=linux-kernel&m=110519095425851&w=2

Adding:
	unsigned long mask = 0x1;
	sched_setaffinity(0, sizeof(mask), &mask);

to the top helps it work on SMP systems.

thanks
-john

