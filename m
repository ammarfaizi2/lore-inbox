Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282067AbRL1Qgq>; Fri, 28 Dec 2001 11:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281835AbRL1Qgg>; Fri, 28 Dec 2001 11:36:36 -0500
Received: from w147.z064001233.sjc-ca.dsl.cnc.net ([64.1.233.147]:13507 "EHLO
	funky.gghcwest.COM") by vger.kernel.org with ESMTP
	id <S282067AbRL1QgY>; Fri, 28 Dec 2001 11:36:24 -0500
Date: Fri, 28 Dec 2001 08:35:50 -0800 (PST)
From: "Jeffrey W. Baker" <jwb@saturn5.com>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.17 absurd number of context switches
Message-ID: <Pine.LNX.4.33.0112280824550.23655-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a slice of vmstat 1 on my 2-way x86, 2GB main memory machine
running Postgres 7.2beta4 on Linux 2.4.17:
                                                           cpu
r b w                                bi  bo  in    cs us sy id
7 0 0 371612 58272 18576 1568896 0 0  0 168 414 33113 49 38 13
9 0 0 371612 59168 18576 1568900 0 0  0  64 215 32143 56 36  8
5 0 0 371612 58532 18576 1568924 0 0  0 696 363 33553 52 41  7
8 0 0 371612 59344 18576 1568956 0 0 16 240 374 34237 52 38  9
3 0 0 371612 58860 18576 1568996 0 0  0 128 254 31848 51 38 11
6 0 0 371612 59172 18576 1568996 0 0  0  64 234 36340 56 30 14
3 0 0 371612 59092 18576 1569004 0 0  0 232 204 32065 48 42 11
                                                ^^^^^
Check out those figures for context switches!  30,000 switches per second
with only three runnable processes and practically no block I/O seems
quite high to me.  You can also see that the system is spending half its
time in the kernel, presumably in the scheduler.  Postgres is barely
getting any CPU time at all, and the performance suffers noticeably.

Is this a scheduler worst-case, something to be expected, or something I
can work around?

Please CC me since vger's majordomo is an impossible chunk of shit.

-jwb

