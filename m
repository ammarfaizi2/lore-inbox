Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWIAUyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWIAUyK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 16:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWIAUyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 16:54:09 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:3260 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1750803AbWIAUyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 16:54:07 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile error
X-Message-Flag: Warning: May contain useful information
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org> <adak64nij8f.fsf@cisco.com>
	<20060901112312.5ff0dd8d.akpm@osdl.org> <ada8xl3ics4.fsf@cisco.com>
	<20060901130444.48f19457.akpm@osdl.org>
	<20060901204343.GA4979@flint.arm.linux.org.uk>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 01 Sep 2006 13:54:04 -0700
In-Reply-To: <20060901204343.GA4979@flint.arm.linux.org.uk> (Russell King's message of "Fri, 1 Sep 2006 21:43:43 +0100")
Message-ID: <adazmdjgvf7.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2006 20:54:05.0988 (UTC) FILETIME=[C3651640:01C6CE08]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Russell> Sure, if you want a _non-atomic_ 64-bit write then that's
    Russell> possible, but many 32-bit architectures can't do a 64-bit
    Russell> atomic IO write and that isn't something they can "fix".

I agree completely.  And going one step further: if an architecture
cannot implement a 64-bit write atomically, then the precise
serialization that is required is device-specific knowledge that
belongs in the device driver.

(For example, in the mthca case, the only serialization required is
that no writes go to the same page of MMIO space between the two
32-bit halves of the 64-bit write)

 - R.

-- 
VGER BF report: H 0
