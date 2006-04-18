Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWDRASv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWDRASv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 20:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWDRASv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 20:18:51 -0400
Received: from omta02sl.mx.bigpond.com ([144.140.93.154]:33671 "EHLO
	omta02sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751334AbWDRASu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 20:18:50 -0400
Message-ID: <44443063.7020503@bigpond.net.au>
Date: Tue, 18 Apr 2006 10:18:43 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: modify move_tasks() to improve load balancing
 outcomes
References: <443DF64B.5060305@bigpond.net.au> <20060413165117.A15723@unix-os.sc.intel.com> <443EFFD2.4080400@bigpond.net.au> <20060414112750.A21908@unix-os.sc.intel.com> <44404455.8090304@bigpond.net.au> <20060417095920.A19931@unix-os.sc.intel.com>
In-Reply-To: <20060417095920.A19931@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 18 Apr 2006 00:18:43 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Sat, Apr 15, 2006 at 10:54:45AM +1000, Peter Williams wrote:
>> Yes, there are problems with the active/expired arrays but they're no 
>> worse with smpnice than they are without it.
> 
> With smpnice, if we make any wrong decision while moving the high and
> low priority tasks, we will enter an endless loop(as load balance
> will keep on showing the imbalance and move_tasks will always move
> the wrong tasks, instead of the correct ones pointed by imbalance..)

This will only happen if the load weight for the task moved is larger 
than the difference between the weighted loads for the two queues.  So a 
check based on this observation can be used to prevent the loop.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
