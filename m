Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266461AbUGQDSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266461AbUGQDSY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 23:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUGQDSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 23:18:24 -0400
Received: from holomorphy.com ([207.189.100.168]:33969 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266461AbUGQDSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 23:18:20 -0400
Date: Fri, 16 Jul 2004 20:16:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Chris Wright <chrisw@osdl.org>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: [RFC] Lock free fd lookup
Message-ID: <20040717031645.GM3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@ocs.com.au>, Jesse Barnes <jbarnes@engr.sgi.com>,
	Chris Wright <chrisw@osdl.org>,
	Ravikiran G Thirumalai <kiran@in.ibm.com>,
	linux-kernel@vger.kernel.org, dipankar@in.ibm.com
References: <20040717011936.GK3411@holomorphy.com> <3671.1090031334@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3671.1090031334@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2004 18:19:36 -0700, William Lee Irwin III wrote:
>> That's a large assumption. NUMA hardware typically violates it.

On Sat, Jul 17, 2004 at 12:28:54PM +1000, Keith Owens wrote:
> True, which is why I mentioned it.  However I suspect that you read
> something into that paragraph which was not intended.

The NUMA issue is the only caveat I saw. I guess I just wanted to
mention it by name.


On Sat, Jul 17, 2004 at 12:28:54PM +1000, Keith Owens wrote:
> Just reading the lockfree list and the structures on the list does not
> suffer from any NUMA problems, because reading does not perform any
> global updates at all.  The SMP starvation problem only kicks in when
> multiple concurrent updates are being done.  Even with multiple
> writers, one of the writers is guaranteed to succeed every time, so
> over time all the write operations will proceed, subject to fair access
> to exclusive cache lines.

The only methods I can think of to repair this (basically queueing) are
not busywait-free.


On Sat, Jul 17, 2004 at 12:28:54PM +1000, Keith Owens wrote:
> Lockfree reads with Moir's algorithms require extra memory bandwidth.
> In the absence of updates, all the cache lines end up in shared state.
> That reduces to local memory bandwidth for the (hopefully) common case
> of lots of readers and few writers.  Lockfree code is nicely suited to
> the same class of problem that RCU addresses, but without the reader
> vs. writer starvation problems.

I suppose it's worth refining the starvation claim to delaying freeing
memory as opposed to readers causing writers to busywait indefinitely.


On Sat, Jul 17, 2004 at 12:28:54PM +1000, Keith Owens wrote:
> Writer vs. writer starvation on NUMA is a lot harder.  I don't know of
> any algorithm that handles lists with lots of concurrent updates and
> also scales well on large cpus, unless the underlying hardware is fair
> in its handling of exclusive cache lines.

Well, neither do I. =)


-- wli
