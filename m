Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317063AbSIEGJy>; Thu, 5 Sep 2002 02:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSIEGJy>; Thu, 5 Sep 2002 02:09:54 -0400
Received: from holomorphy.com ([66.224.33.161]:14761 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317063AbSIEGJx>;
	Thu, 5 Sep 2002 02:09:53 -0400
Date: Wed, 4 Sep 2002 23:05:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com
Subject: Re: statm_pgd_range() sucks!
Message-ID: <20020905060534.GZ888@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, riel@surriel.com
References: <20020830015814.GN18114@holomorphy.com> <3D6EDDC0.F9ADC015@zip.com.au> <20020905032035.GY888@holomorphy.com> <3D76E207.1FA08024@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D76E207.1FA08024@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> I lost track of what the TODO's were but this is of relatively minor
>> import, and I lagged long enough this is against 2.5.33-mm2:

On Wed, Sep 04, 2002 at 09:48:07PM -0700, Andrew Morton wrote:
> Well the TODO was to worry about the (very) incorrect reporting of
> mapping occupancy.  mmap(1G file), touch one byte of it (or none)
> and the thing will report 1G?

I don't know of anything actually meant to report mapping occupancy
(except full RSS) before or after this patch. Or have I blundered?


On Wed, Sep 04, 2002 at 09:48:07PM -0700, Andrew Morton wrote:
> We figured that per-vma rss accounting would be easy and would fix
> it, then we remembered that vma's can be split into two, which
> screwed that plan most royally.
> Maybe when a VMA is split, we set the new VMA to have an rss of zero,
> and keep on doing the accounting.  That way, the sum-of-vmas is
> still correct even though the individual ones are wildly wrong??

Hmm, that could get hairy depending on how we want them grouped. It
might be better just to maintain RSS counters for the kinds of mappings
we're interested in. Doing pagetable walks to make splitvma() do that
right could perform poorly. Otherwise we'd have to find another
instance of the same kind of thing to "donate" our RSS to on unmap.


Cheers,
Bill
