Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVDFQDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVDFQDt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 12:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbVDFQDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 12:03:21 -0400
Received: from unthought.net ([212.97.129.88]:26086 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262241AbVDFQBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 12:01:24 -0400
Date: Wed, 6 Apr 2005 18:01:23 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: linux-kernel@vger.kernel.org
Subject: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050406160123.GH347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello list,

Setup; 
 NFS server (dual opteron, HW RAID, SCA disk enclosure) on 2.6.11.6
 NFS client (dual PIII) on 2.6.11.6

Both on switched gigabit ethernet - I use NFSv3 over UDP (tried TCP but
this makes no difference).

Problem; during simple tests such as a 'cp largefile0 largefile1' on the
client (under the mountpoint from the NFS server), the client becomes
extremely laggy, NFS writes are slow, and I see very high CPU
utilization by bdflush and rpciod.

For example, writing a single 8G file with dd will give me about
20MB/sec (I get 60+ MB/sec locally on the server), and the client rarely
drops below 40% system CPU utilization.

I tried profiling the client (booting with profile=2), but the profile
traces do not make sense; a profile from a single write test where the
client did not at any time drop below 30% system time (and frequently
were at 40-50%) gives me something like:

raven:~# less profile3 | sort -nr | head
257922 total                                      2.6394
254739 default_idle                             5789.5227
   960 smp_call_function                          4.0000
   888 __might_sleep                              5.6923
   569 finish_task_switch                         4.7417
   176 kmap_atomic                                1.7600
   113 __wake_up                                  1.8833
    74 kmap                                       1.5417
    64 kunmap_atomic                              5.3333

The difference between default_idle and total is 1.2% - but I never saw
system CPU utilization under 30%...

Besides, there's basically nothing in the profile that rhymes with
rpciod or bdflush (the two high-hitters on top during the test).

What do I do?

Performance sucks and the profiles do not make sense...

Any suggestions would be greatly appreciated,

Thank you!

-- 

 / jakob

