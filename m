Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVFVCjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVFVCjO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 22:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVFVCjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 22:39:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:31147 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262522AbVFVCjK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 22:39:10 -0400
Subject: Re: [PATCH 1/6] new timeofday core subsystem for -mm (v.B3)
From: john stultz <johnstul@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1119401841.9947.255.camel@cog.beaverton.ibm.com>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506181344000.3743@scrub.home>
	 <1119287354.9947.22.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506202231070.3728@scrub.home>
	 <1119311734.9947.143.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.61.0506211542580.3728@scrub.home>
	 <1119401841.9947.255.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 21 Jun 2005 19:39:01 -0700
Message-Id: <1119407941.9947.270.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 17:57 -0700, john stultz wrote:
> > I don't need any practical numbers, I can already see from the code, that 
> > it's much worse and unless you eliminate the 64bit calculations from the 
> > fast path, I don't know what you are trying to optimize.
> 
> That's exactly what I'm trying to optimize. By precalculating some of
> the 64 bit manipulations, we can remove them from the fast path.
> 
> Ok, from my initial tests on my i686 laptop (@600Mhz), using the
> cheapest timesource available (the TSC), the unoptimized B3 version of
> the code I sent out shows a 17% performance hit in gettimeofday(). That
> ratio will be even smaller if you use a more expensive timesource. So
> starting there, let me see how much I can shave off.

Just a quick update: With a bit of quick optimizing the current design,
removing most of the 64bit math from the gettimeofday fast path, I've
managed to cut it down to within 2% of the current code using the c3tsc
vs tsc. The c3tsc timesource adds a bit of overhead that the mainline
code doesn't do, so I'm going to see how a more comparable TSC vs TSC
test goes.

thanks
-john

