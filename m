Return-Path: <linux-kernel-owner+willy=40w.ods.org-S446062AbUKBHQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S446062AbUKBHQp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 02:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S289046AbUKBHQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 02:16:45 -0500
Received: from wasp.net.au ([203.190.192.17]:433 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S446179AbUKBHP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 02:15:59 -0500
Message-ID: <41873452.8040804@wasp.net.au>
Date: Tue, 02 Nov 2004 11:16:34 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.8+ (X11/20041029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.6.10-rc1-bk page allocation failure. order:2, mode:0x20
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day all,

I'm still getting quite a lot of these come up in the logs when the system is under mild load.
I suspect it might have something to do with running an MTU of 9000 on the main ethernet port which 
is directly feeding a workstation with an NFS root (and thus gets quite a high load at times)

It's not so much an issue but it does cause the workstation to stall for up to a second while it 
waits for data every time it occurs.

The loaded ethernet port is this one on an PCI card

0000:00:0d.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 
10/100/1000Base-T Adapter (rev 12)

This started rearing its ugly head when I moved from 2.6.5 to 2.6.9-preX and persists with BK as of 
about 2 days ago.

Regards,
Brad

srv:/home/brad# uname -a
Linux srv 2.6.10-rc1 #2 Sun Oct 31 10:56:30 GST 2004 i686 GNU/Linux

srv:/home/brad# free
              total       used       free     shared    buffers     cached
Mem:        514676     251088     263588          0      13280     156328
-/+ buffers/cache:      81480     433196
Swap:       987988        284     987704

srv:/home/brad# lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
0000:00:0b.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
0000:00:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
0000:00:0d.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 
10/100/1000Base-T Adapter (rev 12)
0000:00:0e.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
0000:00:13.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 315PRO PCI/AGP VGA Display 
Adapter

srv:/home/brad# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0E:A6:41:45:94
           inet addr:192.168.3.82  Bcast:192.168.3.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
           Interrupt:18 Memory:de800000-0

eth1      Link encap:Ethernet  HWaddr 00:04:E2:8E:1E:AD
           inet addr:192.168.2.82  Bcast:192.168.2.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:9000  Metric:1
           RX packets:5207091 errors:430 dropped:430 overruns:0 frame:0
           TX packets:4805338 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:322428903 (307.4 MiB)  TX bytes:2838601552 (2.6 GiB)
           Interrupt:16 Memory:dc800000-0

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:138 errors:0 dropped:0 overruns:0 frame:0
           TX packets:138 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:9378 (9.1 KiB)  TX bytes:9378 (9.1 KiB)


srv:/home/brad# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/hda1              19G  9.4G  8.1G  54% /
tmpfs                 252M     0  252M   0% /dev/shm
/dev/hda3             165G   38G  119G  24% /raid0
/dev/md0              2.1T  2.1T   12G 100% /raid
/dev/md2              459G  315G  145G  69% /raid2

swapper: page allocation failure. order:2, mode:0x20
  [<c0138a98>] __alloc_pages+0x1c8/0x390
  [<c0138c7f>] __get_free_pages+0x1f/0x40
  [<c013c18d>] kmem_getpages+0x1d/0xb0
  [<c013ce26>] cache_grow+0xb6/0x170
  [<c013d03e>] cache_alloc_refill+0x15e/0x220
  [<c013d400>] __kmalloc+0x80/0xa0
  [<c02e61e7>] alloc_skb+0x47/0xe0
  [<e08bc871>] FillRxDescriptor+0x31/0xc0 [sk98lin]
  [<e08bc824>] FillRxRing+0x54/0x70 [sk98lin]
  [<e08bb89a>] SkGeIsrOnePort+0x17a/0x190 [sk98lin]
  [<c0132b24>] handle_IRQ_event+0x34/0x70
  [<c0132c42>] __do_IRQ+0xe2/0x160
  [<c0106666>] do_IRQ+0x26/0x40
  [<c0104aa8>] common_interrupt+0x18/0x20
  [<c0101fb0>] default_idle+0x0/0x30
  [<c0101fd3>] default_idle+0x23/0x30
  [<c010204a>] cpu_idle+0x3a/0x60
  [<c047e7c2>] start_kernel+0x142/0x160
  [<c047e3b0>] unknown_bootoption+0x0/0x1b0
syslogd: page allocation failure. order:2, mode:0x20
  [<c0138a98>] __alloc_pages+0x1c8/0x390
  [<c0138c7f>] __get_free_pages+0x1f/0x40
  [<c013c18d>] kmem_getpages+0x1d/0xb0
  [<c013ce26>] cache_grow+0xb6/0x170
  [<c013d03e>] cache_alloc_refill+0x15e/0x220
  [<c013d400>] __kmalloc+0x80/0xa0
  [<c02e61e7>] alloc_skb+0x47/0xe0
  [<e08bc871>] FillRxDescriptor+0x31/0xc0 [sk98lin]
  [<e08bc824>] FillRxRing+0x54/0x70 [sk98lin]
  [<e08bb89a>] SkGeIsrOnePort+0x17a/0x190 [sk98lin]
  [<c0132b24>] handle_IRQ_event+0x34/0x70
  [<c0132c42>] __do_IRQ+0xe2/0x160
  [<c0106666>] do_IRQ+0x26/0x40
  [<c0104aa8>] common_interrupt+0x18/0x20
syslogd: page allocation failure. order:2, mode:0x20
  [<c0138a98>] __alloc_pages+0x1c8/0x390
  [<c0104e15>] show_trace+0x35/0x90
  [<c0138c7f>] __get_free_pages+0x1f/0x40
  [<c013c18d>] kmem_getpages+0x1d/0xb0
  [<c013ce26>] cache_grow+0xb6/0x170
  [<c013d03e>] cache_alloc_refill+0x15e/0x220
  [<c0138c7f>] __get_free_pages+0x1f/0x40
  [<c013d400>] __kmalloc+0x80/0xa0
  [<c02e61e7>] alloc_skb+0x47/0xe0
  [<e08bc871>] FillRxDescriptor+0x31/0xc0 [sk98lin]
  [<e08bc824>] FillRxRing+0x54/0x70 [sk98lin]
  [<e08c0584>] SkDrvEvent+0xa44/0xaa0 [sk98lin]
  [<e08cd953>] SkGeSirqIsr+0x1d3/0x890 [sk98lin]
  [<e08d06e4>] SkEventDispatcher+0xc4/0x160 [sk98lin]
  [<e08bb7cc>] SkGeIsrOnePort+0xac/0x190 [sk98lin]
  [<c0132b24>] handle_IRQ_event+0x34/0x70
  [<c0132c42>] __do_IRQ+0xe2/0x160
  [<c0106666>] do_IRQ+0x26/0x40
  [<c0104aa8>] common_interrupt+0x18/0x20

