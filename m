Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUIXEDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUIXEDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 00:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUIXEDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 00:03:36 -0400
Received: from holomorphy.com ([207.189.100.168]:41180 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266879AbUIXEBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 00:01:52 -0400
Date: Thu, 23 Sep 2004 21:01:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Yasunori Goto <ygoto@us.fujitsu.com>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Patch/RFC]Removing zone and node ID from page->flags[0/3]
Message-ID: <20040924040117.GS9106@holomorphy.com>
References: <20040923135108.D8CC.YGOTO@us.fujitsu.com> <20040923232713.GJ9106@holomorphy.com> <20040923203516.0207.YGOTO@us.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923203516.0207.YGOTO@us.fujitsu.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 08:51:58PM -0700, Yasunori Goto wrote:
> Thank you for comment.

At some point in the past, I wrote:
>> Looks relatively innocuous. I wonder if cosmetically we may want
>> s/struct zone_tbl/struct zone_table/

On Thu, Sep 23, 2004 at 08:51:58PM -0700, Yasunori Goto wrote:
> Do you mean "struct zone_table" is better as its name?
> If so, I'll change it.

I'm not extremely picky about naming conventions, and the abbreviation
isn't bad or anything. If there's someone else who also likes it better,
or if you yourself do, I'd change it then.


At some point in the past, I wrote:
>> I like the path compression in the 2-level radix tree.

On Thu, Sep 23, 2004 at 08:51:58PM -0700, Yasunori Goto wrote:
> Hmmmm.....
> Current radix tree code uses slab allocator.
> But, zone_table must be initialized before free_all_bootmem()
> and kmem_cache_alloc().
> So, if I use it for zone_table, I think I have to change radix tree
> code to use bootmem or have to write other original code.
> I'm not sure it is better way....

I meant it as an instance of a radix tree data structure, not to e.g.
be consolidated with the kernel's radix tree library functions (which
have the bootstrap ordering issues you describe preventing their use
for this kind of purpose). The generic software pagetables are also
radix trees, but similarly have constraints (e.g. use on machines with
hardware-interpreted pagetables) preventing consolidation with the
radix tree library code.


-- wli
