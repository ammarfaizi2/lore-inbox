Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264358AbTICURT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTICUPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:15:34 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:30926 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264451AbTICUPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:15:00 -0400
Subject: Re: Scaling noise
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Larry McVoy <lm@work.bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030903194658.GC1715@holomorphy.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com>
	 <20030903111934.GF10257@work.bitmover.com>
	 <20030903180037.GP4306@holomorphy.com>
	 <20030903180547.GD5769@work.bitmover.com>
	 <20030903181550.GR4306@holomorphy.com>
	 <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk>
	 <20030903194658.GC1715@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062619984.20327.15.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 21:13:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 20:46, William Lee Irwin III wrote:
> The sharing matters; e.g. libc and other massively shared bits are
> replicated in memory once per instance, which increases memory and
> cache footprint(s). A number of other consequences of the sharing loss:

Memory is cheap. NUMA people already replicate pages on big systems,
even the entire kernel. Last time I looked libc cost me under $1 a
system.

> Pagecache access suddenly involves cross-instance communication instead
> of swift memory access and function calls, with potentially enormous
> invalidation latencies.

Your cross instance communication some LPAR like setup is tiny, it
doesnt have to bounce over ethernet in that kind of setup that Larry
talks about - in many cases its probably doable as atomic ops in a
shared space

> a single instance (which are just memory copies) to cross-instance
> data traffic, which involves slinging memory around through the
> hypervisor's interface, which is slower.

Why. If I want to explicitly allocated shared space I can allocate it
shared in a setup which is LPAR like. If its across a LAN then yes thats
a different kettle of fish.

> Process migration is confined to within a single instance without
> some very ugly bits; things such as forking servers and dynamic task
> creation algorithms like thread pools fall apart here.

I'd be suprised if that is an issue because large systems either run
lots of stuff so you can do the occasional move at fork time (which is
expensive) or customised setups. Most NUMA setups already mess around
with CPU binding to make the box fast
 
> AFAICT this raises more issues than it addresses. Not that the issues
> aren't worth addressing, but there's a lot more to do than Larry
> saying "I think this is a good idea" before expecting anyone to even
> think it's worth thinking about.

Agreed

