Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUHQU6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUHQU6R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268432AbUHQU6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:58:16 -0400
Received: from mail.dsvr.co.uk ([212.69.192.8]:41362 "EHLO mail.dsvr.co.uk")
	by vger.kernel.org with ESMTP id S266733AbUHQUzF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:55:05 -0400
Date: Tue, 17 Aug 2004 21:55:04 +0100
From: Jonathan Sambrook <beardie@dsvr.net>
To: linux-kernel@vger.kernel.org
Cc: John Riggs <jriggs@altiris.com>, greg@kroah.com
Subject: Re: PROBLEM: 2.6.7 Linux Kernel Crash While Detecting PCI Devices [ahem]
Message-ID: <20040817205504.GF21078@jsambrook>
References: <9B96255DE3B181429D06C6ADB0B37470232AFC@sandman.altiris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9B96255DE3B181429D06C6ADB0B37470232AFC@sandman.altiris.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:22 on Fri 06/08/04, jriggs@altiris.com masquerading as 'John Riggs' wrote:
> Summary: 2.6.7 Linux Kernel Crash While Detecting PCI Devices

This is similar to a problem here. Using kgdb I get the following out of
2.6.8.1:

	Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
	Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
	Memory: 253876k/262064k available (1680k kernel code, 7336k reserved, 1017k data
	, 164k init, 0k highmem)
	Checking if this processor honours the WP bit even in supervisor mode... Ok.
	Calibrating delay loop... 3022.84 BogoMIPS
	Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
	CPU: CLK_CTL MSR was 60031223. Reprogramming to 20031223
	CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
	CPU: L2 Cache: 256K (64 bytes/line)
	Intel machine check architecture supported.
	Intel machine check reporting enabled on CPU#0.
	CPU: AMD Athlon(TM) XP 1800+ stepping 01
	Enabling fast FPU save and restore... done.
	Enabling unmasked SIMD FPU exception support... done.
	Checking 'hlt' instruction... OK.
	enabled ExtINT on CPU#0
	ESR value before enabling vector: 00000000
	ESR value after enabling vector: 00000000
	testing NMI watchdog ... OK.
	Using local APIC timer interrupts.
	calibrating APIC timer ...
	..... CPU clock speed is 1529.0101 MHz.
	..... host bus clock speed is 265.0930 MHz.
	checking if image is initramfs...spurious 8259A interrupt: IRQ7.
	it isn't (no cpio magic); looks like an initrd
	Freeing initrd memory: 1793k freed
	NET: Registered protocol family 16
	PCI: PCI BIOS revision 2.10 entry at 0xf1b20, last bus=2
	PCI: Using configuration type 1
	mtrr: v2.0 (20020519)
	i8k: not running on a Dell system
	i8k: vendor=System Manufacturer, model=System Name, version=ASU
	i8k: unable to get SMM Dell signature
	i8k: unable to get SMM BIOS version
	PCI: Probing PCI hardware
	PCI: Probing PCI hardware (bus 00)
	Scanning bus 00
	Found 00:00 [10de/01a4] 000600 00
	Found 00:01 [10de/01ac] 000500 00
	Found 00:02 [10de/01ad] 000500 00
	Found 00:03 [10de/01aa] 000500 00
	Found 00:08 [10de/01b2] 000601 00
	Found 00:09 [10de/01b4] 000c05 00
	Found 00:10 [10de/01c2] 000c03 00
	Found 00:18 [10de/01c2] 000c03 00
	Found 00:20 [10de/01c3] 000200 00
	Found 00:28 [10de/01b0] 000401 00
	Found 00:30 [10de/01b1] 000401 00
	Found 00:40 [10de/01b8] 000604 01
	Found 00:48 [10de/01bc] 000101 00
	Found 00:f0 [10de/01b7] 000604 01
	Fixups for bus 00
	Scanning behind PCI bridge 0000:00:08.0, config 010100, pass 0
	Scanning bus 01
	Found 01:30 [104c/ac50] 000607 02
	Fixups for bus 01
	Scanning behind PCI bridge 0000:01:06.0, config 000000, pass 0
	Scanning behind PCI bridge 0000:01:06.0, config 000000, pass 1
	Bus scan for 01 returning with max=05
	Scanning behind PCI bridge 0000:00:1e.0, config 020200, pass 0
	[New Thread 1]

	Program received signal SIGSEGV, Segmentation fault.
	[Switching to Thread 1]
	sysfs_add_file (dir=0x0, attr=0xc02f7a9c) at semaphore.h:115
	115     {

	(gdb) bt
	#0  sysfs_add_file (dir=0x0, attr=0xc02f7a9c) at semaphore.h:115
	#1  0xc01e64e4 in class_device_create_file (class_dev=0xcffdbcc0, attr=0x0)
			at drivers/base/class.c:171
	#2  0xc01c02ad in pci_alloc_child_bus (parent=0x0, bridge=0xcfdfd400, busnr=2)
			at drivers/pci/probe.c:299
	#3  0xc01c0542 in pci_scan_bridge (bus=0xcffda160, dev=0xcfdfd400, max=5, 
			pass=0) at drivers/pci/probe.c:368
	#4  0xc01c0baa in pci_scan_child_bus (bus=0x0) at drivers/pci/probe.c:718
	#5  0xc01c0d2c in pci_scan_bus_parented (parent=0x0, bus=0, ops=0x0, 
			sysdata=0x0) at drivers/pci/probe.c:790
	#6  0xc024acd0 in pcibios_scan_root (busnum=0) at pci.h:702
	#7  0xc03c0b79 in pci_legacy_init () at arch/i386/pci/legacy.c:47
	#8  0xc03a682c in do_initcalls () at init/main.c:571
	#9  0xc010041d in init (unused=0x0) at init/main.c:677

	(gdb) p dir
	$1 = (struct dentry *) 0x0

	(gdb) up
	#1  0xc01e64e4 in class_device_create_file (class_dev=0xcffdbcc0, attr=0x0)
			at drivers/base/class.c:171
	171                     error = sysfs_create_file(&class_dev->kobj, &attr->attr);

	(gdb) p class_dev
	$2 = (struct class_device *) 0xcffdbcc0

	(gdb) p *class_dev
	$3 = {node = {next = 0xcffdbcc4, prev = 0x30303030}, kobj = {
			k_name = 0x32303a <Address 0x32303a out of bounds>, 
			name = '\0' <repeats 12 times>, "\001\0\0\0Ü??ýÏ", refcount = {
				counter = -805454628}, entry = {next = 0xc02f7a34, prev = 0xc032e4e0}, 
			parent = 0x0, kset = 0x0, ktype = 0xc02f7a20, dentry = 0x0}, class = 0x0, 
		dev = 0x30303030, class_data = 0x32303a, 
		class_id = '\0' <repeats 12 times>, "Îÿ{ÛNmÎÿ"} 

	(gdb) up
	#2  0xc01c02ad in pci_alloc_child_bus (parent=0x0, bridge=0xcfdfd400, busnr=2)
			at drivers/pci/probe.c:299
	299             class_device_create_file(&child->class_dev, &class_device_attr_cpuaffinity);

	(gdb) 
	#3  0xc01c0542 in pci_scan_bridge (bus=0xcffda160, dev=0xcfdfd400, max=5, 
			pass=0) at drivers/pci/probe.c:368
	368                     child = pci_alloc_child_bus(bus, dev, busnr);

	(gdb) 
	#4  0xc01c0baa in pci_scan_child_bus (bus=0x0) at drivers/pci/probe.c:718
	718                                     max = pci_scan_bridge(bus, dev, max, pass);

	(gdb) p bus
	$8 = (struct pci_bus *) 0x0

	(gdb) up
	#5  0xc01c0d2c in pci_scan_bus_parented (parent=0x0, bus=0, ops=0x0, 
			sysdata=0x0) at drivers/pci/probe.c:790
	790             b->subordinate = pci_scan_child_bus(b);

	(gdb) p b
	$7 = (struct pci_bus *) 0xcffda160



