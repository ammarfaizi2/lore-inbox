Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSHaW3W>; Sat, 31 Aug 2002 18:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSHaW3W>; Sat, 31 Aug 2002 18:29:22 -0400
Received: from holomorphy.com ([66.224.33.161]:63632 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318044AbSHaW3V>;
	Sat, 31 Aug 2002 18:29:21 -0400
Date: Sat, 31 Aug 2002 15:30:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@zip.com.au>,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [RFC] [PATCH] Include LRU in page count
Message-ID: <20020831223044.GC18114@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@arcor.de>,
	Andrew Morton <akpm@zip.com.au>,
	Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
References: <3D644C70.6D100EA5@zip.com.au> <E17lEDR-0004Qq-00@starship> <3D712682.66E2D3B2@zip.com.au> <E17lFQV-0004RO-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <E17lFQV-0004RO-00@starship>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 11:05:02PM +0200, Daniel Phillips wrote:
> The current patch seems satisfactory performance-wise and if it's
> also raceless as it's supposed to be, it gives us something that works,
> and we can evaluate alternatives at our leisure.  Right now I'm afraid
> we have something that just works most of the time.
> I think we're getting to the point where this needs to get some heavy
> beating up, to see what happens.

It's not going to get much heavier than how I'm beating on it.
Although it seems my box is mighty bored during 64 simultaneous
tiobench 256's (i.e. 16384 tasks). I got bored & compiled a kernel:

make -j64 bzImage  304.60s user 848.70s system 694% cpu 2:46.05 total

The cpus are 95+% idle except for when I touch /proc/, where the task
fishing around /proc/ gets stuck spinning hard in the kernel for
anywhere from 30 minutes to several hours before killing it succeeds.
It didn't quite finish the run, as the tty deadlock happened again. The
VM doesn't appear to be oopsing, though I should slap on the OOM fixes.


Cheers,
Bill
