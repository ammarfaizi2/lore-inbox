Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVIWIJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVIWIJq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 04:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVIWIJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 04:09:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28567
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750800AbVIWIJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 04:09:45 -0400
Date: Fri, 23 Sep 2005 01:09:39 -0700 (PDT)
Message-Id: <20050923.010939.11256142.davem@davemloft.net>
To: nickpiggin@yahoo.com.au
Cc: ioe-lkml@rameria.de, linux-kernel@vger.kernel.org, clameter@engr.sgi.com
Subject: Re: making kmalloc BUG() might not be a good idea
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4333B588.9060503@yahoo.com.au>
References: <4333A109.2000908@yahoo.com.au>
	<200509230909.54046.ioe-lkml@rameria.de>
	<4333B588.9060503@yahoo.com.au>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Piggin <nickpiggin@yahoo.com.au>
Date: Fri, 23 Sep 2005 17:58:00 +1000

> Then you'll get people not enabling it on real workloads, or
> tuning it off if it bugs them. No, the point of having a WARN
> there is really for people like SGI to detect a few rare failure
> cases when they first boot up their 1024+ CPU systems. It is not
> going to spam anyone's logs (and if it does it *needs* fixing).

SGI (and people "like" them) can't enable a debug option when bringing
up new changes for the first time on that huge system?  Why is this?

What in the world are all these CONFIG_*DEBUG* options for then?
They are there for "I'm doing something radically new, or my new
change isn't working, therefore I need more debugging than usual."

We want it to spam the logs, sure, during _development_.  We don't
want it on production systems where any kind of downtime is a very
serious problem.  Rate limited, maybe, but not for every call as
that's simply asking for trouble.

This is why we have things like net_ratelimit() in the networking btw.
It's there so you can't remotely spam someone's logs just becuase you
figured out the "bug of the week" magic packet that erroneously
generates a huge number of log messages.

If we know how to make certain classes of bugs non-lethal, we should
do so because there will always be bugs. :-)  This change makes
previously non-lethal bugs potentially kill the machine.
