Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267746AbUHRVko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267746AbUHRVko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267796AbUHRVko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:40:44 -0400
Received: from holomorphy.com ([207.189.100.168]:55993 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267746AbUHRVk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:40:29 -0400
Date: Wed, 18 Aug 2004 14:40:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: pj@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Does io_remap_page_range() take 5 or 6 args?
Message-ID: <20040818214026.GL11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, pj@sgi.com,
	linux-kernel@vger.kernel.org
References: <20040818133348.7e319e0e.pj@sgi.com> <20040818205338.GF11200@holomorphy.com> <20040818135638.4326ca02.davem@redhat.com> <20040818210503.GG11200@holomorphy.com> <20040818143029.23db8740.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818143029.23db8740.davem@redhat.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 14:05:03 -0700 William Lee Irwin III wrote:
>> We should pass 64-bit values to remap_page_range() also, then. Or
>> perhaps passing pfn's to both suffices, as it all has to be page
>> aligned anyway.

On Wed, Aug 18, 2004 at 02:30:29PM -0700, David S. Miller wrote:
> Does not work on a system who has more physical address bits
> than 32 + PAGE_SHIFT
> Sparc32 does not fall into this category... but some other
> might.

All extant systems of this category I'm aware of are 32-bit kernels on
64-bit machines, which we don't really support. Also, the assumption
that physical addresses are bounded by 1ULL << (BITS_PER_LONG + PAGE_SHIFT)
is made broadly elsewhere, particularly in pfn_to_page() and the like.
Making this assumption in remap_page_range() and io_remap_page_range()
would save the overhead of passing additional arguments and/or passing
64-bit arguments on 32-bit machines. Using pgoff_t for pfn's may prove
useful for such systems, but it's highly doubtful the kernel will ever
be made clean for such or that they'll ever be brought to a usable state.


-- wli
