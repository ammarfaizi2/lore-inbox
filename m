Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbTLOPCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbTLOPCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:02:39 -0500
Received: from legolas.restena.lu ([158.64.1.34]:29587 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263723AbTLOPCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:02:32 -0500
Subject: Re: Fwd: Re: Working nforce2, was Re: Fixes for nforce2 hard
	lockup, apic, io-apic, udma133 covered
From: Craig Bradney <cbradney@zip.com.au>
To: ross@datscreative.com.au
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, recbo@nishanet.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200312160030.30511.ross@datscreative.com.au>
References: <200312160030.30511.ross@datscreative.com.au>
Content-Type: text/plain
Message-Id: <1071500545.6680.15.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Dec 2003 16:02:26 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to give the status here ...
Im still running the original 2.6 test 11 patches for apic and ioapic.
Uptime is now 2d 20h with lots of idle time and hard work too.. 

/proc/interrupts as follows:

           CPU0
  0:  245382420    IO-APIC-edge  timer
  1:     139577    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          3    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 12:    1478615    IO-APIC-edge  i8042
 14:    1055548    IO-APIC-edge  ide0
 15:     737664    IO-APIC-edge  ide1
 19:   18405692   IO-APIC-level  radeon@PCI:3:0:0
 21:    5257090   IO-APIC-level  ehci_hcd, NVidia nForce2, eth0
 22:          3   IO-APIC-level  ohci1394
NMI:      14944
LOC:  245087891
ERR:          0
MIS:          6

As for NMI.. I actually forget which I booted from... I think =1, but NMI is a small number now.. would it have wrapped?

Craig
A7N8X Deluxe V2 BIOS 1007



On Mon, 2003-12-15 at 15:30, Ross Dickson wrote:
> >> APIC error on CPU0: 02(02) 
> > > what?? no crash though. 
> > [...] 
> > > bob@where cat /proc/interrupts 
> > > CPU0 
> > > 0: 3350153 IO-APIC-edge timer 
> > > 1: 5775 IO-APIC-edge i8042 
> > > 2: 0 XT-PIC cascade 
> > > 8: 1 IO-APIC-edge rtc 
> > > 9: 0 IO-APIC-level acpi 
> > > 12: 5385 IO-APIC-edge i8042 
> > > 14: 10 IO-APIC-edge ide0 
> > > 15: 10 IO-APIC-edge ide1 
> > > 16: 1717957 IO-APIC-level ide2, ide3, eth0 
> > > 19: 472929 IO-APIC-level ide4, ide5 
> > > 21: 0 IO-APIC-level NVidia nForce2 
> > > NMI: 822 
> > > LOC: 3350073 
> > > ERR: 35 
> > > MIS: 15818 
> 
> >It looks like the infamous APIC delivery bug -- the "MIS" counter shows 
> >how many level-triggered interrupts has been erronously delivered as 
> >edge-triggered ones. No wonder the system shows instability -- you have 
> >noise problems at the APIC bus. 
>  
> Thanks Maciej
> I was wondering about those, I had seen the work around code and would not
> have thought it need apply to recent athlon chipsets?
> 
> 
> For comparison here is my proc/interrupts 
> CPU0
>   0:   50462204    IO-APIC-edge  timer
>   1:      49153    IO-APIC-edge  keyboard
>   2:          0          XT-PIC  cascade
>   9:          0   IO-APIC-level  acpi
>  12:     395912    IO-APIC-edge  PS/2 Mouse
>  14:     995872    IO-APIC-edge  ide0
>  15:        283    IO-APIC-edge  ide1
>  16:    3921102   IO-APIC-level  nvidia
>  18:          2   IO-APIC-level  bttv
>  20:     136325   IO-APIC-level  eth0, usb-ohci
>  21:     146903   IO-APIC-level  ehci_hcd, NVIDIA nForce Audio
>  22:          0   IO-APIC-level  usb-ohci
> NMI:          0
> LOC:   50457798
> ERR:          0
> MIS:          0
> 
> Albatron KM18G-Pro, nforce2, pheonix bios, 2200XP, 255fsb, ddr400,
> ide0 is hard drive, ide1 is cdrom, nmi watchdog off
> 
> Report seems OK but this machine locks up hard without the apic delay patch.
> 
> I am currently trying the simpler v1 (always add a delay) patch but on all apic
> acks as per this posting
> 
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/3291.html
> 
> which is a reply to an earlier posting of the same name but I accidently 
> omitted the Re in the subject.
> 
> Regards,
> Ross.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

