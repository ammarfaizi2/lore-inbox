Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTKUOC4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 09:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTKUOC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 09:02:56 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:34972 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S264275AbTKUOCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 09:02:52 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Andrew Morton <akpm@osdl.org>
Subject: Re: O_DIRECT leaks memory on linux-2.6.0-test9
Date: Fri, 21 Nov 2003 09:02:50 -0500
User-Agent: KMail/1.5.1
Cc: iwamoto@valinux.co.jp, linux-kernel@vger.kernel.org
References: <20031121061806.6A65F7007C@sv1.valinux.co.jp> <200311210324.35127.gene.heskett@verizon.net> <20031121004054.0d688bff.akpm@osdl.org>
In-Reply-To: <20031121004054.0d688bff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311210902.50445.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.54.127] at Fri, 21 Nov 2003 08:02:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 November 2003 03:40, Andrew Morton wrote:
>Gene Heskett <gene.heskett@verizon.net> wrote:
>> On Friday 21 November 2003 02:55, Andrew Morton wrote:
>> >IWAMOTO Toshihiro <iwamoto@valinux.co.jp> wrote:
>> >> It'll take a while to leak a noticable amount of memory. So I
>> >> reduced the amount of memory using a boot option.
>> >
>> >Well I'll be darned.  I took a new version of fsstress and it
>> > happens here too.  We're leaking anonymous memory.  -mm doesn't
>> > do any better, either.
>>
>> Running 2.6.0-test9-mm4, default as scheduler
>>
>> That triggerd me to go look at ksysguard, and I've got 70 megs out
>> in swap in less than 24 hours uptime with my normal loading. 
>> Usually it takes me a couple of weeks to get that much as I've
>> half a gig of main memory.
>
>That's good.  The kernel has given you 70 megs more memory.
>
>>  Its also showing about 95 megs free.
>
Now its down to about 80, and the display for cache and buffers has 
shrunk considerably.  Normal after boot memory usage is in the 125 
meg area, and that portion of the display is now around 350 megs, 
having grown 100megs or so overnight.

>free memory isn't really relevant.  If there's plenty of `buffers'
> and pagecache around then it's mostly reclaimable.

Those two colors in the ksysguard report window are getting mighty 
thin.

>>  Would this leak
>> show up there (ksysguard), and if so, in what section?
>
>I don't know.
>
>> T'would be nice if xosview were to be made operable, but this
>> kernel breaks it.  I used to keep it running in the corner of one
>> of my screens.
>
>I had a patch for that.  Maybe it got merged.  You should hunt down
> the upstream source and try it out.

The srcs for xosview?  I did a freshmeat search, and what I found 
hadn't been touched in over a year.  I didn't bother grabbing it as 
it was the same version number as the copy I have.

>For diagnosing this sort of thing it is best to learn to read the
> /proc files.

cat /proc/meminfo:
MemTotal:       514964 kB
MemFree:        171100 kB
Buffers:         14256 kB
Cached:          80548 kB
SwapCached:      15912 kB
Active:         220456 kB
Inactive:         5124 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514964 kB
LowFree:        171100 kB
SwapTotal:     3857104 kB
SwapFree:      3786316 kB
Dirty:              52 kB
Writeback:           0 kB
Mapped:         181676 kB
Slab:           111528 kB
Committed_AS:   540836 kB
PageTables:       2144 kB
VmallocTotal:   515896 kB
VmallocUsed:     51372 kB
VmallocChunk:   464524 kB

But in the various memory related things in /proc, I don't see a 
reference to anonymous?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

