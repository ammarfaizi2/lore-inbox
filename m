Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbTDQVs3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 17:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbTDQVs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 17:48:29 -0400
Received: from palrel10.hp.com ([156.153.255.245]:7578 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262633AbTDQVs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 17:48:26 -0400
Date: Thu, 17 Apr 2003 15:00:18 -0700
To: Dominik Brodowski <linux@brodo.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.67 + i82365 -> oops
Message-ID: <20030417220018.GA28383@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I've got troubles with 2.5.67 and an ISA Pcmcia bridge
(i82365). Half of the time, after boot, the card is recognised as
memory_cs (which is not compiled), where it should be airo_cs.
	When trying to restart the Pcmcia package (using the init
script), I got the nice oops below...

	Have a nice day...

	Jean

Apr 17 14:50:55 lagaffe cardmgr[307]: executing: 'modprobe -r memory_cs'
Apr 17 14:50:55 lagaffe cardmgr[307]: + FATAL: Module memory_cs not found.
Apr 17 14:50:55 lagaffe cardmgr[307]: modprobe exited with status 1
Apr 17 14:50:55 lagaffe cardmgr[307]: exiting
Apr 17 14:50:57 cs: IO port probe 0x0c00-0x0cff:lagaffe cardmgr[ clean.
1918]: watching cs: IO port probe 0x0800-0x08ff:2 sockets
 clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x220-0x22f 0x330-0x337 0x388-0x39f 0x3c0-0x3e7 0x3f0-0x3ff 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
Apr 17 14:50:57 lagaffe cardmgr[1919]: starting, version is 3.2.3
Apr 17 14:50:57 lagaffe cardmgr[1919]: socket 0: Anonymous Memory
Apr 17 14:50:57 lagaffe cardmgr[1919]: executing: 'modprobe memory_cs'
Apr 17 14:50:57 lagaffe cardmgr[1919]: + FATAL: Module memory_cs not found.
Apr 17 14:50:57 lagaffe cardmgr[1919]: modprobe exited with status 1
Apr 17 14:50:57 lagaffe cardmgr[1919]: module /lib/modules/2.5.67/pcmcia/memory_cs.o not available
Apr 17 14:50:57 lagaffe cardmgr[1919]: bind 'memory_cs' to socket 0 failed: Invalid argument
Unable to handle kernel NULL pointer dereference at virtual address 00000014
 printing eip:
c0180fae
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0180fae>]    Not tainted
EFLAGS: 00010256
EIP is at pci_remove_behind_bridge+0x6/0x38
eax: 00000000   ebx: cb60d000   ecx: cc838dc0   edx: 00000000
esi: 00000000   edi: cc838de4   ebp: 00000000   esp: cbf93f28
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 6, threadinfo=cbf92000 task=cbfa0670)
Stack: cb60d000 cb60d000 cc85bde9 00000000 cc859376 cb60d000 cb60d000 cb60d000 
       cb60d00c cb60d000 00000080 cc838de4 00000000 cc8596a7 cb60d000 00000003 
       cb60d000 cc8596e6 cb60d000 00000080 00000000 00000141 cc83646d cb60d000 
Call Trace:
 [<cc85bde9>] cb_free+0xd/0x14 [pcmcia_core]
 [<cc859376>] shutdown_socket+0x7a/0xe8 [pcmcia_core]
 [<cc838de4>] socket+0x24/0x1a0 [i82365]
 [<cc8596a7>] do_shutdown+0x57/0x5c [pcmcia_core]
 [<cc8596e6>] parse_events+0x3a/0xd8 [pcmcia_core]
 [<cc83646d>] pcic_bh+0x5d/0x74 [i82365]
 [<cc838fe4>] pcic_task+0x4/0x40 [i82365]
 [<c0126f04>] worker_thread+0x1bc/0x294
 [<c0126d48>] worker_thread+0x0/0x294
 [<cc836410>] pcic_bh+0x0/0x74 [i82365]
 [<c0116d8c>] default_wake_function+0x0/0x1c
 [<c0116d8c>] default_wake_function+0x0/0x1c
 [<c0106f51>] kernel_thread_helper+0x5/0xc

Code: 8b 46 14 85 c0 74 26 8b 50 14 83 c0 14 8b 1a 39 c2 74 1a 8d 

