Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270064AbUJTIDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270064AbUJTIDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 04:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270196AbUJTH7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 03:59:10 -0400
Received: from fmr10.intel.com ([192.55.52.30]:5026 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S270121AbUJTHsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 03:48:04 -0400
Subject: Re: gradual timeofday overhaul
From: Len Brown <len.brown@intel.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>
In-Reply-To: <Pine.LNX.4.53.0410200441210.11067@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.53.0410200441210.11067@gockel.physik3.uni-rostock.de>
Content-Type: text/plain
Organization: 
Message-Id: <1098258460.26595.4320.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 20 Oct 2004 03:47:40 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-19 at 23:05, Tim Schmielau wrote:
> I think we could do it in the following steps:
> 
>   1. Sync up jiffies with the monotonic clock,...
>   2. Decouple jiffies from the actual interrupt counter...
>   3. Increase HZ all the way up to 1e9....

> Thoughts?

Yes, for long periods of idle, I'd like to see the periodic clock tick
disabled entirely.  Clock ticks causes the hardware to exit power-saving
idle states.

The current design with HZ=1000 gives us 1ms = 1000usec between clock
ticks.  But some platforms take nearly that long just to enter/exit low
power states; which means that on Linux the hardware pays a long idle
state exit latency (performance hit) but gets little or no power savings
from the time it resides in that idle state.

thanks,
-Len


