Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbSLFA2d>; Thu, 5 Dec 2002 19:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267455AbSLFA2d>; Thu, 5 Dec 2002 19:28:33 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:29327 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267440AbSLFA2c>; Thu, 5 Dec 2002 19:28:32 -0500
Date: Thu, 5 Dec 2002 19:35:49 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200212060035.gB60ZnV07386@devserv.devel.redhat.com>
To: Norman Gaywood <norm@turing.une.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
In-Reply-To: <mailman.1039133948.27411.linux-kernel2news@redhat.com>
References: <mailman.1039133948.27411.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think I have a trigger for a VM bug in the RH kernel-bigmem-2.4.18-18

> By doing a large copy I can trigger this problem in about 30-40 minutes. At
> the end of that time, kswapd will start to get a larger % of CPU and
> the system load will be around 2-3. The system will feel sluggish at an
> interactive shell and it will take several seconds before a command like
> top would start to display. [...]

Check your /proc/slabinfo, just in case, to rule out a leak.

> cat /proc/meminfo
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  16671522816 444915712 16226607104        0 136830976 56520704
> Swap: 34365202432        0 34365202432
> MemTotal:     16280784 kB
> MemFree:      15846296 kB
> MemShared:           0 kB
> Buffers:        133624 kB
> Cached:          55196 kB
> SwapCached:          0 kB
> Active:         249984 kB
> Inact_dirty:     18088 kB
> Inact_clean:       480 kB
> Inact_target:    53708 kB
> HighTotal:    15597504 kB
> HighFree:     15434932 kB
> LowTotal:       683280 kB
> LowFree:        411364 kB
> SwapTotal:    33559768 kB
> SwapFree:     33559768 kB
> Committed_AS:   177044 kB

This is not interesting. Get it _after_ the box becomes sluggish.

Remember, the 2.4.18 stream in RH does not have its own VM, distinct
from Marcelo+Riel. So, you can come to linux-kernel for advice,
but first, get it all reproduced with Marcelo's tree with
Riel's patches all the same.

-- Pete
