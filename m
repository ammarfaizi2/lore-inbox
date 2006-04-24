Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWDXF2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWDXF2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 01:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWDXF2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 01:28:12 -0400
Received: from tallyho.bytemark.co.uk ([80.68.81.166]:32927 "EHLO
	tallyho.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1750761AbWDXF2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 01:28:11 -0400
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
From: Matthew Reppert <arashi@sacredchao.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1145851361.3375.20.camel@minerva>
References: <1145851361.3375.20.camel@minerva>
Content-Type: text/plain
Organization: Yomerashi
Date: Mon, 24 Apr 2006 01:28:09 -0400
Message-Id: <1145856489.3375.28.camel@minerva>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bit more information.

On Mon, 2006-04-24 at 00:02 -0400, Matthew Reppert wrote:
> I've been running 2.6.12-rc2-mm3 for a long time.  Recently I upgraded
> a bunch of OS packages (Debian unstable), so I thought I may as well
> upgrade the kernel, too.  I've got a dual-head setup driven by a Radeon
> 9200 and a Radeon 7000.  When I booted 2.6.17-rc2, X never came up; I
> got "RADEON: Cannot read V_BIOS" and "RADEON: VIdeo BIOS not detected
> in PCI space!" for the RADEON 7000, and it eventually gets in a loop of
> spitting out "RADEON: Idle timed out, resetting engine ... " messages
> in Xorg.log.  Doing a diff of working and broken logs uncovered that the
> Radeon 7000's PCI ROM resource area had moved from ff8c000 to c6900000.
> Once I removed the Radeon 7000 screen from the Xorg config, X came up fine
> on the one head.  Adding stupid amounts of printks to the PCI subsystem in
> .17-rc2 uncovered that at some point, the ROM area is discovered to be
> at ff8c0000, but is later reallocated to c6900000.
> 
> I've also got a Promise PDC20268 whose expansion ROM seems to have made a
> similar move (from ff8f8000 to c6920000), but the ATA devices attached to
> that controller seem to work fine under 2.6.17-rc2.

Also, on 2.6.17-rc2, if I do a hexdump of the PCI config space for the
RADEON 7000 via sysfs once Linux boots, it still says the ROM is located
at ff8c0000, even though I get this message during boot:

PCI: pbus will assign resource 0000:01:0c.0
PCI: assigning resource #6 for 0000:01:0c.0 (start 0)
  got res [c6900000:c691ffff] bus [c6900000:c691ffff] flags 7200 for BAR 6 of
0000:01:0c.0

The first two lines of that bit from dmesg are from extra printks I put
in the for loop at the end of pbus_assign_resources_sorted and at the
top of pci_assign_resource.

The Promise controller's PCI config space says it's at c6920000.


> I have a copy of relevant dmesg and lspci output, as well as a copy of
> Xorg.log files, at http://sacredchao.net/~arashi/pci-problem/ .  I'll
> try to binary-search for the last version of the kernel that works later
> this week (hopefully by Tuesday afternoon), I just haven't had time to
> since I've discovered the problem.
> 
> Matt

