Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264619AbTIDEo7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 00:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264645AbTIDEo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 00:44:59 -0400
Received: from fmr09.intel.com ([192.52.57.35]:40418 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264619AbTIDEoy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 00:44:54 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: ACPI in 2.4.22 breaking several systems
Date: Thu, 4 Sep 2003 00:44:49 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCFC@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ACPI in 2.4.22 breaking several systems
Thread-Index: AcNtxeLlQoZgOxxSTeOVXx+rmjRZUgE11ghg
From: "Brown, Len" <len.brown@intel.com>
To: "Santiago Garcia Mantinan" <manty@manty.net>,
       <linux-kernel@vger.kernel.org>
Cc: <acpi-devel@sourceforge.net>
X-OriginalArrivalTime: 04 Sep 2003 04:44:51.0117 (UTC) FILETIME=[46E33DD0:01C3729F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Santiago,
Thanks for the feedback.

The DMI cutoff for ACPI was set (somewhat arbitrarily) for 1/1/2001.
If the system doesn't have DMI support, then DMI can't be used to
determine the age of the BIOS and so ACPI is not disabled.  That is why
your very old system has ACPI enabled by default.

2.6.0 is actually slightly behind 2.4.22 in ACPI at the moment -- though
I don't recall off-hand any major fixes missing so I'm surprised that
you see different behaviour; we'll be checking the fix list shortly to
update 2.6...

If acpi=off or pci=noacpi is required to make interrupts work, then it
is a bug.  The best way to help is to file bugzilla's for the failures
you see, and there we'll take them one by one.

Thanks,
-Len
--------
Please file a bug at http://bugzilla.kernel.org/
Category: Power Management
Componenet: ACPI

Please attach the output from dmidecode, available in /usr/sbin/, or
here: 
http://www.nongnu.org/dmidecode/

Please attach the output from acpidmp, available in /usr/sbin/, or in
here
http://www.intel.com/technology/iapc/acpi/downloads/pmtools-20010730.tar
.gz

Please attach /proc/interrupts and the dmesg output showing the failure,
if possible.


> -----Original Message-----
> From: Santiago Garcia Mantinan [mailto:manty@manty.net] 
> Sent: Thursday, August 28, 2003 6:52 PM
> To: linux-kernel@vger.kernel.org
> Cc: acpi-devel@sourceforge.net
> Subject: ACPI in 2.4.22 breaking several systems
> 
> 
> Hi!
> 
> I don't know if this could be expected, for what I see most 
> of the problems
> are caused by the changes in the interrupt routing in rc3 or 
> rc4, on my
> first upgrades out of 5 different machines 4 had this kind of 
> problem, for
> all this systems, the pci=noacpi recipe solved the problem, 
> hopefully this
> is sugested on the kernel messages, however I think that 
> maybe a warning in
> the ACPI kernel doc or config should be in place.
> 
> What seems really weird to me is that at least on some of 
> this systems, the
> irq routing problem doesn't exist on 2.6.0test4 and it seems 
> to be using the
> same ACPI version :-???
> 
> The other failures I found was on old Pentium MMX with Intel 
> 430TX chipset
> based motherboards. The machines were working perfectly with 
> ACPI as of
> 2.4.21, powering off correctly as power button was pressed, ... when
> switching to 2.4.22 the first thing I got was a hang when 
> loading the sound
> card drivers, irq routing problem that was solved using 
> pci=noacpi, then I
> tried powering off using halt and it worked, but then I tried 
> powering off
> pushing the power button and I got hang with an error that 
> started like
> this:
> 
> process swapper
> Unable to handle kernel NULL pointer dereference at virtual 
> address 00000008
>  printing eip:
> c016a52b
> 
> I have just tested 2.6.0test4 on this machine and I got the 
> same problem as
> with 2.4.22.
> 
> This is the dmesg|grep -i acpi for 2.4.21 on that machine:
> 
>  BIOS-e820: 0000000003ffd000 - 0000000003ffd800 (ACPI NVS)
>  BIOS-e820: 0000000003ffd800 - 0000000003fff400 (ACPI data)
> ACPI: Core Subsystem version [20011018]
>     ACPI-0349: *** Warning: Zero GPEs are defined in the FADT
> ACPI: Subsystem enabled
> ACPI: System firmware supports S0 S1 S5
> ACPI: Power Button (FF) found
> 
> And this is for 2.4.22:
> 
>  BIOS-e820: 0000000003ffd000 - 0000000003ffd800 (ACPI NVS)
>  BIOS-e820: 0000000003ffd800 - 0000000003fff400 (ACPI data)
> ACPI: have wakeup address 0xc0001000
> ACPI: RSDP (v000                                           ) 
> @ 0x000f6880
> ACPI: RSDT (v001                 0x00000000  0x00000000) @ 0x03ffd800
> ACPI: FADT (v001                 0x00000000  0x00000000) @ 0x03ffd840
> ACPI: DSDT (v001  AWARD AWRDACPI 0x00001000 MSFT 0x01000000) 
> @ 0x00000000
> Kernel command line: auto BOOT_IMAGE=Linux ro root=302 pci=noacpi
> ACPI: Subsystem revision 20030813
>     ACPI-0888: *** Info: There are no GPE blocks defined in the FADT
> ACPI: Interpreter enabled
> ACPI: Using PIC for interrupt routing
> ACPI: System [ACPI] (supports S0 S1 S4bios S5)
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
> ACPI: PCI Root Bridge [PCI0] (00:00)
> ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
> ACPI: Power Button (FF) [PWRF]
> 
> One weird thing was that this system was not detected as an 
> old bios and
> thus the ACPI code was not turned off, while the only machine 
> that I have
> tried on which new ACPI works perfectly, a more modern PII 
> machine, had the
> ACPI set to off because its BIOS was too old.
> 
> Well, I suppose this won't tell much about the problem, so 
> I'm offering for
> gathering the info that may be needed to fix this, just tell 
> me what to do.
> 
> Regards...
> -- 
> Manty/BestiaTester -> http://manty.net
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
