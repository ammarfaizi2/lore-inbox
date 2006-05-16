Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbWEPNvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbWEPNvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 09:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWEPNvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 09:51:37 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:60890 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751098AbWEPNvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 09:51:37 -0400
Date: Tue, 16 May 2006 15:51:35 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Valerie Henson <val_henson@linux.intel.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Blaisorblade <blaisorblade@yahoo.it>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Linux Memory Management <linux-mm@kvack.org>,
       Val Henson <val.henson@intel.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
Message-ID: <20060516135135.GA28995@rhlx01.fht-esslingen.de>
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <200605030225.54598.blaisorblade@yahoo.it> <445CC949.7050900@redhat.com> <445D75EB.5030909@yahoo.com.au> <4465E981.60302@yahoo.com.au> <20060513181945.GC9612@goober> <4469D3F8.8020305@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4469D3F8.8020305@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 16, 2006 at 11:30:32PM +1000, Nick Piggin wrote:
> I also tried running kbuild under UML, and could not make find_vma take
> much time either [in this case, the per-thread vma cache patch roughly
> doubles the number of hits, from about 15%->30% (in the host)].
> 
> So I guess it's time to go back into my hole. If anyone does come across
> a find_vma constrained workload (especially with threads), I'd be very
> interested.

I cannot offer much other than some random confirmation that from my own
oprofiling, whatever I did (often running a load test script consisting of
launching 30 big apps at the same time), find_vma basically always showed up
very prominently in the list of vmlinux-based code (always ranking within the
top 4 or 5 kernel hotspots, such as timer interrupts, ACPI idle I/O etc.pp.).
call-tracing showed it originating from mmap syscalls etc., and AFAIR quite
some find_vma activity from oprofile itself.
Profiling done on 512MB UP Athlon and P3/700, 2.6.16ish, current Debian.
Sorry for the foggy report, I don't have those logs here right now.

So yes, improving that part should help in general, but I cannot quite
say that my machines are "constrained" by it.

But you probably knew that already, otherwise you wouldn't have poked
in there... ;)

Andreas Mohr
