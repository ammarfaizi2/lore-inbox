Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265710AbSJYAMb>; Thu, 24 Oct 2002 20:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265714AbSJYAMb>; Thu, 24 Oct 2002 20:12:31 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:40395 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265710AbSJYAM2>; Thu, 24 Oct 2002 20:12:28 -0400
Date: Thu, 24 Oct 2002 17:18:34 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI device order problem
Message-ID: <20021024171834.A23109@lucon.org>
References: <20021024163945.A21961@lucon.org> <3DB88715.7070203@pobox.com> <20021024165631.A22676@lucon.org> <3DB88CD1.5090204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB88CD1.5090204@pobox.com>; from jgarzik@pobox.com on Thu, Oct 24, 2002 at 08:14:09PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 08:14:09PM -0400, Jeff Garzik wrote:
> H. J. Lu wrote:
> 
> >On Thu, Oct 24, 2002 at 07:49:41PM -0400, Jeff Garzik wrote:
> >  
> >
> >>H. J. Lu wrote:
> >>
> >>    
> >>
> >>>In arch/i386/kernel/pci-pc.c, there are
> >>>
> >>>/*
> >>>* Sort the device list according to PCI BIOS. Nasty hack, but since some
> >>>* fool forgot to define the `correct' device order in the PCI BIOS specs
> >>>* and we want to be (possibly bug-to-bug ;-]) compatible with older kernels 
> >>>* which used BIOS ordering, we are bound to do this... 
> >>>*/
> >>>
> >>>static void __devinit pcibios_sort(void)
> >>>
> >>>The problem is on my MB:
> >>>
> >>>00:00.0 Host bridge: Intel Corp. e7500 [Plumas] DRAM Controller (rev 03)
> >>>00:00.1 Class ff00: Intel Corp. e7500 [Plumas] DRAM Controller Error Reporting ( rev 03)
> >>>00:03.0 PCI bridge: Intel Corp. e7500 [Plumas] HI_C Virtual PCI Bridge (F0) (rev 03)
> >>>00:03.1 Class ff00: Intel Corp. e7500 [Plumas] HI_C Virtual PCI Bridge (F1) (rev 03)
> >>>00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
> >>>00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub  (rev 02)
> >>>00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 42)
> >>>00:1f.0 ISA bridge: Intel Corp. 82801CA ISA Bridge (LPC) (rev 02)
> >>>00:1f.1 IDE interface: Intel Corp. 82801CA IDE U100 (rev 02)
> >>>00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
> >>>01:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
> >>>02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
> >>>02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
> >>>02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 03)
> >>>02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 03)
> >>>03:07.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)
> >>>03:07.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)
> >>>03:08.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
> >>>
> >>>Eth1 becomes:
> >>>03:07.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)
> >>>
> >>>and eth0 becomes:
> >>>03:07.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (rev 01)
> >>>
> >>>Is that a good idea to have an option to sort the PCI device by PCI bus and
> >>>slot numbers?
> >>> 
> >>>
> >>>      
> >>>
> >>Without answering your specific question, but addressing $subject, what 
> >>problem is caused by the PCI device order you see?
> >>    
> >>
> >
> >It is different from the hardware documentation. The hardware manual says
> >it has 2 NICs, NIC 1 (03:07.0) and NIC2 (03:07.1), which makes senses
> >to me. NIC 1 is a special one which supports IPMI over LAN. Since we
> >only use one NIC now, we'd like to use NIC 1 and call it eth0.
> >  
> >
> 
> Well, overall, depending on ordering is error-prone (as you see).  I 
> would suggest migrating to a less-fragile scheme.  nameif and ethtool 
> together should get you exactly the device you need...  (though I wonder 
> why simply using eth1 is so awful, if this situation is constant...)

We can use eth1. It is just very confusing since Linux and hardware
manual don't agree which one is the first NIC. Also, when we upgrade
the BIOS, the BIOS order may change. As for other schemes, we don't want
to change every software which access ethX.


H.J.
