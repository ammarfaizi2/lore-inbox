Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbTELSQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbTELSQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:16:50 -0400
Received: from palrel10.hp.com ([156.153.255.245]:13219 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262547AbTELSQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:16:04 -0400
Date: Mon, 12 May 2003 11:28:40 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       David Gibson <hermes@gibson.dropbear.id.au>,
       Benjamin Reed <breed@almaden.ibm.com>,
       Javier Achirica <achirica@ttd.net>
Subject: New irq stuff on airo/hermes + SMP
Message-ID: <20030512182840.GC24830@bougret.hpl.hp.com>
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

	2.5.69-bk7, SMP. Just a few pings on ad-hoc mode...

airo:  Probing for PCI adapters
airo:  Finished probing for PCI adapters
airo: Doing fast bap_reads
airo: MAC enabled eth0 0:7:e:b8:d4:9f
eth0: index 0x05: Vcc 5.0, Vpp 5.0, irq 5, io 0x0100-0x013f
irq 5: nobody cared!
Call Trace:
 [<c010a998>] handle_IRQ_event+0x94/0xf8
 [<c010aba6>] do_IRQ+0x96/0x100
 [<c0109570>] common_interrupt+0x18/0x20
 [<cc838ea0>] socket+0x0/0x1a0 [i82365]
 [<cc837163>] pcic_set_socket+0x3f/0x50 [i82365]
 [<cc837265>] pcic_init+0x51/0x90 [i82365]
 [<cc862670>] dead_socket+0x0/0xc [pcmcia_core]
 [<cc838ec4>] socket+0x24/0x1a0 [i82365]
 [<cc859051>] init_socket+0x29/0x30 [pcmcia_core]
 [<cc85938e>] shutdown_socket+0x12/0xd8 [pcmcia_core]
 [<cc838ec4>] socket+0x24/0x1a0 [i82365]
 [<cc859717>] do_shutdown+0x57/0x5c [pcmcia_core]
 [<cc859756>] parse_events+0x3a/0xd8 [pcmcia_core]
 [<cc836465>] pcic_bh+0x5d/0x74 [i82365]
 [<cc8390c4>] pcic_task+0x4/0x40 [i82365]
 [<c01273ce>] worker_thread+0x1c2/0x290
 [<c012720c>] worker_thread+0x0/0x290
 [<cc836408>] pcic_bh+0x0/0x74 [i82365]
 [<c01170bc>] default_wake_function+0x0/0x1c
 [<c01170bc>] default_wake_function+0x0/0x1c
 [<c0106f51>] kernel_thread_helper+0x5/0xc

handlers:
[<cc876584>] (airo_interrupt+0x0/0x7b4 [airo])


hermes.c: 4 Jul 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13a (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth0: Station identity 001f:0001:0007:001c
eth0: Looks like a Lucent/Agere firmware version 7.28
eth0: Ad-hoc demo mode supported
eth0: IEEE standard IBSS ad-hoc mode supported
eth0: WEP supported, 104-bit key
eth0: MAC address 00:60:1D:F0:3A:8A
eth0: Station name "HERMES I"
eth0: ready
eth0: index 0x01: Vcc 5.0, irq 5, io 0x0100-0x013f
eth0: New link status: Connected (0001)
orinoco_lock() called with hw_unavailable (dev=cb6ca800)
irq 5: nobody cared!
Call Trace:
 [<c010a998>] handle_IRQ_event+0x94/0xf8
 [<c010aba6>] do_IRQ+0x96/0x100
 [<c0106d70>] default_idle+0x0/0x34
 [<c0105000>] _stext+0x0/0x48
 [<c0109570>] common_interrupt+0x18/0x20
 [<c0106d70>] default_idle+0x0/0x34
 [<c0105000>] _stext+0x0/0x48
 [<c0106d9c>] default_idle+0x2c/0x34
 [<c0106e23>] cpu_idle+0x37/0x48
 [<c0105045>] _stext+0x45/0x48
 [<c030c738>] start_kernel+0x13c/0x144

handlers:
[<cc877074>] (orinoco_interrupt+0x0/0x25c [orinoco])
orinoco_lock() called with hw_unavailable (dev=cb6ca800)


cat /proc/interrupts 
           CPU0       CPU1       
  0:     704444     235801    IO-APIC-edge  timer
  1:        141         27    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:        124        100    IO-APIC-edge  serial
  5:         27         36    IO-APIC-edge  orinoco_cs
  7:          0          3    IO-APIC-edge  WaveLAN
  8:          0          3    IO-APIC-edge  rtc
  9:       2285       1632    IO-APIC-edge  aic7xxx
 10:      36095      11994    IO-APIC-edge  HP J2585B
 12:         56         38    IO-APIC-edge  i8042
NMI:          0          0 
LOC:     939094     940480 
ERR:          0
MIS:          0


	Have fun...

	Jean
