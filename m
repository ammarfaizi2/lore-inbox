Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTJ0Xd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTJ0Xd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:33:56 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:8850 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263765AbTJ0Xdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:33:55 -0500
Date: Mon, 27 Oct 2003 15:33:52 -0800 (PST)
From: John Hawkes <hawkes@babylon.engr.sgi.com>
Message-Id: <200310272333.h9RNXqaP2542634@babylon.engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran AIM7 on a 64p Altix NUMA (Itanium 2 Madison CPUs, 1.5 GHz), with an
XFS filesystem on each of 99 fiberchannel disks, with two different flavors
of AIM7 workloads, on both 2.6.0-test5 and 2.6.0-test8.  One workload shows
that -test8 is half the throughput of -test5.  The other workload shows
that -test8 is 22% faster.

The first workload is the default AIM7 "multiuser/shared system" workload.
2.6.0-test8 shows a peak throughput of 52% of -test5 -- it drops in half.
The -test8 peak at 64p is roughly the same as at 8p and 4p.  This
bottleneck cannot be attributed solely to I/O hardware, since our SGI
ProPack kernel (based upon 2.4.21) achieves a peak throughput at 64p that
is 30% higher than 2.6.0-test5's peak at 64p.

The second workload takes the same "multiuser/shared system" workload,
but turns off the O_SYNC flag for the three sync_* subtests.  This
generally produces higher peak throughput values than when using the
default O_SYNC, and the peak throughput values scale significantly better
as CPU counts increase.  Here the -test8 kernel is 22% *faster* than
-test5 at 64p (and 8x faster for no-O_SYNC than with-O_SYNC).

John Hawkes
