Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269710AbUHZV6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269710AbUHZV6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269681AbUHZV0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:26:42 -0400
Received: from main.gmane.org ([80.91.224.249]:58043 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269695AbUHZVVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:21:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Amit Shah <shahamit@gmail.com>
Subject: Inconsistent accesses to SDRAM on a PCI card
Date: Fri, 27 Aug 2004 02:42:02 +0530
Message-ID: <cgljnk$gmc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: calvin.codito.com
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a custom board that has the Marvell 64360 bridge. It has a powerpc
750GX processor on it and 256MB of SDRAM.

I wrote a host driver that could access the RAM via a /dev interface (I'm
using kernel 2.6.6 on the host). I can read / write from the device to the
sdram on the board. I also have u-boot running on the board, so I can
read / write from / to SDRAM on the board via u-boot. Basically, I can dump
a Linux kernel to the board via the host PCI interface and jump to the
kernel on the board via u-boot.

This worked fine while I worked with this setup on an IBM pserver machine.
However, when I switched to a locally assembled machine based on the intel 
SE7210TP1-E [1] chipset, u-boot's and PCI's view of SDRAM on the board
changed completely.

If I dump the kernel to an offset of 5 MB on the board via the PCI
interface, u-boot doesn't see it. The contents before and after dumping the
kernel remain the same. Ditto over the PCI interface. If I do any writes
via u-boot to the SDRAM, the PCI can't see the newly written contents.

This is very strange, I couldn't find an answer anywhere in the BIOS
settings or any kernel settings. Since the kernel, u-boot, host tools, etc,
haven't changed, and it's just the machine that has changed, I'm guessing
it's the PCI interface or the BIOS initializations that are causing some
funny things to happen.

Any clue why this should be happening?

Thanks,
Amit.


[1] http://www.intel.com/design/servers/boards/SE7210TP1-E/
-- 
Amit Shah
http://amitshah.nav.to/

