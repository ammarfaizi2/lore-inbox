Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbUALWNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 17:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265617AbUALWNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 17:13:42 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:20365 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265576AbUALWNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 17:13:37 -0500
Subject: Re: [PATCH] Intel Alder IOAPIC fix
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
References: <1073876117.2549.65.camel@mulgrave> 
	<Pine.LNX.4.58.0401121152070.1901@evo.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Jan 2004 17:13:31 -0500
Message-Id: <1073945612.2105.67.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-12 at 16:24, Linus Torvalds wrote:
> What are the BAR contents? In particular, maybe the right fix is to add a 
> flag to say "don't touch" - but leave the BAR contents there, so that 
> the resource manager can actually see what the resources actually are..

The bar contents seem to be real:

00:0f.0 Class ff00: Intel Corp. Extended Express System Support
Controller
        Subsystem: Unknown device 0008:2000
        Flags: fast devsel
        Memory at 20000000 (32-bit, prefetchable) [size=1K]
        Memory at 20000400 (32-bit, prefetchable) [size=1K]
        Memory at 20000800 (32-bit, prefetchable) [size=1K]
        Memory at 20000c00 (32-bit, prefetchable) [size=1K]
        Memory at 20001000 (32-bit, prefetchable) [size=1K]
        Memory at 20001400 (32-bit, prefetchable) [size=1K]
        Expansion ROM at fffff800 [disabled] [size=2K]


That sits just on top of my available memory.

However, the resource allocation code produces this on boot (this is
what kills the second IO APIC)

PCI: Cannot allocate resource region 0 of device 00:0f.0
PCI: Cannot allocate resource region 1 of device 00:0f.0
PCI: Cannot allocate resource region 2 of device 00:0f.0
PCI: Cannot allocate resource region 3 of device 00:0f.0
PCI: Cannot allocate resource region 4 of device 00:0f.0
PCI: Cannot allocate resource region 5 of device 00:0f.0
PCI: Error while updating region 00:0f.0/1 (20000408 != 20000008)
PCI: Error while updating region 00:0f.0/2 (20000808 != 20000008)
PCI: Error while updating region 00:0f.0/3 (20000c08 != 20000008)
PCI: Error while updating region 00:0f.0/4 (20001008 != 20000008)
PCI: Error while updating region 00:0f.0/5 (20001408 != 20000008)

I'll poke and find a flag to keep the range.

James


