Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbTKKDEU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 22:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTKKDEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 22:04:20 -0500
Received: from nat-68-172-17-106.ne.rr.com ([68.172.17.106]:63474 "EHLO
	trip.jpj.net") by vger.kernel.org with ESMTP id S264226AbTKKDET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 22:04:19 -0500
Subject: I/O issues, iowait problems, 2.4 v 2.6
From: Paul Venezia <pvenezia@jpj.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1068519213.22809.81.camel@soul.jpj.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 Nov 2003 21:53:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running some benchmarks on 2.4 v 2.6 recently, and came across
another oddity. 

Running smbtorture's NBENCH test against the 2.6 kernel shows a
significant performance disparity vs Redhat 2.4.20 or 2.4.22. The target
system is running RH AS 3.0, and is an IBM x335 dual P4 XEON with 1.5GB
RAM, Broadcom gigabit NIC linked at 1000/full and an MPT RAID
controller.

Running a 12-client NBENCH test against this server running 2.4.22
consistently produces a result of ~33MB/s. Running 2.6.0-test9 through
bk-11 however, produces a much lower result, usually ~14MB/s. The test
will start at ~80MB/s, sustained for 10-15 seconds, then throughput
drops precipitously, and the file transfers slow to a crawl. The target
system shows that it's 100% I/O bound, but I can't seem to locate the
constraint. iostat and sar don't show anything out of the ordinary, but
top shows the CPUs at 99% iowait. Eventually, the bottleneck disappears,
and the performance increases, but never substantially. 

I can reproduce this at will on this system, and a dual Itanium2 system
with Samba 2.2.8a and 3.0. Removing Samba from the equation, copying a
550MB file via NFS takes 240s under 2.6.0-test9-bk11 (~2.5MB/s average),
exhibiting the same iowait problem, while under 2.4.22 the same transfer
takes ~13s (~44MB/s average) without any iowait issues. A raw IP
throughput test shows ~900Mb throughput between the two boxes.

This could be a driver issue, but I don't have any other test boxes at
the moment. I can provide any debug info requested.

-Paul

