Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262366AbTEZXbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTEZXbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:31:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:53390 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262366AbTEZXbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:31:34 -0400
Date: Mon, 26 May 2003 16:43:00 -0700 (PDT)
Message-Id: <20030526.164300.88501443.davem@redhat.com>
To: andrea@suse.de
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030526233446.GZ3767@dualathlon.random>
References: <20030526222406.GU3767@dualathlon.random>
	<20030526162616.6ceacaba.akpm@digeo.com>
	<20030526233446.GZ3767@dualathlon.random>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Tue, 27 May 2003 01:34:46 +0200

   On Mon, May 26, 2003 at 04:26:16PM -0700, Andrew Morton wrote:
   > How hard would it be to make this HT-aware?
   
   yeah! that was the obvious next step.

So what is idle defined as?  How are you going to measure things like
softirq load?  How much weight will softirq load get compared to
hardirq load?  How will process load be factored into this and what
weight will this get?

All of these questions have no answer as far as the kernel is
concerned, because this is a policy decision and something the user
ought to be able to configure to suite his needs.

All you've said today is that IRQ balancing needs to be more like the
cpufreq drivers.  The hardware programming and some of the delicate
time sensitive details are done in the kernel, but deciding how and
when to do these things belongs as some userspace action.

I still contend that Arjan's usermode irq balancer solves one realm of
those problems.  And there is nothing that prevents his work from
being extended to upload policies for the things you have brought up
today.

Finally, claiming this is a performance issue is moot.  We've already
shown that if the current IRQ load balancer in 2.5.x improves
performance for any network based things there is no reasonable reason
WHY this is the case bacause it's behavior is anti-networking in
nature in that it thinks hardware IRQ load equates to real load which
it does not.
