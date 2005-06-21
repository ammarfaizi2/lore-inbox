Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVFURXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVFURXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVFURW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:22:56 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51910 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262190AbVFURUq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:20:46 -0400
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
From: john stultz <johnstul@us.ibm.com>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Roman Zippel <zippel@linux-m68k.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <42B82A4F.5090804@nortel.com>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>
	 <1119287354.9947.22.camel@cog.beaverton.ibm.com>
	 <1119291034.16180.9.camel@mindpipe>
	 <1119304422.9947.90.camel@cog.beaverton.ibm.com>
	 <1119311096.17701.3.camel@mindpipe>  <42B82A4F.5090804@nortel.com>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 10:20:37 -0700
Message-Id: <1119374438.9947.151.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 08:55 -0600, Chris Friesen wrote:
> Lee Revell wrote:
> 
> > But some user space apps are now *required* to use rdtsc for timing due
> > to the massive performance difference.  If we only took a 5x or 10x
> > performance hit vs rdtsc, rather than the current 50x, it might be
> > enough that user space apps won't have to do this.
> 
> For my userspace apps I've actually switched to 
> clock_gettime(CLOCK_MONOTONIC, &ts);
> 
> This at least guarantees that it will never go backwards.
> 
> For the experts: Is there a clock exported to userspace that is both 
> monotonic and uniform?  Does CLOCK_MONOTONIC give this on linux?

clock_gettime(CLOCK_MONOTONIC) should be what you're looking for. Since
that still uses do_gettimeofday internally, it is still possible in some
conditions for the current code to have time inconsistencies caused by
interpolation error. This is one of the major reasons for my work.

thanks
-john

