Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132843AbRDIUed>; Mon, 9 Apr 2001 16:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132844AbRDIUeO>; Mon, 9 Apr 2001 16:34:14 -0400
Received: from [199.217.175.51] ([199.217.175.51]:51725 "EHLO
	core.federated.com") by vger.kernel.org with ESMTP
	id <S132843AbRDIUeI>; Mon, 9 Apr 2001 16:34:08 -0400
From: Jim Studt <jim@federated.com>
Message-Id: <200104092033.PAA20057@core.federated.com>
Subject: Re: aic7xxx and 2.4.3 failures
In-Reply-To: <E14mi85-0002pu-00@the-village.bc.nu> from Alan Cox at "Apr 9, 2001
 09:19:13 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 9 Apr 2001 15:33:47 -0500 (CDT)
CC: Jim Studt <jim@federated.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > A typical startup with 6.1.9 proceeds like this...  (6.1.10 hangs silently
> > after emitting the scsi0 and scsi1 adapter summaries, maybe it is
> > going through the same gyrations silently.) 
> > 
> 

Alan Cox directs...
> Try saying N to the AIC7xxx driver and Y to AIC7XXX_OLD and see if that works.
> This is important both because it might solve your problem for now but also
> because if the old driver works we can be fairly sure the bug is in the 
> new adaptec driver and not elsewhere and triggered on it

Using AIC7XXX_OLD does not work either.  Different output....

SCSI subsystem driver Revision: 1.00
PCI: Assigned IRQ 11 for device 00:0c.0
PCI: The same IRQ used for device 00:0c.1
PCI: Found IRQ 11 for device 00:0c.1
PCI: The same IRQ used for device 00:0c.0
(scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 00 
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
...


Since we are looking elsewhere now... I have tried PCI access mode
BIOS and Direct with no improvement.  

There is an unrecognized PCI bridge resource in the boot messages...

CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU serial number disabled.
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX [8086/7110] at 00:12.0

# lspci
00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge
00:0c.0 SCSI storage controller: Adaptec 7896
00:0c.1 SCSI storage controller: Adaptec 7896
00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
00:12.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:12.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:12.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23)
01:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06)

I will go back and try 2.4.0 and 2.4.3-ac3 and see where that gets me.

-- 
                                     Jim Studt, President
                                     The Federated Software Group, Inc.
