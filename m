Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSIEEbB>; Thu, 5 Sep 2002 00:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSIEEbB>; Thu, 5 Sep 2002 00:31:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61454 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316789AbSIEEbA>;
	Thu, 5 Sep 2002 00:31:00 -0400
Message-ID: <3D76E207.1FA08024@zip.com.au>
Date: Wed, 04 Sep 2002 21:48:07 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com
Subject: Re: statm_pgd_range() sucks!
References: <20020830015814.GN18114@holomorphy.com> <3D6EDDC0.F9ADC015@zip.com.au> <20020905032035.GY888@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Thu, Aug 29, 2002 at 07:51:44PM -0700, Andrew Morton wrote:
> > BTW, Rohit's hugetlb patch touches proc_pid_statm(), so a diff on -mm3
> > would be appreciated.
> 
> I lost track of what the TODO's were but this is of relatively minor
> import, and I lagged long enough this is against 2.5.33-mm2:

Well the TODO was to worry about the (very) incorrect reporting of
mapping occupancy.  mmap(1G file), touch one byte of it (or none)
and the thing will report 1G?

We figured that per-vma rss accounting would be easy and would fix
it, then we remembered that vma's can be split into two, which
screwed that plan most royally.

Maybe when a VMA is split, we set the new VMA to have an rss of zero,
and keep on doing the accounting.  That way, the sum-of-vmas is
still correct even though the individual ones are wildly wrong??
