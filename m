Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUBKB1f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 20:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbUBKB1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 20:27:34 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:22430 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S263244AbUBKB1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 20:27:14 -0500
Date: Tue, 10 Feb 2004 18:29:12 -0700
From: Jesse Allen <the3dfxdude@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: NForce2 + linux 2.6.3-rc2 + acpi,apic patches
Message-ID: <20040211012912.GA948@tesore.local>
Mail-Followup-To: Jesse Allen <the3dfxdude@hotmail.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have noticed two patches in Andrew Morton's tree, 2.6.3-rc1-mm1, that may be 
helpful for me and other nforce 2 users.  The two patches are
nforce-irq-setup-fix.patch
8259-timer-ack-fix.patch

I have compiled 2.6.3-rc2 with those two patches included.  Here is 
/proc/interrupts after reboot:
  0:    2347129  local-APIC-edge  timer
  1:       6604    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:       4458    IO-APIC-edge  serial
  7:          0    IO-APIC-edge  parport0
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:       4456    IO-APIC-edge  ide0
 15:         17    IO-APIC-edge  ide1
 20:     239364   IO-APIC-level  eth0, ohci_hcd
 21:          0   IO-APIC-level  ehci_hcd, NVidia nForce2
 22:          0   IO-APIC-level  ohci_hcd


Timer is now local-APIC-edge instead of XT-PIC.  Seems to be better now.  I've 
checked to see if the problem with large clock time gain returned.  So far, it 
seems to be perfectly synced with my watch.

I don't know if local-APIC or IO-APIC are really any different with the timer.
If there is something I should know about the difference, someone please let
me know =)

Also, here's a snippet from dmesg:
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ...  failed.
...trying to set up timer as Virtual Wire IRQ... works.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1912.0861 MHz.
..... host bus clock speed is 332.0671 MHz.


Thanks Ross and Maciej for the patches!

Jesse
