Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266220AbUGASUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266220AbUGASUu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 14:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266225AbUGASUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 14:20:50 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:53442 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266220AbUGASUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 14:20:45 -0400
To: linux-kernel@vger.kernel.org, seb@highlab.com
Subject: io priorities?
Date: Thu, 01 Jul 2004 12:14:05 -0600
From: Sebastian Kuzminsky <seb@highlab.com>
Message-Id: <E1Bg64T-0003MC-00@highlab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks, i've got IO problems...


I've got a computer with one IDE disk.  There are a couple of processes
writing big telemetry logs, totally not time-critical.  Then there's one
process periodically writing a tiny little state file, about 150 bytes.
The process with the state file wants to sync its file to disk and then
quickly be back and running.  When it calls fsync() it has to wait for
other processes' less-important pending I/O before it gets to complete,
and it's not unusual for this to take 30 seconds (CF over IDE), which
is too slow for my application.


This happens with both 2.4.23 and 2.6.6 (as, cfq, & deadline).  I havent
tried to tune the schedulers at all, just using the default values.


I've tried five methods of syncing the file: sync(), fsync(), fdatasync(),
and opening with O_SYNC or O_DSYNC.  All take about the same amount
of time.


I've tried it on my target machine (Compact Flash via pio IDE) and on
my development machine (regular hard drive via udma5 IDE).  Same results
qualitatively speaking.




I read Jens Axboe's thread about cfq + io priorities, and it sounds
perfect!  I could give my one time-critical process high io priority
and it should preempt the others and life would be fine.  But all the
l-k traffic i've found about this is from back in November.  Did this
work go anywhere?


Any suggestions on fixes or workarounds?


I'm stumped.




--
Sebastian

