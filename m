Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWDEQyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWDEQyR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 12:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWDEQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 12:54:17 -0400
Received: from zrtps0kn.nortel.com ([47.140.192.55]:25530 "EHLO
	zrtps0kn.nortel.com") by vger.kernel.org with ESMTP
	id S1751274AbWDEQyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 12:54:16 -0400
Message-ID: <4433F636.3090705@nortel.com>
Date: Wed, 05 Apr 2006 10:54:14 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: help? converting to single global prio_array in scheduler, ran into
 snag
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Apr 2006 16:54:13.0724 (UTC) FILETIME=[916321C0:01C658D1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're having some issues with the load balancer algorithm in CKRM, so 
due to time pressure I'm looking at converting the scheduler to use a 
single global prio_array rather than the per-cpu ones that it currently 
uses.  I realize we're going to take a hit, but we don't have too many 
cpus so I'm hoping it won't be too bad.

So far I've removed arrays/expired/active from the runqueue and made 
them global, added a new spinlock to protect the global list (always 
taken after the runqueue lock), and converted all the callers to use the 
appropriate variable.  All changes were in sched.h and sched.c.

This builds for both UP and SMP, boots for UP, and boots for SMP if I 
set the "nosmp" boot arg.

Unfortunately I seem to have missed something. On my Mac G5 if I allow 
it to use both cpus it gets to "smp_core99_setup_cpu 0 done", then hangs.

Anyone have any suggestions as to what I should look at?  Maybe the idle 
task initialization?

Thanks,

Chris

