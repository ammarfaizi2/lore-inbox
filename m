Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbTBTUC4>; Thu, 20 Feb 2003 15:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbTBTUCz>; Thu, 20 Feb 2003 15:02:55 -0500
Received: from tapu.f00f.org ([202.49.232.129]:39825 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S262492AbTBTUCy>;
	Thu, 20 Feb 2003 15:02:54 -0500
Date: Thu, 20 Feb 2003 12:13:00 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Zwane Mwaikambo <zwane@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-ID: <20030220201300.GA27814@f00f.org>
References: <Pine.LNX.4.44.0302201245100.10184-100000@localhost.localdomain> <Pine.LNX.4.44.0302200717230.2142-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302200717230.2142-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 07:43:16AM -0800, Linus Torvalds wrote:

> This could explain Chris' problems too - my doublefault thing won't
> help much if recursion on the stack has clobbered a lot of kernel
> state (and the doublefault will likely happen only after enough
> state is clobbered that even the doublefault handling might have
> trouble).

An overflow *might* explain why

  - it never happens under 2.4.x

  - for some configurations of 2.5.x it never seems to happen either

  - for some configurations of 2.5.x it does happen, but it's very
    nebulous as to which options are required to make this happen;
    very few options seems table,  many options crashes quickly, and a
    in-between it lasts for what might be slightly longer periods of
    time

Now, one thing I'm using that many people may not be is XFS, ACLs &
quota.  Since IRIX has almost inifinite memory available in
kernel-space, I should check to make sure XFS isn't sucking too much
stack space somewhere...  it could be that it is, and depending on the
right magic internal XFS state and when an interrupt arrives or
similar, something goes splat.

I have the stack checking on, but as observed it may not suffice.  I
wonder if 16k stacks are possible for testing?



  --cw

