Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265726AbTLINT3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 08:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265761AbTLINT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 08:19:28 -0500
Received: from ssatchell1.pyramid.net ([208.170.252.115]:40327 "EHLO
	ssatchell1.pyramid.net") by vger.kernel.org with ESMTP
	id S265726AbTLINT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 08:19:26 -0500
Subject: Swap performance statistics in 2.6 -- which /proc file has it?
From: Stephen Satchell <list@satchell.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3FD546D5.2000003@nishanet.com>
References: <BF1FE1855350A0479097B3A0D2A80EE00184D619@hdsmsx402.hd.intel.com>
	 <1070911748.2408.39.camel@dhcppc4>  <3FD546D5.2000003@nishanet.com>
Content-Type: text/plain
Message-Id: <1070975964.5966.5.camel@ssatchell1.pyramid.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 05:19:25 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, color me stupid.  I just grepped the entire Documentation directory
for 2.6.0-test11, and couldn't find anywhere where the number of disk
requests for swap, or the swap transfer volume, is provided.  In 2.4 I
had a single place where all swap activity (whether it was to a separate
partition or to a file on a mounted file system) is recorded.

I also grepped the proc filesystem source (linux/fs/proc) for "swap" and 
"Swap" and didn't find anything that had to do with swap request accounting, 
only with swap memory allocation (which I do use, but which for me is only 
half the story).

My purpose for wanting this performance metric is to try to detect when
a server has entered a thrashing mode (lots of swaps for an extended
period of time, possibly coupled with an ever-increasing amount of swap
used as the server falls further and further behind) so that I can take
some form of corrective action before the OOM killer starts committing
processicide, perhaps incorrectly.

Now, I could try to identify swap partitions using /proc/swaps,
totalling up the RIO+WIO and RBLK+WBLK from /proc/diskinfo for those
partitions that are swap partitions to get some measure, but that
doesn't help when an after-the-build swap file is added because the
original swap partition is too small.

(The person who answered this when I had a blinkered subject line of 
"Re: balanced interrupts" neglected to indicate which source file he 
was quoting to when providing what he thought was an answer.)

Someone please point out the obvious oversight to this feeble old fool
of a programmer.

Stephen Satchell


