Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264239AbTKKDXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264240AbTKKDXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:23:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:29581 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264239AbTKKDXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:23:05 -0500
Date: Mon, 10 Nov 2003 19:22:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Venezia <pvenezia@jpj.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
In-Reply-To: <1068519213.22809.81.camel@soul.jpj.net>
Message-ID: <Pine.LNX.4.44.0311101918210.2881-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10 Nov 2003, Paul Venezia wrote:
> 
> Running smbtorture's NBENCH test against the 2.6 kernel shows a
> significant performance disparity vs Redhat 2.4.20 or 2.4.22. The target
> system is running RH AS 3.0, and is an IBM x335 dual P4 XEON with 1.5GB
> RAM, Broadcom gigabit NIC linked at 1000/full and an MPT RAID
> controller.
> 
> Running a 12-client NBENCH test against this server running 2.4.22
> consistently produces a result of ~33MB/s. Running 2.6.0-test9 through
> bk-11 however, produces a much lower result, usually ~14MB/s. The test
> will start at ~80MB/s, sustained for 10-15 seconds, then throughput
> drops precipitously, and the file transfers slow to a crawl.

Can you try to see where it is waiting? "ctrl + scrollock" while outside X 
should get you a call trace of all the processes in the system, and it 
would be interesting to see what seems to trigger the iowait. So if you do 
the scrollock thing a few times while the system is spending 99% in 
iowait, the results should show where the processes ended up actually 
waiting for IO.

Now, it's entirely possible that the IO waits are there in 2.4.x too, but 
that driver breakage or just IO scheduler breakage makes them much 
_bigger_ in 2.6.x. In which case you won't see anything very interesting.

But we've also had a few cases where the IO gets throttled for totally 
different reasons - implementing FDATASYNC incorrectly, for example, or 
just having the memory allocator throttle on IO too aggressively (the 
latter usually leads to much nicer interactive usage, but can hurt 
throughput a lot).

		Linus

