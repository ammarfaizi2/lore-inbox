Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278477AbRJPAFA>; Mon, 15 Oct 2001 20:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278479AbRJPAEu>; Mon, 15 Oct 2001 20:04:50 -0400
Received: from adsl-216-102-163-254.dsl.snfc21.pacbell.net ([216.102.163.254]:45979
	"EHLO windmill.gghcwest.com") by vger.kernel.org with ESMTP
	id <S278477AbRJPAEi>; Mon, 15 Oct 2001 20:04:38 -0400
Date: Mon, 15 Oct 2001 17:02:21 -0700 (PDT)
From: "Jeffrey W. Baker" <jwbaker@acm.org>
X-X-Sender: <jwb@windmill.gghcwest.com>
To: <linux-kernel@vger.kernel.org>
Subject: very slow RAID-1 resync
Message-ID: <Pine.LNX.4.33.0110151653120.13462-100000@windmill.gghcwest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just plugged in a new RAID-1(+0, 2 2-disk stripe sets mirrored) to a
2.4.12-ac3 machine.  The md code decided it was going to resync the mirror
at between 100KB/sec and 100000KB/sec.  The actual rate was 100KB/sec,
while the device was otherwise idle.  By increasing
/proc/.../speed_limit_min, I was able to crank the resync rate up to
20MB/sec, which is slightly more reasonable but still short of the
~60MB/sec this RAID is capable of.

So, two things: there is something wrong with the resync code that makes
it run at the minimum rate even when the device is idle, and why is the
resync proceeding so slowly?

raid1d and raid1syncd are barely getting any CPU time on this otherwise
idle SMP system.

There must be some optimization to mostly skip the sync on an array of new
drives, ja?

-jwb

