Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbUCZORi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 09:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbUCZORi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 09:17:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:28289 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262165AbUCZORg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 09:17:36 -0500
Date: Fri, 26 Mar 2004 09:19:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: locking pages into a processes` working set
Message-ID: <Pine.LNX.4.53.0403260917300.7184@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have been trying to lock pages down so I can get
a stable bench-mark without a bunch of paging.
I have tried mlock(), mlockall(), etc., but both
the RSS and SIZE entries shown by `top` vary all
over the place when the process is active.

`strace` of an attempt to keep some shared memory
resident. It seems to work as far as `strace`
shows.

munmap(0x400cc000, 4096)                = 0
shmget(4277009102, 1052672, IPC_CREAT|IPC_EXCL|0x180|0600) = 425984
shmctl(425984, IPC_STAT, 0xbffff698)    = 0
shmat(425984, 0, 0)                     = 0x400cc000
shmctl(425984, IPC_RMID, 0xbffff698)    = 0
mlock(0x400cc000)                       = 0

However, it doesn't.

Also, there are bugs in `strace`. This version (4.2) doesn't show
the length parameter passed to mlock() and the version distributed
with RH (4.4) shows two '0's instead of the length parameter.

Maybe mlock() and friends don't prevent paging, but
only prevent the pages from being written to swap?
Could somebody tell me how to keep memory from being
paged, i.e., in the processes` working-set all the time.

I have an application on an imbedded system that almost
works. It's frustrating. If I could keep the application's
pages resident it would work fine. If I mmap physical pages
the kernel doesn't know about, it works fine. But if I
try to do more "standard" stuff and use shared RAM, the
application gets far behind the data-rate and I'm screwed.

The kernel version is 2.4.24. Maybe it's broken?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


