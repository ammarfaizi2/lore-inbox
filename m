Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288824AbSAEO27>; Sat, 5 Jan 2002 09:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288825AbSAEO2u>; Sat, 5 Jan 2002 09:28:50 -0500
Received: from mail.fido.net ([194.70.36.10]:45988 "EHLO
	monty.test.eng.fido.net") by vger.kernel.org with ESMTP
	id <S288823AbSAEO2h> convert rfc822-to-8bit; Sat, 5 Jan 2002 09:28:37 -0500
X-Header: FidoNet Virus Scanned
From: "Shaf [Mobile]" <shaf@shaf.net>
To: <linux-kernel@vger.kernel.org>, <linux-admin@vger.kernel.org>
Cc: <shaf.ali@orange.net>, <becker@beta.scyld.com>, <becker@scyld.com>,
        <jgarzik@mandrakesoft.com>
Subject: Correct ether= parameters for 8139too (RealTek 8139) ?
Date: Sat, 5 Jan 2002 14:28:34 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.1432.1
Message-ID: <auto-000001888701@monty.test.eng.fido.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
My apologies for the major spam here but this problem is really causing me havoc :)

Basically my machine has 2xIntel eepro onboard NICs and 1 RealTek 8139 PCI NIC.
My problem is that I am unable to force the RealTek Card register as a specific device namely eth2 - it always decides to register itself as eth0.


Let's take my previous configuration.
Kernel Version : 2.4.17
Let's assume that modules e100 have not been compiled (source Intel who so not support these drivers to be built into the kernel)

/etc/modules.conf

alias eth0 e100
alias eth1 e100
alias eth2 8139too

If for whatever reason eth0/1 do not come up eg unresolved symbol/module not installed… The RealTek (8139too) registers itself as eth0 regardless of what options I give eth2…. So I decided to compile 8139too into the kernel in order to parse ether= parameters to it via LILO.

Current Configuration
Kernel Version : 2.4.17 (with 8139too built in)

/etc/modules.conf

alias eth0 e100
alias eth1 e100
##alias eth2 8139too (not needed obviously)

No matter what ether= parameters I parse to the kernel at boot time the RealTek card is registered as eth0 :(
So I ended up trying to debug 8139too and recomped it.

Can anyone please indicate what the correct ether= parameters I should be parsing to the kernel in order to register the card to eth2 or even a hack for 8139too.c ?

Here's as much data as I can give you….
Many thanks in advance,
Shaf

>From 8139too.c
	Much code comes from Donald Becker's rtl8139.c driver,
	versions 1.13 and older.  This driver was originally based
	on rtl8139.c version 1.07.  Header of rtl8139.c version 1.13:
	
DPRINTK("about to register device named %s (%p)...\n", dev->name, dev);
	i = register_netdev (dev);

/proc/bus/pci/devices
0048	10ec8139	b	0000c001	dffcdf00	00000000	00000000	00000000	00000000	dffb0000	00000100	00000100	00000000	00000000	00000000	00000000	00010000	8139too

ifconfig -a

eth0      Link encap:Ethernet  HWaddr 00:50:BF:74:8D:BC  
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:11 Base address:0xaf00 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 
          RX bytes:560 (560.0 b)  TX bytes:560 (560.0 b)

/proc/pci

  Bus  0, device   9, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xc000 [0xc0ff].
      Non-prefetchable 32 bit memory at 0xdffcdf00 [0xdffcdfff].

/proc/ioports
c000-c0ff : Realtek Semiconductor Co., Ltd. RTL-8139
  c000-c0ff : 8139too

/proc/iomem
dffcdf00-dffcdfff : Realtek Semiconductor Co., Ltd. RTL-8139
  dffcdf00-dffcdfff : 8139too

dmesg
8139too Fast Ethernet driver 0.9.22
rtl8139_init_board: PIO region size == 0x100
rtl8139_init_board: MMIO region size == 0x100
rtl8139_init_board: chipset id (116) == index 5, 'RTL-8139C'
rtl8139_init_board: PCI PM wakeup
rtl8139_init_one: about to register device named eth%d (f7e7f800)...
Shaf :<6>eth0: RealTek RTL8139 Fast Ethernet at 0xf880af00, c02a93fa:00:c02a5426:50:c02a5426:bf, IRQ -1070967770
eth0:  Identified 8139 chip type 'RTL-8139C'




eth0:  Identified 8139 chip type 'RTL-8139C'




eth0:  Identified 8139 chip type 'RTL-8139C'








