Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUFNMDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUFNMDz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 08:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUFNMDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 08:03:55 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:2188 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262585AbUFNMDd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 08:03:33 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-18.tower-45.messagelabs.com!1087214610!3558633
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [141.156.156.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page Allocation Failures
Date: Mon, 14 Jun 2004 08:02:57 -0400
Message-ID: <2E314DE03538984BA5634F12115B3A4E2CF373@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page Allocation Failures
Thread-Index: AcRQWb+xKf+xG5AHQTGqm9R6TJEr3wBrcPoA
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone have any suggestions on how to fix this?

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Justin Piszcz
Sent: Saturday, June 12, 2004 4:44 AM
To: linux-kernel@vger.kernel.org
Subject: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page
Allocation Failures

When I run: ifconfig eth0 mtu 9000

Also, I tried to copy a file from 2.6.5 -> 2.4.26 (over NFS) and it did 
not copy, although I saw my hard disk reading @ 35-40MB/s until it was 
"ready to copy?" but it never sent any packets over the network.

On kernel: 2.4.26 I get no errors.
On kernel: 2.6.5 I get a lot of errors, they are:

Kernel 2.4.26 Intel Card:

00:0d.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet 
Controller
         Subsystem: Intel Corp.: Unknown device 1113
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (63750ns min), cache line size 08
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at ff040000 (32-bit, non-prefetchable) 
[size=128K]
         Region 1: Memory at ff020000 (32-bit, non-prefetchable) 
[size=128K]
         Region 2: I/O ports at cc80 [size=64]
         Expansion ROM at f9000000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
         Capabilities: [e4] PCI-X non-bridge device.
                 Command: DPERE- ERO+ RBC=0 OST=0
                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, 
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0] 
Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000

  Kernel 2.6.5 Intel Card:

02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet 
Controller (LOM)
         Subsystem: ABIT Computer Corp.: Unknown device 1014
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (63750ns min), cache line size 08
         Interrupt: pin A routed to IRQ 18
         Region 0: Memory at fc000000 (32-bit, non-prefetchable) 
[size=128K]
         Region 2: I/O ports at a000 [size=32]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-

$ dmesg
ages+0x1b/0x31
  [<c01429b3>] cache_alloc_refill+0x308/0x62d
  [<c014265b>] __kmalloc+0x6a/0x6c
  [<c0303291>] alloc_skb+0x53/0xfc
  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
  [<c0279f1d>] e1000_clean+0x38a/0x7c0
  [<c011a906>] recalc_task_prio+0xdf/0x1c9
  [<c030843e>] net_rx_action+0x77/0xf9
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0108da1>] do_IRQ+0x19a/0x206
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c0104581>] default_idle+0x0/0x2c
  [<c01045aa>] default_idle+0x29/0x2c
  [<c010460e>] cpu_idle+0x2e/0x3c
  [<c04726c9>] start_kernel+0x371/0x3fb
  [<c04721a3>] unknown_bootoption+0x0/0x18e

printk: 53 messages suppressed.
swapper: page allocation failure. order:3, mode:0x20
Call Trace:
  [<c01401b5>] __alloc_pages+0x30d/0x311
  [<c01401d4>] __get_free_pages+0x1b/0x31
  [<c01429b3>] cache_alloc_refill+0x308/0x62d
  [<c014265b>] __kmalloc+0x6a/0x6c
  [<c0303291>] alloc_skb+0x53/0xfc
  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
  [<c0279f1d>] e1000_clean+0x38a/0x7c0
  [<c030843e>] net_rx_action+0x77/0xf9
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0108da1>] do_IRQ+0x19a/0x206
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c0104581>] default_idle+0x0/0x2c
  [<c01045aa>] default_idle+0x29/0x2c
  [<c010460e>] cpu_idle+0x2e/0x3c
  [<c04726c9>] start_kernel+0x371/0x3fb
  [<c04721a3>] unknown_bootoption+0x0/0x18e

