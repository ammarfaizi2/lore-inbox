Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268120AbUHTOes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268120AbUHTOes (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 10:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUHTOer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 10:34:47 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:55277 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268120AbUHTOen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 10:34:43 -0400
Date: Fri, 20 Aug 2004 10:38:54 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Hans Kristian Rosbach <hk@isphuset.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SMP cpu deep sleep
In-Reply-To: <1092994933.18271.21.camel@linux.local>
Message-ID: <Pine.LNX.4.58.0408201017530.27390@montezuma.fsmlabs.com>
References: <1092989207.18275.14.camel@linux.local>  <200408200458.38591.jeffpc@optonline.net>
 <1092994933.18271.21.camel@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004, Hans Kristian Rosbach wrote:

> Nice, this can be done on non-hotplug motherboards as well?
> How much time does it take to take the cpu up again?

Yes it works on non hotplug motherboards, it's only a logical offline.
Returning from offline;

root@morocco cpu1 {0:0} time echo 0 > online
0.000u 0.290s 0:01.77 16.3%     0+0k 0+0io 0pf+0w
root@morocco cpu1 {0:0} time echo 1 > online
0.000u 0.001s 0:00.10 0.0%      0+0k 0+0io 0pf+0w

> It would need to be awakened whenever the activity increases
> again, and that delay should not be too long.
>
> Also, what effect does this have on cpu power consumtion
> and thermal output? Does it lower it below normal idle?

None at the moment as we busy loop, so if anything, power consumption
would go up. What could be done is perhaps 'hlt' the processor and wait
for a RETURN_FROM_OFFLINE IPI. Or perhaps with more work, graft in the
ACPI C state transitions.