Rebooting into 2.4.27 (which boots but since 2.4.23 doesn't work with
the TI PCI1410 Carbus COntroller) allows me to extract the following
info:

	$ lspci 
	00:00.0 Host bridge: nVidia Corporation nForce CPU bridge (rev b2)
	00:00.1 RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev b2)
	00:00.2 RAM memory: nVidia Corporation nForce 220/420 Memory Controller (rev b2)
	00:00.3 RAM memory: nVidia Corporation: Unknown device 01aa (rev b2)
	00:01.0 ISA bridge: nVidia Corporation nForce ISA Bridge (rev c3)
	00:01.1 SMBus: nVidia Corporation nForce PCI System Management (rev c1)
	00:02.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3)
	00:03.0 USB Controller: nVidia Corporation nForce USB Controller (rev c3)
	00:04.0 Ethernet controller: nVidia Corporation nForce Ethernet Controller (rev c2)
	00:05.0 Multimedia audio controller: nVidia Corporation: Unknown device 01b0 (rev c2)
	00:06.0 Multimedia audio controller: nVidia Corporation nForce Audio (rev c2)
	00:08.0 PCI bridge: nVidia Corporation nForce PCI-to-PCI bridge (rev c2)
	00:09.0 IDE interface: nVidia Corporation nForce IDE (rev c3)
	00:1e.0 PCI bridge: nVidia Corporation nForce AGP to PCI Bridge (rev b2)
	01:06.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
	02:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra TF

	$ lspci -t
	-[00]-+-00.0
				+-00.1
				+-00.2
				+-00.3
				+-01.0
				+-01.1
				+-02.0
				+-03.0
				+-04.0
				+-05.0
				+-06.0
				+-08.0-[01]----06.0
				+-09.0
				\-1e.0-[02]----00.0

	$ lspci -n
	00:00.0 Class 0600: 10de:01a4 (rev b2)
	00:00.1 Class 0500: 10de:01ac (rev b2)
	00:00.2 Class 0500: 10de:01ad (rev b2)
	00:00.3 Class 0500: 10de:01aa (rev b2)
	00:01.0 Class 0601: 10de:01b2 (rev c3)
	00:01.1 Class 0c05: 10de:01b4 (rev c1)
	00:02.0 Class 0c03: 10de:01c2 (rev c3)
	00:03.0 Class 0c03: 10de:01c2 (rev c3)
	00:04.0 Class 0200: 10de:01c3 (rev c2)
	00:05.0 Class 0401: 10de:01b0 (rev c2)
	00:06.0 Class 0401: 10de:01b1 (rev c2)
	00:08.0 Class 0604: 10de:01b8 (rev c2)
	00:09.0 Class 0101: 10de:01bc (rev c3)
	00:1e.0 Class 0604: 10de:01b7 (rev b2)
	01:06.0 Class 0607: 104c:ac50 (rev 01)
	02:00.0 Class 0300: 1002:5446

More debugging possible - what do you want to know?

Regards,
Jonathan

-- 
                   
 Jonathan Sambrook 
Software  Developer 
 Designer  Servers
-- 
                   
 Jonathan Sambrook 
Software  Developer 
 Designer  Servers