printk: 165 messages suppressed.
swapper: page allocation failure. order:3, mode:0x20
Call Trace:
  [<c01401b5>] __alloc_pages+0x30d/0x311
  [<c01401d4>] __get_free_pages+0x1b/0x31
  [<c01429b3>] cache_alloc_refill+0x308/0x62d
  [<c014265b>] __kmalloc+0x6a/0x6c
  [<c0303291>] alloc_skb+0x53/0xfc
  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
  [<c0279f1d>] e1000_clean+0x38a/0x7c0
  [<c011a906>] recalc_task_prio+0xdf/0x1c9
  [<c030843e>] net_rx_action+0x77/0xf9
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0108da1>] do_IRQ+0x19a/0x206
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c0104581>] default_idle+0x0/0x2c
  [<c01045aa>] default_idle+0x29/0x2c
  [<c010460e>] cpu_idle+0x2e/0x3c
  [<c04726c9>] start_kernel+0x371/0x3fb
  [<c04721a3>] unknown_bootoption+0x0/0x18e

printk: 94 messages suppressed.
swapper: page allocation failure. order:3, mode:0x20
Call Trace:
  [<c01401b5>] __alloc_pages+0x30d/0x311
  [<c01401d4>] __get_free_pages+0x1b/0x31
  [<c011c8c6>] __wake_up_common+0x38/0x57
  [<c01429b3>] cache_alloc_refill+0x308/0x62d
  [<c014265b>] __kmalloc+0x6a/0x6c
  [<c0303291>] alloc_skb+0x53/0xfc
  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
  [<c0279f1d>] e1000_clean+0x38a/0x7c0
  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
  [<c030843e>] net_rx_action+0x77/0xf9
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0108da1>] do_IRQ+0x19a/0x206
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c0104581>] default_idle+0x0/0x2c
  [<c01045aa>] default_idle+0x29/0x2c
  [<c010460e>] cpu_idle+0x2e/0x3c
  [<c04726c9>] start_kernel+0x371/0x3fb
  [<c04721a3>] unknown_bootoption+0x0/0x18e

printk: 95 messages suppressed.
swapper: page allocation failure. order:3, mode:0x20
Call Trace:
  [<c01401b5>] __alloc_pages+0x30d/0x311
  [<c01401d4>] __get_free_pages+0x1b/0x31
  [<c01429b3>] cache_alloc_refill+0x308/0x62d
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c014265b>] __kmalloc+0x6a/0x6c
  [<c0303291>] alloc_skb+0x53/0xfc
  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
  [<c0279f1d>] e1000_clean+0x38a/0x7c0
  [<f8e34b00>] nv_unlock_rm+0x45/0x46 [nvidia]
  [<c030843e>] net_rx_action+0x77/0xf9
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0108da1>] do_IRQ+0x19a/0x206
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c0104581>] default_idle+0x0/0x2c
  [<c01045aa>] default_idle+0x29/0x2c
  [<c010460e>] cpu_idle+0x2e/0x3c
  [<c04726c9>] start_kernel+0x371/0x3fb
  [<c04721a3>] unknown_bootoption+0x0/0x18e

printk: 68 messages suppressed.
swapper: page allocation failure. order:3, mode:0x20
Call Trace:
  [<c01401b5>] __alloc_pages+0x30d/0x311
  [<c01401d4>] __get_free_pages+0x1b/0x31
  [<c01429b3>] cache_alloc_refill+0x308/0x62d
  [<c014265b>] __kmalloc+0x6a/0x6c
  [<c0303291>] alloc_skb+0x53/0xfc
  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
  [<c0279f1d>] e1000_clean+0x38a/0x7c0
  [<c030843e>] net_rx_action+0x77/0xf9
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0108da1>] do_IRQ+0x19a/0x206
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c0104581>] default_idle+0x0/0x2c
  [<c01045aa>] default_idle+0x29/0x2c
  [<c010460e>] cpu_idle+0x2e/0x3c
  [<c04726c9>] start_kernel+0x371/0x3fb
  [<c04721a3>] unknown_bootoption+0x0/0x18e

printk: 41 messages suppressed.
swapper: page allocation failure. order:3, mode:0x20
Call Trace:
  [<c01401b5>] __alloc_pages+0x30d/0x311
  [<c01401d4>] __get_free_pages+0x1b/0x31
  [<c01429b3>] cache_alloc_refill+0x308/0x62d
  [<c014265b>] __kmalloc+0x6a/0x6c
  [<c0303291>] alloc_skb+0x53/0xfc
  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
  [<c0279f1d>] e1000_clean+0x38a/0x7c0
  [<c030843e>] net_rx_action+0x77/0xf9
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0108da1>] do_IRQ+0x19a/0x206
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c0104581>] default_idle+0x0/0x2c
  [<c01045aa>] default_idle+0x29/0x2c
  [<c010460e>] cpu_idle+0x2e/0x3c
  [<c04726c9>] start_kernel+0x371/0x3fb
  [<c04721a3>] unknown_bootoption+0x0/0x18e

