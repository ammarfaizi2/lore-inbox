Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265683AbTABFQo>; Thu, 2 Jan 2003 00:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265689AbTABFQo>; Thu, 2 Jan 2003 00:16:44 -0500
Received: from holomorphy.com ([66.224.33.161]:63170 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265683AbTABFQn>;
	Thu, 2 Jan 2003 00:16:43 -0500
Date: Wed, 1 Jan 2003 21:25:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: 2.5.53-mm2
Message-ID: <20030102052504.GQ9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org
References: <3E0E4744.8EE126ED@digeo.com> <20030102045327.GC7644@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102045327.GC7644@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2002 at 04:52:20PM -0800, Andrew Morton wrote:
>> wli-11_pgd_ctor.patch

On Wed, Jan 01, 2003 at 08:53:27PM -0800, William Lee Irwin III wrote:
> A moment's reflection on the subject suggests to me it's worthwhile to
> generalize pgd_ctor support so it works (without #ifdefs!) on both PAE
> and non-PAE. This tiny tweak is actually more noticeably beneficial
> on non-PAE systems but only really because pgd_alloc() is more visible;
> the most likely reason it's less visible on PAE is "other overhead".
> It looks particularly nice since it removes more code than it adds.
> Touch tested on NUMA-Q (PAE). OFTC #kn testers testing the non-PAE case.

For those needing more interpretation, this is essentially a reinstatement
of the 2.4.x-style pgd/pmd cache optimization in a leak-free and accounted
(in /proc/slabinfo) manner.

The point of the optimizations is that these initializations are large
cache hits to take in a single shot, and in the PAE case, amount to a
full L1 cache flush as they traverse almost an entire 16K.

No rigorous benchmarking has been done yet.

Bill
