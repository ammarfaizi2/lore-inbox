Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWILWdB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWILWdB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWILWdB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:33:01 -0400
Received: from chain.digitalkingdom.org ([64.81.49.134]:16346 "EHLO
	chain.digitalkingdom.org") by vger.kernel.org with ESMTP
	id S932252AbWILWdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:33:00 -0400
Date: Tue, 12 Sep 2006 15:32:58 -0700
To: linux-kernel@vger.kernel.org
Subject: Early boot hang on recent 2.6 kernels (> 2.6.3), on x86-64 with 16gb of RAM
Message-ID: <20060912223258.GM4612@chain.digitalkingdom.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
From: Robin Lee Powell <rlpowell@digitalkingdom.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please cc me on replies, as I'm not on the list.

I have some moderately old hosts that hang on boot, very early on,
with any kernel newer than 2.6.3.  Important basic facts about the
box are dual opteron 244s, 16gb of RAM, and it's a 64-bit build of
the kernel.  We've tried both MK8 and CONFIG_MK8 and
CONFIG_GENERIC_CPU to no avail.  Hell, I think I've tried just about
everything at this point.

In most cases the stopping point is:

[snip]
    Initializing CPU#0
[snip]
    CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
    CPU: L2 Cache: 1024K (64 bytes/line)
    CPU 0/0(1) -> Node 0 -> Core 0

(see below for complete version)

Whether that last line shows up or not is based on BIOS configs,
AFAICT.

I've been working on these for several days now, and I'm totally
stumped.  I'll generate any data any of you ask for that might be
useful, and I'll be appending a lot of data here.

The kernel I'm actually trying to get working is 2.6.17.11, but I've
tried all of the following:

linux-2.6.2
linux-2.6.3
linux-2.6.4
linux-2.6.6
linux-2.6.10
linux-2.6.17.11

Only the first two work.

For all of them except 2.6.17.11, the config was just the config
from the known-working 2.6.2, make oldconfig, hold down the return
button.  2.6.17.11 I played with a bit more.

The original 2.6.2 working .config is
http://teddyb.org/~rlpowell/media/regular/lkml/orig.config.txt

The current 2.6.17.11 .config is
http://teddyb.org/~rlpowell/media/regular/lkml/current.config.txt

The full boot with apci on is
http://teddyb.org/~rlpowell/media/regular/lkml/apci_boot.txt

The full boot with apci off is
http://teddyb.org/~rlpowell/media/regular/lkml/noapci_boot.txt

This version is rather different, as it ends in:

    HARDWARE ERROR
    CPU 0: Machine Check Exception:                7 Bank 3: b40000000000083b
    RIP 10:<ffffffff80446e3e> {pci_conf1_read+0xbe/0xf0}
    TSC 2e7932dbf8 ADDR fdfc000cfc
    This is not a software problem!
    Run through mcelog --ascii to decode and contact your hardware vendor
    Kernel panic - not syncing: Uncorrected machine check

We believe this to be spurious, as both machines of this type we've
tested showed the same error, and both of them have been running
with 2.6.2 for years.

The motherboard is, apparently, a RioWorks Rhapsody HDAMA, whatever that is.
We are not on the latest BIOS revision, but then the changes between 1.84
(which we're on) and 1.89 don't look relevant.

BIOS information is
http://teddyb.org/~rlpowell/media/regular/lkml/bios_info.txt

lspci -v (generated while up on the 2.6.2 kernel that's been running
for years) is
http://teddyb.org/~rlpowell/media/regular/lkml/lspci_v.txt

dmidecode is
http://teddyb.org/~rlpowell/media/regular/lkml/dmidecode.txt

-Robin