printk: 30 messages suppressed.
swapper: page allocation failure. order:3, mode:0x20
Call Trace:
  [<c01401b5>] __alloc_pages+0x30d/0x311
  [<c01401d4>] __get_free_pages+0x1b/0x31
  [<c01429b3>] cache_alloc_refill+0x308/0x62d
  [<c014265b>] __kmalloc+0x6a/0x6c
  [<c0303291>] alloc_skb+0x53/0xfc
  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
  [<c0279f1d>] e1000_clean+0x38a/0x7c0
  [<c030843e>] net_rx_action+0x77/0xf9
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0108da1>] do_IRQ+0x19a/0x206
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c0104581>] default_idle+0x0/0x2c
  [<c01045aa>] default_idle+0x29/0x2c
  [<c010460e>] cpu_idle+0x2e/0x3c
  [<c04726c9>] start_kernel+0x371/0x3fb
  [<c04721a3>] unknown_bootoption+0x0/0x18e

printk: 46 messages suppressed.
swapper: page allocation failure. order:3, mode:0x20
Call Trace:
  [<c01401b5>] __alloc_pages+0x30d/0x311
  [<c01401d4>] __get_free_pages+0x1b/0x31
  [<c01429b3>] cache_alloc_refill+0x308/0x62d
  [<c014265b>] __kmalloc+0x6a/0x6c
  [<c0303291>] alloc_skb+0x53/0xfc
  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
  [<c0279f1d>] e1000_clean+0x38a/0x7c0
  [<c011a906>] recalc_task_prio+0xdf/0x1c9
  [<c030843e>] net_rx_action+0x77/0xf9
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0108da1>] do_IRQ+0x19a/0x206
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c0104581>] default_idle+0x0/0x2c
  [<c01045aa>] default_idle+0x29/0x2c
  [<c010460e>] cpu_idle+0x2e/0x3c
  [<c04726c9>] start_kernel+0x371/0x3fb
  [<c04721a3>] unknown_bootoption+0x0/0x18e

printk: 33 messages suppressed.
swapper: page allocation failure. order:3, mode:0x20
Call Trace:
  [<c01401b5>] __alloc_pages+0x30d/0x311
  [<c01401d4>] __get_free_pages+0x1b/0x31
  [<c011c8c6>] __wake_up_common+0x38/0x57
  [<c01429b3>] cache_alloc_refill+0x308/0x62d
  [<c014265b>] __kmalloc+0x6a/0x6c
  [<c0303291>] alloc_skb+0x53/0xfc
  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
  [<c0279f1d>] e1000_clean+0x38a/0x7c0
  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
  [<c030843e>] net_rx_action+0x77/0xf9
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0108da1>] do_IRQ+0x19a/0x206
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c0104581>] default_idle+0x0/0x2c
  [<c01045aa>] default_idle+0x29/0x2c
  [<c010460e>] cpu_idle+0x2e/0x3c
  [<c04726c9>] start_kernel+0x371/0x3fb
  [<c04721a3>] unknown_bootoption+0x0/0x18e

printk: 136 messages suppressed.
swapper: page allocation failure. order:3, mode:0x20
Call Trace:
  [<c01401b5>] __alloc_pages+0x30d/0x311
  [<c01401d4>] __get_free_pages+0x1b/0x31
  [<c011c8c6>] __wake_up_common+0x38/0x57
  [<c01429b3>] cache_alloc_refill+0x308/0x62d
  [<c014265b>] __kmalloc+0x6a/0x6c
  [<c0303291>] alloc_skb+0x53/0xfc
  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
  [<c0279f1d>] e1000_clean+0x38a/0x7c0
  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
  [<c02d9cb1>] serio_interrupt+0x7c/0xaf
  [<c030843e>] net_rx_action+0x77/0xf9
  [<c0125536>] do_softirq+0x6e/0xcd
  [<c0108da1>] do_IRQ+0x19a/0x206
  [<c01070b8>] common_interrupt+0x18/0x20
  [<c0104581>] default_idle+0x0/0x2c
  [<c01045aa>] default_idle+0x29/0x2c
  [<c010460e>] cpu_idle+0x2e/0x3c
  [<c04726c9>] start_kernel+0x371/0x3fb
  [<c04721a3>] unknown_bootoption+0x0/0x18e

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


