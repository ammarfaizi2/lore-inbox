Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318979AbSH1UYr>; Wed, 28 Aug 2002 16:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318980AbSH1UYr>; Wed, 28 Aug 2002 16:24:47 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:6418 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318979AbSH1UYq>; Wed, 28 Aug 2002 16:24:46 -0400
Message-ID: <3D6D3216.D472CBC3@zip.com.au>
Date: Wed, 28 Aug 2002 13:27:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] adjustments to dirty memory thresholds
References: <3D6C53ED.32044CAD@zip.com.au> <20020828200857.GB888@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> On Tue, Aug 27, 2002 at 09:39:09PM -0700, Andrew Morton wrote:
> > These ratios are scaled so that as the highmem:lowmem ratio goes
> > beyond 4:1, the maximum amount of allowed dirty memory ceases to
> > increase.  It is clamped at the amount of memory which a 4:1 machine
> > is allowed to use.
> 
> This is disturbing. I suspect this is only going to raise poor memory
> utilization issues on highmem boxen.

The intent is to fix them.  Allowing more than 2G of dirty data to
float about seems unreasonable, and it pins buffer_heads.

But hey.  The patch merely sets the initial value of /proc/sys/vm/dirty*,
and those things are writeable.

> Of course, "f**k highmem" is such
> a common refrain these days so that's probably falling on deaf ears.

On the contrary.

> AFAICT the OOM issues are largely a by-product of mempool allocations
> entering out_of_memory() when they have the perfectly reasonable
> alternative strategy of simply waiting for the mempool to refill.

I don't have enough RAM to reproduce this.  Please send
call traces up from out_of_memory().
