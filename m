Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbRHHSyV>; Wed, 8 Aug 2001 14:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbRHHSyM>; Wed, 8 Aug 2001 14:54:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58498 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265844AbRHHSxz>;
	Wed, 8 Aug 2001 14:53:55 -0400
Date: Wed, 8 Aug 2001 11:53:28 -0700
Message-Id: <200108081853.LAA02747@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: lm@bitmover.com
CC: torvalds@transmeta.com, frankeh@us.ibm.com, mkravetz@beaverton.ibm.com,
        linux-kernel@vger.kernel.org, wscott@bitmover.com
In-Reply-To: <20010808111844.S23718@work.bitmover.com> (message from Larry
	McVoy on Wed, 8 Aug 2001 11:18:44 -0700)
Subject: Re: [RFC][PATCH] Scalable Scheduling
In-Reply-To: <Pine.LNX.4.33.0108081041260.8047-100000@penguin.transmeta.com> <Pine.LNX.4.33.0108081058420.8103-100000@penguin.transmeta.com> <20010808111844.S23718@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 8 Aug 2001 11:18:44 -0700
   From: Larry McVoy <lm@bitmover.com>

   Someobdy really ought to take the time to make a cache miss counter program
   that works like /bin/time.  So I could do

	   $ cachemiss lat_ctx 2
	   10123 instruction, 22345 data, 50432 TLB flushes

   Has anyone done that?  If so, then what would be cool is if each of these
   wonderful new features that people propose come with cachemiss results for
   the related part of LMbench or some other benchmark.

On some platforms, such an app can basically be written already.

The kernel support is there for sparc64 wrt. the cache
miss stuff.  It uses the cpu performance counter stuff.
Have a look at linux/include/asm-sparc64/perfctr.h to see
what I mean.

The performance counters are fancy enough that you can
ask them to do stuff like:

1) tell me D-cache misses in user and/or kernel mode
2) tell me D-cache misses that hit the E-cache
   in user and/or kernel mode
3) tell me I-cache misses, but only those which actually
   ended up stalling the pipeline
4) tell me E-cache misses, where the chip was not able
   to get granted to memory bus immediately
5) Same as #4, but how many total bus cycles were spent
   waiting for bus grant for the E-cache miss

Later,
David S. Miller
davem@redhat.com
