Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbSL2OiT>; Sun, 29 Dec 2002 09:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbSL2OiT>; Sun, 29 Dec 2002 09:38:19 -0500
Received: from alpham.uni-mb.si ([164.8.1.101]:2047 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S266638AbSL2OiS>;
	Sun, 29 Dec 2002 09:38:18 -0500
Date: Sun, 29 Dec 2002 15:46:57 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: [PATCH] Workaround for AMD762MPX "mouse" bug
To: ak@muc.de, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3E0F0AE1.EB2C5DAA@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen (ak@muc.de) wrote :

> AMD has published a new errata sheet for the AMD762, which describes 
> the root cause of the infamous "AMD 762 unstable when no PS/2 mouse 
> connected" bug. The reason is that without a PS/2 mouse the BIOS doesn't 
> put a data page in front of the VGA buffer at 640K. When the kernel 
> puts a page cache page there and does busmaster IO with it then the automatic 
> PCI prefetch from the chipset can hit the VGA buffer and that may cause a hang. 
> 
> 
> The workaround is to reserve the page directly before 640K if it wasn't 
> already reserved by the BIOS. 
> 
> 
> The bug only occurs in newer revisions (B0,B1) 
> 
> 
> The workaround here is somewhat hackish. We can only reserve the page 
> in early boot, but at that time there is no easy way to check for the 
> AMD762's PCI-ID because the PCI subsystem hasn't been initialized yet. 
> 
> 
> This patch checks later during the pci quirks pass instead 
> and then tells the user to pass a kernel option - "vgaguard" - in 
> case of instability. This is not ideal, but probably preferable than 
> to connect PS/2 mouses to all boxes in a colocated rack. Another 
> way would be to always reserve that page, but I didn't feel like 
> punishing everybody just for a hardware bug in a single chipset. 
> 
> 
> Patch for 2.5.53. Please consider applying. 

Some suggestions :

 - do not tell the user to use the "vgaguard" option if he is already
using it
 - change to more informative text :
old :
I/O APIC: AMD762 Errata #56 may be present.
In case of instability boot with "vgaguard" or connect a PS/2 mouse.
new:
I/O APIC: AMD762 Errata #56 may be present.
In case of instability boot with the "vgaguard" kernel boot option or
connect a PS/2 mouse and reboot.

Just connecting a PS/2 mouse on a running system does not help, right ?
:-)

 - maybe rename the option to "amd762vgaguard" ?
 - also write some docs and put a link to it in the kernel message ?
For now this would be enough :
I/O APIC: AMD762 Errata #56 may be present.
In case of instability boot with the "vgaguard" kernel boot option or
connect a PS/2 mouse and reboot.
See http://www.uwsg.indiana.edu/hypermail/linux/kernel/0212.3/0043.html


Regards,
David Balazic
