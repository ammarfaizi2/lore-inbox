Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265132AbUFGX61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbUFGX61 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 19:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbUFGX61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 19:58:27 -0400
Received: from bhhdoa.org.au ([216.17.101.199]:54023 "EHLO bhhdoa.org.au")
	by vger.kernel.org with ESMTP id S265132AbUFGX6Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 19:58:24 -0400
Message-ID: <1086644098.40c4df826be23@vds.kolivas.org>
Date: Tue,  8 Jun 2004 07:34:58 +1000
From: Con Kolivas <kernel@kolivas.org>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
References: <20040607214034.27475.qmail@web51807.mail.yahoo.com>
In-Reply-To: <20040607214034.27475.qmail@web51807.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Phy Prabab <phyprabab@yahoo.com>:

> OOOPPPSSSS....
> 
> I need to make a correction on my previous data.  I
> had inadvertantly turned off interactivity and also
> increased the compute time to 100.  I confirmed that
> just setting interactivity off, does not solve my
> problem:
> 
> 2.6.7-rc3-s63 (0 @ /proc/sys/kernel/interactive):
> A:  37.30user 40.56system 1:42.01elapsed 76%CPU
> B:  37.29user 40.35system 1:23.87elapsed 92%CPU
> C:  37.30user 40.56system 1:36.01elapsed 81%CPU
> 
> 2.6.7-rc3-s63 (0 @ /proc/sys/kernel/interactive & 1
> /proc/sys/kernel/compute):
> A:  37.28user 40.36system 1:25.60elapsed 90%CPU
> B:  37.22user 40.35system 1:22.17elapsed 94%CPU
> C:  37.27user 40.35system 1:24.71elapsed 91%CPU
> 
> The question here, noticing that user and kernel time
> are the same, where is the dead time coming from and
> why is it sooooo much more deterministic with compute
> time at 100 vs 10?  Maybe I am misinterpreting the
> data, but this suggests to me that something is going
> awry (ping-pong, no settle, ???) within the kernl?
> 
> 
> Also please note the degredation between
> 2.6.7-rc2-bk8-s63:
> 
> A:  35.57user 38.18system 1:20.28elapsed 91%CPU
> B:  35.54user 38.40system 1:19.48elapsed 93%CPU
> C:  35.48user 38.28system 1:20.94elapsed 91%CPU
> 
> Interesting how much more time is spent in both user
> and kernel space between the two kernels.  Also note
> that 2.4.x exhibits even greater delta:
> 
> A:  28.32user 29.51system 1:01.17elapsed 93%CPU
> B:  28.54user 29.40system 1:01.48elapsed 92%CPU
> B:  28.23user 28.80system 1:00.21elapsed 94%CPU
> 
> Could anyone suggest a way to understand why the
> difference between the 2.6 kernels and the 2.4
> kernels?
> 
> Thank you for your time.
> Phy
> 
Hi.

How repeatable are the numbers normally? Some idea of what it is you're
benchmarking may also help in understanding the problem; locking may be an
issue with what you're benchmarking and out-of-order scheduling is not as
forgiving of poor locking. Extending the RR_INTERVAL and turning off
interactivity makes it more in-order and more forgiving of poor locking or
yield().

Compute==1 setting inactivates interactivity anyway, but that's not really
relevant to your figures since you had set interactive 0 when you set compute
1.

Con

