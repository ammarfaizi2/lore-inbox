Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTEMNpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbTEMNpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:45:31 -0400
Received: from kiruna.synopsys.com ([204.176.20.18]:16605 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP id S261222AbTEMNpZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:45:25 -0400
Date: Tue, 13 May 2003 15:57:59 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: David Hinds <dahinds@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.69+bk: "sleeping function called from illegal context" on card release while shutting down
Message-ID: <20030513135759.GG32559@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Just tried to eject the card while the system was shutting down.

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

$ lspci |grep CardBus
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


Hw. address read/write mismap 0
Hw. address read/write mismap 1
Hw. address read/write mismap 2
Hw. address read/write mismap 3
Hw. address read/write mismap 4
Hw. address read/write mismap 5
Debug: sleeping function called from illegal context at include/asm/semaphore.h:119
Call Trace:
 [<c0118bc8>] __might_sleep+0x58/0x70
 [<c6a31eb6>] +0x82/0x58c [pcmcia_core]
 [<c6a2d193>] undo_irq+0x23/0x90 [pcmcia_core]
 [<c6a31eb6>] +0x82/0x58c [pcmcia_core]
 [<c6a302f8>] pcmcia_release_irq+0xb8/0xe0 [pcmcia_core]
 [<c6a25e00>] pcnet_release+0x0/0x80 [pcnet_cs]
 [<c6a312d5>] CardServices+0x155/0x260 [pcmcia_core]
 [<c6a312c9>] CardServices+0x149/0x260 [pcmcia_core]
 [<c6a25e56>] pcnet_release+0x56/0x80 [pcnet_cs]
 [<c01224a4>] run_timer_softirq+0xc4/0x1a0
 [<c010a8b3>] handle_IRQ_event+0x33/0xf0
 [<c011e889>] do_softirq+0xa9/0xb0
 [<c010abb5>] do_IRQ+0x125/0x150
 [<c01093a8>] common_interrupt+0x18/0x20
 [<c01a3dba>] strnlen_user+0x1a/0x40
 [<c016fd42>] create_elf_tables+0x2d2/0x360
 [<c01706cd>] load_elf_binary+0x4cd/0xba0
 [<c0134379>] buffered_rmqueue+0xc9/0x160
 [<c0170200>] load_elf_binary+0x0/0xba0
 [<c015639b>] search_binary_handler+0xcb/0x2d0
 [<c01566f9>] do_execve+0x159/0x1a0
 [<c0157d28>] getname+0x78/0xc0
 [<c0107a46>] sys_execve+0x36/0x70
 [<c0109187>] syscall_call+0x7/0xb

