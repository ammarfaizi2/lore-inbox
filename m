Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSG2CGR>; Sun, 28 Jul 2002 22:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSG2CGR>; Sun, 28 Jul 2002 22:06:17 -0400
Received: from holomorphy.com ([66.224.33.161]:32426 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316213AbSG2CGQ>;
	Sun, 28 Jul 2002 22:06:16 -0400
Date: Sun, 28 Jul 2002 19:09:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
Message-ID: <20020729020922.GW25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>, Andrea Arcangeli <andrea@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au> <20020729004942.GL1201@dualathlon.random> <3D44A2DF.F751B564@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D44A2DF.F751B564@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
>> how will you fix the pte_chain allocation to avoid deadlocks? please
>> elaborate. none of the callers can handle a failure there, no surprise
>> there is a panic there.

On Sun, Jul 28, 2002 at 07:05:19PM -0700, Andrew Morton wrote:
> I think that code's in redhat kernels, actually.  So it's presumably
> not occurring on a daily basis.   But no, it cannot be allowed
> to live.  It was replaced with a slab in the patches I sent yesterday,
> and Bill is cooking something up for the OOM handling there.

There is a small race for time here; if the OOM handling doesn't
materialize before the algorithm no longer requires per-pte allocation
it may not happen unless an explicit requirement appears.


On Sun, Jul 28, 2002 at 07:05:19PM -0700, Andrew Morton wrote:
> It's the 32G highmem systems which would be prepared to spend the CPU
> cycles to get the ZONE_NORMAL savings.  But we'd need appropriate
> conditionals so that 64-bit machines didn't need to pay for the 
> ia32 highmem silliness.

The bad news is this is going to turn into 64GB and soon. Hopefully
these will flop badly enough to silence the users thereof with the
most minimally invasive accommodations.


Cheers,
Bill
