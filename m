Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263385AbTHWU6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 16:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbTHWU6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 16:58:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7178 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263754AbTHWU6M convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.redhat.com>);
	Sat, 23 Aug 2003 16:58:12 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: 2.6.0-test4 - lost ACPI
Date: Sat, 23 Aug 2003 16:58:00 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE009FCC9@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.0-test4 - lost ACPI
Thread-Index: AcNpojzy1DcCuADUQBOy9ENOio/x8gAFYNVQ
From: "Brown, Len" <len.brown@intel.com>
To: "Tomasz Torcz" <zdzichu@irc.pl>
Cc: "LKML" <linux-kernel@vger.redhat.com>, <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 23 Aug 2003 20:58:01.0881 (UTC) FILETIME=[3D89C090:01C369B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

manually modifying ACPI_BLACKLIST_CUTOFF_YEAR and using acpi=force on
the cmdline should have the same effect.

pci=noacpi is also an option.  If it works, then it means you got burnt
by ACPI's PCI interrupt code.  We've had trouble with Award/VIA in this
area recently, so it wouldn't be surprising to have trouble with a
3-year old Award/VIA BIOS.  The puzzling thing is why ACPI enabled
worked for you before and doesn't work now.

I'd be interested in looking over a copy of your /proc/acpi/dsdt, or
even better, the output from acpidmp, which you can get from the pmtools
package here:
http://developer.intel.com/technology/iapc/acpi/downloads/pmtools-200107
30.tar.gz


Thanks,
-Len

> -----Original Message-----
> From: Tomasz Torcz [mailto:zdzichu@irc.pl] 
> Sent: Saturday, August 23, 2003 12:59 PM
> To: Brown, Len
> Cc: LKML
> Subject: Re: 2.6.0-test4 - lost ACPI
> 
> 
> On Sat, Aug 23, 2003 at 12:47:04PM -0400, Brown, Len wrote:
>  
> > I didn't see which VIA 693 MB you've got, but it could be that a
> > BIOS upgrade would move it from 09/13/00 to something past 
> 1/1/2001 --
> > the (yes, arbitrary) cutoff for enabling ACPI by default.
> 
> It's Matsonic 7132A (http://www.matsonic.com/ms7132a.htm ; 
> http://206.135.80.155/manual/ms7132a.pdf).
> Pretty nice board. Latest bios for it is dated 09/13/00 and
> there is no upgrade.
>  
> > Or you could add "acpi=force" to your command line, as 
> suggested in the
> > dmesg output.
> 
> Tried this with strange results - kernel halted during boot,
> after displaying:
> 
> [... dmesg ...]
> PM: Adding info for ide:1.0
> hda: max request size: 1024KiB
> hda: 156301488 sectors (80026 MB) w/2048KiB Cache, 
> CHS=16383/255/63, UDMA(66)
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
> hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> mice: PS/2 mouse device common for all mice
> 
> HALT. No sysrq, no shift+pgup, no response for power button.
> 
> Dmesg _without_ acpi=force: 
> 
> hdc: ATAPI 32X CD-ROM CD-R/RW drive, 8192kB Cache, DMA
> Uniform CD-ROM driver Revision: 3.12
> mice: PS/2 mouse device common for all mice
> serio: i8042 AUX port at 0x60,0x64 irq 12
> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
> Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed 
> Aug 20 20:27:13 2003 UTC).
> PCI: Found IRQ 10 for device 0000:00:0b.0
> 
> And so on.
> 
> > Or you could change the source to alter or disable #define
> > ACPI_BLACKLIST_CUTOFF_YEAR 2001
> 
> I will try this next. ACPI was working flawlessly for me almost from
> the beginning.
> 
> -- 
> Tomasz Torcz                                                  
>      72->|   80->|
> zdzichu@irc.-nie.spam-.pl                                     
>      72->|   80->|
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
