Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUFXNQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUFXNQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUFXNQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:16:19 -0400
Received: from quack.nr.no ([156.116.3.157]:44200 "EHLO quack.nr.no")
	by vger.kernel.org with ESMTP id S264560AbUFXNOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:14:47 -0400
Date: Thu, 24 Jun 2004 15:14:41 +0200
From: =?iso-8859-1?B?UOVs?= Dahle <pal.dahle@nr.no>
To: linux-kernel@vger.kernel.org
Subject: Kernel freeze caused by tg3 driver?
Message-ID: <20040624131441.GA13640@mira.nr.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-NR-MailScanner-Information: This email was scanned for malicious content by Norwegian Computing Center
X-NR-MailScanner: Found to be clean
X-MailScanner-From: paal.dahle@nr.no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I have a Dell D600 laptop (see lspci output below) which is running 
an up-to-date Debian sid distribution. Since early June my machine 
has started to freeze. The freeze is total and I have to use the 
power button to get going again.

This problem started all of a sudden when I had been running kernel 
2.6.5 without problems since April. 

I have managed to track the freeze down to the tg3 driver. Here are
some info: 

- Freezes for all my kernels: 2.4.23, 2.6.3, 2.6.5, and 2.6.7

- Sometimes the machine freezes in cycles, that is, the machine freezes 
  for two seconds, then runs fine for 2 seconds, freezes again, and so 
  on, until it eventually locks up completely.

- I both use kernels where tg3 is compiled in and kernels where it is 
  compiled as a module. The last time I tried to insert the tg3 module 
  in the kernel using modprobe the kernel froze immediately.

My problems may be related to a partly defect network card, but this 
should not freeze the kernel, should it?  
   
Paal

Excerpts from kern.log:
-------------------------------------------------------------------------------------------

Jun 18 13:10:52 localhost kernel: tg3.c:v3.6 (June 12, 2004)
Jun 18 13:10:52 localhost kernel: eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:0b:db:dc:58:a5
Jun 18 13:10:52 localhost kernel: eth0: HostTXDS[1] RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
...
Jun 18 13:10:54 localhost kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Jun 18 13:10:54 localhost kernel: tg3: eth0: Flow control is on for TX and on for RX.
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=2c00 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=2000 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=3400 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=2400 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=2800 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=3000 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=1400 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=1800 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=c00 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=4800 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=1000 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=6400 enable_bit=2
Jun 18 13:14:18 localhost kernel: tg3: tg3_stop_block timed out, ofs=1c00 enable_bit=2
Jun 18 13:14:20 localhost kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Jun 18 13:14:20 localhost kernel: tg3: eth0: Flow control is on for TX and on for RX.

-------------------------------------------------------------------------------------------

Jun 22 11:55:34 localhost kernel: tg3.c:v3.6 (June 12, 2004)
Jun 22 11:55:34 localhost kernel: ACPI: No IRQ known for interrupt pin ? of device 0000:0
2:00.0 - using IRQ 11
Jun 22 11:55:34 localhost kernel: tg3: Cannot find PowerManagement capability, aborting.
Jun 22 11:55:34 localhost kernel: tg3: probe of 0000:02:00.0 failed with error -5

-------------------------------------------------------------------------------------------

Jun 23 09:14:40 localhost kernel: tg3.c:v3.6 (June 12, 2004)
Jun 23 09:14:40 localhost kernel: eth0: Tigon3 [partno(BCM95702A20) rev 1002 PHY(5703)] (PCI:33MHz:32-bit) 10/100/1000BaseT Ethernet 00:0b:db:dc:58:a5
Jun 23 09:14:40 localhost kernel: eth0: HostTXDS[1] RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
...
Jun 23 09:14:40 localhost kernel: kobject_register failed for tg3 (-17)
Jun 23 09:14:40 localhost kernel:  [c_show+269/301] kobject_register+0x57/0x59
Jun 23 09:14:40 localhost kernel:  [agp_intel_probe+598/1051] bus_add_driver+0x50/0xa3
Jun 23 09:14:40 localhost kernel:  [device_initialize+49/87] driver_register+0x2f/0x33
Jun 23 09:14:40 localhost kernel:  [pci_set_master+37/120] pci_register_driver+0x5c/0x84
Jun 23 09:14:40 localhost kernel:  [pg0+947130383/1068740608] tg3_init+0xf/0x1d [tg3]
Jun 23 09:14:40 localhost kernel:  [load_module+2348/2449] sys_init_module+0x117/0x22f
Jun 23 09:14:40 localhost kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
...
Jun 23 09:14:42 localhost kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Jun 23 09:14:42 localhost kernel: tg3: eth0: Flow control is on for TX and on for RX.

-------------------------------------------------------------------------------------------

lspci:

0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 01)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 81)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 01)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage Controller (rev 01)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 01)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01)
0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X Gigabit Ethernet (rev 02)
0000:02:01.0 CardBus bridge: O2 Micro, Inc. OZ711EC1 SmartCardBus Controller (rev 20)
0000:02:01.1 CardBus bridge: O2 Micro, Inc. OZ711EC1 SmartCardBus Controller (rev 20)
0000:03:00.0 Ethernet controller: 3Com Corporation: Unknown device 0013 (rev 01)
