Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbUKJQbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUKJQbi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 11:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbUKJQbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 11:31:37 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:36551 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261996AbUKJQbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 11:31:18 -0500
Date: Wed, 10 Nov 2004 10:31:07 -0600
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org
Subject: kthread realtime priorities and exporting 
 sys_sched_setscheduler()
Message-ID: <4192424B.mailxNJY11KR1G@aqua.americas.sgi.com>
User-Agent: nail 10.6 11/15/03
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: dcn@sgi.com (Dean Nelson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to push XP[C|NET] out to the community. (For further details:
http://marc.theaimsgroup.com/?l=linux-ia64&m=109337050919186&w=2 )

An objection was raised over the exporting and calling of
sys_sched_setscheduler(), which XPC calls to make its kthreads
run at realtime priorities. Without this change we found that it
was possible for user processes to be given a higher effective
priority than the kthreads used by XPC. The upshot of this was
that the latencies incurred by XPC increased 300 times in the
test example given. If XPC's kthreads were given realtime
priorities this did not happen. (For further details:
http://marc.theaimsgroup.com/?l=linux-ia64&m=109337503100067&w=2 )

Note that XPC uses kthreads because it is possible for them to block
indefinitely.

So if we are unable to export sys_sched_setscheduler() or setscheduler()
what would you suggest we do to solve this particular problem?

Thanks,
Dean
