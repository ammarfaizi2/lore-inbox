Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbTISRQU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 13:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbTISRQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 13:16:20 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:31428 "EHLO
	iramx2.ira.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S261648AbTISRQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 13:16:17 -0400
Date: Fri, 19 Sep 2003 19:16:13 +0200
From: Roland Bless <bless@tm.uka.de>
To: miquels@cistron.nl, linux-kernel@vger.kernel.org
Cc: walter@tm.uka.de, winter@tm.uka.de, doll@tm.uka.de
Subject: Fix for wrong OOM killer trigger?
Message-Id: <20030919191613.36750de3.bless@tm.uka.de>
Organization: Institute of Telematics, University of Karlsruhe
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

I read your e-mail http://www.cs.helsinki.fi/linux/linux-kernel/2003-27/1274.html
in the archive, but was not able to find a solution.
We have a similar problem:
HW: 4x 2,4GHz Xeon, 4GB Ram, 3ware 7000-series ATA-RAID
SW: Kernel 2.4.22 (also seen on 2.4.21, 2.4.22-ac3), lvm, software raid,
reiserfs, SuSE 8.1. Swap turned off (see later).

**Symptom: programs that heavily search the whole filesystem
(e.g., rsync, ssync, TSM backup client dsmc) cause to trigger the 
OOM killer procedure (not very funny if NIS or NFS gets killed).

Sep 17 21:49:07 fs1 kernel: Out of Memory: Killed process 1384 (lmgrd).
Sep 17 21:49:12 fs1 kernel: Out of Memory: Killed process 1617 (exim).
Sep 17 21:49:18 fs1 kernel: Out of Memory: Killed process 1402 (ntpd).
Sep 17 21:49:23 fs1 kernel: Out of Memory: Killed process 1278 (portmap).
Sep 17 21:49:29 fs1 kernel: Out of Memory: Killed process 2715 (dsmc).
Sep 17 21:49:29 fs1 kernel: Out of Memory: Killed process 2716 (dsmc).
Sep 17 21:49:29 fs1 kernel: Out of Memory: Killed process 2717 (dsmc).
Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1600 (nscd).
Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1601 (nscd).
Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1602 (nscd).
Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1603 (nscd).
Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1604 (nscd).
Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1605 (nscd).
Sep 17 21:49:35 fs1 kernel: Out of Memory: Killed process 1606 (nscd).
Sep 17 21:49:40 fs1 kernel: Out of Memory: Killed process 1602 (nscd).
Sep 17 21:49:46 fs1 kernel: Out of Memory: Killed process 1421 (ypbind).
Sep 17 21:49:46 fs1 kernel: Out of Memory: Killed process 1422 (ypbind).
Sep 17 21:49:46 fs1 kernel: Out of Memory: Killed process 1423 (ypbind).
Sep 17 21:49:46 fs1 kernel: Out of Memory: Killed process 1424 (ypbind).
Sep 17 21:49:51 fs1 kernel: Out of Memory: Killed process 1584 (atd).
Sep 17 21:49:57 fs1 kernel: Out of Memory: Killed process 1329 (ypserv).

The OOM kill occured also when the cache memory didn't exhausted the
available memory (total mem usage was around 1.8GB).
echo 2>/proc/sys/vm/overcommit_memory did not solve the problem either.
In my understanding it has to do something with the fs cache/vm. We have some
files that are larger than 2GB, but usually the killing process starts at 
different points in time.

However, I also saw that kswapd used a lot CPU though swap was not active.
With swap space activated, the load on the cpu increases dramatically
so that the system becomes unusable, too. This is our file server and
I'm currently not able to make a backup to other systems. That's really
frustrating.

Anyone any ideas? Please Cc: to me in your replies since I'm not on the lkml.
Cheers,
 Roland

-- 
Roland Bless -- e-Mail: bless@tm.uka.de WWW: http://www.tm.uka.de/~bless
Institute of Telematics, University of Karlsruhe, Germany  
