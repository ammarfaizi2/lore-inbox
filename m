Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbTARVgg>; Sat, 18 Jan 2003 16:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTARVgg>; Sat, 18 Jan 2003 16:36:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:46739 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265093AbTARVgf>;
	Sat, 18 Jan 2003 16:36:35 -0500
Date: Sat, 18 Jan 2003 13:47:01 -0800
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <conman@kolivas.net>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [BENCHMARK] 2.5.59{-mm2} with contest
Message-Id: <20030118134701.555c9728.akpm@digeo.com>
In-Reply-To: <200301190051.13781.conman@kolivas.net>
References: <200301190051.13781.conman@kolivas.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 21:45:30.0257 (UTC) FILETIME=[EBA9B010:01C2BF3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <conman@kolivas.net> wrote:
>
> io_load:
> Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
> 2.5.58          3       136     58.8    6       12.4    1.84
> 2.5.58-mm1      3       138     55.8    7       13.0    1.86
> 2.5.59          4       113     68.1    4       9.7     1.53
> 2.5.59-mm2      3       563     12.8    38      17.4    7.61

I don't see such gross variations here, and there's nothing between -mm1 and
-mm2 which could cause this.  (BTW: what idiot broke diffstat as distributed
in rh8.0?  It fails to understand interdiff output, which is quite
legitimately formatted).

However there are some interesting snippets.  Elapsed time for io_load:

2.5.59: 					182,183,180
2.5.59 + deadline-np-42:			198,114,106,112,183,140
2.5.59 + deadline-np-42 + deadline-np-43:	224,224
2.5.59-mm2:					212,239

So it looks like deadline-np-42.patch lessens starvation of reads by writes,
and deadline-np-43.patch considerably worsens it.

But this is all just fiddling around.  Nick is working on an implementation
of anticipatory scheduling, which is a whole new ball game.  The pressure is
on ;)


