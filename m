Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268269AbUJGVlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268269AbUJGVlo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUJGVlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:41:15 -0400
Received: from convulsion.choralone.org ([212.13.208.157]:516 "EHLO
	convulsion.choralone.org") by vger.kernel.org with ESMTP
	id S268170AbUJGVjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:39:21 -0400
Date: Thu, 7 Oct 2004 22:39:13 +0100
From: Dave Jones <davej@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-ID: <20041007213913.GA5302@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
References: <20041007142019.D2441@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041007142019.D2441@build.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 02:20:19PM -0700, Chris Wright wrote:
 > Is this known?  Just came back from lunch, so I've no clue what kicked it
 > off.  Profile below. (2.6.9-rc3-bk from yesterday, pending updates don't
 > appear to touch vmscan or mm/ in general).
 > 
 > CPU: AMD64 processors, speed 1994.35 MHz (estimated)
 > Counted CPU_CLK_UNHALTED events (Cycles outside of halt state) with a
 > unit mask
 > of 0x00 (No unit mask) count 100000
 > samples  %        symbol name
 > 2410135  53.4092  balance_pgdat
 > 1328186  29.4329  shrink_zone
 > 555121   12.3016  shrink_slab
 > 84942     1.8823  __read_page_state
 > 40770     0.9035  timer_interrupt

I saw the same thing yesterday, also on an amd64 box though that
could be coincidence. The kswapd1 process was pegging the cpu at 99%
kswapd0 was idle.  After a few minutes, the box became so unresponsive
I had to reboot it.

I had put this down to me fiddling with some patches, and it hasnt'
reappeared today yet, but it sounds like we're seeing the same thing.

Sadly, I didn't get a profile of what was happening.
A 'make allmodconfig' triggered it for me, on a box with 2GB of ram,
and 2GB of swap. No swap was in use when things 'went wierd', and
there was a bunch of RAM sitting free too (about half a gig if memory
serves correctly)

		Dave

