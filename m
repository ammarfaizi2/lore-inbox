Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbVLCAUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVLCAUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 19:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVLCAUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 19:20:43 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:16622 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1751095AbVLCAUm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 19:20:42 -0500
Message-ID: <4390E48E.4020005@mvista.com>
Date: Fri, 02 Dec 2005 16:19:26 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/13] Time: Reduced NTP Rework (part 2)
References: <20051202032551.19357.51421.sendpatchset@cog.beaverton.ibm.com> <20051202032604.19357.59425.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051202032604.19357.59425.sendpatchset@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> All,
> 	Here is the second of two patches which try to minimize my ntp rework
> patches.
> 	
> This patch further changes the interrupt time NTP code, breaking out the
> leapsecond processing and introduces an accessor to a shifted ppm

In a discusson aroung the leapsecond and how to disable it (some folks 
don't want the time jump) it came to light that, for the most part, 
this is unused code.  It requires that time be kept in UST to be 
useful and, from what I can tell, most folks keep time in their local 
timezone, thus, effectively, disableing the usage of the leapsecond 
correction (ntp figures this out and just says "no").  Possibly it is 
time to ask if we should keep this in the kernel at all.


-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
