Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTDUPeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 11:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbTDUPeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 11:34:17 -0400
Received: from franka.aracnet.com ([216.99.193.44]:22460 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261362AbTDUPeP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 11:34:15 -0400
Date: Mon, 21 Apr 2003 08:46:17 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 614] New: Oops on boot in vortex_interrupt with 3c59x
Message-ID: <28390000.1050939977@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=614

           Summary: Oops on boot in vortex_interrupt with 3c59x
    Kernel Version: 2.5.68-bk1
            Status: NEW
          Severity: high
             Owner: jgarzik@pobox.com
         Submitter: bwindle-kbt@fint.org


Distribution: Debian Testing
Hardware Environment:
00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X
(rev  5c)
02:0a.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
02:0b.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev
10)

Software Environment:
# CONFIG_ACPI is not set
# CONFIG_APM is not set
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_USB_UHCI_HCD=y

Linux razor 2.5.67-bk9 #15 Fri Apr 18 09:30:12 EST 2003 i686 unknown
unknown  GNU/Linux

Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      implemented
e2fsprogs              1.32
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.10


Problem Description:
Kernel 2.5.68-bk1 oops on boot during network setup with the following oops:
Unable to handle kernel NULL pointer dereference at virtual address 0000006b
 printing eip:
c023f1c5
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c023f1c5>]    Not tainted
EFLAGS: 00010282
EIP is at vortex_interrupt+0x15/0x410
eax: 0000000b   ebx: cfca35d0   ecx: 0000000b   edx: 00000020
esi: 00000001   edi: c03fbf50   ebp: c03fbf28   esp: c03fbf04
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03fa000 task=c03ae700)
Stack: cfca35d0 00000001 c03fbf50 c027f040 c13e2400 c03fbf84 c135c998
00000000        0000000b c03fbf54 c010b15a c03fbf50 0000000b c13d3000
c03fbf84 c03f7cc0        c03f7cd0 c03fa000 04000001 00000001 c03fbf7c
c010b641 0000000b c03fbf84 Call Trace:
 [<c027f040>] usb_hcd_irq+0x34/0x60
 [<c010b15a>] handle_IRQ_event+0x36/0xa8
 [<c010b641>] do_IRQ+0x1a1/0x2ec
 [<c01070d4>] default_idle+0x0/0x34
 [<c01070d4>] default_idle+0x0/0x34
 [<c0109c70>] common_interrupt+0x18/0x20
 [<c01070d4>] default_idle+0x0/0x34
 [<c01070d4>] default_idle+0x0/0x34
 [<c01070fa>] default_idle+0x26/0x34
 [<c0107189>] cpu_idle+0x35/0x44
 [<c0105000>] _stext+0x0/0xcc
 [<c01050c5>] _stext+0xc5/0xcc
 [<c03fc6b1>] start_kernel+0x1c9/0x1d4

Code: 8b 70 60 89 55 f4 8b 40 18 89 45 f8 b8 00 e0 ff ff 21 e0 ff
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

This did NOT happen in 2.5.67-bk9, the last kernel I tried on this box.

Steps to reproduce:

