Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269967AbTGPBOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 21:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269983AbTGPBOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 21:14:53 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:34321
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S269967AbTGPBOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 21:14:51 -0400
Date: Tue, 15 Jul 2003 18:29:48 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: greg@kroah.com
Subject: Hotplug Oops Re: Linux v2.6.0-test1
Message-ID: <20030716012948.GA1877@matchmail.com>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	greg@kroah.com
References: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307132055080.2096-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a nice oops for you guys.

Hotplug is the trigger.  I can't reproduce without hotplug.

hotplug tries to load ohci, ehci, and finally uhci (the correct module), it
oopses for each driver with hotplug, but if I try without hotplug ('apt-get
remove hotplug' before rebooting), I can load all three usb drivers with no
oops.

I saw this on 2.5.70 also, but this is the first time I tried SAK after the
console hung during boot.  After SAK, it continued booting, and I saved the
oops.

I can supply more info as needed, and test patches.

I'm running smp+preempt on a UP pII 450.

input: Logitech USB Mouse on usb-0000:00:07.2-2
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Adding 262136k swap on /usr/swap_file.  Priority:2 extents:38
Unable to handle kernel paging request at virtual address d493885c
 printing eip:
c01d3bdd
*pde = 040ce067
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c01d3bdd>]    Not tainted
EFLAGS: 00010292
EIP is at kobject_add+0x79/0xf4
eax: c03d2280   ebx: d49550c4   ecx: d493885c   edx: d49550dc
esi: c03d2288   edi: c03d2224   ebp: d3731f34   esp: d3731f28
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 209, threadinfo=d3730000 task=c4216080)
Stack: d49550c4 d49550c4 00000000 d3731f4c c01d3c70 d49550c4 d49550c4 d49550c4 
       c03d2220 d3731f70 c0238d6f d49550c4 d49550c4 d4953a8a 00000014 d4955080 
       00000000 d4955120 d3731f7c c023912a d49550a8 d3731f94 c01d9ba0 d49550a8 
Call Trace:
 [<c01d3c70>] kobject_register+0x18/0x48
 [<c0238d6f>] bus_add_driver+0x3f/0x8c
 [<c023912a>] driver_register+0x36/0x3c
 [<c01d9ba0>] pci_register_driver+0x74/0x9c
 [<d48e401e>] init+0x1e/0x4c [ehci_hcd]
 [<c01381c8>] sys_init_module+0x118/0x240
 [<c0109af7>] syscall_call+0x7/0xb

Code: 89 11 8b 43 24 8b 38 8d 4f 44 89 c8 ba ff ff 00 00 f0 0f c1 
 <7>ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount 
SysRq : SAK
SAK: killed process 13 (init): p->session==tty->session
SAK: killed process 14 (rcS): p->session==tty->session
SAK: killed process 205 (S36hotplug): p->session==tty->session
SAK: killed process 207 (usb.rc): p->session==tty->session
SAK: killed process 210 (modprobe): p->session==tty->session
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
RPC: sendmsg returned error 101
portmap: RPC call returned error 101
process `snmpd' is using obsolete setsockopt SO_BSDCOMPAT

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02)
00:10.0 VGA compatible controller: Number 9 Computer Company Imagine 128 T2R [Ticket to Ride]
