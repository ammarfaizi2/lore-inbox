Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263330AbTCTXeI>; Thu, 20 Mar 2003 18:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263331AbTCTXeI>; Thu, 20 Mar 2003 18:34:08 -0500
Received: from loki.a-q.co.uk ([195.224.50.15]:19467 "EHLO loki.a-q.co.uk")
	by vger.kernel.org with ESMTP id <S263330AbTCTXeE>;
	Thu, 20 Mar 2003 18:34:04 -0500
Date: Thu, 20 Mar 2003 23:45:01 +0000
From: James Wright <james@jigsawdezign.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: jun.nakajima@intel.com, linux-kernel@vger.kernel.org
Subject: Re: P4 3.06Ghz Hyperthreading with 2.4.20?
Message-Id: <20030320234501.45e9bdc8.james@jigsawdezign.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A210@orsmsx401.jf.intel.com>
References: <F760B14C9561B941B89469F59BA3A84725A210@orsmsx401.jf.intel.com>
Organization: Jigsaw Dezign
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Problem Solved!!!  I had foolishly enabled ACPI CPU Enumeration Only, i switched this off
and now all is working!!! wow... checkout those BogoMIPS;  

CPU0: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 07
CPU1: Intel(R) Pentium(R) 4 CPU 3.06GHz stepping 07
Total of 2 processors activated (12242.12 BogoMIPS).


Thanks for your quick response,
James



On Thu, 20 Mar 2003 14:32:00 -0800
"Grover, Andrew" <andrew.grover@intel.com> wrote:

> 
> > From: James Wright [mailto:james@jigsawdezign.com] 
> > ACPI: Local APIC address 0xfee00000
> > ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> > Processor #0 Pentium 4(tm) XEON(tm) APIC version 16
> > ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> > Processor #1 Pentium 4(tm) XEON(tm) APIC version 16
> 
> There should be some messages about IO APICs right here. To be SMP, you
> need IO APICs.
> 
> If you did the ACPI cpu enumeration only, please try the full ACPI
> support. That is the only reason I can think of (except for !CONFIG_SMP)
> as to why the IO APIC(s) could be overlooked.
> 
> > Kernel command line: BOOT_IMAGE=linux ro root=302 acpismp=force
> 
> Don't need acpismp=force, btw. With the patch off sf.net it is on by
> default - you can use acpi=off to disable it, though. ;-)
> 
> Regards -- Andy
> 
> > On Thu, 20 Mar 2003 09:11:10 -0800
> > "Grover, Andrew" <andrew.grover@intel.com> wrote:
> > 
> > > > From: James Wright [mailto:james@jigsawdezign.com] 
> > > >    So i can apply the ACPI patch to 2.4.20, and it will work, 
> > > > even though my motherboard BIOS
> > > > doesn't provide the MPS table?
> > > 
> > > Yes, because ACPI uses a different table.
> > > 
> > > > Do i still need to use 
> > > > "acpismp=force" option?
> > > 
> > > Nope.
> > > 
> > > > What do you mean
> > > > by *configuring* acpi
> > > 
> > > Configuring it into your kernel, presumably, using make menuconfig.
> > > 
> > > > do i need the "acpid" or other 
> > > > resources, than just enabling it?
> > > 
> > > Nope, all the SMP detection stuff is in the kernel.
> > > 
> > > Regards -- Andy
> > > 
> > > > 
> > > > Thanks,
> > > > James
> > > > 
> > > > 
> > > > On Wed, 19 Mar 2003 18:50:59 -0800
> > > > "Nakajima, Jun" <jun.nakajima@intel.com> wrote:
> > > > 
> > > > > You need to apply the ACPI patch: 
> > > > http://sourceforge.net/projects/acpi and *configure* APIC. 
> > > > > 
> > > > > The 2.4 kernel depends on the MPS table for all but logical 
> > > > processors. If MPS table is not present, it will fall back to UP.
> > > > > 
> > > > > Thanks,
> > > > > Jun
> > > > > 
> > > > > > -----Original Message-----
> > > > > > From: James Wright [mailto:james@jigsawdezign.com]
> > > > > > Sent: Wednesday, March 19, 2003 5:34 PM
> > > > > > To: linux-kernel@vger.kernel.org
> > > > > > Subject: P4 3.06Ghz Hyperthreading with 2.4.20?
> > > > > > 
> > > > > > Hello,
> > > > > > 
> > > > > >    I have kernel 2.4.20 with a single P4 3.06Ghz CPU and 
> > > > Asus P4G8X
> > > > > > motherboard
> > > > > > (with the Intel E7205) Chipset. I have enabled 
> > > > Hyperthreading in the BIOS
> > > > > > options,
> > > > > > compiled in SMP & ACPI support, and also tried adding 
> > > > "acpismp=force" to
> > > > > > my lilo
> > > > > > kernel cmdline, but it just doesn't seem to detect the 
> > > > second Logical CPU.
> > > > > > My
> > > > > > current theory is that this is bcos Linux expects the 
> > > > motherboard to be an
> > > > > > SMP
> > > > > > item (as with the Xeon boards) but this board is a Single 
> > > > processor board,
> > > > > > ansd
> > > > > > doesn't have an MP table, but the cpu info is held in the 
> > > > ACPI tables.?!?
> > > > > > 
> > > > > > I have tried installing 2.5.65 but can't get past the 
> > > > compile due to
> > > > > > compile-time
> > > > > > errors... Is this a known problem? SHall i just disable 
> > > > Hyperthreading
> > > > > > until a new
> > > > > > kernel release?
> > > > > > 
> > > > > > 
> > > > > > Thanks,
> > > > > > James
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > -
> > > > > > To unsubscribe from this list: send the line "unsubscribe 
> > > > linux-kernel" in
> > > > > > the body of a message to majordomo@vger.kernel.org
> > > > > > More majordomo info at  
> > http://vger.kernel.org/majordomo-info.html
> > > > > > Please 
> > read the FAQ at  http://www.tux.org/lkml/
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe 
> > > > linux-kernel" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  
> > http://vger.kernel.org/majordomo-info.html
> > > > > Please read 
> > the FAQ at  http://www.tux.org/lkml/
> > > > > 
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe 
> > > > linux-kernel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > > 
> > > 
> > 
> 
