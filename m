Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129295AbQKYK6b>; Sat, 25 Nov 2000 05:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130464AbQKYK6V>; Sat, 25 Nov 2000 05:58:21 -0500
Received: from nread2.inwind.it ([212.141.53.75]:28290 "EHLO relay4.inwind.it")
        by vger.kernel.org with ESMTP id <S129295AbQKYK6P>;
        Sat, 25 Nov 2000 05:58:15 -0500
Date: Sat, 25 Nov 2000 11:28:03 +0100
To: linux-kernel@vger.kernel.org
Subject: PCI problem with an Olivetti M4
Message-ID: <20001125112803.A365@dracula.home.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: root <g.anzolin@inwind.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
	I have an old PC, it's an Olivetti M4 (P166) and I tried to
install linux on it. But I got a problem: just after LILO has loaded the
kernel (after 'Loading......') the screen becomes black and I can't see
anything. In other words the video card doesn't seem to work.

	I also tested tha same system with FreeBSD 4.1.1.1 and it works
without problems.


	I can boot the linux kernel and I can access the system with
ssh. I found something interesting.

The video card is a PCI Trident 9660 integrated on the mainboard but
lspci doesn't show it:

fourier:~# lspci 
00:00.0 Host bridge: Intel Corporation 430FX - 82437FX TSC [Triton I]
(rev 02)
00:07.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev
02)
00:07.1 IDE interface: Intel Corporation 82371FB PIIX IDE [Triton I]
(rev 02)

it doesn't find the PCI card. FreeBSD detects it with the pci id 00:09.0

I tried to boot either a 2.2.18pre17 kernel or a 2.4.0-test11 kernel.
No kernel worked. I tried also to change the PCI access: pci access
Direct, Any or BIOS... nothing changed...

I tried also to compile the vesa framebuffer (as the card should be
vesda compliant) but it didn't work.

On #kernelnewbies somebody told me to enable the DEBUG definition in the
pci subsystem and this is what I get in the dmesg (kernel 2.4.0-test11):

PCI: BIOS32 Service Directory structure at 0xc00fdb50
PCI: BIOS32 Service Directory entry at 0xfdb60
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=00
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=0
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: IRQ init
PCI: IRQ fixup
PCI: Allocating resources
PCI: Resource 0000ffa0-0000ffaf (f=101, d=0, p=0)
PCI: Sorting device list...
Limiting direct PCI/PCI transfers.                                                                            

On http://www.gest.unipd.it/~iig0573/lspci.txt you'll find the output of
lspci -xvv

Thanks,

	Gianluca

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
