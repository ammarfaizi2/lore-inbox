Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422988AbWJaIwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422988AbWJaIwE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422989AbWJaIwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:52:03 -0500
Received: from poczta2.linux.webserwer.pl ([193.178.241.17]:43437 "EHLO
	poczta2.linux.webserwer.pl") by vger.kernel.org with ESMTP
	id S1422988AbWJaIwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:52:01 -0500
Message-ID: <45470EAA.1060901@limcore.pl>
Date: Tue, 31 Oct 2006 09:51:54 +0100
From: "lkml-2006i-ticket@limcore.pl" <lkml-2006i-ticket@limcore.pl>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.18.1 + grsecurity JFS failed with dbAllocNext: Corrupt dmap page
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
on 2.6.18.1 + grsecurity I totally lost an JFS partition.

I was doing regular work on freshly installed debian stable (on
olerd/rather tested hardware that worked 24/24 7/7)
I installed 2.6.18.1 + grsecurity, started memtest and stress in the
background, enabled swap with encryption, and played a bit with SysRq -
using it to dump CPU state and tasks list (playing around).

After a while I got tons of errors like
ERROR: (device hda3): DT_GETPAGE: dtree page corrupt
ERROR: (device hda3): dbAllocNext: Corrupt dmap page

about 10 per second. I rebooted (computer hanged)

After reset the partition used - hda3 (as /, it was the only rw mounted
partition) was gone, unable to repair "since both master and secondary
superblocks are damaged".

If anyone is interested I saved first 100 MB of this ~6 GB partition
using dd, it looks totally different in hexdump then other partition (at
least the begin) so it suggests that indeed superblock and other data
was totally shreded / filled with garbage.

The config it Althon 1700 with 512 RAM, kernel 2.6.18.1 + grsecurity.
Config: in 250 Hz timer frequency, with Voluntary Kernel Preemption,
with no privilaged ioports, possible with some additional kernel hackng
options (like vm debugging),

otherwise config was like the 2.6.18 (but not .1) that run perfectly on
other machines.

The failure occured during heavy load and stress testing while playing
with SysRq at same time (but only non-destructive things like -p -t -m)

The smartctrl shows 2 UDMA errors for this device (but they might be
very old).

Possible that this is hardware fault, but letting now perhaps anyone had
simmilar problems...


ERROR: (device hda3): DT_GETPAGE: dtree page corrupt
ERROR: (device hda3): dbAllocNext: Corrupt dmap page


-- 
LimCore    C++ Software Architect / Team Lead
---> oo    Linux programs
limcore
software


