Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVD1QMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVD1QMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 12:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVD1QMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 12:12:15 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62168 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262016AbVD1QMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 12:12:07 -0400
Subject: Re: [RFC][PATCH] Reduce ext3 allocate-with-reservation lock
	latencies
From: Lee Revell <rlrevell@joe-job.com>
To: cmm@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1114673852.4104.33.camel@localhost.localdomain>
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
Content-Type: text/plain
Date: Thu, 28 Apr 2005 12:12:05 -0400
Message-Id: <1114704726.17712.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 00:37 -0700, Mingming Cao wrote:
> On Wed, 2005-04-27 at 23:45 -0400, Lee Revell wrote:
> > On Fri, 2005-04-22 at 15:10 -0700, Mingming Cao wrote:
> > > Please review. I have tested on fsx on SMP box. Lee, if you got time,
> > > please try this patch.
> > 
> > I have tested and this does fix the problem.  I ran my tests and no ext3
> > code paths showed up on the latency tracer at all, it never went above
> > 33 usecs.
> > 
> Thanks, Lee.
> 
> The patch survived on many fsx test over 20 hours on a 2cpu machine.
> Tested the patch on the same machine with tiobench (1-64 threads), and
> untar a kernel tree test, no regression there.
> However I see about 5-7% throughput drop on dbench with 16 threads. It
> probably due to the cpu cost that we have discussed.

Hmm, I guess someone needs to test it on a bigger system.  AFAICT this
should improve SMP scalability quite a bit.  Maybe that lock is rarely
contended.

Lee

