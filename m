Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUHMOCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUHMOCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 10:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbUHMOCf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 10:02:35 -0400
Received: from gw-oleane.hubxpress.net ([81.80.52.129]:26326 "EHLO
	yoda.hubxpress.net") by vger.kernel.org with ESMTP id S265487AbUHMOCa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 10:02:30 -0400
From: "Sylvain COUTANT" <sylvain.coutant@illicom.com>
To: <linux-kernel@vger.kernel.org>
Subject: High CPU usage (up to server hang) under heavy I/O load
Date: Fri, 13 Aug 2004 16:01:35 +0200
Organization: ILLICOM
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcSBPdykdNbyY+XFR4iSOX7E4jeWtgAABWeA
Message-Id: <20040813140229.4F48B2FC2C@illicom.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gurus,

I have a problem with one server (DELL, 1 TB RAID5 + RAID0, Bi-Xeon, 8 GB
RAM) which, sometimes, goes mad when the I/O pressure gets too high. We use
this server as a VMWare server and as a backup server (200 GB are dedicated
to the backup part). We have run full hardware diags and checked every
software that runs on the system. We have been able to reproduce the problem
once without having launched the VMWare server (so I believe this software
is not responsible for the problem).

We have tested kernels 2.4.22 and 2.4.26. The server is running under Debian
Woody.

The exact problem is the unix load sometimes goes _very high_ under I/O
activity (mainly disk writes seem to cause this). Even having just two or
three tar+gz processes running can cause the 15 minutes load average to get
as high as 20 or 30 (where we would expect it being between 2 and 4). The
load can go to so high value that we can't do anything anymore on the server
during some delay (between a few seconds and a few days). Our Friday night
backups often hang the server until we unplug the power to reboot on monday
morning. From what we have seen, it can happen that kswapd and kupdated eats
up to 70% of one CPU each. Otherwise, it's very hard to tell what happens
exactly because when the server is slowing down we have no possible
monitoring, no log, no alerts, no automatic reboot (must power off/on to
reboot), no console alert, ... Just, that it's still pingable !!

We didn't found a way to reproduce this behaviour with a specific test case.
Sometimes the server will be fine during a few days then slow down and hang.
Sometimes it will hang just a few hours after having been booted.

I have spent hours searching for information and found our problem was very
common in early 2.4.x kernels (virtual memory management) between 2000 and
2002 on servers with large RAM. Only recent information I found was some
patches related to kernel hanging or something like, but symptoms described
was never exactly the same as ours.

I tried to play a little with "/proc/sys/vm/*" settings (mainly bdflush) but
I didn't found any major improvement (perhaps just because I didn't put in
the good values). What I was trying to do was reducing the amount of memory
the kernel could use for dirty buffers, thus having more regular flush to
disks.

Hopefully, some people here could be of help ;-))


Regards,
Sylvain.

