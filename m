Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbSKKD4Y>; Sun, 10 Nov 2002 22:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265424AbSKKD4X>; Sun, 10 Nov 2002 22:56:23 -0500
Received: from packet.digeo.com ([12.110.80.53]:29386 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265423AbSKKD4V>;
	Sun, 10 Nov 2002 22:56:21 -0500
Message-ID: <3DCF2BF5.5DD165DD@digeo.com>
Date: Sun, 10 Nov 2002 20:03:01 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@conectiva.com.br>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       marcelo@conectiva.com.br
Subject: Re: [BENCHMARK] 2.4.{18,19{-ck9},20rc1{-aa1}} with contest
References: <3DCEC6F7.E5EC1147@digeo.com> <Pine.LNX.4.44L.0211101902390.8133-100000@imladris.surriel.com> <20021111015445.GB5343@x30.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2002 04:03:01.0882 (UTC) FILETIME=[3A949DA0:01C28937]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> the slowdown happens in this case:
> 
>         queue 5 6 7 8 9
> 
> insert read 3
> 
>         queue 3 5 6 7 8 9

read-latency will not do that.
 
> However I think even read-latency is more a workarond to a problem in
> the I/O queue dimensions.

The problem is the 2.4 algorithm.  If a read is not mergeable or
insertable it is placed at the tail of the queue.  Which is the
worst possible place it can be put because applications wait on
reads, not on writes.
