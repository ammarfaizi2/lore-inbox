Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129964AbRB0Xn3>; Tue, 27 Feb 2001 18:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129958AbRB0XnU>; Tue, 27 Feb 2001 18:43:20 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:29452 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S129740AbRB0XnD>; Tue, 27 Feb 2001 18:43:03 -0500
Date: Tue, 27 Feb 2001 16:42:59 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Via-rhine is not finding its interrupts under 2.2.19pre14
Message-ID: <20010227164259.B23026@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After I booted 2.2.19pre14 on a system with two via-rhine cards I see the
following:

via-rhine.c:v1.08b-LK1.0.0 12/14/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
eth0: VIA VT3043 Rhine at 0x9400, 00:50:ba:c1:64:d9, IRQ 0.
eth0: MII PHY found at address 8, status 0x7809 advertising 05e1 Link 0000.
eth1: VIA VT3043 Rhine at 0x8800, 00:50:ba:ab:60:64, IRQ 0.
eth1: MII PHY found at address 8, status 0x782d advertising 05e1 Link 0000.

and a network does not work due to these IRQ 0, I guess.

In contrast when I will boot on the same hardware 2.4.2-ac5 then I get,
among other things,

via-rhine.c:v1.08b-LK1.1.7  8/9/2000  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Enabling device 00:09.0 (0094 -> 0097)
PCI: Found IRQ 9 for device 00:09.0
PCI: The same IRQ used for device 00:04.2
PCI: The same IRQ used for device 00:04.3
PCI: The same IRQ used for device 00:0d.0
eth0: VIA VT3043 Rhine at 0x9400, 00:50:ba:c1:64:d9, IRQ 9.
eth0: MII PHY found at address 8, status 0x7809 advertising 05e1 Link 0000.
PCI: Enabling device 00:0c.0 (0094 -> 0097)
PCI: Found IRQ 11 for device 00:0c.0
eth1: VIA VT3043 Rhine at 0x8800, 00:50:ba:ab:60:64, IRQ 11.
eth1: MII PHY found at address 8, status 0x782d advertising 05e1 Link 0000.


Devices in question can be seen here:

-[00]-+-00.0  VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
      +-01.0-[01]----00.0  ATI Technologies Inc Rage 128 RF
      +-04.0  VIA Technologies, Inc. VT82C686 [Apollo Super South]
      +-04.1  VIA Technologies, Inc. Bus Master IDE
      +-04.2  VIA Technologies, Inc. UHCI USB
      +-04.3  VIA Technologies, Inc. UHCI USB
      +-04.4  VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
      +-09.0  VIA Technologies, Inc. VT86C100A [Rhine 10/100]
      +-0a.0  Symbios Logic Inc. (formerly NCR) 53c810
      +-0c.0  VIA Technologies, Inc. VT86C100A [Rhine 10/100]
      +-0d.0  Ensoniq CT5880 [AudioPCI]
      \-11.0  Promise Technology, Inc. 20265


I do not have turned on a support for USB or audio in either of these
two kernels.  They are actually configured pretty similar (within a
reason :-).  But network is operational with 2.4.2-ac5.  Hm...

Even with these IRQ conflicts for eth0 one would think that eth1 should
get its interrupt.  It does not conflict with anything.  Forgotten
'pci_enable()' somewhere?

  Michal

