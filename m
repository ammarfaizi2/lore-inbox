Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUDCCik (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 21:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbUDCCik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 21:38:40 -0500
Received: from [24.80.50.208] ([24.80.50.208]:8716 "EHLO gw.sieb.net")
	by vger.kernel.org with ESMTP id S261378AbUDCCii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 21:38:38 -0500
Message-ID: <406E2392.2090804@sieb.net>
Date: Fri, 02 Apr 2004 18:38:10 -0800
From: Samuel Sieb <samuel@sieb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: linux-pcmcia@lists.infradead.org
Subject: pc card hangs computer with 2.6 kernel (more details)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this originally to the pcmcia list, but haven't seen a response yet.

My laptop freezes as soon as I insert a Linksys WPC11 card which is an
802.11b wireless card.  I don't think it's the driver since as far as I
can tell, the drivers aren't included in the kernel (it's a prism 2).  I
first tried with a 2.6.1 kernel and then upgraded to 2.6.4 but it still
acts the same.  (I'm using Fedora Core Testing, updated to latest.)

The laptop is a Compaq Presario 2190, the cardbus is:
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
         Subsystem: Hewlett-Packard Company: Unknown device 0024
         Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
         Memory at 80000000 (32-bit, non-prefetchable)
         Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
         Memory window 0: 81000000-81100000 (prefetchable)
         Memory window 1: 10000000-103ff000
         I/O window 0: 00003000-0000307f
         I/O window 1: 00004000-000040ff
         16-bit legacy interface ports at 0001

dmesg shows:
Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0024]
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x220-0x22f
0x330-0x337 0x378-0x37f 0x388-0x38f 0x3c0-0x3df 0x408-0x40f 0x480-0x48f
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.

I just noticed that it did get a message in /var/log/messages:
Apr  1 09:48:57 localhost kernel: cs: memory probe xa0000000-0xa0ffffff:
clean.
Apr  1 09:48:57 localhost cardmgr[1001]: socket 0: Intersil PRISM2 11
Mbps Wireless Adapter

That's the last thing in the log before the next startup.
If the card was already in when I booted it, then there was one more
line in the log from the next booting step before it hung.

Further probing shows that the computer is still functioning as I can 
use sysrq functions.  Using sysrq-p gives me a list that appears to 
scroll off the screen.  From the top of the screen, the first few items are:
alloc_netdev
ether_setup
orinoco_cs_hard_reset
orinoco_cs_attach
orinoco_cs_event
bind_request
kmem_cache_alloc
bind_request
ds_ioctl
get_random_bytes
arch_align_stack
mmap_top
mm_init

I have updated the laptop's bios to the latest version.  Any other 
information that would be helpful?

