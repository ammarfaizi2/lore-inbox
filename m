Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTEQQDH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 12:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbTEQQDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 12:03:07 -0400
Received: from adsl-64-175-242-240.dsl.sntc01.pacbell.net ([64.175.242.240]:38727
	"HELO top.worldcontrol.com") by vger.kernel.org with SMTP
	id S261605AbTEQQDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 12:03:05 -0400
From: brian@worldcontrol.com
Date: Sat, 17 May 2003 09:15:59 -0700
To: linux-kernel@vger.kernel.org
Subject: 3ware driver causing lost network packets
Message-ID: <20030517161559.GA25792@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Archive: yes
X-Noarchive: yes
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


3ware 7200 Controller (firmware from yesterday)
Linux 2.4.18 (loses some packets), 2.4.20, 2.4.21rc1 (lose lots)
AMD 2xMP2000
Tyan 2466 MB
512MB ECC DDR RAM

In our application the system has 3 ethernet interfaces.  2
10/100 and 1 10/100/1000.

We run about 60mbits per second through the system acting as
a router, and much of the data is also written to the disk array.

Dest Machine A -- 
Dest Machine B -- Gbit      Router machine ---100mbit  -- Source Machine A
Dest Machine C -- Switch -- with storage   ---switches -- Source machine B
Dest Machine D --                                      -- ...
...

The data is mostly RTP via udp/multicast.

Every few minutes each stream of data loses one packet as
indicated by the RTP sequence number.   This manifests itself
at the destination machines.

I have isolated the problem to the 3ware controller.

We can turn off writing to the disk array and packets are not lost.
We can run a similar setup using regular IDE controllers
and the packets are not lost.  

The kicker is that while we lose a few packets every few minutes
with 2.4.18, 2.4.20 & 2.4.21rc1 lose many packets constantly.

Another observation is that we can run 120mbits per second
through the system and the packet loss rate is about the same.

Any thoughts as to where to look to solve this problem?

I've cc'ed 3ware on this.

-- 
Brian Litzinger
