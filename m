Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319346AbSH2U5A>; Thu, 29 Aug 2002 16:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319352AbSH2U5A>; Thu, 29 Aug 2002 16:57:00 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:1806 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319346AbSH2U46>; Thu, 29 Aug 2002 16:56:58 -0400
Message-ID: <3D6E8B25.425263D5@zip.com.au>
Date: Thu, 29 Aug 2002 13:59:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] low-latency zap_page_range()
References: <3D6E844C.4E756D10@zip.com.au> <1030653602.939.2677.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
> unless we
> wanted to unconditionally drop the locks and let preempt just do the
> right thing and also reduce SMP lock contention in the SMP case.

That's an interesting point.  page_table_lock is one of those locks
which is occasionally held for ages, and frequently held for a short
time.

I suspect that yes, voluntarily popping the lock during the long holdtimes
will allow other CPUs to get on with stuff, and will provide efficiency
increases.  (It's a pretty lame way of doing that though).

But I don't recall seeing nasty page_table_lock spintimes on
anyone's lockmeter reports, so...
