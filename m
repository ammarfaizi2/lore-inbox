Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTL2B0l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 20:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTL2B0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 20:26:41 -0500
Received: from mail.nzol.net ([210.55.200.32]:64685 "EHLO linuxmail1.nzol.net")
	by vger.kernel.org with ESMTP id S262192AbTL2B0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 20:26:03 -0500
Message-ID: <1072657930.3fef760a50062@webmail.nzol.net>
Date: Mon, 29 Dec 2003 13:32:10 +1300
From: akmiller@nzol.net
To: linux-kernel@vger.kernel.org
Subject: ide: "lost interrupt" with 2.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 210.55.200.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing "lost interrupt" during kernel init, immediately after the drive is
probed.

The system boots under 2.2.x, using the kernel supplied with the current stable
Debian release. I have not yet tried it with 2.4.x(I had to transfer 2.6.x as
split on floppies as the network device won't work with 2.2.x).

Data is copied by hand from the monitor, so accuracy not guaranteed(but I think
its correct)...

Relevant lspci line, after booting under 2.2.x...
00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (rev
05)

We have had problems with these devices(ACS7500, a transparent IDE RAID
controller from Accusys) on other boards where the BIOS wouldn't boot them, so
they may be doing something weird with the standards. The BIOS on this board
can allow the system to boot correctly off this device.

Relevant part of the output on bootup...
hda: Accusys ACS7500 C5VL, ATA DISK drive
ide0 at 0x1f0-0x1f7, 0x3f6 on irq 14
hdc: LG CD-ROM CRD-8522B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: 234441648 sectors(120034 MB) w/2048 KiB Cache, CHS=16383/255/63
hda:<4>hda: lost interrupt
lost interrupt
lost interrupt
(continues forever)

I have tried (without success) enabling all workarounds in the kernel config,
disabling APIC(noapic on command line, this is a single P4), disconnecting the
CDROM from the secondary IDE, swapping the disk onto the secondary IDE,
disabling DMA-by-default in the kernel config, disabling DMA in the BIOS setup,
setting the PIO mode in the BIOS setup to 0, and trying the old driver on the
primary interface(which failed because the device has too many cylinders).

Has anyone else seen this sort of problem? (Sorry if this is a known issue, I
couldn't find anything that seemed to be the same in the archives). Has anyone
got an ACS7500 running under 2.6.0, or 2.4.x for any recent kernel?

If you anyone needs any more info I should be able to get it, but remember I
can't actually boot into 2.6.0 only the 2.2.x kernel.
-- 
Yours sincerely,
Andrew


-------------------------------------------------
This mail sent through NZOL Webmail: http://webmail.nzol.net/

