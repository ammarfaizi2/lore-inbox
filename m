Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132289AbRAPSVs>; Tue, 16 Jan 2001 13:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131259AbRAPSV3>; Tue, 16 Jan 2001 13:21:29 -0500
Received: from shelly.surfsouth.com ([216.128.200.24]:19984 "EHLO
	shelly.surfsouth.com") by vger.kernel.org with ESMTP
	id <S129831AbRAPSVN>; Tue, 16 Jan 2001 13:21:13 -0500
Date: Tue, 16 Jan 2001 13:22:51 -0500
From: Chad Miller <cmiller@surfsouth.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: matroxfb on 2.4.0 / PCI: Failed to allocate...
Message-ID: <20010116132251.A1021@cahoots.surfsouth.com>
In-Reply-To: <12C0E7CE41C0@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <12C0E7CE41C0@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Tue, Jan 16, 2001 at 05:56:34PM +0000
X-mrl-nonsense: It's better to be Pavlov's Dog than Schrodenger's Cat.
X-key-info: GPG key at http://web.chad.org/home/gpgkey
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 05:56:34PM +0000, Petr Vandrovec wrote:
> What does 'lspci -v' say?

Hi, Petr.

I'm sorry for the verbosity, all.  Here it is:

#00:00.0 Host bridge: VIA Technologies, Inc. VT8371 [KX133] (rev 02)
#        Flags: bus master, medium devsel, latency 0
#        Memory at d0000000 (32-bit, prefetchable) [size=64M]
#        Capabilities: <available only to root>
#
#00:01.0 PCI bridge: VIA Technologies, Inc. VT8371 [KX133 AGP]  (prog-if 00 \
#[Normal decode])
#        Flags: bus master, 66Mhz, medium devsel, latency 0
#        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
#        Memory behind bridge: d4000000-d6ffffff
#        Prefetchable memory behind bridge: d7000000-d8ffffff
#        Capabilities: <available only to root>
#
#00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] \
#(rev 22)
#        Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
#        Flags: bus master, stepping, medium devsel, latency 0
#
#00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) \
#(prog-if 8a [Master SecP PriP])
#        Flags: bus master, medium devsel, latency 32
#        I/O ports at e000 [size=16]
#        Capabilities: <available only to root>
#
#00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] \
#(rev 30)
#        Flags: medium devsel
#        Capabilities: <available only to root>
#
#00:09.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] \
#(rev 08)
#        Subsystem: Intel Corporation EtherExpress PRO/100+ Management Adapter
#        Flags: bus master, medium devsel, latency 32, IRQ 11
#        Memory at da100000 (32-bit, non-prefetchable) [size=4K]
#        I/O ports at ec00 [size=64]
#        Memory at da000000 (32-bit, non-prefetchable) [size=1M]
#        Expansion ROM at <unassigned> [disabled] [size=1M]
#        Capabilities: <available only to root>
#
#01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP \
#(rev 05) (prog-if 00 [VGA])
#        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head 32Mb
#        Flags: bus master, VGA palette snoop, medium devsel, latency 64, IRQ 10
#        Memory at d8000000 (32-bit, prefetchable) [size=16M]
#        Memory at d4000000 (32-bit, non-prefetchable) [size=16K]
#        Memory at d5000000 (32-bit, non-prefetchable) [size=8M]
#        Expansion ROM at <unassigned> [disabled] [size=64K]
#        Capabilities: <available only to root>
#


> Are you sure that you do not have 'matroxfb: control registers are not
> available, matroxfb disabled', or 'matroxfb: video RAM is not available
> in PCI address space, matroxfb disabled' messages?

$ dmesg |egrep -i '(pci|matrox|mga|fb|registers|video)' | \
 egrep -v '(IDE|passed|Serial)'
Kernel command line: mem=262080K  root=/dev/hda3 video=matrox
PCI: PCI BIOS revision 2.10 entry at 0xfb4d0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Cannot allocate resource region 0 of device 01:00.0
PCI: Failed to allocate resource 0 for Matrox Graphics, Inc. MGA G400 AGP
matroxfb: Matrox Millennium G400 MAX (AGP) detected
PCI: Found IRQ 11 for device 00:09.0
$ 

> Also, when request_mem_region(ctrl, 16K, "matroxfb MMIO") or
> request_mem_region(videoram, 32M, "matroxfb FB") fails (f.e. when
> both regions are uninitialized they overlaps, so second request_mem_region
> fails), there is a bug that no error message is printed
> in such case, as matroxfb assumes that if request_mem_region failed,
> it was because of some other driver already controls this hardware.

Is there a patch available, or should I go looking for it?

 
> You should make sure that (1) you have only one VGA in machine and
> (2) your BIOS is not buggy. Changing any of these two conditions should
> enable matroxfb to run (G400 is not very well supported as second head;
> you can experiment with 'memtype' matroxfb option, but...)

(1) is true.  (2) is true, AFAICT, but I'm no BIOS expert.  I once success-
fully used matroxfb on this machine under 2.2.~17, but haven't tried it
again before 2.4 . 

						- chad

--
Chad Miller <cmiller@surfsouth.com>   URL: http://web.chad.org/   (GPG)
"Any technology distinguishable from magic is insufficiently advanced".
First corollary to Clarke's Third Law (Jargon File, v4.2.0, 'magic')
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
