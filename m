Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbWFIFYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbWFIFYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 01:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWFIFYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 01:24:40 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52143
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965208AbWFIFYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 01:24:39 -0400
Date: Thu, 08 Jun 2006 22:23:52 -0700 (PDT)
Message-Id: <20060608.222352.59657133.davem@davemloft.net>
To: auke-jan.h.kok@intel.com
Cc: jeremy@goop.org, mpm@selenic.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Using netconsole for debugging suspend/resume
From: David Miller <davem@davemloft.net>
In-Reply-To: <4489038C.3050901@intel.com>
References: <20060608210702.GD24227@waste.org>
	<4488D4DE.3000100@goop.org>
	<4489038C.3050901@intel.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Auke Kok <auke-jan.h.kok@intel.com>
Date: Thu, 08 Jun 2006 22:13:48 -0700

> netconsole should retry. There is no timeout programmed here since that might
> lose important information, and you rather want netconsole to survive an odd
> unplugged cable then to lose vital debugging information when the system is
> busy for instance. (losing link will cause the interface to be down and thus
> the queue to be stopped)

I completely disagree that netpoll should loop when the ethernet
cable is plugged out.  This stops the entire system.  What if this
is one of my main web servers and I have other links on the machine
for redundancy and load balancing?  Just because some careless
sysop knocks one of the cables out, my system just freezes up and
stops?

What if I'm on a remote serial console, how long should I scratch
my head wondering why the whole machine is frozen up before I "figure
out" that the ethernet cable being out has made my system unusable
because netpoll is just looping on the thing forever?

That's an extremely poor quality of implementation if you ask me.

Netpoll is _BEST_ _EFFORT_, end of story.  It by definition can only
offer that level of service because it does locking in circumstances
where such locking might be illegal or even impossible.  So it has to
try, but if it can't get the resources it needs, it must stop trying
and abort the logging.
