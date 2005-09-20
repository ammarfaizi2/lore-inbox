Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbVITEmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbVITEmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbVITEmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:42:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:3470 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964886AbVITEmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:42:00 -0400
Date: Tue, 20 Sep 2005 10:11:10 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
Message-ID: <20050920044110.GA19184@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost> <20050919062336.GA9466@in.ibm.com> <1127111830.4087.3.camel@linux-hp.sh.intel.com> <1127111784.5272.10.camel@npiggin-nld.site> <1127113930.4087.6.camel@linux-hp.sh.intel.com> <1127114538.5272.16.camel@npiggin-nld.site> <20050919072842.GA11293@elte.hu> <1127115425.5272.21.camel@npiggin-nld.site> <1127170547.18737.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127170547.18737.3.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 08:55:47AM +1000, Nigel Cunningham wrote:
> I got on the same page eventually :). When you have it ready, I'll be
> happy to try it. Apart from trying another 75 suspends (which I'm happy
> to do), I'm not really sure how we can be totally sure that the patch
> fixes it. Do you have any thoughts in this regard?

Since this seems to be related to CPU down event, you could run a
tight loop like this overnight (for all CPUs in the system):

	while :
	do
		echo 0 > online
		echo 1 > online
	done


This, maybe in conjunction with some other test like LTP or make -jN bzImage,
is usually enough to capture all CPU-hotplug related problems.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
