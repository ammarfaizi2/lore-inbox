Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274924AbSITEDa>; Fri, 20 Sep 2002 00:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274925AbSITEDa>; Fri, 20 Sep 2002 00:03:30 -0400
Received: from holomorphy.com ([66.224.33.161]:55173 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S274924AbSITEDa>;
	Fri, 20 Sep 2002 00:03:30 -0400
Date: Thu, 19 Sep 2002 21:02:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020920040228.GF3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Hanna Linder <hannal@us.ibm.com>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020920000815.GC3530@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 04:38:14PM -0700, Andrew Morton wrote:
>> It would be interesting to know the context switch rate
>> during this test, and to see what things look like with HZ=100.

On Thu, Sep 19, 2002 at 05:08:15PM -0700, William Lee Irwin III wrote:
> The context switch rate was 60 or 70 cs/sec. during the steady
> state of the test, and around 10K cs/sec for ramp-up and ramp-down.
> I've already prepared a kernel with a lowered HZ, but stopped briefly to
> debug a calibrate_delay() oops and chat with folks around the workplace.

Okay, figured that one out (c.f. x86_udelay_tsc thread). I'll grind out
another one in about 90-120 minutes or thereabouts with HZ == 100. I'm
going to take a wild guess param.h should have an #ifdef there for
NR_CPUS >= WLI_SAW_EXCESS_TIMER_INTS_HERE or something. It's probably
possible to figure out what the service time vs. arrival rate stuff says
but it's too easy to fix to be worth analyzing, and we don't exist to
process timer ticks anyway. Hrm, yet another cry for i386 subarches?

Hanna, did you have a particular dcache patch in mind? ISTR there were
several flavors. (I can of course sift through them myself as well.)

Cheers,
Bill
