Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWC0QX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWC0QX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWC0QX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:23:26 -0500
Received: from gscsmtp.wustl.edu ([128.252.233.26]:8609 "EHLO
	gscsmtp.wustl.edu") by vger.kernel.org with ESMTP id S1750801AbWC0QXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:23:25 -0500
Message-ID: <4428117A.6040300@watson.wustl.edu>
Date: Mon, 27 Mar 2006 10:23:22 -0600
From: Richard Wohlstadter <rwohlsta@watson.wustl.edu>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 64bit 2.6.15.3 kernel not reporting free memory correctly?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some servers running 64-bit kernels with 8g of memory and from 
what I understand of linux kernel memory management, it does not look 
like free memory is being reported correctly after some large jobs have 
run over time.  For instance, here is what one my servers are reporting 
right now:

$ free

              total       used       free     shared    buffers     cached
Mem:       8181360    5049828    3131532          0     243612      18256
-/+ buffers/cache:    4787960    3393400
Swap:      2048248       2496    2045752

$ cat /proc/meminfo

MemTotal:      8181360 kB
MemFree:       3131672 kB
Buffers:        243628 kB
Cached:          18308 kB
SwapCached:          0 kB
Active:        1126408 kB
Inactive:      3740400 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      8181360 kB
LowFree:       3131672 kB
SwapTotal:     2048248 kB
SwapFree:      2045752 kB
Dirty:              12 kB
Writeback:           0 kB
Mapped:          19764 kB
Slab:           164564 kB
CommitLimit:   6138928 kB
Committed_AS:    44092 kB
PageTables:       1064 kB
VmallocTotal: 34359738367 kB
VmallocUsed:    263376 kB
VmallocChunk: 34359474699 kB

There are not many processes running right now, so I added all processes 
VmSize values which totals to: 332 meg

So the question is, if buffer/cache used totals 260meg and all processes 
running vmsize total 332 meg, then why is meminfo  only reporting 3gig 
free.  It seems that the kernel is keeping inactive pages from processes 
that have run in the past that are no longer running.  I never see this 
type of issue on 32bit kernels so it seems this is 64-bit only(I've 
tried 2.6.14.3 and 2.6.15.3 kernels).  Thanks to anyone who has any 
insight on this issue.

Rich Wohlstadter
Washington University of St. Louis
