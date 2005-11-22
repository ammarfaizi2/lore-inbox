Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbVKVKOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbVKVKOa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 05:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVKVKOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 05:14:30 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:31761 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932343AbVKVKO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 05:14:29 -0500
Message-ID: <4382EF48.1050107@shadowen.org>
Date: Tue, 22 Nov 2005 10:13:28 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Andi Kleen <ak@suse.de>, linux-mm@kvack.org, mingo@elte.hu,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH 2/5] Light Fragmentation Avoidance V20: 002_usemap
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie> <200511160036.54461.ak@suse.de> <Pine.LNX.4.58.0511160137540.8470@skynet> <200511160252.05494.ak@suse.de> <Pine.LNX.4.58.0511160200530.8470@skynet>
In-Reply-To: <Pine.LNX.4.58.0511160200530.8470@skynet>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:

> That's iterating through, potentially, 1024 pages which I considered too
> expensive. In terms of code complexity, the page-flags patch adds 237
> which is not much of a saving in comparison to 275 that the usemap
> approach uses.

Surley you would just use a single bit in the first page of a MAX_ORDER
block.   We guarentee that the mem_map is contigious out to MAX_ORDER
pages so you can simply calculate the offset.  The page free path does
the same thing to find the buddy pages when coallescing.

> Again, I can revisit the page-flag approach if I thought that something
> like this would get merged and people would not choke on another page flag
> being consumed.

All of that said, I am not even sure we have a bit left in the page
flags on smaller architectures :/.

-apw
