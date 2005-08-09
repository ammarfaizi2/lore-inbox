Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVHIV7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVHIV7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 17:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbVHIV7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 17:59:06 -0400
Received: from dsl3-63-249-67-204.cruzio.com ([63.249.67.204]:64159 "EHLO
	cichlid.com") by vger.kernel.org with ESMTP id S964972AbVHIV7F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 17:59:05 -0400
Date: Tue, 9 Aug 2005 14:58:47 -0700
From: Andrew Burgess <aab@cichlid.com>
Message-Id: <200508092158.j79LwlmM010246@cichlid.com>
To: linux-kernel@vger.kernel.org
Subject: BUG: Real-Time Preemption 2.6.13-rc5-RT-V0.7.52-16
Cc: mingo@elte.hu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This particular module (uhci-hcd) caused hangs with many recent up rt kernels
when loaded by rc.sysinit so I put it in the hotplug blacklist and loaded it
manually later. This time I got a BUG.

On a probably seperate issue: I've tried this smp kernel a few times and half
the time I have no keyboard and all the times I tried I have no mouse. Makes
things difficult :-) I'm going to try to dig up a usb mouse to see if that works
around it. Anyone else see this?

The up version of this kernel is much more useable for me. This is a P4HT cpu.

messages:

Aug  9 13:51:39 cichlid kernel: Linux version 2.6.13-rc5-RT-V0.7.52-16-smp-2 (root@athlon) (gcc version 3.4.4 20050721 (Red Hat 3.4.4-2)) #2 SMP Mon Aug 8 17:28:41 PDT 2005
...
Aug  9 13:51:40 cichlid kernel: Kernel command line: ro root=LABEL=/ rhgb vga=791 pci=noacpi noapic acpi=ht single
...
Aug  9 13:52:35 cichlid kernel: USB Universal Host Controller Interface driver v2.3
Aug  9 13:52:35 cichlid kernel: PCI: Found IRQ 11 for device 0000:00:1d.0
Aug  9 13:52:35 cichlid kernel: PCI: Sharing IRQ 11 with 0000:00:1d.3
Aug  9 13:52:35 cichlid kernel: uhci_hcd 0000:00:1d.0: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1
Aug  9 13:52:35 cichlid kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Aug  9 13:52:35 cichlid kernel: uhci_hcd 0000:00:1d.0: irq 11, io base 0x0000bc00
Aug  9 13:52:35 cichlid kernel: hub 2-0:1.0: USB hub found
Aug  9 13:52:35 cichlid kernel: hub 2-0:1.0: 2 ports detected
Aug  9 13:52:35 cichlid x10: insmod /lib/modules/2.6.13-rc5-RT-V0.7.52-16-smp-2/kernel/drivers/usb/host/uhci-hcd.ko 
Aug  9 13:52:35 cichlid kernel: BUG: scheduling with irqs disabled: modprobe/0x20000000/10765
Aug  9 13:52:35 cichlid kernel: caller is __down_mutex+0x484/0x62a
Aug  9 13:52:35 cichlid kernel:  [dump_stack+30/32] dump_stack+0x1e/0x20 (20)
Aug  9 13:52:35 cichlid kernel:  [<c0103ee1>] dump_stack+0x1e/0x20 (20)
Aug  9 13:52:36 cichlid kernel:  [schedule+161/274] schedule+0xa1/0x112 (28)
Aug  9 13:52:36 cichlid kernel:  [<c02f09cd>] schedule+0xa1/0x112 (28)
Aug  9 13:52:36 cichlid kernel:  [__down_mutex+1156/1578] __down_mutex+0x484/0x62a (124)
Aug  9 13:52:36 cichlid kernel:  [<c02f1a24>] __down_mutex+0x484/0x62a (124)
Aug  9 13:52:36 cichlid kernel:  [_spin_lock_irqsave+31/73] _spin_lock_irqsave+0x1f/0x49 (28)
Aug  9 13:52:36 cichlid kernel:  [<c02f342b>] _spin_lock_irqsave+0x1f/0x49 (28)
Aug  9 13:52:36 cichlid kernel:  [urb_unlink+28/113] urb_unlink+0x1c/0x71 (28)
Aug  9 13:52:36 cichlid kernel:  [<c0252580>] urb_unlink+0x1c/0x71 (28)
Aug  9 13:52:36 cichlid kernel:  [usb_hcd_giveback_urb+22/116] usb_hcd_giveback_urb+0x16/0x74 (28)
Aug  9 13:52:36 cichlid kernel:  [<c0252b32>] usb_hcd_giveback_urb+0x16/0x74 (28)
Aug  9 13:52:36 cichlid kernel:  [usb_hcd_poll_rh_status+196/360] usb_hcd_poll_rh_status+0xc4/0x168 (48)
Aug  9 13:52:36 cichlid kernel:  [<c0251a22>] usb_hcd_poll_rh_status+0xc4/0x168 (48)
Aug  9 13:52:36 cichlid kernel:  [usb_add_hcd+795/922] usb_add_hcd+0x31b/0x39a (56)
Aug  9 13:52:36 cichlid kernel:  [<c0253084>] usb_add_hcd+0x31b/0x39a (56)
Aug  9 13:52:36 cichlid kernel:  [usb_hcd_pci_probe+608/869] usb_hcd_pci_probe+0x260/0x365 (60)
Aug  9 13:52:36 cichlid kernel:  [<c0257600>] usb_hcd_pci_probe+0x260/0x365 (60)
Aug  9 13:52:36 cichlid kernel:  [__pci_device_probe+73/87] __pci_device_probe+0x49/0x57 (28)
Aug  9 13:52:36 cichlid kernel:  [<c01c7f11>] __pci_device_probe+0x49/0x57 (28)
Aug  9 13:52:36 cichlid kernel:  [pci_device_probe+43/75] pci_device_probe+0x2b/0x4b (24)
Aug  9 13:52:36 cichlid kernel:  [<c01c7f4a>] pci_device_probe+0x2b/0x4b (24)
Aug  9 13:52:36 cichlid kernel:  [driver_probe_device+51/173] driver_probe_device+0x33/0xad (36)
Aug  9 13:52:36 cichlid kernel:  [<c021e980>] driver_probe_device+0x33/0xad (36)
Aug  9 13:52:36 cichlid kernel:  [__driver_attach+65/81] __driver_attach+0x41/0x51 (24)
Aug  9 13:52:36 cichlid kernel:  [<c021eac8>] __driver_attach+0x41/0x51 (24)
Aug  9 13:52:37 cichlid kernel:  [bus_for_each_dev+87/119] bus_for_each_dev+0x57/0x77 (48)
Aug  9 13:52:37 cichlid kernel:  [<c021e074>] bus_for_each_dev+0x57/0x77 (48)
Aug  9 13:52:37 cichlid kernel:  [driver_attach+40/42] driver_attach+0x28/0x2a (24)
Aug  9 13:52:37 cichlid kernel:  [<c021eb00>] driver_attach+0x28/0x2a (24)
Aug  9 13:52:37 cichlid kernel:  [bus_add_driver+122/219] bus_add_driver+0x7a/0xdb (36)
Aug  9 13:52:37 cichlid kernel:  [<c021e521>] bus_add_driver+0x7a/0xdb (36)
Aug  9 13:52:37 cichlid kernel:  [driver_register+84/91] driver_register+0x54/0x5b (32)
Aug  9 13:52:37 cichlid kernel:  [<c021ee75>] driver_register+0x54/0x5b (32)
Aug  9 13:52:37 cichlid kernel:  [pci_register_driver+149/173] pci_register_driver+0x95/0xad (28)
Aug  9 13:52:37 cichlid kernel:  [<c01c81c3>] pci_register_driver+0x95/0xad (28)
Aug  9 13:52:37 cichlid kernel:  [pg0+951435395/1069052928] uhci_hcd_init+0x83/0xf6 [uhci_hcd] (36)
Aug  9 13:52:37 cichlid kernel:  [<f8fd3083>] uhci_hcd_init+0x83/0xf6 [uhci_hcd] (36)
Aug  9 13:52:37 cichlid kernel:  [sys_init_module+370/573] sys_init_module+0x172/0x23d (32)
Aug  9 13:52:37 cichlid kernel:  [<c0141257>] sys_init_module+0x172/0x23d (32)
Aug  9 13:52:37 cichlid kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75 (-8116)
Aug  9 13:52:37 cichlid kernel:  [<c0102f63>] sysenter_past_esp+0x54/0x75 (-8116)
Aug  9 13:52:37 cichlid kernel: ---------------------------
Aug  9 13:52:37 cichlid kernel: | preempt count: 20000000 ]
Aug  9 13:52:37 cichlid kernel: | 0-level deep critical section nesting:
Aug  9 13:52:37 cichlid kernel: ----------------------------------------
Aug  9 13:52:37 cichlid kernel: 
Aug  9 13:52:38 cichlid kernel: ------------------------------
Aug  9 13:52:38 cichlid kernel: | showing all locks held by: |  (modprobe/10765 [f72ee720, 120]):
Aug  9 13:52:38 cichlid kernel: ------------------------------
Aug  9 13:52:38 cichlid kernel: 
Aug  9 13:52:38 cichlid kernel: #001:             [f7e84200] {(struct semaphore *)(&dev->sem)}
Aug  9 13:52:38 cichlid kernel: ... acquired at:               __driver_attach+0x18/0x51
Aug  9 13:52:38 cichlid kernel: 
Aug  9 13:52:38 cichlid kernel: usb 2-1: new low speed USB device using uhci_hcd and address 2
Aug  9 13:52:38 cichlid kernel: PCI: Found IRQ 9 for device 0000:00:1d.1
Aug  9 13:52:38 cichlid kernel: uhci_hcd 0000:00:1d.1: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2
Aug  9 13:52:38 cichlid kernel: usb 2-2: new full speed USB device using uhci_hcd and address 3
Aug  9 13:52:38 cichlid kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Aug  9 13:52:38 cichlid kernel: uhci_hcd 0000:00:1d.1: irq 9, io base 0x0000b000
Aug  9 13:52:38 cichlid kernel: hub 3-0:1.0: USB hub found
Aug  9 13:52:38 cichlid kernel: hub 3-0:1.0: 2 ports detected
Aug  9 13:52:38 cichlid kernel: PCI: Found IRQ 11 for device 0000:00:1d.2
Aug  9 13:52:38 cichlid kernel: PCI: Sharing IRQ 11 with 0000:00:1f.1
Aug  9 13:52:38 cichlid kernel: PCI: Sharing IRQ 11 with 0000:00:1f.2
Aug  9 13:52:38 cichlid kernel: PCI: Sharing IRQ 11 with 0000:02:02.0
Aug  9 13:52:38 cichlid kernel: uhci_hcd 0000:00:1d.2: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI #3
Aug  9 13:52:38 cichlid kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Aug  9 13:52:38 cichlid kernel: uhci_hcd 0000:00:1d.2: irq 11, io base 0x0000b400

lspci:

00:00.0 Host bridge: Intel Corp. 82875P/E7210 Memory Controller Hub (rev 02)
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) SATA Controller (rev 02)
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5500] (rev a1)
02:02.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 IEEE-1394a-2000 Controller (PHY/Link)
02:04.0 Unknown mass storage controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
02:05.0 Unknown mass storage controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
02:06.0 RAID bus controller: 3ware Inc 3ware Inc 3ware 7xxx/8xxx-series PATA/SATA-RAID (rev 01)
02:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
02:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
02:09.0 Multimedia audio controller: VIA Technologies Inc. ICE1712 [Envy24] PCI Multi-Channel I/O Controller (rev 02)

