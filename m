Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030598AbVIPFLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030598AbVIPFLS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 01:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbVIPFLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 01:11:18 -0400
Received: from SOUTH-STATION-ANNEX.MIT.EDU ([18.72.1.2]:63735 "EHLO
	south-station-annex.mit.edu") by vger.kernel.org with ESMTP
	id S1030598AbVIPFLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 01:11:17 -0400
Subject: Re: pci detection on alpha fails to assign irq to on-board usb
	device
From: Ilia Mirkin <imirkin@MIT.EDU>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050916025416.GA31585@kroah.com>
References: <1126830006.7002.12.camel@localhost>
	 <20050916025416.GA31585@kroah.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 01:11:04 -0400
Message-Id: <1126847464.10966.72.camel@INFERNAL.mit.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.212
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

To add a little more to my last e-mail, here is kernel output with pci
debug enabled:

PCI: Scanning bus 0000:00
PCI: Found 0000:00:07.0 [1080/c693] 000601 00
PCI: Calling quirk fffffc00006e0840 for 0000:00:07.0
PCI: Calling quirk fffffc00004cf3b0 for 0000:00:07.0
PCI: Calling quirk fffffc00004cfa80 for 0000:00:07.0
PCI: Found 0000:00:07.1 [1080/c693] 000101 00
PCI: Calling quirk fffffc00006e0840 for 0000:00:07.1
PCI: Calling quirk fffffc00004cf3b0 for 0000:00:07.1
PCI: Calling quirk fffffc00004cfa80 for 0000:00:07.1
PCI: Found 0000:00:07.2 [1080/c693] 000101 00
PCI: Calling quirk fffffc00006e0840 for 0000:00:07.2
PCI: Calling quirk fffffc00004cf3b0 for 0000:00:07.2
PCI: Calling quirk fffffc00004cfa80 for 0000:00:07.2
PCI: Found 0000:00:07.3 [1080/c693] 000c03 00
PCI: Calling quirk fffffc00006e0840 for 0000:00:07.3
PCI: Calling quirk fffffc00004cf3b0 for 0000:00:07.3
PCI: Calling quirk fffffc00004cfa80 for 0000:00:07.3
PCI: Found 0000:00:0c.0 [1011/000d] 000300 00
PCI: Calling quirk fffffc00004cf3b0 for 0000:00:0c.0
PCI: Calling quirk fffffc00004cfa80 for 0000:00:0c.0
PCI: Fixups for bus 0000:00
PCI: Bus scan for 0000:00 returning with max=00
PCI: Scanning bus 0001:01
PCI: Found 0001:01:03.0 [1011/0019] 000200 00
PCI: Calling quirk fffffc00004cf3b0 for 0001:01:03.0
PCI: Calling quirk fffffc00004cfa80 for 0001:01:03.0
PCI: Found 0001:01:06.0 [1077/1020] 000100 00
PCI: Calling quirk fffffc00004cf3b0 for 0001:01:06.0
PCI: Calling quirk fffffc00004cfa80 for 0001:01:06.0
PCI: Found 0001:01:08.0 [1011/0024] 000604 01
PCI: Calling quirk fffffc00004cf3b0 for 0001:01:08.0
PCI: Calling quirk fffffc00004cfa80 for 0001:01:08.0
PCI: Fixups for bus 0001:01
PCI: Scanning behind PCI bridge 0001:01:08.0, config 020200, pass 0
PCI: Scanning behind PCI bridge 0001:01:08.0, config 020200, pass 1
PCI: Scanning bus 0001:02
PCI: Found 0001:02:09.0 [109e/036e] 000400 00
PCI: Calling quirk fffffc00004cf3b0 for 0001:02:09.0
PCI: Calling quirk fffffc00004cfa80 for 0001:02:09.0
PCI: Found 0001:02:09.1 [109e/0878] 000480 00
PCI: Calling quirk fffffc00004cf3b0 for 0001:02:09.1
PCI: Calling quirk fffffc00004cfa80 for 0001:02:09.1
PCI: Fixups for bus 0001:02
PCI: Bus scan for 0001:02 returning with max=02
PCI: Bus scan for 0001:01 returning with max=02
  got res [a000000:bffffff] bus [a000000:bffffff] flags 1208 for BAR 0
of 0000:00:0c.0
PCI: moved device 0000:00:0c.0 resource 0 (1208) to a000000
  got res [9000000:900ffff] bus [9000000:900ffff] flags 200 for BAR 4 of
0000:00:07.2
PCI: moved device 0000:00:07.2 resource 4 (200) to 9000000
  got res [9010000:9017fff] bus [9010000:9017fff] flags 7200 for BAR 6
of 0000:00:0c.0
  got res [9018000:9018fff] bus [9018000:9018fff] flags 200 for BAR 0 of
0000:00:07.3
PCI: moved device 0000:00:07.3 resource 0 (200) to 9018000
  got res [8000:800f] bus [8000:800f] flags 101 for BAR 4 of
0000:00:07.1
PCI: moved device 0000:00:07.1 resource 4 (101) to 8000
  got res [209100000:20913ffff] bus [9100000:913ffff] flags 7200 for BAR
6 of 0001:01:03.0
  got res [209140000:20914ffff] bus [9140000:914ffff] flags 7200 for BAR
6 of 0001:01:06.0
  got res [209150000:209150fff] bus [9150000:9150fff] flags 200 for BAR
1 of 0001:01:06.0
PCI: moved device 0001:01:06.0 resource 1 (200) to 9150000
  got res [209151000:2091513ff] bus [9151000:91513ff] flags 200 for BAR
1 of 0001:01:03.0
PCI: moved device 0001:01:03.0 resource 1 (200) to 9151000
  got res [200008000:2000080ff] bus [8000:80ff] flags 101 for BAR 0 of
0001:01:06.0
PCI: moved device 0001:01:06.0 resource 0 (101) to 8000
  got res [200008400:20000847f] bus [8400:847f] flags 101 for BAR 0 of
0001:01:03.0
PCI: moved device 0001:01:03.0 resource 0 (101) to 8400
  got res [209000000:209000fff] bus [9000000:9000fff] flags 1208 for BAR
0 of 0001:02:09.0
PCI: moved device 0001:02:09.0 resource 0 (1208) to 9000000
  got res [209001000:209001fff] bus [9001000:9001fff] flags 1208 for BAR
0 of 0001:02:09.1
PCI: moved device 0001:02:09.1 resource 0 (1208) to 9001000
PCI: Bridge: 0001:01:08.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: 09000000-090fffff
PCI: fixup irq: (0000:00:07.0) got 0
PCI: fixup irq: (0000:00:07.1) got 0
PCI: fixup irq: (0000:00:07.2) got 0
PCI: fixup irq: (0000:00:07.3) got 0
PCI: fixup irq: (0000:00:0c.0) got 36
PCI: fixup irq: (0001:01:03.0) got 45
PCI: fixup irq: (0001:01:06.0) got 47
PCI: fixup irq: (0001:01:08.0) got 0
PCI: fixup irq: (0001:02:09.0) got 28
PCI: fixup irq: (0001:02:09.1) got 28
SMC37c669 Super I/O Controller found @ 0x3f0
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
srm_env: version 0.0.5 loaded successfully
NTFS driver 2.1.23 [Flags: R/W].
Initializing Cryptographic API
PCI: Calling quirk fffffc00006e0900 for 0000:00:07.0
PCI: Calling quirk fffffc00004cf230 for 0000:00:07.0
PCI: Calling quirk fffffc00006e0900 for 0000:00:07.1
PCI: Calling quirk fffffc00004cf230 for 0000:00:07.1
PCI: Calling quirk fffffc00006e0900 for 0000:00:07.2
PCI: Calling quirk fffffc00004cf230 for 0000:00:07.2
PCI: Calling quirk fffffc00006e0900 for 0000:00:07.3
PCI: Calling quirk fffffc00004cf230 for 0000:00:07.3
PCI: Calling quirk fffffc00006e0900 for 0000:00:0c.0
PCI: Calling quirk fffffc00004cf230 for 0000:00:0c.0
PCI: Calling quirk fffffc00006e0900 for 0001:01:03.0
PCI: Calling quirk fffffc00004cf230 for 0001:01:03.0
PCI: Calling quirk fffffc00006e0900 for 0001:01:06.0
PCI: Calling quirk fffffc00004cf230 for 0001:01:06.0
PCI: Calling quirk fffffc00006e0900 for 0001:01:08.0
PCI: Calling quirk fffffc00004cf230 for 0001:01:08.0
PCI: Calling quirk fffffc00006e0900 for 0001:02:09.0
PCI: Calling quirk fffffc00004cf230 for 0001:02:09.0
PCI: Calling quirk fffffc00006e0900 for 0001:02:09.1
PCI: Calling quirk fffffc00004cf230 for 0001:02:09.1

  -Ilia


