Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbTBUKmk>; Fri, 21 Feb 2003 05:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbTBUKmk>; Fri, 21 Feb 2003 05:42:40 -0500
Received: from holomorphy.com ([66.224.33.161]:54179 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267243AbTBUKmj>;
	Fri, 21 Feb 2003 05:42:39 -0500
Date: Fri, 21 Feb 2003 02:51:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, David Lang <david.lang@digitalinsight.com>,
       linux-kernel@vger.kernel.org
Subject: Re: IO scheduler benchmarking
Message-ID: <20030221105146.GA10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	David Lang <david.lang@digitalinsight.com>,
	linux-kernel@vger.kernel.org
References: <20030220212304.4712fee9.akpm@digeo.com> <Pine.LNX.4.44.0302202247110.12601-100000@dlang.diginsite.com> <20030221001624.278ef232.akpm@digeo.com> <20030221103140.GN31480@x30.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221103140.GN31480@x30.school.suse.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 12:16:24AM -0800, Andrew Morton wrote:
>> Well 2.4 is unreponsive period.  That's due to problems in the VM -
>> processes which are trying to allocate memory get continually DoS'ed
>> by `cp' in page reclaim.

On Fri, Feb 21, 2003 at 11:31:40AM +0100, Andrea Arcangeli wrote:
> this depends on the workload, you may not have that many allocations,
> a echo 1 >/proc/sys/vm/bdflush will fix it shall your workload be hurted
> by too much dirty cache. Furthmore elevator-lowlatency makes
> the blkdev layer much more fair under load.

Restricting io in flight doesn't actually repair the issues raised by
it, but rather avoids them by limiting functionality.

The issue raised here is streaming io competing with processes working
within bounded memory. It's unclear to me how 2.5.x mitigates this but
the effects are far less drastic there. The "fix" you're suggesting is
clamping off the entire machine's io just to contain the working set of
a single process that generates unbounded amounts of dirty data and
inadvertently penalizes other processes via page reclaim, where instead
it should be forced to fairly wait its turn for memory.

-- wli
