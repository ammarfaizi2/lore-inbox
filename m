Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWAZMnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWAZMnR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 07:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWAZMnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 07:43:17 -0500
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:24300
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S1751334AbWAZMnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 07:43:17 -0500
Date: Thu, 26 Jan 2006 13:42:50 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RT] kgameportd/633 changed soft IRQ-flags.
Message-ID: <20060126124250.GA11512@titan.lahn.de>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ingo,Thomas!

While trying 2.6.15-rt15 I got the following warning, which you might be
interested in. If you need more information, please feel free to contact
me,

Linux version 2.6.15.1-rt15 (root@titan) (gcc version 4.0.3 20060115 (prerelease) (Debian 4.0.2-7)) #1 SMP PREEMPT Tue Jan 24 23:26:28 CET 2006
...
CPU0: Intel Pentium III (Katmai) stepping 03
CPU1: Intel Pentium III (Katmai) stepping 03
...
isapnp: Scanning for PnP cards...
pnp: SB audio device quirk - increasing port range
pnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB32 PnP'
isapnp: 1 Plug & Play card detected total
...
pnp: Device 01:01.03 activated.
gameport: NS558 PnP Gameport is pnp01:01.03/gameport0, io 0x200, speed 727kHz
WARNING: kgameportd/633 changed soft IRQ-flags.
 [<c010388e>] dump_stack+0x15/0x17 (12)
 [<c01321a4>] illegal_API_call+0x3c/0x41 (20)
 [<c013224b>] __local_irq_save+0x2b/0x2d (8)
 [<e08d8735>] analog_calibrate_timer+0x19/0x192 [analog] (40)
 [<e08d8f8b>] analog_init_port+0x31/0x224 [analog] (40)
 [<e08d91b6>] analog_connect+0x38/0xfd [analog] (36)
 [<e08d1c56>] gameport_driver_probe+0x1a/0x2b [gameport] (12)
 [<c022c87d>] driver_probe_device+0x35/0x82 (20)
 [<c022c94f>] __driver_attach+0x29/0x37 (20)
 [<c022c16e>] bus_for_each_dev+0x36/0x5b (32)
 [<c022c971>] driver_attach+0x14/0x17 (12)
 [<c022c4e6>] bus_add_driver+0x66/0xb0 (24)
 [<c022cc44>] driver_register+0x49/0x50 (20)
 [<e08d15db>] gameport_handle_event+0x5f/0x7a [gameport] (12)
 [<e08d16b5>] gameport_thread+0xc/0xc6 [gameport] (32)
 [<c012ad91>] kthread+0x77/0xa4 (32)
 [<c0100fe5>] kernel_thread_helper+0x5/0xb (560652316)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (kgameportd/633 [df0847e0, 111]):
------------------------------

#001:             [e08d3764] {gameport_sem.lock}
... acquired at:               gameport_handle_event+0xe/0x7a [gameport]

#002:             [defc12f8] {(struct semaphore *)(&dev->sem)}
... acquired at:               __driver_attach+0x17/0x37

input: Analog 3-axis 4-button joystick as /class/input/input2

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
