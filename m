Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264755AbSKLACw>; Mon, 11 Nov 2002 19:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264972AbSKLACw>; Mon, 11 Nov 2002 19:02:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:17138 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264755AbSKLACw>;
	Mon, 11 Nov 2002 19:02:52 -0500
Message-ID: <3DD046BD.799F36D4@digeo.com>
Date: Mon, 11 Nov 2002 16:09:33 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
References: <1037057498.3dd03dda5a8b9@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Nov 2002 00:09:34.0295 (UTC) FILETIME=[C7D23670:01C289DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.18 [3]              474.1   15      36      10      6.64
> 2.4.19 [3]              492.6   14      38      10      6.90
> 2.5.46 [1]              600.5   13      48      12      8.41
> 2.5.46-mm1 [5]          134.3   58      6       8       1.88
> 2.5.47 [3]              165.9   46      9       9       2.32
> 2.5.47-mm1 [5]          126.3   61      5       8       1.77
> 
> Very nice. Further improvement in 2.5.47-mm1 (note the big change in 2.5.46-47
> is consistent with the preempt addition as mentioned in a previous thread)
> 

Actually, 2.5.47 changed fifo_batch from 32 to 16.  That's what caused
this big shift.

We've increased the kernel build speed by 3.6x while decreasing the
speed at which writes are retired by 5.3x.

It could be argued that this is a net decrease in throughput.  Although
there's clearly a big increase in total CPU utilisation.

It's a tradeoff.  I think this is a better tradeoff than the old one
though.
