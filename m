Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWIPCjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWIPCjK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 22:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWIPCjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 22:39:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:27078 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932382AbWIPCjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 22:39:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cyjpDp8g6FbQRPH5AvhfLyuo4wbsAPZgArhv/WqOAOX211jN5dRCWNM7iuNPZurmX1SYLtZgQOsBEvlmbNeVHQuVhTBQMmvrWS5OWARRTepNM+NHugFN612+sWPE4cOVVvP0YdhuWPe0ULT3py4elnsI/OaNbYu+3j1aeOlInzo=
Message-ID: <a63d67fe0609151939q2dc05a8cg559fcfc6870d2632@mail.gmail.com>
Date: Fri, 15 Sep 2006 19:39:06 -0700
From: "Dan Carpenter" <error27@gmail.com>
To: "Matt Domsch" <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.18-rc5] PCI: sort device lists breadth-first
Cc: "Dan Carpenter" <error27.lkml@gmail.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, "Greg KH" <greg@kroah.com>,
       linux-kernel@vger.kernel.org, ppokorny@penguincomputing.com
In-Reply-To: <20060915130226.GA2291@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060908031422.GA4549@lists.us.dell.com>
	 <b263e5900609142053r12fbb71ep6ea3e1d63a722d4e@mail.gmail.com>
	 <20060915130226.GA2291@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/06, Matt Domsch <Matt_Domsch@dell.com> wrote:
> On Thu, Sep 14, 2006 at 08:53:16PM -0700, Dan Carpenter wrote:
> > On 9/7/06, Matt Domsch <Matt_Domsch@dell.com> wrote:
> > >Problem:
> > >Many people have come to expect this naming.  Linux 2.6
> > >kernels name these eth1 and eth0 respectively (backwards from
> > >expectations).  I also have reports that various Sun and HP servers
> > >have similar behavior.
> > >
> >
> > On RHEL3 the 32bit and 64bit versions order the NICs differently.
> > 64bit RHEL3 orders it the same as 2.6.
> >
> > I've got a lot of systems where the NIC LEDs are labelled.  The labels
> > are correct for 2.6 but not for 2.4 32 bit.  I'm suspect the labels
> > were designed for Windows originally.
>
> 2.4 i386 by default resorts the list by what BIOS reports the order
> should be.  No other arches do this.  So I'd expect it to be opposite
> of what you say.
>
> Care to send the output of 'lspci -tv' and the first 80 or so lines of
> dmidecode?  This is curious.
>

On this system the LEDs match the BIOS and the PXE boot order and the
2.6 ordering.

-+-[06]-+-01.0-[07]--
 |      +-01.1  Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC
 |      +-02.0-[08]--
 |      \-02.1  Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC
 \-[00]-+-00.0  nVidia Corporation CK804 Memory Controller
        +-01.0  nVidia Corporation CK804 ISA Bridge
        +-01.1  nVidia Corporation CK804 SMBus
        +-02.0  nVidia Corporation CK804 USB Controller
        +-02.1  nVidia Corporation CK804 USB Controller
        +-06.0  nVidia Corporation CK804 IDE
        +-07.0  nVidia Corporation CK804 Serial ATA Controller
        +-08.0  nVidia Corporation CK804 Serial ATA Controller
        +-09.0-[01]----07.0  ATI Technologies Inc Rage XL
        +-0b.0-[02]----00.0  Broadcom Corporation NetXtreme BCM5721
Gigabit Ethernet PCI Express
        +-0c.0-[03]--
        +-0d.0-[04]----00.0  Broadcom Corporation NetXtreme BCM5721
Gigabit Ethernet PCI Express
        +-0e.0-[05]--
        +-18.0  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
        +-18.1  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        +-18.2  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
        +-18.3  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
        +-19.0  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
        +-19.1  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        +-19.2  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
DRAM Controller
        \-19.3  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control

# dmidecode 2.2
SMBIOS 2.3 present.
54 structures occupying 2065 bytes.
Table at 0x000FA560.
Handle 0x0000
	DMI type 0, 20 bytes.
	BIOS Information
		Vendor: IR2300
		Version: BIOS Version 1.50 Date: 03/17/06 13:23:14
		Release Date: <BAD INDEX>
		Address: 0xF0000
		Runtime Size: 64 kB
		ROM Size: 1024 kB
		Characteristics:
			ISA is supported
			PCI is supported
			PNP is supported
			BIOS is upgradeable
			BIOS shadowing is allowed
			ESCD support is available
			Boot from CD is supported
			Selectable boot is supported
			BIOS ROM is socketed
			EDD is supported
			3.5"/2.88 MB floppy services are supported (int 13h)
			Print screen service is supported (int 5h)
			8042 keyboard services are supported (int 9h)
			Serial services are supported (int 14h)
			CGA/mono video services are supported (int 10h)
			ACPI is supported
			USB legacy is supported
			LS-120 boot is supported
			ATAPI Zip drive boot is supported
			BIOS boot specification is supported
			Function key-initiated network boot is supported
Handle 0x0001
	DMI type 1, 25 bytes.
	System Information
		Manufacturer: To Be Filled By O.E.M.
		Product Name: IR2300
		Version: To Be Filled By O.E.M.
		Serial Number: To Be Filled By O.E.M.
		UUID: 00020003-0004-0005-0006-000700080009
		Wake-up Type: Power Switch
Handle 0x0002
	DMI type 2, 8 bytes.
	Base Board Information
		Manufacturer: InventecESC
		Product Name: Tuna
		Version: To be filled by O.E.M.
		Serial Number: To be filled by O.E.M.
Handle 0x0003
	DMI type 3, 17 bytes.
	Chassis Information
		Manufacturer: InventecESC
		Type: Hand Held
		Lock: Not Present
		Version: To Be Filled By O.E.M.
		Serial Number: To Be Filled By O.E.M.
		Asset Tag: To Be Filled By O.E.M.
		Boot-up State: Safe
		Power Supply State: Safe
		Thermal State: Safe
		Security Status: None
		OEM Information: 0x00000000

regards,
dan carpenter
