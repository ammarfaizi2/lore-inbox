Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318925AbSICVAR>; Tue, 3 Sep 2002 17:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318930AbSICVAR>; Tue, 3 Sep 2002 17:00:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13701 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318925AbSICVAP>;
	Tue, 3 Sep 2002 17:00:15 -0400
Message-Id: <200209032103.g83L30J11272@w-gaughen.beaverton.ibm.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
Reply-to: gone@us.ibm.com
From: Patricia Gaughen <gone@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk
Subject: 2.4.20pre5 not booting on numa-q with CONFIG_MULTIQUAD
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 14:02:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

2.4.20pre4 booted fine for me, but 2.4.20pre5 is not booting on the numa-q 
boxes when I turn on CONFIG_MULTIQUAD.  I've included the messages that I see 
leading up to the panic. I looked over some pci changes that went in pre5 and 
don't see anything suspect, but I'm not familiar with that area of code.

Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>
 (unofficial 2.2/2.4 kernel port, version 1.03+LK1.3.6, March 7, 2002)
eth0: Adaptec Starfire 6915 at 0xf8a01000, 00:00:d1:ec:a9:0d, IRQ 40.
eth0: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth0: scatter-gather and hardware TCP cksumming disabled.
eth1: Adaptec Starfire 6915 at 0xf8a82000, 00:00:d1:ec:a9:0e, IRQ 39.
eth1: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth1: scatter-gather and hardware TCP cksumming disabled.
eth2: Adaptec Starfire 6915 at 0xf8b03000, 00:00:d1:ec:a9:0f, IRQ 38.
eth2: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth2: scatter-gather and hardware TCP cksumming disabled.
eth3: Adaptec Starfire 6915 at 0xf8b84000, 00:00:d1:ec:a9:10, IRQ 37.
eth3: MII PHY found at address 1, status 0x7809 advertising 01e1.
eth3: scatter-gather and hardware TCP cksumming disabled.
PCI: Unable to reserve mem region #1:80000@fd900000 for device 02:04.0
PCI: Unable to reserve mem region #1:80000@fd900000 for device 02:04.0
Trying to free nonexistent resource <30303750-69462030>
Trying to free nonexistent resource <00000000-00000029>
Trying to free nonexistent resource <f7ac6800-f7ac6000>
Trying to free nonexistent resource <6e6f4320-6c6f7274>
Trying to free nonexistent resource <202e7072-34353238>
Trying to free nonexistent resource <fcc2ffff-00000200>
<.... removed about 120000 instances of this message...>
Trying to free nonexistent resource <00004000-00029615>
Trying to free nonexistent resource <00000000-69680000>
Trying to free nonexistent resource <f390f3bc-0246f000>
Trying to free nonexistent resource <ffff7e00-0000ed00>
Trying to free nonexistent resource <f00000fd-f00000fd>
Trying to free nonexistent resource <f000efd2-f000f3a3>
Unable to handle kernel paging request at virtual address bfffffec
c01a527b
*pde = 00000000
Oops: 0000
CPU:    2
EIP:    0010:[<c01a527b>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: c85397dc   ebx: fe02fc44   ecx: f7ac6800   edx: f000e2c3
esi: fe02fc45   edi: f7ac6800   ebp: f7ac6800   esp: f7adbf34
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=f7adb000)
Stack: fe02fc44 f7ac6800 fe02fc46 c01a5508 f7ac6800 fe02fc45 00080000 f77dc000
       fd900000 c0187db1 f7ac6800 f77dc000 00000001 00000001 00000000 00000028
       c022ddd8 c022de20 f7ac6800 00000000 c01a55dc f7ac6800 c022ddd8 f7ac6800
Call Trace:    [<c01a5508>] [<c0187db1>] [<c01a55dc>] [<c01a5642>] [<c0105000>]
  [<c0105078>] [<c0105000>] [<c01071c6>] [<c0105050>]
Code: 8b 54 38 10 85 d2 75 08 8b 4c 38 14 85 c9 74 6b 8b 5c 38 14

>>EIP; c01a527b <pci_release_region+1b/a0>   <=====
Trace; c01a5508 <pci_request_regions+a8/c0>
Trace; c0187db1 <starfire_init_one+e1/4d0>
Trace; c01a55dc <pci_announce_device+3c/60>
Trace; c01a5642 <pci_register_driver+42/60>
Trace; c0105000 <_stext+0/0>
Trace; c0105078 <init+28/190>
Trace; c0105000 <_stext+0/0>
Trace; c01071c6 <kernel_thread+26/30>
Trace; c0105050 <init+0/190>
Code;  c01a527b <pci_release_region+1b/a0>
00000000 <_EIP>:
Code;  c01a527b <pci_release_region+1b/a0>   <=====
   0:   8b 54 38 10               mov    0x10(%eax,%edi,1),%edx   <=====
Code;  c01a527f <pci_release_region+1f/a0>
   4:   85 d2                     test   %edx,%edx
Code;  c01a5281 <pci_release_region+21/a0>
   6:   75 08                     jne    10 <_EIP+0x10> c01a528b 
<pci_release_re
gion+2b/a0>
Code;  c01a5283 <pci_release_region+23/a0>
   8:   8b 4c 38 14               mov    0x14(%eax,%edi,1),%ecx
Code;  c01a5287 <pci_release_region+27/a0>
   c:   85 c9                     test   %ecx,%ecx
Code;  c01a5289 <pci_release_region+29/a0>
   e:   74 6b                     je     7b <_EIP+0x7b> c01a52f6 
<pci_release_re
gion+96/a0>
Code;  c01a528b <pci_release_region+2b/a0>
  10:   8b 5c 38 14               mov    0x14(%eax,%edi,1),%ebx

 <0>Kernel panic: Attempted to kill init!


Thanks,
Pat

-- 
Patricia Gaughen (gone@us.ibm.com)
IBM Linux Technology Center
http://www.ibm.com/linux/ltc/


