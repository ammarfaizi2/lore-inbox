Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268301AbUJGV4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268301AbUJGV4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 17:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUJGVvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 17:51:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:38291 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268360AbUJGVtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 17:49:49 -0400
Date: Thu, 7 Oct 2004 14:49:48 -0700
From: Chris Wright <chrisw@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-ID: <20041007144948.K2357@build.pdx.osdl.net>
References: <20041007142019.D2441@build.pdx.osdl.net> <20041007213913.GA5302@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041007213913.GA5302@redhat.com>; from davej@redhat.com on Thu, Oct 07, 2004 at 10:39:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@redhat.com) wrote:
> I saw the same thing yesterday, also on an amd64 box though that
> could be coincidence. The kswapd1 process was pegging the cpu at 99%
> kswapd0 was idle.

Same here.

> After a few minutes, the box became so unresponsive
> I had to reboot it.

Well, that CPU is useless ;-)  Otherwise the thing is still responding. 
One thing I noticed is the swap usage:

# grep Swap proc/meminfo
SwapCached:          4 kB
SwapTotal:     2031608 kB
SwapFree:      2031604 kB

So, I'm guessing the first page that went out to swap started this thing
off.

> I had put this down to me fiddling with some patches, and it hasnt'
> reappeared today yet, but it sounds like we're seeing the same thing.

I do have some local changes too.  But nothing that should trigger this.

> Sadly, I didn't get a profile of what was happening.
> A 'make allmodconfig' triggered it for me, on a box with 2GB of ram,
> and 2GB of swap. No swap was in use when things 'went wierd', and
> there was a bunch of RAM sitting free too (about half a gig if memory
> serves correctly)

Memory's a bit tighter here, but still 55M free though.

# cat /proc/meminfo
MemTotal:      2053240 kB
MemFree:         55324 kB
Buffers:        161900 kB
Cached:        1321312 kB
SwapCached:          4 kB
Active:         988476 kB
Inactive:       651820 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      2053240 kB
LowFree:         55564 kB
SwapTotal:     2031608 kB
SwapFree:      2031604 kB
Dirty:              28 kB
Writeback:           0 kB
Mapped:         205600 kB
Slab:           334968 kB
Committed_AS:   581136 kB
PageTables:       8916 kB
VmallocTotal: 536870911 kB
VmallocUsed:      3080 kB
VmallocChunk: 536867727 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
