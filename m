Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbTEMNgo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbTEMNgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:36:44 -0400
Received: from boden.synopsys.com ([204.176.20.19]:45987 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP id S261210AbTEMNgl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:36:41 -0400
Date: Tue, 13 May 2003 15:49:07 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: linux-kernel@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Jeff Garzik <jgarzik@pobox.com>
Subject: 2.5.69+bk: "irq 15: nobody cared!" on a Compaq Armada 1592DT
Message-ID: <20030513134907.GF32559@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

(Zwane, I saw you fixing a similar bug in xircom, so included
you in cc also. Maybe you have an idea what could I try first?)


This occured just after starting pcmcia, when booted with a
card already in slot and cable connected to it.
The traces didn't stop until i removed the card
(i tried to disconnect the cable first, which didn't help).

-alex

$ lsmod
Module                  Size  Used by
pcnet_cs               16100  1
8390                    8384  1 pcnet_cs
crc32                   3744  1 8390
ds                     11616  3 pcnet_cs
yenta_socket           14240  2
pcmcia_core            53888  3 pcnet_cs,ds,yenta_socket
soundcore               6560  0

$ lspci | grep CardBus
00:11.0 CardBus bridge: Texas Instruments PCI1131 (rev 01)
00:11.1 CardBus bridge: Texas Instruments PCI1131 (rev 01)

$ grep PCMCIA .config
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
# PCMCIA/CardBus support
CONFIG_PCMCIA=m
CONFIG_PCMCIA_PROBE=y
# CONFIG_PARPORT_PC_PCMCIA is not set
# PCMCIA SCSI adapter support
# CONFIG_PCMCIA_AHA152X is not set
# CONFIG_PCMCIA_FDOMAIN is not set
# CONFIG_PCMCIA_NINJA_SCSI is not set
# CONFIG_PCMCIA_QLOGIC is not set
# PCMCIA network device support
CONFIG_NET_PCMCIA=y
CONFIG_PCMCIA_3C589=m
CONFIG_PCMCIA_3C574=m
CONFIG_PCMCIA_FMVJ18X=m
CONFIG_PCMCIA_PCNET=m
CONFIG_PCMCIA_NMCLAN=m
CONFIG_PCMCIA_SMC91C92=m
CONFIG_PCMCIA_XIRC2PS=m
# CONFIG_PCMCIA_AXNET is not set
# PCMCIA character devices


Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 15 for device 00:11.0
irq 15: nobody cared!
Call Trace:
 [<c010a8fb>] handle_IRQ_event+0x7b/0xf0
 [<c010ab39>] do_IRQ+0xa9/0x150
 [<c01093a8>] common_interrupt+0x18/0x20
 [<c01a4355>] pci_bus_write_config_word+0x55/0x70
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a1eeb1>] yenta_probe_irq+0xb1/0x120 [yenta_socket]
 [<c6a1ed60>] yenta_interrupt+0x0/0x60 [yenta_socket]
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a1ef49>] yenta_get_socket_capabilities+0x29/0x50 [yenta_socket]
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a1fa6e>] yenta_open+0x12e/0x180 [yenta_socket]
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a20ff4>] +0x94/0x840 [yenta_socket]
 [<c6a1e316>] add_pci_socket+0xa6/0xe0 [yenta_socket]
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a20bc0>] pci_cardbus_driver+0x0/0xa0 [yenta_socket]
 [<c6a1e391>] cardbus_probe+0x31/0x40 [yenta_socket]
 [<c6a20e40>] yenta_operations+0x0/0x40 [yenta_socket]
 [<c01a7555>] pci_device_probe+0x45/0x60
 [<c6a20b80>] cardbus_table+0x0/0x40 [yenta_socket]
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c01cf675>] bus_match+0x35/0x60
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c01cf768>] driver_attach+0x58/0x60
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c6a20c10>] pci_cardbus_driver+0x50/0xa0 [yenta_socket]
 [<c01cf9f6>] bus_add_driver+0x96/0xb0
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c6a20e80>] +0x0/0xe0 [yenta_socket]
 [<c01cfe1f>] driver_register+0x2f/0x40
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c01a765e>] pci_register_driver+0x3e/0x50
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c6a1200d>] +0xd/0x11 [yenta_socket]
 [<c6a20bc0>] pci_cardbus_driver+0x0/0xa0 [yenta_socket]
 [<c012f015>] sys_init_module+0x135/0x280
 [<c0109187>] syscall_call+0x7/0xb

handlers:
[<c6a1ed60>] (yenta_interrupt+0x0/0x60 [yenta_socket])
irq 15: nobody cared!
Call Trace:
 [<c010a8fb>] handle_IRQ_event+0x7b/0xf0
 [<c010ab39>] do_IRQ+0xa9/0x150
 [<c01093a8>] common_interrupt+0x18/0x20
 [<c011e827>] do_softirq+0x47/0xb0
 [<c010abb5>] do_IRQ+0x125/0x150
 [<c01093a8>] common_interrupt+0x18/0x20
 [<c01a4355>] pci_bus_write_config_word+0x55/0x70
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a1eeb1>] yenta_probe_irq+0xb1/0x120 [yenta_socket]
 [<c6a1ed60>] yenta_interrupt+0x0/0x60 [yenta_socket]
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a1ef49>] yenta_get_socket_capabilities+0x29/0x50 [yenta_socket]
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a1fa6e>] yenta_open+0x12e/0x180 [yenta_socket]
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a20ff4>] +0x94/0x840 [yenta_socket]
 [<c6a1e316>] add_pci_socket+0xa6/0xe0 [yenta_socket]
 [<c6a20f60>] +0x0/0x840 [yenta_socket]
 [<c6a20bc0>] pci_cardbus_driver+0x0/0xa0 [yenta_socket]
 [<c6a1e391>] cardbus_probe+0x31/0x40 [yenta_socket]
 [<c6a20e40>] yenta_operations+0x0/0x40 [yenta_socket]
 [<c01a7555>] pci_device_probe+0x45/0x60
 [<c6a20b80>] cardbus_table+0x0/0x40 [yenta_socket]
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c01cf675>] bus_match+0x35/0x60
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c01cf768>] driver_attach+0x58/0x60
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c6a20c10>] pci_cardbus_driver+0x50/0xa0 [yenta_socket]
 [<c01cf9f6>] bus_add_driver+0x96/0xb0
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c6a20e80>] +0x0/0xe0 [yenta_socket]
 [<c01cfe1f>] driver_register+0x2f/0x40
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c01a765e>] pci_register_driver+0x3e/0x50
 [<c6a20be8>] pci_cardbus_driver+0x28/0xa0 [yenta_socket]
 [<c6a1200d>] +0xd/0x11 [yenta_socket]
 [<c6a20bc0>] pci_cardbus_driver+0x0/0xa0 [yenta_socket]
 [<c012f015>] sys_init_module+0x135/0x280
 [<c0109187>] syscall_call+0x7/0xb

