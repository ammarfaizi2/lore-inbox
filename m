Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129385AbQLBEkn>; Fri, 1 Dec 2000 23:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129415AbQLBEke>; Fri, 1 Dec 2000 23:40:34 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:57065 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129385AbQLBEkV>; Fri, 1 Dec 2000 23:40:21 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 1 Dec 2000 20:09:54 -0800
Message-Id: <200012020409.UAA04058@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Transmeta and Linux-2.4.0-test12-pre3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Minutes after slashdot ran their article saying that the
Transmeta recall was limited to about 300 Fujitsu computers, I ran
to Fry's and bought a Sony PictureBook PCG-C1VN.  Thank heavens for
those extended Christmas hours I thought, while praying that the
statements about the Crusoe problems being that limited would turn
out to be true.

	This device is the only commercially available computer in the
world that uses a processor made by Transmeta (a 600MHz TMS5600, stepping
03).  I thought surely that there would be a little subculture of
Linux PictureBook users at transmeta making sure that this particular
combination would work.

	Well, alas, it appears that linux-2.4.0-test12-pre3 freezes hard
while reading the base address registers of the first PCI device
(the "host bridge").  Actually, I think the problem is some kind of
system management interrupt occuring at about this time, since the
exact point where the printk's stop gets earlier as I add more
printk's.  With few printk's the printk's stop while the 6th base
address configuration register is being read; with more printk's it
stops at the second one, and it will stop in different places with
different boots, at least with the not-quite-stock kernels that I usually
use.  Also, turning off interrupts during this code has no effect, so
I do not think it is directly caused by the something in the PictureBook
pepperring the processor with unexpected interrupts (I thought it might have
to do with the USB-based floppy disk).

	Although the results of the debugging printk's that I added from
a somewhat modified linux-2.4.0-tset12-pre3 built for CONFIG_M386, I
also tried "pristine" linux-2.4.0-test12-pre3.  When built with
CONFIG_M386 (which has historically been the way to get a kernel that
runs on all x86 processors), I get no output or other apparent
activity after the boot loader jumps to it.  When buid with
CONFIG_MCRUSOE, it hangs after printing "PCI: Probing PCI Hardware",
just like our kernels (which, oddly, do work up this point even though
they are build with CONFIG_M386).  In case anyone is curious, I have
put the .config file from the pristine CONFIG_MCRUOSOE build in
ftp://ftp.yggdrasil.com/private/adam/linux-crusoe/.config.

	My initial attempts to find a processor manual on the tms5600
on the web and on Transmeta's web site have no yet turned up anything,
and I understand that the tms5600 includes the north bridge.  So, I
assume that that would be the first place to look for ideas about
any weirdness that occurs during PCI initialization of the PCI host
bridge.

	One sin that I am committing in these builds is that I am bulding
them under gcc-2.95.2, although I do not think this is the sort of
behavior that an optimizer bug is likely to produce.

	If anyone out there is using Linux 2.4.0-test on a Sony
PictureBook PCG-C1VN (the Transmeta version), I would be interested in
at least trying to build from your .config file.

	Memo to Transmeta management: buy Linus a PictureBook. :-)

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
