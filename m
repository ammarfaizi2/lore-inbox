Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276701AbRJKSrX>; Thu, 11 Oct 2001 14:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276707AbRJKSrO>; Thu, 11 Oct 2001 14:47:14 -0400
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:46471 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S276701AbRJKSrI>;
	Thu, 11 Oct 2001 14:47:08 -0400
Date: Thu, 11 Oct 2001 11:47:36 -0700
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>
Subject: Really slow netstat and /proc/net/tcp in 2.4
Message-ID: <20011011114736.A13722@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there something that changed from 2.2 -> 2.4 with regards to the
speed of netstat and /proc/net/tcp?  We have some webservers we just
upgraded from 2.2.19 to 2.4.12, and some in-house monitoring tools that
check /proc/net/tcp have begun to suck up a lot of CPU cycles trying to
read that file.

A simple cat or wc -l on the file feels like about on the order of two
magnitudes slower ("time" reports around a second when the file has 450
entries).  Some servers seem to be worse than others, and it does not
appear to be proportional to the number of entries across servers.

netstat -tn just crawls along on these servers.  Should I enable
profile=1 or something to see what's happening here?

Examples:

2.2.19:

[sroot@marble:/root]# time wc -l /proc/net/tcp
    858 /proc/net/tcp
0.000u 0.010s 0:00.01 100.0%    0+0k 0+0io 112pf+0w

2.4.12:

[sroot@pro:/root]# time wc -l /proc/net/tcp
    463 /proc/net/tcp
0.000u 0.640s 0:00.64 100.0%    0+0k 0+0io 69pf+0w

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
