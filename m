Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTJ0PwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTJ0PwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:52:06 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:55979 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263076AbTJ0Pvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:51:42 -0500
Date: Mon, 27 Oct 2003 07:51:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: spam@agurk.com
Subject: [Bug 1431] New: Crash accessing /proc/ide/*/identify on	promise 20265 (fasttrak bios not loaded) 
Message-ID: <605440000.1067269890@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1431

           Summary: Crash accessing /proc/ide/*/identify on promise 20265
                    (fasttrak bios not loaded)
    Kernel Version: 2.6.0-test9
            Status: NEW
          Severity: high
             Owner: bzolnier@elka.pw.edu.pl
         Submitter: spam@agurk.com


Distribution:
Redhat 9 + upgrade fixes for kernel 2.6


Hardware Environment:
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC 
Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16)
00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
00:0b.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
00:11.0 RAID bus controller: Promise Technology, Inc. 20265 (rev 02)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01)

The promise "raid" controller is my 2nd ide controller on the motherboard and since it is not very good 
for raid I use linux software raid instead. Problem occur when the fasttrak100 "speed" bios (the promise 
bios) is not loaded during startup (before grub boot).


Software Environment:
Redhat 9 + upgrade fixes for kernel 2.6

Problem Description:
The command 'cat /proc/ide/hde/identify' crashes the computer hard (no keyboard/net response).
This only happens when the fastrak100 bios (the promise bios) is not loaded during startup.

This will crash a normal redhat configurating which uses the devlabel script which use the command to 
identify the disks.

Steps to reproduce:
Compile kernel 2.6-test9 with pdc20xxx_old.
Boot with loading of the promise raid bios disabled
With a normal redhat config your computer will hang during init
cat /proc/ide/hde/identify
where hde is one of the disks controlled by the promise controller

