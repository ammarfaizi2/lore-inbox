Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbVIPENg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbVIPENg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 00:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbVIPENg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 00:13:36 -0400
Received: from SOUTH-STATION-ANNEX.MIT.EDU ([18.72.1.2]:47304 "EHLO
	south-station-annex.mit.edu") by vger.kernel.org with ESMTP
	id S1161051AbVIPENg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 00:13:36 -0400
Subject: Re: pci detection on alpha fails to assign irq to on-board usb
	device
From: Ilia Mirkin <imirkin@MIT.EDU>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050916025416.GA31585@kroah.com>
References: <1126830006.7002.12.camel@localhost>
	 <20050916025416.GA31585@kroah.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 00:13:25 -0400
Message-Id: <1126844006.10966.68.camel@INFERNAL.mit.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.149
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-15 at 19:54 -0700, Greg KH wrote:
> On Thu, Sep 15, 2005 at 08:20:06PM -0400, Ilia Mirkin wrote:
> > This is on a Compaq Professional Workstation XP1000, which is a Tsunami
> > system, compiled with the DP264 system setting in the kernel:
> > 
> > ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
> > ohci_hcd 0000:00:07.3: Found HC with no IRQ.  Check BIOS/PCI
> > 0000:00:07.3 setup!
> > ohci_hcd 0000:00:07.3: init 0000:00:07.3 fail, -19
> > 
> > lspci -vvvx -s 00:07.3
> > 0000:00:07.3 USB Controller: Contaq Microsystems 82c693 (prog-if 10
> > [OHCI])
> >         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR-
> >         Interrupt: pin A routed to IRQ 0
> >         Region 0: Memory at 0000000009018000 (32-bit, non-prefetchable)
> > 00: 80 10 93 c6 03 00 80 02 00 10 03 0c 08 f8 80 00
> > 10: 00 80 01 09 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00
> > 
> > There was a fix that went into the miata system type a while back:
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0110.3/0849.html
> > 
> > I am using kernel 2.6.12.5, though the same problem occured with
> > 2.6.11.8.
> 
> Can you try 2.6.13.1 or 2.6.14-rc1?

Tried with 2.6.13.1 -- same thing. If you think that there are relevant
patches that went into -rc1 that are not in .1, I could try that out
too. A cursory look does not suggest any though.

I'll add that this Contaq chip is weird... 

0000:00:07.0 ISA bridge: Contaq Microsystems 82c693
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:07.1 IDE interface: Contaq Microsystems 82c693 (prog-if 80
[Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 01f0
        Region 1: I/O ports at 03f4 [size=4]
        Region 4: I/O ports at 8000 [size=16]

0000:00:07.2 IDE interface: Contaq Microsystems 82c693 (prog-if 00 [])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 0
        Region 0: I/O ports at 0170
        Region 1: I/O ports at 0374 [size=4]
        Region 4: Memory at 0000000009000000 (32-bit, non-prefetchable)
[disabled] [size=64K]

0000:00:07.3 USB Controller: Contaq Microsystems 82c693 (prog-if 10
[OHCI])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 0000000009018000 (32-bit, non-prefetchable)

So this whole chip is being routed to IRQ 0, but the IDE stuff works
(admittedly only the first one has anything plugged in, so for all I
know the second one might not.)

Also, in enabling the IDE controller:
PCI: Enabling device: (0000:00:07.2), cmd 7

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 (so it gets some other irq! amazing. shows how much i know about irq
routing)

I don't see any reference to 07.3 being enabled (maybe it doesn't print
anything if it fails to 'enable'?)

cat /proc/interrupts 
  1:         10          XT-PIC   i8042
  2:          0          XT-PIC   cascade
  8:     670785             RTC  +timer
 14:         13          XT-PIC  +ide0
 28:          1           DP264  +bttv0
 45:       2040           DP264   eth0
 47:      18994           DP264   qla1280
ERR:          0

  -Ilia

