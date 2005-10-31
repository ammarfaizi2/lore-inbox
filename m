Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVJaF5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVJaF5i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 00:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbVJaF5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 00:57:38 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:55430 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932317AbVJaF5h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 00:57:37 -0500
Date: Sun, 30 Oct 2005 21:57:25 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051031055725.GA3820@w-mikek2.ibm.com>
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 06:33:55PM +0000, Mel Gorman wrote:
> Here are a few brief reasons why this set of patches is useful;
> 
> o Reduced fragmentation improves the chance a large order allocation succeeds
> o General-purpose memory hotplug needs the page/memory groupings provided
> o Reduces the number of badly-placed pages that page migration mechanism must
>   deal with. This also applies to any active page defragmentation mechanism.

I can say that this patch set makes hotplug memory remove be of
value on ppc64.  My system has 6GB of memory and I would 'load
it up' to the point where it would just start to swap and let it
run for an hour.  Without these patches, it was almost impossible
to find a section that could be offlined.  With the patches, I
can consistently reduce memory to somewhere between 512MB and 1GB.
Of course, results will vary based on workload.  Also, this is
most advantageous for memory hotlug on ppc64 due to relatively
small section size (16MB) as compared to the page grouping size
(8MB).  A more general purpose solution is needed for memory hotplug
support on architectures with larger section sizes.

Just another data point,
-- 
Mike
