Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVG1NZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVG1NZz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVG1NZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:25:55 -0400
Received: from [202.136.32.45] ([202.136.32.45]:47266 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S261289AbVG1NZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:25:53 -0400
From: Grant Coady <lkml@dodo.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.32-pre2: uhci.c: ff80: host controller halted. very bad
Date: Thu, 28 Jul 2005 23:25:37 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <4vmhe19jvvjumvbrdedidvu331tb31k910@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
More info on Toshiba laptop lockup with 2.4.32-pre2:

/var/log/syslog:
Jul 28 22:59:33 tosh kernel: Linux version 2.4.32-pre2 (root@tosh) (gcc version 3.3.5) #4 Thu Jul 28 22:57:05 EST 2005
Jul 28 22:59:33 tosh kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jul 28 22:59:33 tosh kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jul 28 22:59:33 tosh kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul 28 22:59:33 tosh kernel:  BIOS-e820: 0000000000100000 - 000000000bfe0000 (usable)
Jul 28 22:59:33 tosh kernel:  BIOS-e820: 000000000bfe0000 - 000000000bff0000 (ACPI data)
Jul 28 22:59:33 tosh kernel:  BIOS-e820: 000000000bff0000 - 000000000c000000 (reserved)
Jul 28 22:59:33 tosh kernel:  BIOS-e820: 00000000100a0000 - 00000000100b6e00 (reserved)
Jul 28 22:59:33 tosh kernel:  BIOS-e820: 00000000100b6e00 - 00000000100b7000 (ACPI NVS)
Jul 28 22:59:33 tosh kernel:  BIOS-e820: 00000000100b7000 - 0000000010100000 (reserved)
Jul 28 22:59:33 tosh kernel:  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
Jul 28 22:59:33 tosh kernel: On node 0 totalpages: 49120
Jul 28 22:59:33 tosh kernel: zone(0): 4096 pages.
Jul 28 22:59:33 tosh kernel: zone(1): 45024 pages.
Jul 28 22:59:33 tosh kernel: zone(2): 0 pages.
Jul 28 22:59:33 tosh kernel: Kernel command line: BOOT_IMAGE=2.4.32-pre2 ro root=303 video=vesafb:mtrr,ywrap
Jul 28 22:59:33 tosh kernel: Detected 497.562 MHz processor.
Jul 28 22:59:33 tosh kernel: Console: colour dummy device 80x25
Jul 28 22:59:33 tosh kernel: Calibrating delay loop... 992.87 BogoMIPS
Jul 28 22:59:33 tosh kernel: Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul 28 22:59:33 tosh kernel: CPU: Intel Celeron (Coppermine) stepping 01
Jul 28 22:59:33 tosh kernel: POSIX conformance testing by UNIFIX
Jul 28 22:59:33 tosh kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Jul 28 22:59:33 tosh kernel: mtrr: detected mtrr type: Intel
Jul 28 22:59:33 tosh kernel: PCI: Probing PCI hardware (bus 00)
Jul 28 22:59:33 tosh kernel: Initializing RT netlink socket
Jul 28 22:59:33 tosh kernel: Starting kswapd
Jul 28 22:59:33 tosh kernel: Console: switching to colour frame buffer device 100x37
Jul 28 22:59:33 tosh kernel: pty: 256 Unix98 ptys configured
Jul 28 22:59:33 tosh kernel: hda: SAMSUNG MP0402H, ATA DISK drive
Jul 28 22:59:33 tosh kernel: blk: queue c034ca20, I/O limit 4095Mb (mask 0xffffffff)
Jul 28 22:59:33 tosh kernel: hdc: CD-224E-B, ATAPI CD/DVD-ROM drive
Jul 28 22:59:33 tosh kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 28 22:59:33 tosh kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 28 22:59:33 tosh kernel: hda: attached ide-disk driver.
Jul 28 22:59:33 tosh kernel: hda: host protected area => 1
Jul 28 22:59:33 tosh kernel: hdc: attached ide-cdrom driver.
Jul 28 22:59:33 tosh kernel: ip_conntrack version 2.1 (1535 buckets, 12280 max) - 152 bytes per conntrack
Jul 28 22:59:33 tosh kernel: ip_tables: (C) 2000-2002 Netfilter core team
Jul 28 22:59:33 tosh kernel: PCI: Enabling device 14:00.0 (0000 -> 0003)
Jul 28 22:59:33 tosh kernel: reiserfs: found format "3.6" with standard journal
Jul 28 22:59:33 tosh kernel: reiserfs: checking transaction log (device ide0(3,3)) ...
Jul 28 22:59:33 tosh kernel: for (ide0(3,3))
Jul 28 22:59:33 tosh kernel: ide0(3,3):Using r5 hash to sort names
Jul 28 22:59:33 tosh kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Jul 28 23:01:25 tosh kernel: uhci.c: ff80: host controller process error. something bad happened
Jul 28 23:01:25 tosh kernel: uhci.c: ff80: host controller halted. very bad

Running okay with USB "< >" off...
http://scatter.mine.nu/test/linux-2.4/tosh/ for more info

Grant.
