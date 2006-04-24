Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWDXEDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWDXEDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 00:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWDXEDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 00:03:00 -0400
Received: from tallyho.bytemark.co.uk ([80.68.81.166]:11928 "EHLO
	tallyho.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751510AbWDXEC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 00:02:59 -0400
Subject: PCI ROM resource allocation issue with 2.6.17-rc2
From: Matthew Reppert <arashi@sacredchao.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Yomerashi
Date: Mon, 24 Apr 2006 00:02:41 -0400
Message-Id: <1145851361.3375.20.camel@minerva>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running 2.6.12-rc2-mm3 for a long time.  Recently I upgraded
a bunch of OS packages (Debian unstable), so I thought I may as well
upgrade the kernel, too.  I've got a dual-head setup driven by a Radeon
9200 and a Radeon 7000.  When I booted 2.6.17-rc2, X never came up; I
got "RADEON: Cannot read V_BIOS" and "RADEON: VIdeo BIOS not detected
in PCI space!" for the RADEON 7000, and it eventually gets in a loop of
spitting out "RADEON: Idle timed out, resetting engine ... " messages
in Xorg.log.  Doing a diff of working and broken logs uncovered that the
Radeon 7000's PCI ROM resource area had moved from ff8c000 to c6900000.
Once I removed the Radeon 7000 screen from the Xorg config, X came up fine
on the one head.  Adding stupid amounts of printks to the PCI subsystem in
.17-rc2 uncovered that at some point, the ROM area is discovered to be
at ff8c0000, but is later reallocated to c6900000.

I've also got a Promise PDC20268 whose expansion ROM seems to have made a
similar move (from ff8f8000 to c6920000), but the ATA devices attached to
that controller seem to work fine under 2.6.17-rc2.

I have a copy of relevant dmesg and lspci output, as well as a copy of
Xorg.log files, at http://sacredchao.net/~arashi/pci-problem/ .  I'll
try to binary-search for the last version of the kernel that works later
this week (hopefully by Tuesday afternoon), I just haven't had time to
since I've discovered the problem.

Matt

