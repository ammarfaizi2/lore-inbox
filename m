Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269965AbUJHNWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269965AbUJHNWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 09:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269957AbUJHNU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 09:20:58 -0400
Received: from [203.124.158.219] ([203.124.158.219]:26253 "EHLO
	ganesha.intranet.calsoftinc.com") by vger.kernel.org with ESMTP
	id S269967AbUJHNS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 09:18:26 -0400
Subject: Re: [RFC] [PATCH] Performance of del_single_shot_timer_sync
From: shobhit dayal <shobhit@calsoftinc.com>
Reply-To: shobhit@calsoftinc.com
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1097242659.11717.483.camel@kuber>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 08 Oct 2004 19:07:39 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> By how much?  (CPU load, overall runtime, etc)
> 
> It's a bit odd to have an expired-timer-intensive workload.  Presumably
> postgres has some short-lived nanosleep or select-based polling loop in
> there which isn't doing much.

I am running this load on a numa hardware so I profile the kernel by logging
functions that cause remote node memory access. I generate a final log
that shows functions that cause remote memory accesses greater that 0.5%
of all remote memory access on the system.

del_timer_sync was responsible for about 2% of all remote memory
accesses on the system and came up as part of the top 10 functions who
were doing this. On top was schedule(7.52%) followed by
default_wake_function(2.79%). Rest every one in the top 10 were
around the range of 2%.

After the patch it never came up in the logs again( so less than 0.5% of
all faulting eip's).


regards
shobhit


> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


