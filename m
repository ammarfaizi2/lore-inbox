Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVD1Se5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVD1Se5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVD1Se5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:34:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8664 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262222AbVD1Seg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:34:36 -0400
Subject: Re: [RFC][PATCH] Reduce ext3 allocate-with-reservation lock
	latencies
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1114704726.17712.17.camel@mindpipe>
References: <1112673094.14322.10.camel@mindpipe>
	 <20050405041359.GA17265@elte.hu>
	 <1112765751.3874.14.camel@localhost.localdomain>
	 <20050407081434.GA28008@elte.hu>
	 <1112879303.2859.78.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112917023.3787.75.camel@dyn318043bld.beaverton.ibm.com>
	 <1112971236.1975.104.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1112983801.10605.32.camel@dyn318043bld.beaverton.ibm.com>
	 <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114207837.7339.50.camel@localhost.localdomain>
	 <1114659912.16933.5.camel@mindpipe>
	 <1114673852.4104.33.camel@localhost.localdomain>
	 <1114704726.17712.17.camel@mindpipe>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 28 Apr 2005 11:34:18 -0700
Message-Id: <1114713258.18996.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 12:12 -0400, Lee Revell wrote:
> On Thu, 2005-04-28 at 00:37 -0700, Mingming Cao wrote:
> > On Wed, 2005-04-27 at 23:45 -0400, Lee Revell wrote:
> > > On Fri, 2005-04-22 at 15:10 -0700, Mingming Cao wrote:
> > > > Please review. I have tested on fsx on SMP box. Lee, if you got time,
> > > > please try this patch.
> > > 
> > > I have tested and this does fix the problem.  I ran my tests and no ext3
> > > code paths showed up on the latency tracer at all, it never went above
> > > 33 usecs.
> > > 
> > Thanks, Lee.
> > 
> > The patch survived on many fsx test over 20 hours on a 2cpu machine.
> > Tested the patch on the same machine with tiobench (1-64 threads), and
> > untar a kernel tree test, no regression there.
> > However I see about 5-7% throughput drop on dbench with 16 threads. It
> > probably due to the cpu cost that we have discussed.
> 
> Hmm, I guess someone needs to test it on a bigger system.  AFAICT this
> should improve SMP scalability quite a bit.  Maybe that lock is rarely
> contended.

Probably. I will try it on a relatively full filesystem(where bitmap
scan to find a free block takes time), and on a 4 cpu box with many
threads allocating at the same time.

Mingming

