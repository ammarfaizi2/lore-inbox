Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271934AbTHHU6k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 16:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271939AbTHHU6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 16:58:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:23972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271934AbTHHU6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 16:58:38 -0400
Message-Id: <200308082058.h78KwV300335@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Con Kolivas <kernel@kolivas.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 osdl-aim-7 regression 
In-Reply-To: Message from Con Kolivas <kernel@kolivas.org> 
   of "Thu, 07 Aug 2003 12:40:54 +1000." <200308071240.54863.kernel@kolivas.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Aug 2003 13:58:31 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 7 Aug 2003 05:10, Cliff White wrote:
> > > Binary searching (insert gratuitous rant about benchmarks that take more
> > > than two minutes to complete) reveals that the slowdown is due to
> > > sched-2.6.0-test2-mm2-A3.
> 
> This is most likely the round robinning of tasks every 25ms. The extra 
> overhead of nanosecond timing I doubt could make that size difference (but I 
> could be wrong). There is some tweaking of this round robinning in my code 
> which may help this, but it won't bring it back up to original performance I 
> believe. Two things to try are add my patches up to O12.3int first to see how 
> much (if at all!) it helps, and change TIMESLICE_GRANULARITY in sched.c to 
> (MAX_TIMESLICE) which basically disables it completely. If there is still  a 
> drop in performance with this, the remainder is the extra locking/overhead in 
> nanosecond timing.
> 
> Con
> 
Added your patches to PLM, from your web site. We've had other issues slowing 
up the
4-cpu queue, but the two CPU tests ran. On these smaller platforms, not seeing 
big
difference between the patches.

STP id PLM# Kernel Name         Workfile   MaxJPM  MaxUser Host     %Change
 277231 2042 CK-O13-O13.1int-1  new_dbase  1333.60  22     stp2-002 0.00
 277230 2041 CK-O12.3-O13int-1  new_dbase  1344.23  24     stp2-003 0.80
 277228 2040 CK-012.2-O12.3int-1 new_dbase 1328.86  22     stp2-002 -0.36
All are a bit better than stock:
276572 2020 linux-2.6.0-test2    new_dbase  1320.68 22	   stp2-000 -0.96
---- 
Code location:
bk://developer.osdl.org/osdl-aim-7
More results:
http://developer.osdl.org/cliffw/reaim/index.html

Run parameters: 

./reaim -s2 -x -t -i2 -f workfile.new_dbase -r3 -b -l./stp.config

cliffw


