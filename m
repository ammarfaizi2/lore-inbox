Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265641AbUAGWBa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 17:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265647AbUAGWB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 17:01:29 -0500
Received: from lightning.hereintown.net ([141.157.132.3]:60117 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S265641AbUAGWB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 17:01:28 -0500
Subject: MegaRAID on AMD64 under 2.6.1
From: Chris Meadors <clubneon@hereintown.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1073512887.8211.39.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Jan 2004 17:01:28 -0500
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AeLk0-0003qi-3E*//cHCQ5ANLQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to recall some discussion reguarding the MegaRAID driver use on
AMD64 machines with large amounts of RAM.  My machine only has 2 GB of
RAM, and the driver was working fine under 2.6.0 (note I use Andi
Kleen's x86_64 patch kit, on an otherwise stock kernel).  But with the
release of 2.6.1-rc1 the driver does not load.  I have module support
disabled and all needed drivers built into the kernel.  All my file
systems (including root) are on logical drives provided by the RAID
controller.  So the kernel panics when attempting to mount the root
filesystem, if the driver doesn't load.

Looking through the 2.6.1-rc2 patch, it seems that the megaraid.[ch]
files got some large amount of re-ordering.  So I can't easily spot what
change might have effected the driver.

Here is the lspci output for my specific card:

02:07.0 RAID bus controller: LSI Logic / Symbios Logic PowerEdge
Expandable RAID Controller 4 (rev 01)
        Subsystem: LSI Logic / Symbios Logic: Unknown device a520
        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 26
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Expansion ROM at fc9f8000 [disabled] [size=32K]
        Capabilities: [80] Power Management version 2

I'm wondering if the driver just doesn't claim it anymore.  Or maybe it
is being told not to load on 64-bit machines?

I can test any patches.

-- 
Chris

