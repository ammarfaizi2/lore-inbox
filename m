Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbUAPTLL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265507AbUAPTLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:11:10 -0500
Received: from web40602.mail.yahoo.com ([66.218.78.139]:58686 "HELO
	web40602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264927AbUAPTLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:11:07 -0500
Message-ID: <20040116191102.98783.qmail@web40602.mail.yahoo.com>
Date: Fri, 16 Jan 2004 11:11:02 -0800 (PST)
From: Ravi Wijayaratne <ravi_wija@yahoo.com>
Subject: Linux Page Cache performance
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All.

We are running dbench on a machine with Dual Xeon (Hyper threading 
turned off), 1GB RAM
and 4 Drive software RAID5. The kernel is 2.4.29-xfs 1.2. We are using 
LVM. However
similar test done using ext2 on a disk partiotion (no md or LVM) shows 

The throughput is find till the number of clients are Around 16. At 
that point the throughput
plummets about 40%. We are trying to avoid that and see how we could 
have a consistent throughput
perhaps sacrificing some peak performance.

One could argue that at the point the performance drops we are actualy 
beggining to see 
I/O requests missing page cache and going to disk. That is our current 
guess. We try to tune
the buffer age and the interval page buffer daemon runs, but had no 
effect on the curve.
So transactional meta data operations seems not be causing the bottle 
neck.

Are there any VM patches that smooths out the Page Cache dirty page 
swapping process so that we
wont see this sudden drop of through put, but could have a smoother 
transition. I ran a 
kernel profiler on the test and I dont see any dentry cache flushes or 
inode cache flushes.

Similar test done using ext2 on a disk partiotion (no md or LVM) shows 
us similar performances.
However for ext2 when we tweak the bdflush parameters in /proc 
(specifically the max age of meta
data buffers) we can push the point where the data throughput falls to 
around 40 clients. 

But we are more interested in finding out ways to solve the XFS case.

Any insights on this ?

Thanx
Ravi



=====
------------------------------
Ravi Wijayaratne

__________________________________
Do you Yahoo!?
Yahoo! Hotjobs: Enter the "Signing Bonus" Sweepstakes
http://hotjobs.sweepstakes.yahoo.com/signingbonus
