Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbTE1Rpb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 13:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264804AbTE1Rpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 13:45:31 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:48769 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S264801AbTE1Rpa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 13:45:30 -0400
Date: Wed, 28 May 2003 19:58:42 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: linux-kernel@vger.kernel.org
Cc: robn@verdi.et.tudelft.nl
Subject: 2.4 bug: fifo-write causes diskwrites to read-only fs !
Message-ID: <20030528175842.GA13657@verdi.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It turns out that Linux is updating inode timestamps of fifos (named
pipes) that are written to while residing on a read-only filesystem.
It is not only updating in-ram info, but it will issue *physical*
writes to the read-only fs on the disk !

I use a CompactFlash in an embedded application with a read-only root-fs
on it.  There are several processes that communicate with each other
via fifos.  This bug in Linux causes frequent writes to my CF and will
shorten it's lifetime enormously ..

I've posted a report on the "mysterious writes" before:
( http://www.ussg.iu.edu/hypermail/linux/kernel/0303.2/1753.html )
(incorrectly) linking it to a possible bug in O_SYNC.  Nothing came out
of it.

But now I've completely tracked down the bug (logging all diskaccesses
and seeing it undoubtly write in disksectors containing time-stamp
info of fifo's).  Looking back it would have been easier to prove that
something is wrong: the modified time-stamps survive power-cycles.
This is not supposed to happen on a read-only fs.

I've tried reading the kernel source to find where the bug lives,
But I'm not too familiar with it.  Anyone out there who can
pin it down ?

	greetings,
	Rob van Nieuwkerk


Sysinfo:
--------
- various 2.4 kernels including RH-2.4.20-13.9,
  but also straight 2.4(ac) ones.
- CompactFlash (= IDE disk)
- Geode GX1 CPU (i586 compatible)
