Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbUDWV4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbUDWV4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUDWV4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:56:44 -0400
Received: from spc1-brig1-3-0-cust85.lond.broadband.ntl.com ([80.0.159.85]:32474
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261580AbUDWV4m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:56:42 -0400
Date: Fri, 23 Apr 2004 22:56:41 +0100 (BST)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: linux-kernel@vger.kernel.org
Subject: IDE throughput in 2.6 - it's good!
Message-ID: <Pine.LNX.4.58.0404232237140.19797@ppg_penguin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Talk about lies, damned lies, and statistics.  I've seen comments about
disk throughput, and running hdparm -t is one of my normal tests for new
kernels.  On this particular box (1000Mhz Duron, 512MB) hdparm regularly
reported disk reads of >= 40MB/S, at least on the outside.  Then I
booted 2.6.5 and the reported speed dropped away to typically 26-28MB/S.

 I remembered a recent comment about block sizes, so I tested the read
speed shown for various partitions.  The outer part of the disk has
several VFAT partitions, the ext3 partitions on the inside now report
around 31MB/S - better than 26, but sounds poor, and 2.6.1 reported a
slightly faster speed (might be the compiler, for 2.6.1 I used
gcc-2.95.3, now I'm using gcc-3.3.3).  All of the 2.6 kernels on this
box have preempt enabled.

 But, when all's said and done these are only numbers.  I found the
biggest tar on this box (463MiB) and timed -
 cp from hda10 to hda9 (these are the innermost partitions)
 sync
 rm from hda9
 sync again
Repeated three times, no other users, noted the real time.

 Under 2.4.25, between 41 and 45 seconds.
 Under 2.6.1, between 42 and 50 seconds.
 Under 2.6.5, between 38 and 40 seconds.

So, despite the numbers shown by hdparm looking worse, when only one
user is doing anything the performance is actually improved.  I've no
idea which changes have achieved this, but thanks to whoever were
involved.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

