Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUI1OfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUI1OfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 10:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267860AbUI1OfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 10:35:07 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:45955 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267749AbUI1Oeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 10:34:37 -0400
Date: Tue, 28 Sep 2004 09:34:12 -0500
From: Robin Holt <holt@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: Robin Holt <holt@sgi.com>, jlan@engr.sgi.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, csa@oss.sgi.com, akpm@osdl.org,
       guillaume.thouvenin@bull.net, tim@physik3.uni-rostock.de,
       corliss@digitalmages.com
Subject: Re: [PATCH 2.6.9-rc2 2/2] enhanced MM accounting data collection
Message-ID: <20040928143412.GA5608@lnx-holt.americas.sgi.com>
References: <4158956F.3030706@engr.sgi.com> <41589927.5080803@engr.sgi.com> <20040928023350.611c84d8.pj@sgi.com> <20040928113858.GA1090@lnx-holt.americas.sgi.com> <20040928062949.2ab2249e.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928062949.2ab2249e.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Is there any non-trivial risk that some other "unfortunate side affect"
> exists today, that we'd find on benchmarking?

When I last owned csa, I was running benchmarks before each SGI release.
The tests were a simple matter of grabbing belay or belay2 and running
setting up an FC disk vault (one was usually attached that had 16 disks
and use Jack's runit script to launch it.  I would then take the
output and use Jack's web page to graph and compare it to the previous.

Additionally, every time I got access to a new larger system, I would
run the tests on there and check for any odd affects of CSA.

Nothing interesting ever popped up from LBS2.1.1 all the way through
to LBS3.0.

> 
> I'm not sure its worth benchmarking again, but I slightly suspect it is,
> and if benchmarking was done, I'd do it with these calls both inline and
> out of line, to see what affect that had on runtime.  If no affect on
> runtime, I'd tend toward the out of line calls - at least saving a
> little kernel text space.

AIM7 is far to big of a hammer to find this level of micro-optimization.
You could probably find or write a simple microbenchmark which shows
the difference that introducing the code causes, but I would doubt it
would show the inline versus the callout.  Either way, we have probably
spent more time discussing benchmarking this than it is worth at this
point of time.

I would expect the do_no_page() path will be the easiest to identify
the change.  I have a simple test which maps a large region and
then touches a large number of pages.  The whole loop is surronded by
reading of the Shub RTC register.  This was done to determine the
effect of quicklists on page faulting.  That type of microbenchmark
might be your best bet at finding the problem.

Robin
