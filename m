Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbTEALq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 07:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbTEALq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 07:46:28 -0400
Received: from wsip-68-15-8-100.sd.sd.cox.net ([68.15.8.100]:48516 "EHLO
	gnuppy") by vger.kernel.org with ESMTP id S261235AbTEALpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 07:45:21 -0400
Date: Thu, 1 May 2003 04:57:20 -0700
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Robert Love <rml@tech9.net>,
       viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@digeo.com>,
       Rick Lindsley <ricklind@us.ibm.com>, solt@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org, frankeh@us.ibm.com,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: must-fix list for 2.6.0
Message-ID: <20030501115720.GA3645@gnuppy.monkey.org>
References: <E19B2IS-0007wx-00@w-gerrit2> <3EB0B346.1080805@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB0B346.1080805@us.ibm.com>
User-Agent: Mutt/1.5.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 10:40:22PM -0700, Dave Hansen wrote:
> Gerrit Huizenga wrote:
> > Which affects JVM in most cases.  NPTL based JVMs will possibly
> > obviate that problem.  My guess is that in the JVM case, they have
> > a bad locking model (er, a simpler 2-tier locking model instead of
> > a more correct and complex 3-tier locking model) for their threading
> > operations.  As a result, they use either sched_yield() or used
> > to use pause() to relinquish the processor so the world could change
> > and they could acquire the locks they wanted.
> 
> The JVM's extensive use of sched_yield(), plus the HT scheduler causes
> some pretty undesirable behaviour in SPECjbb(tm) (see disclaimer).  It
> starves some pieces of the benchmark so badly, that the benchmark
> results are invalid.  We also start to get tons of idle time as the load
> goes up.

Have the Blackdown folks fix that. The Solaris Threads implementation
suppresses the actual call to a yield in the HotSpot VM if it gets too
many of them bunched together in short period of time. It's really a problem
not with the JVM itself, but the Linux implementaion of their threading
glue logic... Make'm fix it. :)

I've heard that a number of folks in Blackdown want to try out the new
threading model, so this might be a good opportunity to do that... add
special thread suspension support, etc...

:)

bill

