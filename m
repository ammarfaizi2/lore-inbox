Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbULOHSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbULOHSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 02:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbULOHRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 02:17:43 -0500
Received: from cantor.suse.de ([195.135.220.2]:16604 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262277AbULOHRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 02:17:35 -0500
Date: Wed, 15 Dec 2004 08:17:34 +0100
From: Andi Kleen <ak@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andi Kleen <ak@suse.de>, Brent Casavant <bcasavan@sgi.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 0/3] NUMA boot hash allocation interleaving
Message-ID: <20041215071734.GO27225@wotan.suse.de>
References: <Pine.SGI.4.61.0412141140030.22462@kzerza.americas.sgi.com> <9250000.1103050790@flay> <20041214191348.GA27225@wotan.suse.de> <19030000.1103054924@flay> <Pine.SGI.4.61.0412141720420.22462@kzerza.americas.sgi.com> <20041215040854.GC27225@wotan.suse.de> <686170000.1103094885@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <686170000.1103094885@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 11:14:46PM -0800, Martin J. Bligh wrote:
> Well hold on a sec. We don't need to use the hugepages pool for this,
> do we? This is the same as using huge page mappings for the whole of
> kernel space on ia32. As long as it's a kernel mapping, and 16MB aligned
> and contig, we get it for free, surely?

The whole point of the patch is to not use the direct mapping, but
use a different interleaved mapping on NUMA machines to spread
the memory out over multiple nodes.

> > Using other page sizes would be probably tricky because the 
> > linux VM can currently barely deal with two page sizes.
> > I suspect handling more would need some VM infrastructure effort
> > at least in the changed port. 
> 
> For the general case I'd agree. But this is a setup-time only tweak
> of the static kernel mapping, isn't it?

It's probably not impossible, just lots of ugly special cases.
e.g. how about supporting it for /proc/kcore etc? 

-Andi

