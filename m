Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbTICUc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTICUc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:32:57 -0400
Received: from holomorphy.com ([66.224.33.161]:46474 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264363AbTICUbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:31:35 -0400
Date: Wed, 3 Sep 2003 13:31:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@work.bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scaling noise
Message-ID: <20030903203135.GW4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Larry McVoy <lm@work.bitmover.com>,
	"Brown, Len" <len.brown@intel.com>,
	Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com> <20030903111934.GF10257@work.bitmover.com> <20030903180037.GP4306@holomorphy.com> <20030903180547.GD5769@work.bitmover.com> <20030903181550.GR4306@holomorphy.com> <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk> <20030903194658.GC1715@holomorphy.com> <1062619984.20327.15.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062619984.20327.15.camel@dhcp23.swansea.linux.org.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 20:46, William Lee Irwin III wrote:
>> Pagecache access suddenly involves cross-instance communication instead
>> of swift memory access and function calls, with potentially enormous
>> invalidation latencies.

On Wed, Sep 03, 2003 at 09:13:05PM +0100, Alan Cox wrote:
> Your cross instance communication some LPAR like setup is tiny, it
> doesnt have to bounce over ethernet in that kind of setup that Larry
> talks about - in many cases its probably doable as atomic ops in a
> shared space

I was thinking of things like truncate(), which is already a single
system latency problem.


On Mer, 2003-09-03 at 20:46, William Lee Irwin III wrote:
>> a single instance (which are just memory copies) to cross-instance
>> data traffic, which involves slinging memory around through the
>> hypervisor's interface, which is slower.

On Wed, Sep 03, 2003 at 09:13:05PM +0100, Alan Cox wrote:
> Why. If I want to explicitly allocated shared space I can allocate it
> shared in a setup which is LPAR like. If its across a LAN then yes thats
> a different kettle of fish.

It'll probably deteriorate by an additional copy plus trap costs for
hcalls for things like sockets (and pipes are precluded unless far more
cross-system integration than I've heard of is planned). Userspace API's
for distributed shared memory are hard to program, but userspace could
exploit them to cut down on the amount of copying.


On Mer, 2003-09-03 at 20:46, William Lee Irwin III wrote:
>> Process migration is confined to within a single instance without
>> some very ugly bits; things such as forking servers and dynamic task
>> creation algorithms like thread pools fall apart here.

On Wed, Sep 03, 2003 at 09:13:05PM +0100, Alan Cox wrote:
> I'd be suprised if that is an issue because large systems either run
> lots of stuff so you can do the occasional move at fork time (which is
> expensive) or customised setups. Most NUMA setups already mess around
> with CPU binding to make the box fast

A better way of phrasing this is "the load balancing problem is harder".


-- wli
