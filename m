Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751991AbWCBQIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbWCBQIB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 11:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbWCBQIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 11:08:01 -0500
Received: from mba.ocn.ne.jp ([210.190.142.172]:216 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751991AbWCBQIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 11:08:00 -0500
Date: Fri, 03 Mar 2006 01:07:54 +0900 (JST)
Message-Id: <20060303.010754.30187520.anemo@mba.ocn.ne.jp>
To: johnstul@us.ibm.com
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: why do we have wall_jiffies?
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <1140202014.5479.4.camel@leatherman>
References: <17397.25985.646489.878694@cargo.ozlabs.ibm.com>
	<1140202014.5479.4.camel@leatherman>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, I missed this thread...

>>>>> On Fri, 17 Feb 2006 10:46:53 -0800, john stultz <johnstul@us.ibm.com> said:
>> In other places there is code that uses (jiffies - wall_jiffies).
>> However I can't see any way that jiffies and wall_jiffies could
>> ever be different (except for a few nanoseconds while executing the
>> code above).  I also can't see any way that `ticks' could ever be
>> anything other than 1.
>> 
>> Is the wall_jiffies stuff just a leftover from days when we used to
>> do timekeeping from a softirq?  Or am I missing something
>> fundamental?

john> Its only use right now is that on some arches we increment
john> jiffies when we detect lost ticks. This then forces xtime to be
john> updated the appropriate number of times.

Currently, jiffies and wall_jiffies is _really_ different most of
time.  The jiffies is almost always one bigger than wall_jiffies (at
least on i386 and MIPS).  Please refer my yesterday's mail (subject:
jiffies_64 vs. jiffies) for the reason.

john> It probably could be killed and the arches can just call
john> do_timer() the appropriate number of times. That might clean
john> some things up. My TOD work would also make it unnecessary.

I just posted a patch to doing this (subject: [PATCH] simplify
update_times ...).  I thought only x86_64 is doing such thing, right?

Also, I suppose then we can get rid of wall_jiffies completely.
---
Atsushi Nemoto
