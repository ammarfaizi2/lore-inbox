Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266803AbUF3Rhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266803AbUF3Rhc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266788AbUF3Rg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:36:59 -0400
Received: from lucidpixels.com ([66.45.37.187]:13447 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S266779AbUF3Rer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:34:47 -0400
Date: Wed, 30 Jun 2004 13:34:43 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>
cc: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
       linux-kernel@vger.kernel.org
Subject: RE: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page
 Allocation Failures
In-Reply-To: <468F3FDA28AA87429AD807992E22D07E019ADF87@orsmsx408>
Message-ID: <Pine.LNX.4.60.0406301334060.21480@p500>
References: <468F3FDA28AA87429AD807992E22D07E019ADF87@orsmsx408>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The controller in P4 box:

02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet 
Controller (LOM)
         Subsystem: ABIT Computer Corp.: Unknown device 1014
         Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 18
         Memory at fc000000 (32-bit, non-prefetchable) [size=128K]
         I/O ports at b000 [size=32]
         Capabilities: <available only to root>

The controller in P3 box:

02:09.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet 
Controller
         Subsystem: Intel Corp.: Unknown device 1113
         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
         Memory at fafe0000 (32-bit, non-prefetchable) [size=128K]
         Memory at fafc0000 (32-bit, non-prefetchable) [size=128K]
         I/O ports at dcc0 [size=64]
         Expansion ROM at fb000000 [disabled] [size=128K]
         Capabilities: <available only to root>


On Wed, 30 Jun 2004, Venkatesan, Ganesh wrote:

> Justin:
>
> Could you also send me your kernel configuration
> (/usr/src/linux-2.6.7/.config) file?
>
> Thanks,
> ganesh
>
> -------------------------------------------------
> Ganesh Venkatesan
> Network/Storage Division, Hillsboro, OR
>
> -----Original Message-----
> From: Justin Piszcz [mailto:jpiszcz@lucidpixels.com]
> Sent: Saturday, June 26, 2004 1:57 AM
> To: Venkatesan, Ganesh
> Cc: Piszcz, Justin Michael; linux-kernel@vger.kernel.org
> Subject: RE: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page
> Allocation Failures
>
> Also under 2.6.7 on the other box now (did not do it w/2.4)
>
> When I try to copy a file, I get page allocation failures all over the
> place:
>
> printk: 11 messages suppressed.
> bzip2: page allocation failure. order:3, mode:0x20
>  [<c0137a8b>] __alloc_pages+0x2eb/0x300
>  [<c0137ab8>] __get_free_pages+0x18/0x40
>  [<c013b27f>] kmem_getpages+0x1f/0xc0
>  [<c013be7a>] cache_grow+0xba/0x250
>  [<c013c1db>] cache_alloc_refill+0x1cb/0x210
>  [<c037f140>] ip_rcv_finish+0x0/0x260
>  [<c013c741>] __kmalloc+0x71/0x80
>  [<c0366633>] alloc_skb+0x53/0x100
>  [<c02fc495>] e1000_alloc_rx_buffers+0x65/0x100
>  [<c02fc157>] e1000_clean_rx_irq+0x197/0x470
>  [<c037f02e>] ip_rcv+0x37e/0x490
>  [<c02fbd3d>] e1000_clean+0x4d/0xf0
>  [<c036b9da>] net_rx_action+0x6a/0xf0
>  [<c011dbb1>] __do_softirq+0x41/0x90
>  [<c011dc27>] do_softirq+0x27/0x30
>  [<c01084dd>] do_IRQ+0x10d/0x130
>  [<c0106658>] common_interrupt+0x18/0x20
>
> printk: 1542 messages suppressed.
> bzip2: page allocation failure. order:3, mode:0x20
>  [<c0137a8b>] __alloc_pages+0x2eb/0x300
>  [<c0137ab8>] __get_free_pages+0x18/0x40
>  [<c013b27f>] kmem_getpages+0x1f/0xc0
>  [<c013be7a>] cache_grow+0xba/0x250
>  [<c013c1db>] cache_alloc_refill+0x1cb/0x210
>  [<c0106658>] common_interrupt+0x18/0x20
>  [<c013c741>] __kmalloc+0x71/0x80
>  [<c0366633>] alloc_skb+0x53/0x100
>  [<c02fc495>] e1000_alloc_rx_buffers+0x65/0x100
>  [<c02fc157>] e1000_clean_rx_irq+0x197/0x470
>  [<c02fbd3d>] e1000_clean+0x4d/0xf0
>  [<c036b9da>] net_rx_action+0x6a/0xf0
>  [<c011dbb1>] __do_softirq+0x41/0x90
>  [<c011dc27>] do_softirq+0x27/0x30
>  [<c01084dd>] do_IRQ+0x10d/0x130
>  [<c0106658>] common_interrupt+0x18/0x20
>
> printk: 757 messages suppressed.
> bzip2: page allocation failure. order:3, mode:0x20
>  [<c0137a8b>] __alloc_pages+0x2eb/0x300
>  [<c0137ab8>] __get_free_pages+0x18/0x40
>  [<c013b27f>] kmem_getpages+0x1f/0xc0
>  [<c013be7a>] cache_grow+0xba/0x250
>  [<c013c1db>] cache_alloc_refill+0x1cb/0x210
>  [<c037f140>] ip_rcv_finish+0x0/0x260
>  [<c013c741>] __kmalloc+0x71/0x80
>  [<c0366633>] alloc_skb+0x53/0x100
>  [<c02fc495>] e1000_alloc_rx_buffers+0x65/0x100
>  [<c02fc157>] e1000_clean_rx_irq+0x197/0x470
>  [<c037f02e>] ip_rcv+0x37e/0x490
>  [<c02fbd3d>] e1000_clean+0x4d/0xf0
>  [<c036b9da>] net_rx_action+0x6a/0xf0
>  [<c011dbb1>] __do_softirq+0x41/0x90
>  [<c011dc27>] do_softirq+0x27/0x30
>  [<c01084dd>] do_IRQ+0x10d/0x130
>  [<c0106658>] common_interrupt+0x18/0x20
>
> printk: 584 messages suppressed.
> lftp: page allocation failure. order:3, mode:0x20
>  [<c0137a8b>] __alloc_pages+0x2eb/0x300
>  [<c0137ab8>] __get_free_pages+0x18/0x40
>  [<c013b27f>] kmem_getpages+0x1f/0xc0
>  [<c013be7a>] cache_grow+0xba/0x250
>  [<c013c1db>] cache_alloc_refill+0x1cb/0x210
>  [<c037f140>] ip_rcv_finish+0x0/0x260
>  [<c013c741>] __kmalloc+0x71/0x80
>  [<c0366633>] alloc_skb+0x53/0x100
>  [<c02fc495>] e1000_alloc_rx_buffers+0x65/0x100
>  [<c02fc157>] e1000_clean_rx_irq+0x197/0x470
>  [<c0116a20>] default_wake_function+0x0/0x20
>  [<c02fbd3d>] e1000_clean+0x4d/0xf0
>  [<c036b9da>] net_rx_action+0x6a/0xf0
>  [<c011dbb1>] __do_softirq+0x41/0x90
>  [<c011dc27>] do_softirq+0x27/0x30
>  [<c01084dd>] do_IRQ+0x10d/0x130
>  [<c0106658>] common_interrupt+0x18/0x20
>
>
>
>
> On Fri, 25 Jun 2004, Venkatesan, Ganesh wrote:
>
>> Could you send me details on your machine (processor, motherboard,
>> memory size, etc.)?
>>
>> Thanks,
>> ganesh
>>
>> -------------------------------------------------
>> Ganesh Venkatesan
>> Network/Storage Division, Hillsboro, OR
>>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org
>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Piszcz,
> Justin
>> Michael
>> Sent: Monday, June 14, 2004 5:03 AM
>> To: Justin Piszcz; linux-kernel@vger.kernel.org
>> Subject: RE: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC -
> Page
>> Allocation Failures
>>
>> Anyone have any suggestions on how to fix this?
>>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org
>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Justin Piszcz
>> Sent: Saturday, June 12, 2004 4:44 AM
>> To: linux-kernel@vger.kernel.org
>> Subject: 2.6.5 Does Not Handle Jumbo Frames w/Intel GigE NIC - Page
>> Allocation Failures
>>
>> When I run: ifconfig eth0 mtu 9000
>>
>> Also, I tried to copy a file from 2.6.5 -> 2.4.26 (over NFS) and it
> did
>> not copy, although I saw my hard disk reading @ 35-40MB/s until it was
>> "ready to copy?" but it never sent any packets over the network.
>>
>> On kernel: 2.4.26 I get no errors.
>> On kernel: 2.6.5 I get a lot of errors, they are:
>>
>> Kernel 2.4.26 Intel Card:
>>
>> 00:0d.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet
>> Controller
>>         Subsystem: Intel Corp.: Unknown device 1113
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
>> ParErr- Stepping- SERR+ FastB2B-
>>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>>> TAbort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 64 (63750ns min), cache line size 08
>>         Interrupt: pin A routed to IRQ 10
>>         Region 0: Memory at ff040000 (32-bit, non-prefetchable)
>> [size=128K]
>>         Region 1: Memory at ff020000 (32-bit, non-prefetchable)
>> [size=128K]
>>         Region 2: I/O ports at cc80 [size=64]
>>         Expansion ROM at f9000000 [disabled] [size=128K]
>>         Capabilities: [dc] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>>         Capabilities: [e4] PCI-X non-bridge device.
>>                 Command: DPERE- ERO+ RBC=0 OST=0
>>                 Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-,
>> DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0]
>> Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
>>                 Address: 0000000000000000  Data: 0000
>>
>>  Kernel 2.6.5 Intel Card:
>>
>> 02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet
>> Controller (LOM)
>>         Subsystem: ABIT Computer Corp.: Unknown device 1014
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>> ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium
>>> TAbort-
>> <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0 (63750ns min), cache line size 08
>>         Interrupt: pin A routed to IRQ 18
>>         Region 0: Memory at fc000000 (32-bit, non-prefetchable)
>> [size=128K]
>>         Region 2: I/O ports at a000 [size=32]
>>         Capabilities: [dc] Power Management version 2
>>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>                 Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>>
>> $ dmesg
>> ages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c011a906>] recalc_task_prio+0xdf/0x1c9
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 53 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 165 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c011a906>] recalc_task_prio+0xdf/0x1c9
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 94 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c011c8c6>] __wake_up_common+0x38/0x57
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 95 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<f8e34b00>] nv_unlock_rm+0x45/0x46 [nvidia]
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 68 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 41 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 30 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 46 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c011a906>] recalc_task_prio+0xdf/0x1c9
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 33 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c011c8c6>] __wake_up_common+0x38/0x57
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> printk: 136 messages suppressed.
>> swapper: page allocation failure. order:3, mode:0x20
>> Call Trace:
>>  [<c01401b5>] __alloc_pages+0x30d/0x311
>>  [<c01401d4>] __get_free_pages+0x1b/0x31
>>  [<c011c8c6>] __wake_up_common+0x38/0x57
>>  [<c01429b3>] cache_alloc_refill+0x308/0x62d
>>  [<c014265b>] __kmalloc+0x6a/0x6c
>>  [<c0303291>] alloc_skb+0x53/0xfc
>>  [<c027825d>] e1000_alloc_rx_buffers+0x55/0xf0
>>  [<c0279f1d>] e1000_clean+0x38a/0x7c0
>>  [<c02d5ed9>] atkbd_interrupt+0x365/0x569
>>  [<c02d9cb1>] serio_interrupt+0x7c/0xaf
>>  [<c030843e>] net_rx_action+0x77/0xf9
>>  [<c0125536>] do_softirq+0x6e/0xcd
>>  [<c0108da1>] do_IRQ+0x19a/0x206
>>  [<c01070b8>] common_interrupt+0x18/0x20
>>  [<c0104581>] default_idle+0x0/0x2c
>>  [<c01045aa>] default_idle+0x29/0x2c
>>  [<c010460e>] cpu_idle+0x2e/0x3c
>>  [<c04726c9>] start_kernel+0x371/0x3fb
>>  [<c04721a3>] unknown_bootoption+0x0/0x18e
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
>
>
