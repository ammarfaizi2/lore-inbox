Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264094AbUDRB7X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 21:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264100AbUDRB7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 21:59:23 -0400
Received: from holomorphy.com ([207.189.100.168]:27533 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264094AbUDRB7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 21:59:21 -0400
Date: Sat, 17 Apr 2004 18:59:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040418015918.GU743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, Marc Singer <elf@buici.com>,
	linux-kernel@vger.kernel.org
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org> <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417165151.24b1fed5.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer <elf@buici.com> wrote:
>> I've watched the vmscan code at work.  The memory pressure is so high
>> that it reclaims mapped pages zealously.  The program's code pages are
>> being evicted frequently.

On Sat, Apr 17, 2004 at 04:51:51PM -0700, Andrew Morton wrote:
> Which tends to imply that the VM is not reclaiming any of that nfs-backed
> pagecache.

The observation that prompted the max() vs. addition was:

	On Sat, Apr 17, 2004 at 10:57:24AM -0700, Marc Singer wrote:
	> I don't think that's the whole story.  I printed distress,
	> mapped_ratio, and swappiness when vmscan starts trying to reclaim
	> mapped pages.
	> reclaim_mapped: distress 50  mapped_ratio 0  swappiness 60
	>   50 + 60 > 100
	> So, part of the problem is swappiness.  I could set that value to 25,
	> for example, to stop the machine from swapping.
	> I'd be fine stopping here, except for you comment about what
	> swappiness means.  In my case, nearly none of memory is mapped.  It is
	> zone priority which has dropped to 1 that is precipitating the
	> eviction.  Is this what you expect and want?


Marc Singer <elf@buici.com> wrote:
>> I've been wondering if the swappiness isn't a red herring.  Is it
>> reasonable that the distress value (in refill_inactive_zones ()) be
>> 50?

On Sat, Apr 17, 2004 at 04:51:51PM -0700, Andrew Morton wrote:
> I'd assume that setting swappiness to zero simply means that you still have
> all of your libc in pagecache when running ls.
> What happens if you do the big file copy, then run `sync', then do the ls?
> Have you experimented with the NFS mount options?  v2? UDP?

I wonder if the ptep_test_and_clear_young() TLB flushing is related.


-- wli
