Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268348AbTBYVMh>; Tue, 25 Feb 2003 16:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268353AbTBYVMh>; Tue, 25 Feb 2003 16:12:37 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:58318 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268348AbTBYVMa>; Tue, 25 Feb 2003 16:12:30 -0500
Date: Tue, 25 Feb 2003 13:12:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <421460000.1046207575@flay>
In-Reply-To: <20030225211718.GY29467@dualathlon.random>
References: <96700000.1045871294@w-hlinder>
 <20030222192424.6ba7e859.akpm@digeo.com>
 <20030225171727.GN29467@dualathlon.random>
 <20030225174359.GA10411@holomorphy.com>
 <20030225175928.GP29467@dualathlon.random>
 <20030225185008.GF10396@holomorphy.com>
 <20030225191817.GT29467@dualathlon.random> <372680000.1046201260@flay>
 <20030225203001.GV29467@dualathlon.random> <417110000.1046206424@flay>
 <20030225211718.GY29467@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Because you don't set up and tear down the rmap pte-chains for every 
>> fault in / delete of any page ... it just works off the vmas.
> 
> so basically it uses the rmap that we always had since at least 2.2 for
> everything but anon mappings, right?  this is what DaveM did a few years
> back too. This makes lots of sense to me, so at least we avoid the
> duplication of rmap information, even if it won't fix the anonymous page
> overhead, but clearly it's much lower cost for everything but anonymous
> pages.

Right ... and anonymous chains are about 95% single-reference (at least for
the case I looked at), so they're direct mapped from the struct page with
no chain at all. Cuts out something like 95% of the space overhead of
pte-chains, and 65% of the time (for kernel compile -j256 on 16x system).
However, it's going to be a little more expensive to *use* the mappings, 
so we need to measure that carefully.

M.

