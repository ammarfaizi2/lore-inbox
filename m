Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSHCWob>; Sat, 3 Aug 2002 18:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318139AbSHCWob>; Sat, 3 Aug 2002 18:44:31 -0400
Received: from dsl-213-023-022-101.arcor-ip.net ([213.23.22.101]:5822 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318138AbSHCWoa>;
	Sat, 3 Aug 2002 18:44:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Rmap speedup
Date: Sun, 4 Aug 2002 00:49:27 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17aiJv-0007cr-00@starship> <E17b3sE-0001T4-00@starship> <3D4C4DD9.779C057B@zip.com.au>
In-Reply-To: <3D4C4DD9.779C057B@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17b7iB-0003Lu-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 23:40, Andrew Morton wrote:
> - total amount of CPU time lost spinning on locks is 1%, mainly
>   in page_add_rmap and zap_pte_range.
> 
> That's not much spintime.   The total system time with this test went
> from 71 seconds (2.5.26) to 88 seconds (2.5.30). (4.5 seconds per CPU)
> So all the time is presumably spent waiting on cachelines to come from
> other CPUs, or from local L2.

Have we tried this one:

 static inline unsigned rmap_lockno(pgoff_t index)
 {
-       return (index >> 4) & (ARRAY_SIZE(rmap_locks) - 1);
+       return (index >> 4) & (ARRAY_SIZE(rmap_locks) - 16);
 }

(which puts all the rmap spinlocks in separate cache lines)

-- 
Daniel
