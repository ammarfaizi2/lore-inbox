Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTE0BJC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbTE0BGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:06:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48271 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262482AbTE0BGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:06:11 -0400
Date: Mon, 26 May 2003 18:17:34 -0700 (PDT)
Message-Id: <20030526.181734.68129361.davem@redhat.com>
To: davej@codemonkey.org.uk
Cc: andrea@suse.de, akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com,
       habanero@us.ibm.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030527011620.GB7135@suse.de>
References: <20030526.174841.116378513.davem@redhat.com>
	<20030527010903.GF3767@dualathlon.random>
	<20030527011620.GB7135@suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Jones <davej@codemonkey.org.uk>
   Date: Tue, 27 May 2003 02:16:20 +0100

   On Tue, May 27, 2003 at 03:09:03AM +0200, Andrea Arcangeli wrote:
   
    > rdtsc could do it very well, irqs and softirqs can't be rescheduled so
    > you can tick measure how long you take in each cpu
   
   On CPUs that vary frequency, this will break, unless TSC scales
   with frequency. You cannot assume that this will be the case.

This is an important issue, for another reason.

The networking packet scheduler layer wants an accurate (but
cheap) high frequency time source too.

I keep forgetting to go back and deal with fixing up all of
those hairy macros in pkt_sched.h, I've added this to my TODO
list.
