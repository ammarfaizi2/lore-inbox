Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264702AbUDWDVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264702AbUDWDVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 23:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264711AbUDWDVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 23:21:14 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:40408 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S264702AbUDWDVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 23:21:11 -0400
Date: Thu, 22 Apr 2004 23:21:09 -0400
From: Noel Maddy <noel@zhtwn.com>
To: linux-kernel@vger.kernel.org
Subject: IRQ21 flood on nForce2
Message-ID: <20040423032109.GA16569@uglybox.localnet>
Reply-To: Noel Maddy <noel@zhtwn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy,

I'm getting over 100k interrupts/second on IRQ21 on an nForce2
motherboard any time I have a driver using that interrupt.

Both ehci_hcd and intel_8x0 use that interrupt. When either or both
modules are loaded, it looks like below. With no modules loaded, or with
pci=noacpi, behavior is fine.

I've filed more detail at buzilla, including dmidecode and acpidmp
output:

http://bugzilla.kernel.org/show_bug.cgi?id=2574

Seems like it'd be something with the ACPI/interrupt configuration, yes?

Noel

-------------

cat /proc/interrupts
           CPU0       
  0:     706031    IO-APIC-edge  timer
  1:          8    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  7:          0    IO-APIC-edge  parport0
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:         50    IO-APIC-edge  i8042
 14:       4742    IO-APIC-edge  ide0
 18:          0   IO-APIC-level  EMU10K1
 19:          3   IO-APIC-level  Bt87x audio, bttv0
 20:      76147   IO-APIC-level  ohci_hcd, eth0
 21:  104487700   IO-APIC-level  ehci_hcd, NVidia nForce2
 22:          0   IO-APIC-level  ohci_hcd
NMI:          0 
LOC:     705958 
ERR:          0
MIS:          0

vmstat 1 10
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0      0 396560   5804  51848    0    0    77    25 27446    46 95  1  3  1
 1  0      0 396560   5804  51848    0    0     0     0 117260     9 100  0  0  0
 1  0      0 396560   5804  51848    0    0     0     0 117333     8 100  0  0  0
 1  0      0 396560   5804  51848    0    0     0     0 117333     6 100  0  0  0
 1  0      0 396560   5804  51848    0    0     0     0 117335     8 100  0  0  0
 1  0      0 396560   5812  51848    0    0     0    60 117334    12 100  0  0  0
 1  0      0 396568   5812  51848    0    0     0     0 117335     8 100  0  0  0
 1  0      0 396568   5812  51848    0    0     0     0 117336    10 99  1  0  0
 1  0      0 396568   5812  51848    0    0     0     0 117343     6 100  0  0  0
 1  0      0 396568   5812  51848    0    0     0     0 117334     6 100  0  0  0

cat /proc/interrupts
           CPU0       
  0:     715191    IO-APIC-edge  timer
  1:          8    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  7:          0    IO-APIC-edge  parport0
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:         50    IO-APIC-edge  i8042
 14:       4744    IO-APIC-edge  ide0
 18:          0   IO-APIC-level  EMU10K1
 19:          3   IO-APIC-level  Bt87x audio, bttv0
 20:      77101   IO-APIC-level  ohci_hcd, eth0
 21:  105550345   IO-APIC-level  ehci_hcd, NVidia nForce2
 22:          0   IO-APIC-level  ohci_hcd
NMI:          0 
LOC:     715119 
ERR:          0
MIS:          0


-- 
In this American stoicism, all phenomena of business life however
crooked or foolish work to the prosperity of the universe under a
benign commercial Providence who is part the God of the Bible, and part
pure money.
			    -- James Buchan, Guardian Unltd, 2002-06-28
+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+--+
Noel Maddy <noel@zhtwn.com>
