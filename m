Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262423AbUKQTX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbUKQTX2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbUKQTVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 14:21:24 -0500
Received: from smtp3.es.uci.edu ([128.200.80.6]:52203 "EHLO smtp3.es.uci.edu")
	by vger.kernel.org with ESMTP id S262423AbUKQTUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:20:33 -0500
Date: Wed, 17 Nov 2004 11:20:18 -0800
From: ccantwel@uci.edu
To: linux-kernel@vger.kernel.org
Subject: DAC960 and latest kernels
Message-ID: <20041117192018.GA25403@zee.ps.uci.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-NACS_ES-MailScanner: No viruses found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that I have found a very serious bug relating to the DAC960
driver, it is present in 2.4.27 and 2.6.8.1 but I haven't tried any
development kernels newer than that.  This message is meant to inform
the people who may be able to figure out what the problem is and
repair the bug.  If anyone wants to respond to me or has further
information on this problem, please cc me directly, as I am not a
member of this mailing list.

There is a bug in latest released kernels for both 2.4 and 2.6
trees that seems to relate to the DAC960 driver.  I have tried
2.4.27 and 2.6.8.1 and both have the following problem.  After
replacing and testing every piece of hardware I've determined
the problem is in the kernel and not the machine.  Also, going
back to kernel 2.4.17 makes everything work perfectly.

When copying a large number of files over the network using nc
and tar and also stress testing on the receiving side with
frequent du commands where the data is being written to (not
required for the problem but it seems to make it more likely
to happen) the machine randomly hangs.  Sometimes it crashes
completely with an Unable to handle kernel paging request at
virtual address, with various processes, and sometimes it just
completely halts and responds to nothing even though it seems
to sort of be running (answers on sockets but transfers no data,
no more communication of any kind on other open sockets, entering
a login name and enter on the console also hangs before the
password prompt.

Upon rebooting the filesystem that was being written to is corrupt.
When this file system is XFS I can still inspect it.  If it is
reiser the machine will often hang trying to run fsck.reiserfs.

In addition, after enough network tar copying I can stop the process,
and even if it has not hung the machine often the filesystem has
become corrupt.  Since this happens with both xfs and reiser and
there are paging problems too I believe it has to relate to the
dac960 driver itself.

I've also tried swapping DAC960 cards, and that doesn't matter,
they both work perfectly in 2.4.17 and the problems occur in
both cases in 2.4.27 and 2.6.8.1.  I'm planning to try some
more kernels in between to narrow down when the problem was
introduced but I'm not a kernel developer and that is about the
most I will be able to do.

I think the DAC960 driver isn't used very often and also without this
specific type of stress testing it is hard to realize the problem is
occuring before the filesystem is irreperably corrupt weeks down the
road, which is why this problem may have not been found yet.  Without
stress testing using tar the machine can go for weeks and act like it
is fine.

Again, if anyone has any information, please cc me when you reply as
I am not a member of this list.

Thank you
