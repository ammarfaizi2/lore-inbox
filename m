Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVFJOhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVFJOhh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 10:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVFJOhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 10:37:34 -0400
Received: from imap.mtholyoke.edu ([138.110.1.185]:1198 "EHLO
	mist.mtholyoke.edu") by vger.kernel.org with ESMTP id S262564AbVFJOh3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 10:37:29 -0400
From: Ron Peterson <rpeterso@mtholyoke.edu>
Date: Fri, 10 Jun 2005 10:37:20 -0400
To: linux-kernel@vger.kernel.org
Subject: slow directory listing
Message-ID: <20050610143720.GA14454@mtholyoke.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Mount Holyoke College
X-Operating-System: Debian GNU/Linux
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: 0 () 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm setting up a new mail server, and am testing/tweaking IO.  I have
two directories: /test/a which contains 750 mbox files totalling 8GB,
and /test/a2, which contains the exact same number of files, same names,
all zero length.

I am using ext3.  I have done this experiment with both indexed and
non-indexed directories (mke2fs -O dir_index ...).  I have also tried
setting the noatime mount option.

The times taken to do a directory listing are significantly different.

1037# time ls /test/a2 > /dev/null

real    0m0.006s
user    0m0.000s
sys     0m0.006s

1038# time ls /test/a > /dev/null

real    0m5.244s
user    0m4.875s
sys     0m0.346s

If I refer to a specific file, there's still a difference, but only 5x,
vs. 875x above.

1044# time ls a/anmbox > /dev/null

real    0m0.010s
user    0m0.009s
sys     0m0.002s

Fri Jun 10 10:31:02 root@slush:/db/tmp
1045# time ls a2/anmbox > /dev/null

real    0m0.002s
user    0m0.001s
sys     0m0.001s

I'm assuming this is normal behaviour.  (?)  However, I'd like to
understand what's happening a little better, and I'm wondering if
there's anything I'm overlooking vis-a-vis tuning my filesystem properly
for this type of application.

Linux 2.6.11.11 on Debian Sarge.  Dell 2800 w/ LSI Megaraid on PCI/E to
Utra320 SCSI disks.

-- 
Ron Peterson
Network & Systems Manager
Mount Holyoke College
http://www.mtholyoke.edu/~rpeterso
