Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUBZVc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 16:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUBZVc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 16:32:58 -0500
Received: from 062016131174.customer.alfanett.no ([62.16.131.174]:4053 "EHLO
	cloud.brage.info") by vger.kernel.org with ESMTP id S261396AbUBZVci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:32:38 -0500
Date: Thu, 26 Feb 2004 22:33:49 +0100
From: Svein Ove Aas <svein.ove@aas.no>
To: linux-kernel@vger.kernel.org
Subject: Kernel BUG (still) at include/linux/list.h:148
Message-ID: <20040226213349.GA11276@cloud.brage.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been having this problem for a long time now, but since
the workaround is simple I never bothered to report it before;
I thought it was caused by my unusual, unusually broken hardware.
(To give you an idea, the Windows installer crashes hard.
Unusual, yes?)

Seeing that others have reported the same problem, though, I
decided to show my own.

Simply put: I get the following bug if I use either network
card (Atheros wlan or Realtek), or if I run X long. It probably
isn't the same each time, but it's usually the same BUG line.

It also almost always crashes during network transfers.

I'm pretty sure that this is somehow caused by having the USB
drivers loaded, as it doesn't crash if I don't load them. Well,
normally, that is: note the following.

- Loading ACPI makes it crash within a few minutes, no matter what.
- Loading ACPI but using pci=noacpi makes it just slightly
  more unstable.
- *Using* highmem makes it more unstable, except in the cases
  where it never crashes anyway - then it doesn't matter.
  I have 1GB of memory - thus, using mem=800M makes it more stable.

I'm currently using 2.6.3-mm4; the problem has been plaguing me
ever since I got the machine, on all possible kernels.
2.4.x doesn't work at *all*, incidentally - rather, it always
winds up crashing.

It can be perfectly stable with 2.6.x, staying up for weeks
at a time. (Doesn't actually *crash*, but may run out of electricity.)
 
The machine in question is a laptop, put together (or at least sold)
by Whitebox. General specs as follows:

- 2x512MB memory
- IDE drive
- Pentium M, 600Mhz-1.5Ghz
- Radeon 9000 M9 (R250 Lf)

It's marked "Centrino", but I requested a different Wlan chipset -
thus, it uses the Atheros version. This works pretty well, using
the madwifi driver.

Oddly, lspci seems to report two separate PCI busses, as well as
the AGP bus. The USB devices are on one bus 0, and end up sharing IRQs
with both the Radeon on bus 1 and the ethernet controllers at bus 2.
Could this be a problem?

In order to avoid flooding, I've put pretty much every conceivable
piece of information online here: http://svein.brage.info/bug/
It's personal DSL line, so it might not be entirely reliable;
mail me if you need more or are having trouble reaching it.

The module list there was written after the current reboot,
after unloading ehci_hcd and uhci_hcd; it should otherwise
be exactly the same as what crashed on me.

Please tell me if there's anything further I can do to help.
(Note that it doesn't have a serial port.)

Feb 26 21:44:50 aeris ------------[ cut here ]------------
Feb 26 21:44:50 aeris kernel BUG at include/linux/list.h:148!
Feb 26 21:44:50 aeris invalid operand: 0000 [#1]
Feb 26 21:44:50 aeris PREEMPT 
Feb 26 21:44:50 aeris CPU:    0
Feb 26 21:44:50 aeris EIP:    0060:[<c01788a5>]    Tainted: P   VLI
Feb 26 21:44:50 aeris EFLAGS: 00010207
Feb 26 21:44:50 aeris EIP is at mpage_writepages+0x2f5/0x310
Feb 26 21:44:50 aeris eax: 00000000   ebx: c18e94c8   ecx: c18e94d0   edx: c10c9e78
Feb 26 21:44:50 aeris esi: eb9f3d58   edi: c1bec000   ebp: c1bedf04   esp: c1bede14
Feb 26 21:44:50 aeris ds: 007b   es: 007b   ss: 0068
Feb 26 21:44:50 aeris Process pdflush (pid: 6, threadinfo=c1bec000 task=c1bef740)
Feb 26 21:44:50 aeris Stack: c18cc6e8 c1bedf04 00000292 f88c377c c1bede44 00000292 eb9f3d80 eb9f3d78 
Feb 26 21:44:50 aeris c01998d0 00000000 00000000 c1b77324 00000000 00000000 00000000 eb9f3d70 
Feb 26 21:44:50 aeris eb9f3d58 c1bedf04 eb9f3cb8 c013e704 eb9f3d58 c1bedf04 00000000 c0176a8e 
Feb 26 21:44:50 aeris Call Trace:
Feb 26 21:44:50 aeris [<c01998d0>] reiserfs_writepage+0x0/0x40
Feb 26 21:44:50 aeris [<c013e704>] do_writepages+0x34/0x40
Feb 26 21:44:50 aeris [<c0176a8e>] __sync_single_inode+0x11e/0x340
Feb 26 21:44:50 aeris [<c0176f10>] sync_sb_inodes+0x1b0/0x280
Feb 26 21:44:50 aeris [<c017703c>] writeback_inodes+0x5c/0xb0
Feb 26 21:44:50 aeris [<c013e507>] wb_kupdate+0xb7/0x140
Feb 26 21:44:50 aeris [<c013eba3>] __pdflush+0x103/0x1f0
Feb 26 21:44:50 aeris [<c013ec90>] pdflush+0x0/0x20
Feb 26 21:44:50 aeris [<c013ec9f>] pdflush+0xf/0x20
Feb 26 21:44:50 aeris [<c013e450>] wb_kupdate+0x0/0x140
Feb 26 21:44:50 aeris [<c0108f70>] kernel_thread_helper+0x0/0x10
Feb 26 21:44:50 aeris [<c0108f75>] kernel_thread_helper+0x5/0x10
Feb 26 21:44:50 aeris 
Feb 26 21:44:50 aeris Code: 04 fc ff e9 e9 fe ff ff 89 d8 e8 e7 05 fc ff e9 cb fe ff ff e8 3d 34 fa ff e9 b3 fe ff ff 0f 0b 95 00 2d 18 2f c0 e9 b7 fd ff ff <0f> 0b 94 00 2d 18 2f c0 e9 9f fd ff ff 8b 46 34 8b 00 89 44 24 
Feb 26 21:44:50 aeris <6>note: pdflush[6] exited with preempt_count 1

* crashes hard three minutes later; no log *



-- 
Ceterum censeo delendo est Microfusili.
