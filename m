Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSGHHEb>; Mon, 8 Jul 2002 03:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSGHHEa>; Mon, 8 Jul 2002 03:04:30 -0400
Received: from adsl-216-62-200-178.dsl.austtx.swbell.net ([216.62.200.178]:33939
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S316798AbSGHHE3>; Mon, 8 Jul 2002 03:04:29 -0400
Subject: Open files problem.
From: Austin Gonyou <austin@digitalroadkill.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 08 Jul 2002 02:05:45 -0500
Message-Id: <1026111946.32680.8.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure what this is related to, but as I'm using a pre10 kernel
from the -aa tree, I thought I'd ask here. 

I'm seeing a constant increase of open files in my Dell 6650 Quad P4
Xeon. Kernel was compiled with gcc 2.96-81 and gcc 3.1. (I haven't
noticed anything major, I was just trying out the -O3 flags with gcc
3.1. No errors to report there.

I'm running an Oracle DB on this box in a test scenario. I've got ~1TB
storage on there..and the DB occupies about 70% of that. About 50% is
data, 30% is index, and the rest is archive, rollback, system, temp,
etc. The problem I have is as follows: 

The DB has been up for about 8 days now...and the open file count has
increased quite a bit. It does not seem to be decreasing though. I've
raised my file-max to 20000, currently cat /proc/sys/fs/file-nr shows
about 15400 in use. 

It started out at 8192, then I quickly realized this wouldn't work, and
rose it to 10200, then up to 14400, then to 15500, then 20000. The
latter has been in effect for about 3 hours or so now..and file-nr is
hovering at 15536 or there abouts.

Has anyone seen these symptoms? Below you will find my bdflush
parameters, file-max, and meminfo. If I need to supply more, please ask
and I will give what info I can. I will be trying rc1-aa as well soon.

I was also curious if this was a known issue with the pre10 or
-aa4-Pre10. 

/proc/sys/vm/bdflush:  60 1000 0 0 1000 800 60 50 0

/proc/sys/fs/file-nr:  15500	239	20000

/proc/meminfo:

        total:    used:    free:  shared: buffers:  cached:
Mem:  7948722176 7692537856 256184320        0        0 6451240960
Swap: 4194811904 1641742336 2553069568
MemTotal:      7762424 kB
MemFree:        250180 kB
MemShared:           0 kB
Buffers:             0 kB
Cached:        6036516 kB
SwapCached:     263524 kB
Active:         961924 kB
Inactive:      5923484 kB
HighTotal:     6946752 kB
HighFree:         2048 kB
LowTotal:       815672 kB
LowFree:        248132 kB
SwapTotal:     4096496 kB
SwapFree:      2493232 kB


-- 
Austin Gonyou <austin@digitalroadkill.net>
