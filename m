Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbUJZWiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbUJZWiw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 18:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUJZWiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 18:38:52 -0400
Received: from ping.ovh.net ([213.186.33.13]:50129 "EHLO ping.ovh.net")
	by vger.kernel.org with ESMTP id S261509AbUJZWit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 18:38:49 -0400
Date: Wed, 27 Oct 2004 00:38:47 +0200
From: Miro <totoro@ovh.net>
To: linux-kernel@vger.kernel.org
Subject: Problem in 2.4.28-rc1 with e1000 and io-apic
Message-ID: <20041026223847.GB7198@ping.ovh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've got problems with a bi-xeon based on Intel E7320 chipset
with 2.4.28-rc1. When I boot the smp kernel, IO-APIC works fine
for all devices except for both e1000 lan.

e1000 driver reports on dmesg "watchdog tx errors".

I suppose it is an io-apic problem:
# cat /proc/interrupts
         CPU0       CPU1       CPU2       CPU3
0:   38000646          0          0          0    IO-APIC-edge  timer
1:          2          0          0          0    IO-APIC-edge  keyboard
2:          0          0          0          0          XT-PIC  cascade
4:         16          0          0          0    IO-APIC-edge  serial
8:          1          0          0          0    IO-APIC-edge  rtc
71:         0          0          0          0            none  eth1
72:         0          0          0          0            none  eth0
[...]						        ^^^^^^

The system can't handle the lan interrupts. It should be the problem.

Enable or disable NAPI option for e1000 doesn't resolve the problem.

But, when I boot the kernel with "noapic" option, both lans work fine:
# cat /proc/interrupts
            CPU0       CPU1       CPU2       CPU3
   0:    1090980          0          0          0          XT-PIC  timer
   1:        235          0          0          0          XT-PIC  keyboard
   2:          0          0          0          0          XT-PIC  cascade
   4:         16          0          0          0          XT-PIC  serial
   8:          1          0          0          0          XT-PIC  rtc
   9:      15629          0          0          0          XT-PIC  eth0, eth1
[...]

Maybe, there are devices that are not supported on this kernel and that
create this problem:
# lspci
00:00.0 Host bridge: Intel Corp. E7320 Memory Controller Hub (rev 0a)
00:02.0 PCI bridge: Intel Corp. E7525/E7520/E7320 PCI Express Port A (rev 0a)
00:03.0 PCI bridge: Intel Corp. E7525/E7520/E7320 PCI Express Port A1 (rev 0a)
00:1c.0 PCI bridge: Intel Corp. 6300ESB 64-bit PCI-X Bridge (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 0a)
00:1f.0 ISA bridge: Intel Corp. 6300ESB LPC Interface Controller (rev 02)
00:1f.1 IDE interface: Intel Corp. 6300ESB PATA Storage Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 6300ESB SMBus Controller (rev 02)
01:00.0 PCI bridge: Intel Corp. 6700PXH PCI Express-to-PCI Bridge A (rev 09)
01:00.2 PCI bridge: Intel Corp. 6700PXH PCI Express-to-PCI Bridge B (rev 09)
03:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev c1)
05:01.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
05:02.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
06:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)


Is there a way to force type of interrupts for both e1000 lan on "IO-APIC-level"?
or maybe to find the bug?

Thanks in advance.
Miro
