Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbTEAF3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 01:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTEAF3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 01:29:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:57279 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262459AbTEAF3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 01:29:30 -0400
Message-ID: <3EB0B346.1080805@us.ibm.com>
Date: Wed, 30 Apr 2003 22:40:22 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Gerrit Huizenga <gh@us.ibm.com>
CC: Robert Love <rml@tech9.net>, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@digeo.com>, Rick Lindsley <ricklind@us.ibm.com>,
       solt@dns.toxicfilms.tv, linux-kernel@vger.kernel.org,
       frankeh@us.ibm.com
Subject: Re: must-fix list for 2.6.0
References: <E19B2IS-0007wx-00@w-gerrit2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga wrote:
> Which affects JVM in most cases.  NPTL based JVMs will possibly
> obviate that problem.  My guess is that in the JVM case, they have
> a bad locking model (er, a simpler 2-tier locking model instead of
> a more correct and complex 3-tier locking model) for their threading
> operations.  As a result, they use either sched_yield() or used
> to use pause() to relinquish the processor so the world could change
> and they could acquire the locks they wanted.

The JVM's extensive use of sched_yield(), plus the HT scheduler causes
some pretty undesirable behaviour in SPECjbb(tm) (see disclaimer).  It
starves some pieces of the benchmark so badly, that the benchmark
results are invalid.  We also start to get tons of idle time as the load
goes up.

In case anybody is curious, we're trying to share more of the data that
we collect when we run the benchmarks.  Most of it us useless, but
someone might find a gem or two.  Here are two runs, one with HT, and
the other without.  There's also a pretty busy gnuplot graph in there:
http://www.sr71.net/prof/jbb/elm3a2/

The benchmark results can be found in:
<run-name>/benchmark/SPECjbb.*

Disclaimer:
SPEC (tm) and the benchmark name SPECjbb (tm) are registered trademarks
of the Standard Performance Evaluation Corporation. The benchmarking was
conducted for research purposes only and were non-compliant with the
following deviations from the rules:

  1. It was run on hardware that does not meet the SPEC
  availability-to-the public criteria. The machine was an
  engineering sample.

-- 
Dave Hansen
haveblue@us.ibm.com

