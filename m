Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267606AbSLFFx2>; Fri, 6 Dec 2002 00:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267607AbSLFFx2>; Fri, 6 Dec 2002 00:53:28 -0500
Received: from holomorphy.com ([66.224.33.161]:3470 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267606AbSLFFx2>;
	Fri, 6 Dec 2002 00:53:28 -0500
Date: Thu, 5 Dec 2002 22:00:51 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Norman Gaywood <norm@turing.une.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206060051.GN9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
	Norman Gaywood <norm@turing.une.edu.au>,
	linux-kernel@vger.kernel.org
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com> <3DF034BB.D5F863B5@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF034BB.D5F863B5@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> Yes, it's necessary; no, I've never directly encountered the issue it
>> fixes. Sorry about the miscommunication there.

On Thu, Dec 05, 2002 at 09:25:15PM -0800, Andrew Morton wrote:
> Linus's approach was to raise the ZONE_NORMAL pages_min limit for
> allocations which _could_ use highmem.  So a GFP_HIGHUSER allocation
> has a pages_min limit of (say) 4M when considering the normal zone,
> but a GFP_KERNEL allocation has a limit of 2M.
> Andrea's patch does the same thing, via a separate table.   He has
> set the threshold much higher (100M on a 4G box).   AFAICT, the
> algorithms are identical - I was planning on just adding a multiplier
> to set Linus's ratio - it is currently hardwired to "1".   Search for 
> "mysterious" in mm/page_alloc.c ;)

There's no mystery here aside from a couple of magic numbers and a
not-very-well-explained admission control policy.

Tweaking magic numbers a la 2.4.x-aa until more infrastructure is
available (2.7) sounds good to me.

Thanks,
Bill
