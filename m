Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273826AbRIXIdB>; Mon, 24 Sep 2001 04:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273823AbRIXIcw>; Mon, 24 Sep 2001 04:32:52 -0400
Received: from chiara.elte.hu ([157.181.150.200]:5896 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S273820AbRIXIci>;
	Mon, 24 Sep 2001 04:32:38 -0400
Date: Mon, 24 Sep 2001 10:30:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Adrian Bridgett <adrian.bridgett@iname.com>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] multipath RAID personality, 2.4.10-pre9
In-Reply-To: <20010918203946.A12814@wyvern>
Message-ID: <Pine.LNX.4.33.0109241028020.1864-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Sep 2001, Adrian Bridgett wrote:

> In fact that brings up another point - which path do you use by
> default?  [...]

the one that is defined to be the first in the MD set.

> If you have the SAN situation where you have a farm of servers each
> with two FC cards two two FC switches and then to two ports on a
> storage array, you don't want everything going to the first switch.
> Just picking one path to use at random would be preferable (unless you
> want to swap every other servers cables around).

raid1's read balancing code done by Mika Kuoppala does exactly the same
thing.

(just randomly distributing will lead to very bad performance, due to the
high granularity of the Linux block-IO interface. So you want to do a
certain amount of clustering across requests, before switching paths.)

	Ingo

