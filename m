Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271820AbTHLSjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271890AbTHLSjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:39:11 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:38052 "EHLO
	pd6mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S271820AbTHLSjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:39:05 -0400
Date: Tue, 12 Aug 2003 11:36:11 -0700
From: Ken Savage <kens1835@shaw.ca>
Subject: High CPU load with kswapd and heavy disk I/O
To: linux kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <200308121136.11979.kens1835@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Short version:
----------------
kernels 2.4.17 --> 2.4.21
Dual Athlon SMP system
4GB RAM, 2GB swap
3ware RAID, filled with millions of files across thousands of directories.
reiserfs 3.6

The following command is guaranteed to lock out the box by activating
kswapd to >95% CPU, blocking out pings, everything.

    find /RAID/data/ -type f -mtime +180 | xargs rm

Details:
----------
Applying the rmap patch seems to prevent kswapd from hogging the CPU,
but causes it to freeze up for some other reason.  (The server is remote,
so I can't view the console.)  Likewise 2.6.0-test* causes freezeups.
Mind you, the server is under a fair bit of CPU and disk load -- hundreds
of processes/threads all actively running.  I suspect something in rmap
has made its way into 2.6 and our usage pattern is triggering the same
fault in both places.

It appears as though the system is unable to efficiently clean up disk
buffer memory when called on to do so.  In the Documentation/, there
is mention of a buffermem sysctl, but that's nowhere to be found.
It's obviously been removed/replaced...  Is there any way to limit the
amount of buffer memory used by the system, that way if/when kswapd
needs to reclaim it, there's very little work for it to do?

Admittedly, that's just masking the problem, as opposed to solving it.
Any idea why kswapd is having such a tough go??  Known solutions
for this problem?

TIA,

Ken

