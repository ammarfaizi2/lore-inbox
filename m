Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263842AbTICSAL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTICSAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:00:11 -0400
Received: from holomorphy.com ([66.224.33.161]:26249 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263842AbTICSAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:00:02 -0400
Date: Wed, 3 Sep 2003 11:00:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Larry McVoy <lm@work.bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030903180037.GP4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Larry McVoy <lm@work.bitmover.com>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903111934.GF10257@work.bitmover.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 05:41:39AM -0400, Brown, Len wrote:
>> The way to address memory latency is by increasing bandwidth and
>> increasing parallelism to use it -- thus amortizing the latency.  

On Wed, Sep 03, 2003 at 04:19:34AM -0700, Larry McVoy wrote:
> And if the app is a pointer chasing app, as many apps are, that doesn't
> help at all.
> It's pretty much analogous to file systems.  If bandwidth was the answer
> then we'd all be seeing data moving at 60MB/sec off the disk.  Instead 
> we see about 4 or 5MB/sec.

RAM is not operationally analogous to disk. For one, it supports
efficient random access, where disk does not.


On Wed, Sep 03, 2003 at 04:19:34AM -0700, Larry McVoy wrote:
> Expecting more bandwidth to help your app is like expecting more platter
> speed to help your file system.  It's not the platter speed, it's the
> seeks which are the problem.  Same thing in system doesn't, it's not the
> bcopy speed, it's the cache misses that are the problem.  More bandwidth
> doesn't do much for that.

Obviously, since the technique is merely increasing concurrency, it
doesn't help any individual application, but rather utilizes cpu
resources while one is stalled to execute another. Cache misses are no
mystery; N times the number of threads of execution is N times the cache
footprint (assuming all threads equal, which is never true but useful
to assume), so it doesn't pay to cachestrate. But it never did anyway.

The lines of reasoning presented against tightly coupled systems are
grossly flawed. Attacking the communication bottlenecks by increasing
the penalty for communication is highly ineffective, which is why these
cookie cutter clusters for everything strategies don't work even on
paper.

First, communication requirements originate from the applications, not
the operating system, hence so long as there are applications with such
requirements, the requirements for such kernels will exist. Second, the
proposal is ignoring numerous environmental constraints, for instance,
the system administration, colocation, and other costs of the massive
duplication of perfectly shareable resources implied by the clustering.
Third, the communication penalties are turned from memory access to I/O,
which is tremendously slower by several orders of magnitude. Fourth, the
kernel design problem is actually made harder, since no one has ever
been able to produce a working design for these cache coherent clusters
yet that I know of, and what descriptions of this proposal I've seen that
are extant (you wrote some paper on it, IIRC) are too vague to be
operationally useful.

So as best as I can tell the proposal consists of using an orders-of-
magnitude slower communication method to implement an underspecified
solution to some research problem that to all appearances will be more
expensive to maintain and keep running than the now extant designs.

I like distributed systems and clusters, and they're great to use for
what they're good for. They're not substitutes in any way for tightly
coupled systems, nor do they render large specimens thereof unnecessary.


-- wli
