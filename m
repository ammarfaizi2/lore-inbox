Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUCBUpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 15:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbUCBUpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 15:45:24 -0500
Received: from imap.gmx.net ([213.165.64.20]:39602 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261712AbUCBUpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 15:45:20 -0500
X-Authenticated: #4512188
Message-ID: <4044F25E.3010802@gmx.de>
Date: Tue, 02 Mar 2004 21:45:18 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1-mm1, as scheduler causes higher idle temp?
References: <20040229140617.64645e80.akpm@osdl.org> <404367C2.3050109@gmx.de> <40448E60.5020403@gmx.de>
In-Reply-To: <40448E60.5020403@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Prakash K. Cheemplavam wrote:
> 
>> has anything changed with C1 halt? I mean it seems that CPU Disconnect 
>> doesn't get called (Though I enabled it), as with 2.6.3-mm4 (yesterday 
>> and today going back) my idle temps are about 46-47°C. Now with 
>> 2.6.4-mm1 they went up to 50-52°C.
> 
> 
> Hmm, today I went back to 2.6.4-rc1-mm1 and everything seems to be 
> normal again. Strange... So forget about it. :-)

Ok, its me again. So now I was running 2.6.4-rc1-mm1 today and the 
rratic behaviour came again, ie, idle temps went high. Strange enough 
this only happens after some time.

Comparing dmesg from both, I see this as major differnece: With latest 
mm-source the as scheduler gets used, though I set elevator=cfq in the 
kernel line. So either you removed cfq or it doesn't get selcted and 
maybe anticipatory causes the temp rise?

Well, I will test as scheduler with 2.6.3-mm4 tomorrow and report back

Prakash

PS: here the diff between the dmesgs:

--- dmesg2.6.3-mm4.txt  2004-03-02 21:40:07.359583984 +0100
+++ dmesg2.6.4-rc1-mm1.txt      2004-03-02 09:59:49.000000000 +0100
@@ -1,4 +1,4 @@
-Linux version 2.6.3-mm4 (root@tachyon) (gcc-Version 3.3.3 20040217 
(Gentoo Linux 3.3.3, propolice-3.3-7)) #12 Tue Mar 2 09:39:12 CET 2004
+Linux version 2.6.4-rc1 (root@tachyon) (gcc-Version 3.3.3 20040217 
(Gentoo Linux 3.3.3, propolice-3.3-7)) #3 Tue Mar 2 09:58:07 CET 2004
  BIOS-provided physical RAM map:
   BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
   BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
@@ -11,7 +11,6 @@
   BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
  127MB HIGHMEM available.
  896MB LOWMEM available.
-zapping low mappings.
  On node 0 totalpages: 262128
    DMA zone: 4096 pages, LIFO batch:1
    Normal zone: 225280 pages, LIFO batch:16
@@ -24,14 +23,15 @@
  ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
  ACPI: PM-Timer IO Port: 0x4008
  Built 1 zonelists
-Initializing CPU#0
  Kernel command line: root=/dev/hde7 quiet apic_tack=2 elevator=cfq 
doataraid noraid hdg=none
  ide_setup: hdg=none
+Initializing CPU#0
  PID hash table entries: 4096 (order 12: 32768 bytes)
-Detected 2205.190 MHz processor.
+Detected 2204.949 MHz processor.
  Using pmtmr for high-res timesource
  Console: colour VGA+ 80x25
-Memory: 1033100k/1048512k available (2555k kernel code, 14492k 
reserved, 862k data, 136k init, 131008k highmem)
+Memory: 1033144k/1048512k available (2527k kernel code, 14448k 
reserved, 861k data, 136k init, 131008k highmem)
+Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
  Calibrating delay loop... 4358.14 BogoMIPS
  Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
  Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
@@ -117,13 +117,13 @@
  ACPI: Power Button (FF) [PWRF]
  ACPI: Fan [FAN] (on)
  ACPI: Processor [CPU0] (supports C1)
-ACPI: Thermal Zone [THRM] (48 C)
+ACPI: Thermal Zone [THRM] (46 C)
  Real Time Clock Driver v1.12
  Non-volatile memory driver v1.2
  Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
  ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
  ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
-Using cfq io scheduler
+Using anticipatory io scheduler
  Floppy drive(s): fd0 is 1.44M
  FDC 0 is a post-1991 82077
  loop: loaded (max 8 devices)
@@ -179,8 +179,8 @@
  i2c_adapter i2c-2: nForce2 SMBus adapter at 0x5100
  Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05 
15:41:49 2004 UTC).
  PCI: Setting latency timer of device 0000:00:06.0 to 64
-intel8x0_measure_ac97_clock: measured 49398 usecs
-intel8x0: clocking to 47423
+intel8x0_measure_ac97_clock: measured 49397 usecs
+intel8x0: clocking to 47422
  ALSA device list:
    #0: NVidia nForce2 at 0xdc081000, irq 10
  NET: Registered protocol family 2
@@ -226,6 +226,7 @@
  ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[11] 
MMIO=[dc084000-dc0847ff]  Max Packet=[2048]
  ohci1394: fw-host0: SelfID received outside of bus reset sequence
  ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000000508df0fbe3]
+svc: unknown version (3)
  nvidia: no version magic, tainting kernel.
  nvidia: module license 'NVIDIA' taints kernel.
  0: nvidia: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-5336 
Wed Jan 14 18:29:26 PST 2004

