Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTAXR3e>; Fri, 24 Jan 2003 12:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbTAXR3e>; Fri, 24 Jan 2003 12:29:34 -0500
Received: from continuum.cm.nu ([216.113.193.225]:43964 "EHLO continuum.cm.nu")
	by vger.kernel.org with ESMTP id <S262469AbTAXR3d>;
	Fri, 24 Jan 2003 12:29:33 -0500
Date: Fri, 24 Jan 2003 09:38:44 -0800
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: PCI IRQs and IO-APIC
Message-ID: <20030124173844.GA18413@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-No-Archive: yes
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using a 2.4.20 Linux kernel with an Intel SDS2
motherboard.  By default, USB doesn't function as is shown
by this /proc/interrupts

CPU0       CPU1
  0:     146457     142403    IO-APIC-edge  timer
  1:          1          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:        616        690    IO-APIC-edge  serial
  7:          0          0    IO-APIC-edge  parport0
 14:          0          2    IO-APIC-edge  ide0
 16:      27394      27504   IO-APIC-level  aic7xxx
 17:          9          7   IO-APIC-level  aic7xxx
 18:      10562      10579   IO-APIC-level  eth0
 19:       6871       6786   IO-APIC-level  eth1
 22:     446759     445440   IO-APIC-level  ide2, ide3
 23:       8089       7770   IO-APIC-level  mxser
 24:        229        213   IO-APIC-level  EMU10K1
 25:          9          7   IO-APIC-level  aic7xxx
 28:         10          6   IO-APIC-level  aic7xxx
 33:          0          0            none  usb-ohci
NMI:          0          0
LOC:     288724     288714
ERR:          0
MIS:          0

Booting with the noapic option does fix this and only gives
16 IRQs so many devices wind up sharing.  The other thing I
tried was the ACPI patch at www.sf.net/projects/acpi and
that also fixed the problem with the APIC enabled.

CPU0       CPU1
  0:    3142365    3090327    IO-APIC-edge  timer
  1:          1          1    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:        221        216    IO-APIC-edge  serial
  7:         21         10    IO-APIC-edge  parport0
  9:          2          4   IO-APIC-level  acpi
 10:          2          0    IO-APIC-edge  usb-ohci
 14:          2          0    IO-APIC-edge  ide0
 16:     152211     153488   IO-APIC-level  aic7xxx
 17:          9          7   IO-APIC-level  aic7xxx
 18:     271568     270316   IO-APIC-level  eth0
 19:       8492       8638   IO-APIC-level  eth1
 22:      26577      25716   IO-APIC-level  ide2, ide3
 23:     213562     200629   IO-APIC-level  mxser
 24:      12651      12583   IO-APIC-level  EMU10K1
 25:         11          5   IO-APIC-level  aic7xxx
 28:          9          7   IO-APIC-level  aic7xxx
NMI:          0          0
LOC:    6231968    6231965
ERR:          0
MIS:          0

Regards,
Shane
