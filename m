Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTE0AhP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTE0AhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:37:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27791 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262416AbTE0AhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:37:14 -0400
Date: Mon, 26 May 2003 17:48:41 -0700 (PDT)
Message-Id: <20030526.174841.116378513.davem@redhat.com>
To: andrea@suse.de
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030527004115.GD3767@dualathlon.random>
References: <20030527000639.GA3767@dualathlon.random>
	<20030526.171527.35691510.davem@redhat.com>
	<20030527004115.GD3767@dualathlon.random>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Tue, 27 May 2003 02:41:15 +0200

   In 2.4 normally the softirq (of course w/o NAPI) are
   served in irq context so we didn't face this yet.
   
Andrea, whether ksoftirqd processes the softirq work or not has
nothing to do with what I'm talking about.

It is all about what does a hardware IRQ mean in terms of work
processed.  And it can mean anything from 1 to 1000 packets worth
of work.

Therefore, any usage of hardware IRQ activity to determine "load" in
any sense is totally inaccurate.

So I'm asking you, again, how are you going to measure softirq load in
making hardware IRQ load balancing decisions?  Watching the scheduling
and running of ksoftirqd is not an answer.  Networking hardware
interrupts, with a simplistic and mindless algorithm like the one we
have currently in the 2.5.x IRQ balancing code, appear to be
contributing very little to "load" and that is wrong.

   But it doesn't change my basic argument about this topic, that there's
   no way in userspace to do anything remotely as accurate as that to boost
   system performance to the maximum, especially on big systems.

You show that the measurements and reactions belong there.  This I
totally understand.  This is how cpufreq is implemented in 2.5.x
currently.  It is a very similar situation.

But deciding how to intepret these measurements and what to do in
response is a userlevel policy decision.  This also coincides with
how cpufreq works.
