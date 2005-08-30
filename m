Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVH3CPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVH3CPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 22:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVH3CPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 22:15:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65500 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751115AbVH3CPc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 22:15:32 -0400
Date: Mon, 29 Aug 2005 19:15:16 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Trailing comments in broken-out series file break quilt
Message-Id: <20050829191516.4e5d9e0b.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently Andrews patch tools allow trailing comments on active lines
in the series file, as in these lines culled from the series file for
2.6.13-rc6-mm2:

    e1000-numa-aware-allocation-of-descriptors-v2.patch # hold
    nfs-nfs3-page-null-fill-in-a-short-read-situation.patch # wait
    sched-implement-nice-support-across-physical-cpus-on-smp.patch # con
    sched-change_prio_bias_only_if_queued.patch # con
    sched-account_rt_tasks_in_prio_bias.patch # con
    sched-smp-nice-bias-busy-queues-on-idle-rebalance.patch # con
    sched-correct_smp_nice_bias.patch # con
    md-fix-rh_dec-rh_inc-race-in-dm-raid1c.patch # wait

However the quilt command passes these additional terms to the patch
command as additional arguments, confusing the heck out of patch,
and generating an error message that confused the heck out of me.

Question - should I be asking Andrew not to comment this way, or
should I be asking quilt to recognize a comment convention here?

If we choose the second alternative, then the following change to
the file /usr/local/share/quilt/scripts/patchfns might to the trick:

--- /tmp/q/patchfns.1	2005-08-29 19:11:24.000000000 -0700
+++ /tmp/q/patchfns.2	2005-08-29 19:11:31.000000000 -0700
@@ -108,8 +108,8 @@ patch_args()
 	then
 		/bin/gawk '
 		$1 == "'"$patch"'" \
-			{ if (NF >= 2)
-				for (i=2; i <= NF; i++)
+			{ if (NF >= 2 && $2 != "#")
+				for (i=2; i <= NF && $i != "#"; i++)
 					print $i
 			  else
 				print "-p1" ;

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
