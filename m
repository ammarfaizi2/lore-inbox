Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWAZKw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWAZKw2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWAZKw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:52:28 -0500
Received: from fmr23.intel.com ([143.183.121.15]:2223 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932273AbWAZKw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:52:27 -0500
Date: Thu, 26 Jan 2006 02:52:21 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: kernel@kolivas.org
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: smp 'nice' bias support breaks scheduler behavior
Message-ID: <20060126025220.B8521@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con,

> [PATCH] sched: implement nice support across physical cpus on SMP

I don't see imbalance calculations in find_busiest_group() take
prio_bias into account. This will result in wrong imbalance value and
will cause issues.

For example on a DP system with HT, if there are three runnable processes
(simple infinite loop with same nice value), this patch is resulting in bouncing
of these 3 processes from one processor to another...Lets assume
if the 3 processes are scheduled as 2 in package-0 and 1 in package1..
Now when the busy processor on package-1 does load balance and as
imbalance doesn't take "prio_bias" into account, this will kick active
load balance on package-0.. And this is continuing for ever, resulting
in bouncing from one processor to another.

Even when the system is completely loaded and if there is an imbalance,
this patch causes wrong imabalance counts and cause unoptimized
movements.

Do you want to look into this and post a patch for 2.6.16?

thanks,
suresh
