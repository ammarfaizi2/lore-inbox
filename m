Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270573AbTGTAYB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 20:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270574AbTGTAYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 20:24:01 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:33990 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S270573AbTGTAX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 20:23:59 -0400
Message-ID: <3F19C838.8040301@cornell.edu>
Date: Sat, 19 Jul 2003 18:37:44 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
Subject: TCQ problems in 2.6.0-test1: the summary  
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test1-current.
The TCQ bugs/problems that I have found in the kernel have not been
addressed yet. Some of the things posted below are new, but most have
been posted before, and there have been no replies. If those bug reports
are invalid, please say so, and I will stop sending them.

================================================================================

I own an IC35L080AVVA07-0 80 GB drive
(IBM Desktar 120 GXP, which is supposed to support TCQ).
TCQ will not be activated on boot unless TCQ is enabled by default.

The problems:

======================================================================================
1) This patch by Jens Axboe makes my machine bootable with tcq enabled.
It hasn't been included in the kernel yet.

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1006.html

2) The default for queue depth is commented as 32, but is in fact 8.

3) This is described as a way to set tcq depth in the docs:
  echo "using_tcq:32" > /proc/ide/hdX/settings

but it results in:  proc_ide_write_settings(): parse error
(hdparm -Q works instead)

4) Using a tcq-enabled kernel with queue depth of 8 results in
massive filesystem corruption for me, verified under reiserfs, and xfs.
Elevator choice does not appear to matter, while queue depth is
important - I do not appear to get filesystem corruption with queue
depth of 32. Reiser refuses to mount with such a kernel, and runs
--fix-fixable at boot time. This is reproducible every time.

5) Using a tcq-enabled kernel causes i/o lockups (disk read/write
freezes, while I am still able to move the mouse, type dmesg, etc..). To
trigger the partial i/o lockups I set the disk standby to 5 seconds.
After waking up the disk, I get numerous errors, and I have also gotten
an oops. Attempts to reproduce this with tcq off have failed so far. The
errors and oops are posted here:

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1682.html

I also get full system hangs like everybody else, but that doesn't
appear to be caused by tcq - have tested without it.

=============================================================================================

I am still keeping an old damaged reiser root filesystem, for the
purposes of testing. If there is interest in testing filesystem
corruption bugs, I am willing to do that. Please reply, though, because
I will eventually destroy that partition if there is no interest.

=============================================================================================
Finally, a comment on buffer-cache read speeds:
they're double what they used to be!
577.80 MB/sec vs 250-ish on 2.4.
That's great - I wondered what causes this improvement?
Thanks to all kernel developers.





