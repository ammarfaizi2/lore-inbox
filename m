Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317804AbSGPItu>; Tue, 16 Jul 2002 04:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317807AbSGPItt>; Tue, 16 Jul 2002 04:49:49 -0400
Received: from holomorphy.com ([66.224.33.161]:52353 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317804AbSGPIts>;
	Tue, 16 Jul 2002 04:49:48 -0400
Date: Tue, 16 Jul 2002 01:52:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
Message-ID: <20020716085233.GA1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
References: <20020716062453.GK1022@holomorphy.com> <3D33C64A.7491B591@zip.com.au> <20020716083142.GQ811@suse.de> <3D33DED8.C5C92C06@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D33DED8.C5C92C06@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>> GFP_NOIO has __GFP_WAIT set, so bio_copy -> bio_alloc -> mempool_alloc
>> should never fail. Puzzled.

On Tue, Jul 16, 2002 at 01:52:40AM -0700, Andrew Morton wrote:
> Presumably the loop driver was called from within shrink_cache(),
> as PF_MEMALLOC.  Those allocations can fail.
> That's maybe wrong - if there are a decent number of pages
> under writeback then we should be able to just wait it out.
> But it gets tricky with the loop driver...

I included a backtrace in my original post showing that the allocation
failure did indeed occur beneath shrink_cache().

>From watching /proc/meminfo it was clear that there were only 1MB or
2MB under writeback, but it also showed that the dirty memory thresholds
were being exceeded. The debugging information obtained was unclear.
The counters reported in /proc/meminfo appear to be accurate.


Cheers,
Bill
