Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936790AbWLCPk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936790AbWLCPk4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 10:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936789AbWLCPk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 10:40:56 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:5315 "EHLO
	ms-smtp-03.texas.rr.com") by vger.kernel.org with ESMTP
	id S936790AbWLCPkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 10:40:55 -0500
Message-Id: <200612031540.kB3FeiQI028507@ms-smtp-03.texas.rr.com>
Reply-To: <Aucoin@Houston.RR.com>
From: "Aucoin" <Aucoin@Houston.RR.com>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <torvalds@osdl.org>, <linux-kernel@vger.kernel.org>, <clameter@sgi.com>
Subject: RE: la la la la ... swappiness
Date: Sun, 3 Dec 2006 09:40:48 -0600
Organization: home
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-reply-to: <20061203000857.af758c33.akpm@osdl.org>
Thread-Index: AccWqdfZWXFrv6KaQ+iuY7z/+u1mVgARLF+Q
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the reply! I'll buy one of your books!

2.6.16.28 SMP

The application is an "embedded", headless system and we've pretty much laid
memory out the way we want it, the only rogue player is the tar update
process. A little bit of swapping is fine but enough swapping to irritate
OOM is not desireable. Yes, the swap is only 500MB but this is a purpose
built system, there are no random user apps started and stopped so
absolutely nothing swaps until the update process runs.

Here's meminfo from an idle system, on a loaded system the machine locks up
now since I've disabled OOM trying to prevent the imminent crash. I got
desperate and not only set swappiness to zero but I've also tried setting
the dirty ratios down as low as 1, the centisecs as low as 1 and cache
pressure as high as 9999. I'm thrashing and running out of dials to turn.

With the ridiculous settings above dirty pages porpoise between 0-20K, with
more reasonable settings they porpoise between 10-40K but it seems to be the
inactive page count that is killing me.

before tar extraction
MemTotal:      2075152 kB
MemFree:        502916 kB
Buffers:          2272 kB
Cached:           7180 kB
SwapCached:          0 kB
Active:         118792 kB
Inactive:         1648 kB
HighTotal:     1179392 kB
HighFree:         3040 kB
LowTotal:       895760 kB
LowFree:        499876 kB
SwapTotal:      524276 kB
SwapFree:       524276 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         116720 kB
Slab:            27956 kB
CommitLimit:    557376 kB
Committed_AS:   903912 kB
PageTables:       1340 kB
VmallocTotal:   114680 kB
VmallocUsed:      1000 kB
VmallocChunk:   113584 kB
HugePages_Total:   345
HugePages_Free:      0
Hugepagesize:     4096 kB

during tar extraction ... inactive pages reaches levels as high as ~375000
MemTotal:      2075152 kB
MemFree:        256316 kB
Buffers:          2944 kB
Cached:         247228 kB
SwapCached:          0 kB
Active:         159652 kB
Inactive:       201608 kB
HighTotal:     1179392 kB
HighFree:         1652 kB
LowTotal:       895760 kB
LowFree:        254664 kB
SwapTotal:      524276 kB
SwapFree:       523932 kB
Dirty:           16068 kB
Writeback:           0 kB
Mapped:         116952 kB
Slab:            34864 kB
CommitLimit:    557376 kB
Committed_AS:   904196 kB
PageTables:       1352 kB
VmallocTotal:   114680 kB
VmallocUsed:      1000 kB
VmallocChunk:   113584 kB
HugePages_Total:   345
HugePages_Free:      0
Hugepagesize:     4096 kB

even after the tar has been complete for a couple minutes.
MemTotal:      2075152 kB
MemFree:        169848 kB
Buffers:          4360 kB
Cached:         334824 kB
SwapCached:          0 kB
Active:         178692 kB
Inactive:       271452 kB
HighTotal:     1179392 kB
HighFree:         1652 kB
LowTotal:       895760 kB
LowFree:        168196 kB
SwapTotal:      524276 kB
SwapFree:       523932 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         116716 kB
Slab:            31868 kB
CommitLimit:    557376 kB
Committed_AS:   903908 kB
PageTables:       1340 kB
VmallocTotal:   114680 kB
VmallocUsed:      1000 kB
VmallocChunk:   113584 kB
HugePages_Total:   345
HugePages_Free:      0
Hugepagesize:     4096 kB

-----Original Message-----
From: Andrew Morton [mailto:akpm@osdl.org] 
Sent: Sunday, December 03, 2006 2:09 AM
To: Aucoin@Houston.RR.com
Cc: torvalds@osdl.org; linux-kernel@vger.kernel.org; clameter@sgi.com
Subject: Re: la la la la ... swappiness

> On Sun, 3 Dec 2006 00:16:38 -0600 "Aucoin" <Aucoin@Houston.RR.com> wrote:
> I set swappiness to zero and it doesn't do what I want!
> 
> I have a system that runs as a Linux based data server 24x7 and
occasionally
> I need to apply an update or patch. It's a BIIIG patch to the tune of
> several hundred megabytes, let's say 600MB for a good round number. The
> server software itself runs on very tight memory boundaries, I've
> preallocated a large chunk of memory that is shared amongst several
> processes as a form of application cache, there is barely 15% spare memory
> floating around.
> 
> The update is delivered to the server as a tar file. In order to minimize
> down time I untar this update and verify the contents landed correctly
> before switching over to the updated software.
> 
> The problem is when I attempt to untar the payload disk I/O starts
caching,
> the inactive page count reels wildly out of control, the system starts
> swapping, OOM fires and there goes my 4 9's uptime. My system just
suffered
> a catastrophic failure because I can't control pagecache due to disk I/O.

kernel version?

> I need a pagecache throttle, what do you suggest?

Don't set swappiness to zero...   Leaving it at the default should avoid
the oom-killer.


