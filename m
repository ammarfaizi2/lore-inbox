Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266252AbUJEXmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUJEXmq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 19:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUJEXmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 19:42:46 -0400
Received: from mail.aei.ca ([206.123.6.14]:53446 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S266252AbUJEXmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 19:42:01 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm2 ip_conntrack problems
Date: Tue, 5 Oct 2004 19:13:00 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20041004020207.4f168876.akpm@osdl.org> <200410041941.56453.edt@aei.ca> <20041004170853.34d25529.akpm@osdl.org>
In-Reply-To: <20041004170853.34d25529.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410051913.00266.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 October 2004 20:08, Andrew Morton wrote:
> Ed Tomlinson <edt@aei.ca> wrote:
> >
> > Has anyone figured out how to fix this one (9-rc3-mm1 compiled ok).
> > 
> >   CC [M]  net/ipv4/netfilter/ip_conntrack_standalone.o
> > net/ipv4/netfilter/ip_conntrack_standalone.c:34:47: linux/netfilter_ipv4/ip_conntrack.h: No such file or directory
> 
> Works for me.  Perhaps you're missing that file?

Yes (egg on face).   bk -r get -qS fixes it.

The startup hangs at the same place rc2-mm1 did.  Disabling APCI does not help.  Recient mm build only
work if APCI is enabled here.

Here is a sysrq-t of the hang

Ed

Oct  5 16:59:32 bert kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Oct  5 16:59:32 bert kernel: apm: disabled on user request.
Oct  5 16:59:37 bert Xprt_64: Xprint server pid=1518 done, exitcode=0.
Oct  5 16:59:40 bert kernel: Kernel logging (proc) stopped.
Oct  5 16:59:40 bert kernel: Kernel log daemon terminating.
Oct  5 16:59:40 bert exiting on signal 15
Oct  5 17:01:51 bert syslogd 1.4.1#15: restart.
Oct  5 17:01:52 bert kernel: klogd 1.4.1#15, log source = /proc/kmsg started.
Oct  5 17:01:52 bert kernel: Inspecting /boot/System.map-2.6.9-rc3-mm2
Oct  5 17:01:52 bert kernel: Loaded 24641 symbols from /boot/System.map-2.6.9-rc3-mm2.
Oct  5 17:01:52 bert kernel: Symbols match kernel version 2.6.9.
Oct  5 17:01:52 bert kernel: No module symbols loaded - kernel modules not enabled. 
Oct  5 17:01:52 bert kernel: Linux version 2.6.9-rc3-mm2 (knoppix@bert) (gcc version 3.4.2 (Debian 3.4.2-2)) #1 Tue Oct 5 06:20:23 EDT 2004
Oct  5 17:01:52 bert kernel: BIOS-provided physical RAM map:
Oct  5 17:01:52 bert kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Oct  5 17:01:52 bert kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Oct  5 17:01:52 bert kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Oct  5 17:01:52 bert kernel:  BIOS-e820: 0000000000100000 - 0000000020000000 (usable)
Oct  5 17:01:52 bert kernel:  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
Oct  5 17:01:52 bert kernel: 512MB LOWMEM available.
Oct  5 17:01:52 bert kernel: DMI 2.1 present.
Oct  5 17:01:52 bert kernel: ACPI: PM-Timer IO Port: 0xf808
Oct  5 17:01:52 bert kernel: Built 1 zonelists
Oct  5 17:01:52 bert kernel: Initializing CPU#0
Oct  5 17:01:52 bert kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=303 apm=power-off
Oct  5 17:01:52 bert kernel: CPU 0 irqstacks, hard=c0395000 soft=c0394000
Oct  5 17:01:52 bert kernel: PID hash table entries: 4096 (order: 12, 65536 bytes)
Oct  5 17:01:52 bert kernel: Detected 1394.141 MHz processor.
Oct  5 17:01:52 bert kernel: Using pmtmr for high-res timesource
Oct  5 17:01:52 bert kernel: Console: colour VGA+ 80x25
Oct  5 17:01:52 bert kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Oct  5 17:01:52 bert kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Oct  5 17:01:52 bert kernel: Memory: 516068k/524288k available (1772k kernel code, 7776k reserved, 715k data, 128k init, 0k highmem)
Oct  5 17:01:52 bert kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Oct  5 17:01:52 bert kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Oct  5 17:01:52 bert kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Oct  5 17:01:52 bert kernel: CPU: L2 cache: 256K
Oct  5 17:01:52 bert kernel: Intel machine check architecture supported.
Oct  5 17:01:52 bert kernel: Intel machine check reporting enabled on CPU#0.
Oct  5 17:01:52 bert kernel: CPU: Intel(R) Celeron(TM) CPU                1400MHz stepping 04
Oct  5 17:01:52 bert kernel: Enabling fast FPU save and restore... done.
Oct  5 17:01:52 bert kernel: Enabling unmasked SIMD FPU exception support... done.
Oct  5 17:01:52 bert kernel: Checking 'hlt' instruction... OK.
Oct  5 17:01:52 bert kernel: ACPI: IRQ9 SCI: Edge set to Level Trigger.
Oct  5 17:01:52 bert kernel: NET: Registered protocol family 16
Oct  5 17:01:52 bert kernel: PCI: PCI BIOS revision 2.10 entry at 0xed880, last bus=1
Oct  5 17:01:52 bert kernel: PCI: Using configuration type 1
Oct  5 17:01:52 bert kernel: mtrr: v2.0 (20020519)
Oct  5 17:01:52 bert kernel: ACPI: Subsystem revision 20040816
Oct  5 17:01:52 bert kernel: ACPI: Interpreter enabled
Oct  5 17:01:52 bert kernel: ACPI: Using PIC for interrupt routing
Oct  5 17:01:52 bert kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
Oct  5 17:01:52 bert kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11)
Oct  5 17:01:52 bert kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11)
Oct  5 17:01:52 bert kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *10 11)
Oct  5 17:01:52 bert kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Oct  5 17:01:52 bert kernel: PCI: Probing PCI hardware (bus 00)
Oct  5 17:01:52 bert kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Oct  5 17:01:52 bert kernel: PnPBIOS: Scanning system for PnP BIOS support...
Oct  5 17:01:52 bert kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fef70
Oct  5 17:01:52 bert kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x604e, dseg 0xf0000
Oct  5 17:01:52 bert kernel: PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
Oct  5 17:01:52 bert kernel: usbcore: registered new driver usbfs
Oct  5 17:01:52 bert kernel: usbcore: registered new driver hub
Oct  5 17:01:52 bert kernel: PCI: Using ACPI for IRQ routing
Oct  5 17:01:52 bert kernel: ** PCI interrupts are no longer routed automatically.  If this
Oct  5 17:01:52 bert kernel: ** causes a device to stop working, it is probably because the
Oct  5 17:01:52 bert kernel: ** driver failed to call pci_enable_device().  As a temporary
Oct  5 17:01:52 bert kernel: ** workaround, the "pci=routeirq" argument restores the old
Oct  5 17:01:52 bert kernel: ** behavior.  If this argument makes the device work again,
Oct  5 17:01:52 bert kernel: ** please email the output of "lspci" to bjorn.helgaas@hp.com
Oct  5 17:01:52 bert kernel: ** so I can fix the driver.
Oct  5 17:01:52 bert kernel: pnp: 00:12: ioport range 0x15c-0x15d has been reserved
Oct  5 17:01:52 bert kernel: pnp: 00:12: ioport range 0x4d0-0x4d1 has been reserved
Oct  5 17:01:52 bert kernel: pnp: 00:13: ioport range 0xf800-0xf81f could not be reserved
Oct  5 17:01:52 bert kernel: pnp: 00:13: ioport range 0xf820-0xf83f has been reserved
Oct  5 17:01:52 bert kernel: pnp: 00:13: ioport range 0xfc00-0xfc0f has been reserved
Oct  5 17:01:52 bert kernel: Initializing Cryptographic API
Oct  5 17:01:52 bert kernel: Limiting direct PCI/PCI transfers.
Oct  5 17:01:52 bert kernel: isapnp: Scanning for PnP cards...
Oct  5 17:01:52 bert kernel: isapnp: No Plug & Play device found
Oct  5 17:01:52 bert kernel: ACPI: PS/2 Keyboard Controller [KBD] at I/O 0x60, 0x64, irq 1
Oct  5 17:01:52 bert kernel: ACPI: PS/2 Mouse Controller [PS2M] at irq 12
Oct  5 17:01:52 bert kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct  5 17:01:52 bert kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct  5 17:01:52 bert kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Oct  5 17:01:52 bert kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Oct  5 17:01:52 bert kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
Oct  5 17:01:52 bert kernel: io scheduler noop registered
Oct  5 17:01:52 bert kernel: io scheduler anticipatory registered
Oct  5 17:01:52 bert kernel: io scheduler deadline registered
Oct  5 17:01:52 bert kernel: io scheduler cfq registered
Oct  5 17:01:52 bert kernel: Compaq SMART2 Driver (v 2.6.0)
Oct  5 17:01:52 bert kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct  5 17:01:52 bert kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct  5 17:01:52 bert kernel: PIIX4: IDE controller at PCI slot 0000:00:14.1
Oct  5 17:01:52 bert kernel: PIIX4: chipset revision 1
Oct  5 17:01:52 bert kernel: PIIX4: not 100%% native mode: will probe irqs later
Oct  5 17:01:52 bert kernel:     ide0: BM-DMA at 0x10e0-0x10e7, BIOS settings: hda:DMA, hdb:pio
Oct  5 17:01:52 bert kernel:     ide1: BM-DMA at 0x10e8-0x10ef, BIOS settings: hdc:DMA, hdd:DMA
Oct  5 17:01:52 bert kernel: hda: Maxtor 6Y080L0, ATA DISK drive
Oct  5 17:01:52 bert kernel: elevator: using anticipatory as default io scheduler
Oct  5 17:01:52 bert kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct  5 17:01:52 bert kernel: hdc: HL-DT-ST RW/DVD GCC-4480B, ATAPI CD/DVD-ROM drive
Oct  5 17:01:52 bert kernel: hdd: HP COLORADO 20GB, ATAPI TAPE drive
Oct  5 17:01:52 bert kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct  5 17:01:52 bert kernel: hda: max request size: 128KiB
Oct  5 17:01:52 bert kernel: hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(33)
Oct  5 17:01:52 bert kernel:  hda: hda1 hda2 hda3 hda4 < hda5 >
Oct  5 17:01:52 bert kernel: USB Universal Host Controller Interface driver v2.2
Oct  5 17:01:52 bert kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
Oct  5 17:01:52 bert kernel: PCI: setting IRQ 10 as level-triggered
Oct  5 17:01:52 bert kernel: ACPI: PCI interrupt 0000:00:14.2[D] -> GSI 10 (level, low) -> IRQ 10
Oct  5 17:01:52 bert kernel: uhci_hcd 0000:00:14.2: Intel Corp. 82371AB/EB/MB PIIX4 USB
Oct  5 17:01:52 bert kernel: uhci_hcd 0000:00:14.2: irq 10, io base 0x10c0
Oct  5 17:01:52 bert kernel: uhci_hcd 0000:00:14.2: new USB bus registered, assigned bus number 1
Oct  5 17:01:52 bert kernel: hub 1-0:1.0: USB hub found
Oct  5 17:01:52 bert kernel: hub 1-0:1.0: 2 ports detected
Oct  5 17:01:52 bert kernel: Badness in remove_proc_entry at fs/proc/generic.c:688
Oct  5 17:01:52 bert kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Oct  5 17:01:52 bert kernel:  [remove_proc_entry+341/352] remove_proc_entry+0x155/0x160
Oct  5 17:01:52 bert kernel:  [uhci_hcd_init+236/272] uhci_hcd_init+0xec/0x110
Oct  5 17:01:52 bert kernel:  [do_initcalls+87/192] do_initcalls+0x57/0xc0
Oct  5 17:01:52 bert kernel:  [init+50/272] init+0x32/0x110
Oct  5 17:01:52 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:01:52 bert kernel: mice: PS/2 mouse device common for all mice
Oct  5 17:01:52 bert kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct  5 17:01:52 bert kernel: usb 1-1: new low speed USB device using address 2
Oct  5 17:01:52 bert kernel: c024e172
Oct  5 17:01:52 bert kernel: PREEMPT 
Oct  5 17:01:52 bert kernel: Modules linked in:
Oct  5 17:01:52 bert kernel: CPU:    0
Oct  5 17:01:52 bert kernel: EIP:    0060:[uhci_alloc_urb_priv+50/144]    Not tainted VLI
Oct  5 17:01:52 bert kernel: EFLAGS: 00010006   (2.6.9-rc3-mm2) 
Oct  5 17:01:52 bert kernel: EIP is at uhci_alloc_urb_priv+0x32/0x90
Oct  5 17:01:52 bert kernel: eax: 00000000   ebx: 00000003   ecx: 0000000b   edx: c17ed000
Oct  5 17:01:52 bert kernel: esi: c17cb8c0   edi: 00000003   ebp: c1731d98   esp: c1731d88
Oct  5 17:01:52 bert kernel: ds: 007b   es: 007b   ss: 0068
Oct  5 17:01:52 bert kernel: Process khubd (pid: 39, threadinfo=c1731000 task=c1728b30)
Oct  5 17:01:52 bert kernel: Stack: c14eec00 fffffff4 c17cb8c0 c14eec00 c1731dbc c024f08a c01c12c2 c17ed000 
Oct  5 17:01:52 bert kernel:        00000000 00000286 c02c2ca0 c17cb8c0 c14eec00 c1731de0 c0242a80 0000900d 
Oct  5 17:01:52 bert kernel:        00000246 c17d1a20 00000010 00000008 c17ed000 00000002 c1731e04 c0243429 
Oct  5 17:01:52 bert kernel: Call Trace:
Oct  5 17:01:52 bert kernel:  [show_stack+122/144] show_stack+0x7a/0x90
Oct  5 17:01:52 bert kernel:  [show_registers+329/448] show_registers+0x149/0x1c0
Oct  5 17:01:52 bert kernel:  [die+221/368] die+0xdd/0x170
Oct  5 17:01:52 bert kernel:  [do_page_fault+1095/1561] do_page_fault+0x447/0x619
Oct  5 17:01:52 bert kernel:  [error_code+45/56] error_code+0x2d/0x38
Oct  5 17:01:52 bert kernel:  [uhci_urb_enqueue+106/608] uhci_urb_enqueue+0x6a/0x260
Oct  5 17:01:52 bert kernel:  [hcd_submit_urb+272/400] hcd_submit_urb+0x110/0x190
Oct  5 17:01:52 bert kernel:  [usb_submit_urb+425/592] usb_submit_urb+0x1a9/0x250
Oct  5 17:01:52 bert kernel:  [usb_start_wait_urb+67/208] usb_start_wait_urb+0x43/0xd0
Oct  5 17:01:52 bert kernel:  [usb_internal_control_msg+96/128] usb_internal_control_msg+0x60/0x80
Oct  5 17:01:52 bert kernel:  [usb_control_msg+133/160] usb_control_msg+0x85/0xa0
Oct  5 17:01:52 bert kernel:  [hub_set_address+90/128] hub_set_address+0x5a/0x80
Oct  5 17:01:52 bert kernel:  [hub_port_init+384/880] hub_port_init+0x180/0x370
Oct  5 17:01:52 bert kernel:  [hub_port_connect_change+194/944] hub_port_connect_change+0xc2/0x3b0
Oct  5 17:01:52 bert kernel:  [hub_events+471/896] hub_events+0x1d7/0x380
Oct  5 17:01:52 bert kernel:  [hub_thread+53/240] hub_thread+0x35/0xf0
Oct  5 17:01:52 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:01:52 bert kernel: Code: 45 f0 a1 c4 30 3b c0 89 75 f8 89 d6 ba 20 00 00 00 89 5d f4 89 7d fc e8 1d ff ee ff 89 c3 31 c0 85 db 74 4b b9 0b 00 00 00 89 df <f3> ab a1 c0 7f 2f c0 89 43 1c a1 c0 7f 2f c0 89 73 08 89 5b 04 
Oct  5 17:01:52 bert kernel:  <6>note: khubd[39] exited with preempt_count 1
Oct  5 17:01:52 bert kernel: input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Oct  5 17:01:52 bert kernel: NET: Registered protocol family 2
Oct  5 17:01:52 bert kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Oct  5 17:01:52 bert kernel: TCP: Hash tables configured (established 131072 bind 65536)
Oct  5 17:01:52 bert kernel: NET: Registered protocol family 1
Oct  5 17:01:52 bert kernel: NET: Registered protocol family 15
Oct  5 17:01:52 bert kernel: ReiserFS: hda3: found reiserfs format "3.6" with standard journal
Oct  5 17:01:52 bert kernel: ReiserFS: hda3: using ordered data mode
Oct  5 17:01:52 bert kernel: ReiserFS: hda3: journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Oct  5 17:01:52 bert kernel: ReiserFS: hda3: checking transaction log (hda3)
Oct  5 17:01:52 bert kernel: ReiserFS: hda3: Using r5 hash to sort names
Oct  5 17:01:52 bert kernel: VFS: Mounted root (reiserfs filesystem) readonly.
Oct  5 17:01:52 bert kernel: Freeing unused kernel memory: 128k freed
Oct  5 17:01:52 bert kernel: Adding 976744k swap on /dev/hda2.  Priority:-1 extents:1
Oct  5 17:01:52 bert kernel: Real Time Clock Driver v1.12
Oct  5 17:01:52 bert kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Oct  5 17:01:52 bert kernel: apm: overridden by ACPI.
Oct  5 17:01:52 bert kernel: NET: Registered protocol family 17
Oct  5 17:01:52 bert kernel: e100: Intel(R) PRO/100 Network Driver, 3.1.4-k2-NAPI
Oct  5 17:01:52 bert kernel: e100: Copyright(c) 1999-2004 Intel Corporation
Oct  5 17:01:52 bert kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Oct  5 17:01:52 bert kernel: PCI: setting IRQ 11 as level-triggered
Oct  5 17:01:52 bert kernel: ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 11 (level, low) -> IRQ 11
Oct  5 17:01:52 bert kernel: e100: eth0: e100_probe: addr 0x40b00000, irq 11, MAC addr 00:08:C7:08:27:CE
Oct  5 17:01:52 bert kernel: input: PC Speaker
Oct  5 17:01:52 bert kernel: device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Oct  5 17:01:52 bert kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Oct  5 17:01:52 bert kernel: warning: process `update' used the obsolete bdflush system call
Oct  5 17:01:52 bert kernel: Fix your initscripts?
Oct  5 17:01:52 bert kernel: SCSI subsystem initialized
Oct  5 17:01:52 bert kernel: kjournald starting.  Commit interval 5 seconds
Oct  5 17:01:52 bert kernel: EXT3 FS on hda1, internal journal
Oct  5 17:01:52 bert kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct  5 17:01:52 bert kernel: ReiserFS: hda5: found reiserfs format "3.6" with standard journal
Oct  5 17:01:52 bert kernel: ReiserFS: hda5: using ordered data mode
Oct  5 17:01:52 bert kernel: ReiserFS: hda5: journal params: device hda5, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
Oct  5 17:01:52 bert kernel: ReiserFS: hda5: checking transaction log (hda5)
Oct  5 17:01:52 bert kernel: ReiserFS: hda5: Using r5 hash to sort names
Oct  5 17:01:52 bert kernel: Badness in enable_irq at kernel/irq/manage.c:106
Oct  5 17:01:52 bert kernel:  [dump_stack+23/32] dump_stack+0x17/0x20
Oct  5 17:01:52 bert kernel:  [enable_irq+178/208] enable_irq+0xb2/0xd0
Oct  5 17:01:52 bert kernel:  [pg0+542801987/1069822976] e100_up+0x143/0x200 [e100]
Oct  5 17:01:52 bert kernel:  [pg0+542806281/1069822976] e100_open+0x29/0x80 [e100]
Oct  5 17:01:52 bert kernel:  [dev_open+116/144] dev_open+0x74/0x90
Oct  5 17:01:52 bert kernel:  [dev_change_flags+82/288] dev_change_flags+0x52/0x120
Oct  5 17:01:52 bert kernel:  [devinet_ioctl+1516/1696] devinet_ioctl+0x5ec/0x6a0
Oct  5 17:01:52 bert kernel:  [inet_ioctl+192/208] inet_ioctl+0xc0/0xd0
Oct  5 17:01:52 bert kernel:  [sock_ioctl+446/672] sock_ioctl+0x1be/0x2a0
Oct  5 17:01:52 bert kernel:  [sys_ioctl+468/560] sys_ioctl+0x1d4/0x230
Oct  5 17:01:52 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:01:52 bert kernel: e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Oct  5 17:01:52 bert kernel: nfs warning: mount version older than kernel
Oct  5 17:01:52 bert last message repeated 2 times
Oct  5 17:01:52 bert kernel: reset at 0x220 failed!!!
Oct  5 17:01:52 bert kernel: reset at 0x220 failed!!!
Oct  5 17:01:52 bert kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Oct  5 17:01:52 bert kernel: apm: disabled on user request.
Oct  5 17:01:53 bert dhcpd: Internet Systems Consortium DHCP Server V3.0.1
Oct  5 17:01:53 bert dhcpd: Copyright 2004 Internet Systems Consortium.
Oct  5 17:01:53 bert dhcpd: All rights reserved.
Oct  5 17:01:53 bert dhcpd: For info, please visit http://www.isc.org/sw/dhcp/
Oct  5 17:01:53 bert dhcpd: Wrote 0 leases to leases file.
Oct  5 17:01:53 bert dhcpd: 
Oct  5 17:01:58 bert xfs: ignoring font path element /usr/lib/X11/fonts/CID (unreadable) 
Oct  5 17:01:59 bert kernel: parport: PnPBIOS parport detected.
Oct  5 17:01:59 bert kernel: parport0: PC-style at 0x378 (0x778), irq 9, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
Oct  5 17:01:59 bert kernel: parport0: irq 9 in use, resorting to polled operation
Oct  5 17:01:59 bert isapnp.rc[1569]:      parport_pc: loaded sucessfully
Oct  5 17:01:59 bert kernel: inserting floppy driver for 2.6.9-rc3-mm2
Oct  5 17:01:59 bert kernel: ACPI: Floppy Controller [FDC0] at I/O 0x3f0-0x3f5 irq 6 dma channel 2
Oct  5 17:01:59 bert kernel: ACPI: [FDC0] doesn't declare FD_DCR; also claiming 0x3f7
Oct  5 17:01:59 bert kernel: Floppy drive(s): fd0 is 1.44M
Oct  5 17:01:59 bert kernel: FDC 0 is a National Semiconductor PC87306
Oct  5 17:01:59 bert isapnp.rc[1569]:      floppy: loaded sucessfully
Oct  5 17:02:00 bert isapnp.rc[1569]:      pcspkr: loaded sucessfully
Oct  5 17:02:00 bert isapnp.rc[1569]:      rtc: loaded sucessfully
Oct  5 17:02:00 bert kernel: Linux agpgart interface v0.100 (c) Dave Jones
Oct  5 17:02:00 bert kernel: agpgart: Detected an Intel 440BX Chipset.
Oct  5 17:02:00 bert kernel: agpgart: Maximum main memory to use for agp memory: 440M
Oct  5 17:02:00 bert kernel: agpgart: AGP aperture is 64M @ 0x44000000
Oct  5 17:02:00 bert pci.agent[1692]:      intel-agp: loaded successfully
Oct  5 17:02:00 bert pci.agent[1751]:      e100: already loaded
Oct  5 17:02:00 bert kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
Oct  5 17:02:00 bert kernel: ACPI: PCI interrupt 0000:00:0e.0[A] -> GSI 10 (level, low) -> IRQ 10
Oct  5 17:02:01 bert pci.agent[1779]:      snd-emu10k1: loaded successfully
Oct  5 17:02:01 bert kernel: gameport: pci0000:00:0e.1 speed 1217 kHz
Oct  5 17:02:01 bert pci.agent[1881]:      emu10k1-gp: loaded successfully
Oct  5 17:02:01 bert kernel: ohci1394: $Rev: 1226 $ Ben Collins <bcollins@debian.org>
Oct  5 17:02:01 bert kernel: ACPI: PCI interrupt 0000:00:10.0[A] -> GSI 10 (level, low) -> IRQ 10
Oct  5 17:02:01 bert kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[40a00000-40a007ff]  Max Packet=[2048]
Oct  5 17:02:01 bert pci.agent[1917]:      ohci1394: loaded successfully
Oct  5 17:02:02 bert kernel: piix4_smbus 0000:00:14.3: Found 0000:00:14.3 device
Oct  5 17:02:02 bert pci.agent[2018]:      i2c-piix4: loaded successfully
Oct  5 17:02:02 bert pci.rc[1681]:      ignoring pci display device on 01:00.0
Oct  5 17:03:54 bert kernel: SysRq : Show State
Oct  5 17:03:54 bert kernel: 
Oct  5 17:03:54 bert kernel:                                                sibling
Oct  5 17:03:54 bert kernel:   task             PC      pid father child younger older
Oct  5 17:03:54 bert kernel: init          S C02FAD80     0     1      0     2               (NOTLB)
Oct  5 17:03:54 bert kernel: c151ceb4 00000086 00000246 c02fad80 c13f7200 00000000 c02faca4 00000000 
Oct  5 17:03:54 bert kernel:        000000d8 00000000 c013968a c151cee0 c016122c c151c000 dfe88090 00000000 
Oct  5 17:03:54 bert kernel:        c151cec8 07435d80 000f421d c039a180 c15415f0 c15417cc fffdc8ce c151cec8 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+87/176] schedule_timeout+0x57/0xb0
Oct  5 17:03:54 bert kernel:  [do_select+614/688] do_select+0x266/0x2b0
Oct  5 17:03:54 bert kernel:  [sys_select+577/1264] sys_select+0x241/0x4f0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: ksoftirqd/0   S C151FF70     0     2      1             3       (L-TLB)
Oct  5 17:03:54 bert kernel: c151ffb4 00000046 c1541080 c151ff70 c02b93a5 00000000 00000011 c1541080 
Oct  5 17:03:54 bert kernel:        00000000 00000000 ffffffff 00000086 c151cee4 00000000 00000000 ffffffff 
Oct  5 17:03:54 bert kernel:        c0113e47 121b4180 000f41fc c039a180 c1541080 c154125c c151f000 c151f000 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [ksoftirqd+179/192] ksoftirqd+0xb3/0xc0
Oct  5 17:03:54 bert kernel:  [kthread+138/208] kthread+0x8a/0xd0
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: events/0      R running     0     3      1             4     2 (L-TLB)
Oct  5 17:03:54 bert kernel: khelper       S C0127A40     0     4      1             5     3 (L-TLB)
Oct  5 17:03:54 bert kernel: c1524f3c 00000046 c0127a40 c0127a40 00000000 dd695e40 00000000 00000000 
Oct  5 17:03:54 bert kernel:        000001f9 00000000 0000007b 0000007b c15176f8 00000001 00000003 c1524000 
Oct  5 17:03:54 bert kernel:        00000000 80bf0fc0 000f4203 c039a180 c15405a0 c154077c dd695e00 00000292 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [worker_thread+536/608] worker_thread+0x218/0x260
Oct  5 17:03:54 bert kernel:  [kthread+138/208] kthread+0x8a/0xd0
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: kthread       S C1540030     0     5      1     6      51     4 (L-TLB)
Oct  5 17:03:54 bert kernel: c152ff3c 00000046 00000000 c1540030 c0113e00 00000000 00000000 00000000 
Oct  5 17:03:54 bert kernel:        00000000 00000000 00000001 c1540030 c152a5d8 00000001 00000003 c152f000 
Oct  5 17:03:54 bert kernel:        00000000 8526b700 000f4200 c039a180 c1540030 c154020c dff72de4 00000292 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [worker_thread+536/608] worker_thread+0x218/0x260
Oct  5 17:03:54 bert kernel:  [kthread+138/208] kthread+0x8a/0xd0
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: kacpid        S 00800000     0     6      5            38       (L-TLB)
Oct  5 17:03:54 bert kernel: c159af3c 00000046 c01124c9 00800000 00000000 00000000 d5c5ebbf 01000000 
Oct  5 17:03:54 bert kernel:        00000000 00000000 a91c9008 00010000 c159a000 c1729610 c159a000 c159af3c 
Oct  5 17:03:54 bert kernel:        c0124d9c 41d88c40 000f41fa c039a180 c1729610 c17297ec c159a000 c151cf28 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [worker_thread+536/608] worker_thread+0x218/0x260
Oct  5 17:03:54 bert kernel:  [kthread+138/208] kthread+0x8a/0xd0
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: kblockd/0     S C03AE920     0    38      5            49     6 (L-TLB)
Oct  5 17:03:54 bert kernel: c15a1f3c 00000046 c15a1000 c03ae920 c15a1f18 c023208c c17c4da0 c17c4da0 
Oct  5 17:03:54 bert kernel:        00000021 00000000 ffffffff c14e8840 c172af38 00000001 00000003 c15a1000 
Oct  5 17:03:54 bert kernel:        00000000 b63c2f00 000f420f c039a180 c17290a0 c172927c c17c4e20 00000246 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [worker_thread+536/608] worker_thread+0x218/0x260
Oct  5 17:03:54 bert kernel:  [kthread+138/208] kthread+0x8a/0xd0
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: pdflush       S 00000002     0    49      5            50    38 (L-TLB)
Oct  5 17:03:54 bert kernel: c1732f7c 00000046 c15405a0 00000002 521e3280 000f41fa c039a180 c17285c0 
Oct  5 17:03:54 bert kernel:        00000000 00000000 ffffffff c17285c0 c1732f5c c02b93a5 00000000 00000011 
Oct  5 17:03:54 bert kernel:        c17285c0 53ba2f40 000f41fa c039a180 c17285c0 c172879c c1732000 c1732fa8 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [__pdflush+160/496] __pdflush+0xa0/0x1f0
Oct  5 17:03:54 bert kernel:  [pdflush+30/32] pdflush+0x1e/0x20
Oct  5 17:03:54 bert kernel:  [kthread+138/208] kthread+0x8a/0xd0
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: pdflush       S C013AC6C     0    50      5            52    49 (L-TLB)
Oct  5 17:03:54 bert kernel: c173af7c 00000046 c173af7c c013ac6c fffd3721 0000cccc 00000000 00000000 
Oct  5 17:03:54 bert kernel:        000000c4 00000000 00000000 00000000 00000000 00000000 00000000 00000005 
Oct  5 17:03:54 bert kernel:        00000000 7e96f640 000f421c c039a180 c1728050 c172822c 00000000 c173afa8 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [__pdflush+160/496] __pdflush+0xa0/0x1f0
Oct  5 17:03:54 bert kernel:  [pdflush+30/32] pdflush+0x1e/0x20
Oct  5 17:03:54 bert kernel:  [kthread+138/208] kthread+0x8a/0xd0
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: aio/0         S 00800000     0    52      5           665    50 (L-TLB)
Oct  5 17:03:54 bert kernel: c1742f3c 00000046 c01124c9 00800000 00000000 00000000 c7f5ffff 01000000 
Oct  5 17:03:54 bert kernel:        00000000 00000000 bb5eb22c 00010000 c1742000 c176b0c0 c1742000 c1742f3c 
Oct  5 17:03:54 bert kernel:        c0124d9c 521e3280 000f41fa c039a180 c176b0c0 c176b29c c1742000 c151cf2c 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [worker_thread+536/608] worker_thread+0x218/0x260
Oct  5 17:03:54 bert kernel:  [kthread+138/208] kthread+0x8a/0xd0
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: kswapd0       S C176B630     0    51      1           635     5 (L-TLB)
Oct  5 17:03:54 bert kernel: c173bf88 00000046 00000000 c176b630 00000001 00000002 c173bf50 c0128a78 
Oct  5 17:03:54 bert kernel:        01000000 00000000 00000000 c02fa120 c173bf60 c0121c74 c173b000 c173bf70 
Oct  5 17:03:54 bert kernel:        c0119f01 53ba2f40 000f41fa c039a180 c176b630 c176b80c c173b000 c02faf3c 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [kswapd+163/208] kswapd+0xa3/0xd0
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: kseriod       S C176A5E0     0   635      1           952    51 (L-TLB)
Oct  5 17:03:54 bert kernel: c1789f90 00000046 00000000 c176a5e0 00000001 00000002 c1789f58 c0128a78 
Oct  5 17:03:54 bert kernel:        01000000 00000000 00000000 c02fa120 c1789f68 c0121c74 c1789000 c1789f78 
Oct  5 17:03:54 bert kernel:        c0119f01 6910d4c0 000f41fa c039a180 c176a5e0 c176a7bc c1789000 c1789000 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [serio_thread+150/272] serio_thread+0x96/0x110
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: reiserfs/0    S 00000001     0   665      5          1026    52 (L-TLB)
Oct  5 17:03:54 bert kernel: dfe54f3c 00000046 00000000 00000001 00000000 00000c6e 00000003 00000000 
Oct  5 17:03:54 bert kernel:        0000014d 00000000 00000000 00000000 c17fda58 00000001 00000003 dfe54000 
Oct  5 17:03:54 bert kernel:        00000000 b60e6840 000f420f c039a180 c176a070 c176a24c e081211c 00000246 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [worker_thread+536/608] worker_thread+0x218/0x260
Oct  5 17:03:54 bert kernel:  [kthread+138/208] kthread+0x8a/0xd0
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: kjournald     S 3639B1FF     0   952      1          1018   635 (L-TLB)
Oct  5 17:03:54 bert kernel: df606f64 00000046 c0118a85 3639b1ff 00002b7f 00002b7f df606000 df606f3c 
Oct  5 17:03:54 bert kernel:        00000000 00000000 ffffffff 00000286 c1503424 00000001 00000003 df606000 
Oct  5 17:03:54 bert kernel:        00000000 25128b80 000f4202 c039a180 df8d0110 df8d02ec df606000 c15033e0 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [pg0+542709087/1069822976] kjournald+0x22f/0x250 [jbd]
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: portmap       S 00000000     0  1018      1          1027   952 (NOTLB)
Oct  5 17:03:54 bert kernel: df65bf14 00000086 00000020 00000000 00001fc0 00000001 00000000 df8d1160 
Oct  5 17:03:54 bert kernel:        00000b47 00000000 00000000 000000d0 df65bf34 00000000 df54d560 df65bfa0 
Oct  5 17:03:54 bert kernel:        df65bef8 91413f40 000f4202 c039a180 df8d1160 df8d133c 00000000 7fffffff 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+162/176] schedule_timeout+0xa2/0xb0
Oct  5 17:03:54 bert kernel:  [do_poll+148/192] do_poll+0x94/0xc0
Oct  5 17:03:54 bert kernel:  [sys_poll+406/560] sys_poll+0x196/0x230
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: rpciod/0      S 00800000     0  1026      5                 665 (L-TLB)
Oct  5 17:03:54 bert kernel: df262f3c 00000046 c01124c9 00800000 00000000 00000000 df262f00 01000000 
Oct  5 17:03:54 bert kernel:        00000000 00000000 df262f94 00010000 df262000 dfe890e0 df262000 df262f3c 
Oct  5 17:03:54 bert kernel:        c0124d9c 8526b700 000f4200 c039a180 dfe890e0 dfe892bc df262000 dff72e2c 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [worker_thread+536/608] worker_thread+0x218/0x260
Oct  5 17:03:54 bert kernel:  [kthread+138/208] kthread+0x8a/0xd0
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: lockd         S 00000000     0  1027      1          1235  1018 (L-TLB)
Oct  5 17:03:54 bert kernel: df8aaf10 00000046 00000000 00000000 0011709d 00000000 df8aaefc c01124c9 
Oct  5 17:03:54 bert kernel:        0005ba7b 00000000 00000000 00000331 004ac4e2 00000000 00000000 00000000 
Oct  5 17:03:54 bert kernel:        c1728b30 8535f940 000f4200 c039a180 dfe88b70 dfe88d4c c14fc400 7fffffff 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+162/176] schedule_timeout+0xa2/0xb0
Oct  5 17:03:54 bert kernel:  [pg0+544038087/1069822976] svc_recv+0x437/0x560 [sunrpc]
Oct  5 17:03:54 bert kernel:  [pg0+544142057/1069822976] lockd+0x129/0x290 [lockd]
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: rc            S DFE5BEE8     0  1235      1  1554    1251  1027 (NOTLB)
Oct  5 17:03:54 bert kernel: dfe5bf18 00000086 dfe636a0 dfe5bee8 c0144daf df4f03c0 dfe97080 1f224065 
Oct  5 17:03:54 bert kernel:        0000dfaf 00000000 dfe636a0 dfe636cc df847ac4 dfe5bfb4 c0110a8a 00000001 
Oct  5 17:03:54 bert kernel:        ffffffff a177a340 000f4202 c039a180 df8d16d0 df8d18ac dfe5b000 00000004 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [do_wait+582/1200] do_wait+0x246/0x4b0
Oct  5 17:03:54 bert kernel:  [sys_waitpid+37/39] sys_waitpid+0x25/0x27
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: syslogd       S C02FACA4     0  1251      1          1254  1235 (NOTLB)
Oct  5 17:03:54 bert kernel: df248eb4 00000086 00000000 c02faca4 00000000 00000001 df248eac c013968a 
Oct  5 17:03:54 bert kernel:        00000151 00000000 df248ea0 c0122535 00000001 00000000 df26f7b0 00000010 
Oct  5 17:03:54 bert kernel:        c02faeec e211e180 000f421c c039a180 df26f7b0 df26f98c 00000000 7fffffff 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+162/176] schedule_timeout+0xa2/0xb0
Oct  5 17:03:54 bert kernel:  [do_select+614/688] do_select+0x266/0x2b0
Oct  5 17:03:54 bert kernel:  [sys_select+577/1264] sys_select+0x241/0x4f0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: klogd         R running     0  1254      1          1355  1251 (NOTLB)
Oct  5 17:03:54 bert kernel: automount     S C013968A     0  1355      1          1361  1254 (NOTLB)
Oct  5 17:03:54 bert kernel: dffbff14 00000086 dffbfefc c013968a c0119bc7 00000000 00000000 00000000 
Oct  5 17:03:54 bert kernel:        0000000b 00000000 df26ecd0 00000010 c02faeec 00000000 000000d0 de89fe20 
Oct  5 17:03:54 bert kernel:        00000000 33c9ae40 000f421d c039a180 df26ecd0 df26eeac 00000000 7fffffff 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+162/176] schedule_timeout+0xa2/0xb0
Oct  5 17:03:54 bert kernel:  [do_poll+148/192] do_poll+0x94/0xc0
Oct  5 17:03:54 bert kernel:  [sys_poll+406/560] sys_poll+0x196/0x230
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: dbus-daemon-1 S DF752260     0  1361      1          1374  1355 (NOTLB)
Oct  5 17:03:54 bert kernel: df2e1f14 00000086 b7f35c90 df752260 df2e1ee8 00000001 00000000 df3117d0 
Oct  5 17:03:54 bert kernel:        00040e95 00000000 00000000 000000d0 df75228c 00000000 df34f560 df2e1fa0 
Oct  5 17:03:54 bert kernel:        df2e1ef8 39ee9f40 000f4201 c039a180 df3117d0 df3119ac 00000000 7fffffff 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+162/176] schedule_timeout+0xa2/0xb0
Oct  5 17:03:54 bert kernel:  [do_poll+148/192] do_poll+0x94/0xc0
Oct  5 17:03:54 bert kernel:  [sys_poll+406/560] sys_poll+0x196/0x230
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: famd          S 00000001     0  1374      1          1381  1361 (NOTLB)
Oct  5 17:03:54 bert kernel: df347eb4 00000086 00000000 00000001 df347ea4 c013968a df0cae0c df53a4c0 
Oct  5 17:03:54 bert kernel:        00044444 00000000 00000001 00000000 df26f240 00000010 c02faeec 00000000 
Oct  5 17:03:54 bert kernel:        000000d0 cd559b80 000f4201 c039a180 df26f240 df26f41c 00000000 7fffffff 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+162/176] schedule_timeout+0xa2/0xb0
Oct  5 17:03:54 bert kernel:  [do_select+614/688] do_select+0x266/0x2b0
Oct  5 17:03:54 bert kernel:  [sys_select+577/1264] sys_select+0x241/0x4f0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: gkrellmd      S 00000001     0  1381      1          1386  1374 (NOTLB)
Oct  5 17:03:54 bert kernel: de85eeb4 00000086 00000000 00000001 de85eea4 c013968a de76dfff 37363430 
Oct  5 17:03:54 bert kernel:        00026443 00000000 00000001 00000000 df26e1f0 00000010 c02faeec 00000000 
Oct  5 17:03:54 bert kernel:        de85eec8 6adccd40 000f421d c039a180 df26e1f0 df26e3cc fffdbd1b de85eec8 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+87/176] schedule_timeout+0x57/0xb0
Oct  5 17:03:54 bert kernel:  [do_select+614/688] do_select+0x266/0x2b0
Oct  5 17:03:54 bert kernel:  [sys_select+577/1264] sys_select+0x241/0x4f0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: inetd         S 00000001     0  1386      1          1392  1381 (NOTLB)
Oct  5 17:03:54 bert kernel: df7a9eb4 00000086 00000000 00000001 df7a9ea4 c013968a 00000010 00000020 
Oct  5 17:03:54 bert kernel:        000114e7 00000000 00000001 00000000 df26e760 00000010 c02faeec 00000000 
Oct  5 17:03:54 bert kernel:        000000d0 2ffae740 000f4202 c039a180 df26e760 df26e93c 00000000 7fffffff 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+162/176] schedule_timeout+0xa2/0xb0
Oct  5 17:03:54 bert kernel:  [do_select+614/688] do_select+0x266/0x2b0
Oct  5 17:03:54 bert kernel:  [sys_select+577/1264] sys_select+0x241/0x4f0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: lisa          S 00000001     0  1392      1          1410  1386 (NOTLB)
Oct  5 17:03:54 bert kernel: de68beb4 00000086 00000000 00000001 de68bea4 c013968a 00000000 00000000 
Oct  5 17:03:54 bert kernel:        0000009a 00000000 00000001 00000000 df8d0bf0 00000010 c02faeec 00000000 
Oct  5 17:03:54 bert kernel:        de68bec8 57d8bfc0 000f421c c039a180 df8d0bf0 df8d0dcc fffdc51f de68bec8 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+87/176] schedule_timeout+0x57/0xb0
Oct  5 17:03:54 bert kernel:  [do_select+614/688] do_select+0x266/0x2b0
Oct  5 17:03:54 bert kernel:  [sys_select+577/1264] sys_select+0x241/0x4f0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: smail         S 00000001     0  1410      1  1415    1418  1392 (NOTLB)
Oct  5 17:03:54 bert kernel: de70beb4 00000082 00000000 00000001 de70bea4 c013968a 00000000 00000000 
Oct  5 17:03:54 bert kernel:        00028612 00000000 00000001 00000000 df8d0680 00000010 c02faeec 00000000 
Oct  5 17:03:54 bert kernel:        000000d0 ff0b7000 000f4201 c039a180 df8d0680 df8d085c 00000000 7fffffff 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+162/176] schedule_timeout+0xa2/0xb0
Oct  5 17:03:54 bert kernel:  [do_select+614/688] do_select+0x266/0x2b0
Oct  5 17:03:54 bert kernel:  [sys_select+577/1264] sys_select+0x241/0x4f0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: smail         Z DF27F9BC     0  1415   1410                     (L-TLB)
Oct  5 17:03:54 bert kernel: de7e6f84 00000046 00000000 df27f9bc 00000000 de7e6f48 00000296 00000000 
Oct  5 17:03:54 bert kernel:        00028612 00000000 df310210 00000000 c15415f0 de7e6f84 c011aa5f df3102f4 
Oct  5 17:03:54 bert kernel:        df310334 ff0b7000 000f4201 c039a180 df310210 df3103ec 00000001 00000000 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [do_exit+579/1072] do_exit+0x243/0x430
Oct  5 17:03:54 bert kernel:  [do_group_exit+54/160] do_group_exit+0x36/0xa0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: sshd          S 00000001     0  1418      1          1452  1410 (NOTLB)
Oct  5 17:03:54 bert kernel: de7eceb4 00000082 00000000 00000001 de7ecea4 c013968a 00000000 00000000 
Oct  5 17:03:54 bert kernel:        0014d55d 00000000 00000001 00000000 df310780 00000010 c02faeec 00000000 
Oct  5 17:03:54 bert kernel:        000000d0 14439100 000f4202 c039a180 df310780 df31095c 00000000 7fffffff 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+162/176] schedule_timeout+0xa2/0xb0
Oct  5 17:03:54 bert kernel:  [do_select+614/688] do_select+0x266/0x2b0
Oct  5 17:03:54 bert kernel:  [sys_select+577/1264] sys_select+0x241/0x4f0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: xfs           S C02FACA4     0  1452      1          1527  1418 (NOTLB)
Oct  5 17:03:54 bert kernel: de388eb4 00000082 00000000 c02faca4 00000000 00000001 de388eac c013968a 
Oct  5 17:03:54 bert kernel:        007286a9 00000000 c02fab20 df555284 00000001 00000000 dfe88600 00000000 
Oct  5 17:03:54 bert kernel:        de388ec8 8fc3c700 000f4202 c039a180 dfe88600 dfe887dc 00051bce de388ec8 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+87/176] schedule_timeout+0x57/0xb0
Oct  5 17:03:54 bert kernel:  [do_select+614/688] do_select+0x266/0x2b0
Oct  5 17:03:54 bert kernel:  [sys_select+577/1264] sys_select+0x241/0x4f0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: bash          S DDE69EE8     0  1527      1  1528    1540  1452 (NOTLB)
Oct  5 17:03:54 bert kernel: dde69f18 00000082 dfe63040 dde69ee8 c0144daf ddea038c df7a8080 1df28065 
Oct  5 17:03:54 bert kernel:        00031141 00000000 dfe63040 dfe6306c df8d96a4 dde69fb4 c0110a8a 00000001 
Oct  5 17:03:54 bert kernel:        ffffffff 769c9180 000f4202 c039a180 dde73280 dde7345c dde69000 00000004 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [do_wait+582/1200] do_wait+0x246/0x4b0
Oct  5 17:03:54 bert kernel:  [sys_waitpid+37/39] sys_waitpid+0x25/0x27
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: bash          S DE3F4EE8     0  1528   1527  1529    1532       (NOTLB)
Oct  5 17:03:54 bert kernel: de3f4f18 00000086 df752d00 de3f4ee8 c0144daf dde8f4b8 dffc2080 1deb7065 
Oct  5 17:03:54 bert kernel:        00031141 00000000 df752d00 df752d2c df53b3e4 de3f4fb4 c0110a8a 00000001 
Oct  5 17:03:54 bert kernel:        c0103e4b 768d4f40 000f4202 c039a180 dfe89650 dfe8982c de3f4000 00000004 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [do_wait+582/1200] do_wait+0x246/0x4b0
Oct  5 17:03:54 bert kernel:  [sys_waitpid+37/39] sys_waitpid+0x25/0x27
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: Xprt          S C02FACA4     0  1529   1528                     (NOTLB)
Oct  5 17:03:54 bert kernel: ddf08eb4 00000082 00000000 c02faca4 00000000 00000001 ddf08eac c013968a 
Oct  5 17:03:54 bert kernel:        004c15c0 00000000 c02fab20 dfe7043c 00000001 00000000 ddf15810 00000000 
Oct  5 17:03:54 bert kernel:        ddf08ec8 dbc2bbc0 000f4202 c039a180 ddf15810 ddf159ec 000520bb ddf08ec8 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+87/176] schedule_timeout+0x57/0xb0
Oct  5 17:03:54 bert kernel:  [do_select+614/688] do_select+0x266/0x2b0
Oct  5 17:03:54 bert kernel:  [sys_select+577/1264] sys_select+0x241/0x4f0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: bash          S C02FAB20     0  1532   1527                1528 (NOTLB)
Oct  5 17:03:54 bert kernel: ddea3ed0 00000086 df04d3e4 c02fab20 df04d3e4 00000212 ddea3ec0 c01449b7 
Oct  5 17:03:54 bert kernel:        00031141 00000000 ddea3ec0 c0143bd5 00000000 dfe5556c 0809cfb0 df04d3e4 
Oct  5 17:03:54 bert kernel:        df7526a0 769c9180 000f4202 c039a180 dde727a0 dde7297c de89e940 de89e8d0 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [pipe_wait+120/176] pipe_wait+0x78/0xb0
Oct  5 17:03:54 bert kernel:  [pipe_readv+393/624] pipe_readv+0x189/0x270
Oct  5 17:03:54 bert kernel:  [pipe_read+31/48] pipe_read+0x1f/0x30
Oct  5 17:03:54 bert kernel:  [vfs_read+224/288] vfs_read+0xe0/0x120
Oct  5 17:03:54 bert kernel:  [sys_read+61/112] sys_read+0x3d/0x70
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: rpc.statd     S C02FACA4     0  1540      1          1553  1527 (NOTLB)
Oct  5 17:03:54 bert kernel: dde92eb4 00000082 00000000 c02faca4 00000000 00000001 dde92eac c013968a 
Oct  5 17:03:54 bert kernel:        0008b4db 00000000 00000246 c02faca4 00000001 00000000 dde72d10 00000010 
Oct  5 17:03:54 bert kernel:        c02faeec 91413f40 000f4202 c039a180 dde72d10 dde72eec 00000000 7fffffff 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+162/176] schedule_timeout+0xa2/0xb0
Oct  5 17:03:54 bert kernel:  [do_select+614/688] do_select+0x266/0x2b0
Oct  5 17:03:54 bert kernel:  [sys_select+577/1264] sys_select+0x241/0x4f0
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: arpwatch      S DDFE1C94     0  1553      1          1941  1540 (NOTLB)
Oct  5 17:03:54 bert kernel: ddfe1ce4 00000086 7fffffff ddfe1c94 c0133a98 ddfe1ca8 c0105c8f ddfe1cbc 
Oct  5 17:03:54 bert kernel:        00000eb0 00000000 ffffffff c010419c 00000000 00000000 00000000 7fffffff 
Oct  5 17:03:54 bert kernel:        ddfe1d50 eeb4be80 000f421c c039a180 ddf147c0 ddf1499c 00000000 7fffffff 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [schedule_timeout+162/176] schedule_timeout+0xa2/0xb0
Oct  5 17:03:54 bert kernel:  [wait_for_packet+226/304] wait_for_packet+0xe2/0x130
Oct  5 17:03:54 bert kernel:  [skb_recv_datagram+122/208] skb_recv_datagram+0x7a/0xd0
Oct  5 17:03:54 bert kernel:  [pg0+542639585/1069822976] packet_recvmsg+0x51/0x140 [af_packet]
Oct  5 17:03:54 bert kernel:  [sock_recvmsg+188/240] sock_recvmsg+0xbc/0xf0
Oct  5 17:03:54 bert kernel:  [sys_recvfrom+129/224] sys_recvfrom+0x81/0xe0
Oct  5 17:03:54 bert kernel:  [sys_socketcall+431/560] sys_socketcall+0x1af/0x230
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: S40hotplug    S DE847EE8     0  1554   1235  2062               (NOTLB)
Oct  5 17:03:54 bert kernel: de847f18 00000082 df752ae0 de847ee8 c0144daf dd8fc3cc ddea5080 1d5c6065 
Oct  5 17:03:54 bert kernel:        0000cec0 00000000 df752ae0 df752b0c df53b9bc de847fb4 c0110a8a 00000001 
Oct  5 17:03:54 bert kernel:        ffffffff 50d2fec0 000f4203 c039a180 c176ab50 c176ad2c de847000 00000004 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [do_wait+582/1200] do_wait+0x246/0x4b0
Oct  5 17:03:54 bert kernel:  [sys_waitpid+37/39] sys_waitpid+0x25/0x27
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: khpsbpkt      S DF4F1DDC     0  1941      1          1954  1553 (L-TLB)
Oct  5 17:03:54 bert kernel: de232f84 00000046 c0112570 df4f1ddc 00000000 de232f48 00000296 00000000 
Oct  5 17:03:54 bert kernel:        00002d19 00000000 01000000 000f4203 0000000f 00000000 80bf0fc0 000f4203 
Oct  5 17:03:54 bert kernel:        80bf0fc0 80bf0fc0 000f4203 c039a180 dde72230 dde7240c e0c40058 00000246 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [__down_interruptible+156/376] __down_interruptible+0x9c/0x178
Oct  5 17:03:54 bert kernel:  [__down_failed_interruptible+10/16] __down_failed_interruptible+0xa/0x10
Oct  5 17:03:54 bert kernel:  [pg0+545720938/1069822976] .text.lock.ieee1394_core+0xf/0x15 [ieee1394]
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: knodemgrd_0   S DD695F28     0  1954      1                1941 (L-TLB)
Oct  5 17:03:54 bert kernel: dd695f6c 00000046 000000d0 dd695f28 00000202 dd31e6c0 000000d0 dd695f38 
Oct  5 17:03:54 bert kernel:        00000000 00000000 dcde1f60 0000a1ff dd695f54 c0185d73 0000a1ff dd31e6c0 
Oct  5 17:03:54 bert kernel:        dd31e6c0 80bf0fc0 000f4203 c039a180 dd6b6d50 dd6b6f2c dcda14d0 00000246 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [__down_interruptible+156/376] __down_interruptible+0x9c/0x178
Oct  5 17:03:54 bert kernel:  [__down_failed_interruptible+10/16] __down_failed_interruptible+0xa/0x10
Oct  5 17:03:54 bert kernel:  [pg0+545751169/1069822976] .text.lock.nodemgr+0x10f/0x1ae [ieee1394]
Oct  5 17:03:54 bert kernel:  [kernel_thread_helper+5/16] kernel_thread_helper+0x5/0x10
Oct  5 17:03:54 bert kernel: usb.rc        S DE36BEE8     0  2062   1554  2064               (NOTLB)
Oct  5 17:03:54 bert kernel: de36bf18 00000086 dff056c0 de36bee8 c0144daf dd5ba3e0 dd6f7080 1d796065 
Oct  5 17:03:54 bert kernel:        00000000 00000000 dff056c0 dff056ec df8d922c de36bfb4 c0110a8a 00000001 
Oct  5 17:03:54 bert kernel:        ffffffff 529cc240 000f4203 c039a180 df310cf0 df310ecc de36b000 00000004 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [do_wait+582/1200] do_wait+0x246/0x4b0
Oct  5 17:03:54 bert kernel:  [sys_waitpid+37/39] sys_waitpid+0x25/0x27
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:03:54 bert kernel: grep          D 00000000     0  2064   2062                     (NOTLB)
Oct  5 17:03:54 bert kernel: dd6e7ed8 00000086 dd6a7080 00000000 dd6e7ec0 c0144849 dd6a7080 00000001 
Oct  5 17:03:54 bert kernel:        00000000 00000000 00000000 00000000 08065d64 dd699c24 dff054a0 00000001 
Oct  5 17:03:54 bert kernel:        dd6a7080 529cc240 000f4203 c039a180 dd6b72c0 dd6b749c c14ee824 00000246 
Oct  5 17:03:54 bert kernel: Call Trace:
Oct  5 17:03:54 bert kernel:  [__down+124/320] __down+0x7c/0x140
Oct  5 17:03:54 bert kernel:  [__down_failed+11/20] __down_failed+0xb/0x14
Oct  5 17:03:54 bert kernel:  [.text.lock.usb+19/166] .text.lock.usb+0x13/0xa6
Oct  5 17:03:54 bert kernel:  [usb_device_read+179/304] usb_device_read+0xb3/0x130
Oct  5 17:03:54 bert kernel:  [vfs_read+224/288] vfs_read+0xe0/0x120
Oct  5 17:03:54 bert kernel:  [sys_read+61/112] sys_read+0x3d/0x70
Oct  5 17:03:54 bert kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct  5 17:04:27 bert kernel: SysRq : Emergency Sync
Oct  5 17:04:27 bert kernel: Emergency Sync complete







