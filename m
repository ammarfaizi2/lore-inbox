Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269092AbUJUJVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269092AbUJUJVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269020AbUJUJU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 05:20:27 -0400
Received: from smtp2.netcabo.pt ([212.113.174.29]:19737 "EHLO
	exch01smtp10.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S268368AbUJUJNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 05:13:38 -0400
Message-ID: <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
In-Reply-To: <20041020094508.GA29080@elte.hu>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
    <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
    <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
    <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
    <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>
    <20041020094508.GA29080@elte.hu>
Date: Thu, 21 Oct 2004 10:12:56 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041021101256_48369"
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 21 Oct 2004 09:13:33.0621 (UTC) FILETIME=[3D40DE50:01C4B74E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041021101256_48369
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Ingo Molnar wrote:
>
> i have released the -U8 Real-Time Preemption patch:
>
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8
>

Hi,

   I'm posting this time about to report my current status of my two
boxes, regarding the realtime-preempt-2.6.9-rc4-mm1-U8 patch. So it
seems that now the positions have been somewhat reversed. Respective
config.gz are attached.


a) Desktop P4 2.80C@3.3Ghz SMP/HT (SuSE 9.1 Pro)
   config-2.6.9-rc4-mm1-RT-U8.0smp.gz

   This is apparently but surprinsingly OK, as everything seems to work
flawlessly, besides some quirks on the onboard NIC (sk98lin) that only
shows up initially but stabilizes later on. Indeed, U8 is the first
SMP+PREEMPT_REALTIME encarnation that runs at all and is fairly
workable on this machine. This is a relief.


b) Laptop P4 2.533Ghz UP (Mandrake 10.1c)
   config-2.6.9-rc4-mm1-RT-U8.1.gz

   This box was known to work without major issues until U4. With U8 it's
a real pain. Once trivial operations turns out fatal now. Running jackd
-R, which has been a flagship before, now freezes the whole system in
no time. (I'll take some netconsole capture sessions later)

   One of the signs that there's real trouble in here can be seen on the
following complete dmesg output (which was even a miracle to be
captured at all). This shows the complete bootstrap and init sequences
and at the end one fatal crash while plugging an USB flash memory stick
(usb-storage). This has been already reported earlier yesterday, but I
just want to make it here, as the evidence-at-hand.

   After this precise occurence, the system becomes very flaky, unreliable
and often ends up freezing to death.


Hope this helps (me)

Bye now.
--
Linux version 2.6.9-rc4-mm1-RT-U8.1 (root@lambda) (gcc version 3.4.1
(Mandrakelinux (Alpha 3.4.1-3mdk)) #1 Thu Oct 21 09:08:18 WEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001f770000 (usable)
 BIOS-e820: 000000001f770000 - 000000001f77f000 (ACPI data)
 BIOS-e820: 000000001f77f000 - 000000001f780000 (ACPI NVS)
 BIOS-e820: 000000001f780000 - 000000001f800000 (reserved)
 BIOS-e820: 000000002f780000 - 000000002f800000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
503MB LOWMEM available.
On node 0 totalpages: 128880
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 124784 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6c70
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x1f7783fd
ACPI: FADT (v001 ATI    Salmon   0x06040000 ATI  0x000f4240) @ 0x1f77ef64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x1f77efd8
ACPI: DSDT (v001    ATI MS2_1535 0x06040000 MSFT 0x0100000e) @ 0x00000000
Built 1 zonelists
No local APIC present or hardware disabled
Initializing CPU#0
Kernel command line: BOOT_IMAGE=linux-RT-U8.1 ro root=305 devfs=nomount
acpi=on
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2525.698 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 507728k/515520k available (1791k kernel code, 7300k reserved, 591k
data, 152k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 4931.58 BogoMIPS (lpj=2465792)
Security Scaffold v1.0.0 initialized
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebf9ff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebf9ff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: After all inits, caps:        bfebf9ff 00000000 00000000 00000080
CPU: Intel(R) Pentium(R) 4 CPU 2.53GHz stepping 07
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: IRQ9 SCI: Edge set to Level Trigger.
ksoftirqd started up.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd88b, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK0] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK2] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK3] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK4] (IRQs 7 *10)
ACPI: PCI Interrupt Link [LNK5] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNK6] (IRQs 7 10) *0, disabled.
ACPI: PCI Interrupt Link [LNK7] (IRQs *5)
ACPI: PCI Interrupt Link [LNK8] (IRQs 7 *10)
ACPI: Embedded Controller [EC0] (gpe 24)
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Simple Boot Flag at 0x37 set to 0x1
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Activating ISA DMA hang workarounds.
Real Time Clock Driver v1.12
ACPI: PS/2 Keyboard Controller [KBC0] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [MSE0] at irq 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PCI: Enabling device 0000:00:08.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNK6] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 10 (level, low) -> IRQ 10
ttyS0 at I/O 0x1428 (irq = 10) is a 8250
ttyS2 at I/O 0x1440 (irq = 10) is a 8250
ttyS3 at I/O 0x1450 (irq = 10) is a 8250
ttyS4 at I/O 0x1460 (irq = 10) is a 8250
ttyS5 at I/O 0x1470 (irq = 10) is a 8250
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
ACPI: Floppy Controller [FDC] at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma channel 2
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: PCI interrupt 0000:00:10.0[A]: no GSI
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: IC25N040ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.8
 Sensor: 35
 new absolute packet format
 Touchpad has extended capability bits
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
NET: Registered protocol family 2
IP: routing cache hash table of 128 buckets, 20Kbytes
TCP: Hash tables configured (established 1024 bind 1638)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
kjournald starting.  Commit interval 5 seconds
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (52 C)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNK8] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: irq 10, pci mem 0xd4000000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:0f.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:0f.0: OHCI Host Controller
ohci_hcd 0000:00:0f.0: irq 10, pci mem 0xd4009000
ohci_hcd 0000:00:0f.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
usb usb2: string descriptor 0 read error: -113
usb usb2: string descriptor 0 read error: -113
usb usb2: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb2: string descriptor 0 read error: -113
usb usb2: string descriptor 0 read error: -113
usb usb2: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
usb usb1: string descriptor 0 read error: -113
EXT3 FS on hda5, internal journal
Adding 506008k swap on /dev/hda6.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
subfs 0.9
loop: loaded (max 8 devices)
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:12.0[A] -> GSI 10 (level, low) -> IRQ 10
natsemi eth0: NatSemi DP8381[56] at 0xd400a000 (0000:00:12.0),
00:0b:cd:85:0f:54, IRQ 10, port TP.
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: Enabling device 0000:00:0a.0 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNK5] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 11 (level, low) -> IRQ 11
Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0850]
Yenta: ISA IRQ mask 0x00b8, PCI irq 11
Socket status: 30000007
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x408-0x40f 0x480-0x48f
0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
prism2_cs: Ignoring new-style parameters in presence of obsolete ones
prism2cs_init: prism2_cs.o: 0.2.1-pre22 Loaded
prism2cs_init: dev_info is: prism2_cs
PCI: Enabling device 0000:00:06.0 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNK7] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
usbcore: registered new driver snd-usb-usx2y
Realtime LSM initialized (group 81, mlock=1)
mtrr: no more MTRRs available
ohci_hcd 0000:00:0f.0: wakeup
usb 2-1: new full speed USB device using address 2
Initializing USB Mass Storage driver...
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
------------[ cut here ]------------
kernel BUG at lib/rwsem-generic.c:598!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: usb_storage realtime commoncap snd_seq_oss
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_usb_usx2y
snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep snd_ali5451
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd soundcore prism2_cs
p80211 ds yenta_socket pcmcia_core natsemi crc32 loop subfs evdev ohci_hcd
usbcore thermal processor fan button battery ac
CPU:    0
EIP:    0060:[<c01b7e24>]    Not tainted VLI
EFLAGS: 00010202   (2.6.9-rc4-mm1-RT-U8.1)
EIP is at up_write+0x1d4/0x202
eax: d4dce000   ebx: 00000292   ecx: d4e18980   edx: d52da030
esi: d4e69e24   edi: d5803400   ebp: d4dcfd6c   esp: d4dcfd4c
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process usb-stor (pid: 6630, threadinfo=d4dce000 task=d4dcd8f0)
Stack: d4dcd8f0 d4dcfd78 c02bea7a 00000001 d4dcd8f0 00000292 d4e18980
d5803400
       d4dcfd84 e018e139 d4e18980 d4dcfd84 00000292 d58034b8 d4dcfdac
c022ed0c
       d4e18980 c022ef10 c023166d 00000000 d4e189d4 d4e18980 dcf21000
d5803400
Call Trace:
 [<c0104eb0>] show_stack+0x80/0x96 (28)
 [<c010504b>] show_registers+0x165/0x1de (56)
 [<c010525d>] die+0xf6/0x191 (64)
 [<c0105797>] do_invalid_op+0x10b/0x10d (188)
 [<c0104b0d>] error_code+0x2d/0x38 (100)
 [<e018e139>] queuecommand+0x70/0x7c [usb_storage] (24)
 [<c022ed0c>] scsi_dispatch_cmd+0x168/0x218 (40)
 [<c02342e1>] scsi_request_fn+0x1ee/0x42b (52)
 [<c0205606>] blk_insert_request+0xcd/0xfb (44)
 [<c0232f43>] scsi_insert_special_req+0x3b/0x3f (28)
 [<c0233175>] scsi_wait_req+0x61/0x94 (60)
 [<c0235290>] scsi_probe_lun+0x8e/0x240 (68)
 [<c0235883>] scsi_probe_and_add_lun+0xb0/0x1be (48)
 [<c0236009>] scsi_scan_target+0xa4/0x123 (60)
 [<c0236115>] scsi_scan_channel+0x8d/0xa4 (48)
 [<c02361a5>] scsi_scan_host_selected+0x79/0xd4 (44)
 [<c0236231>] scsi_scan_host+0x31/0x33 (28)
 [<e0190cbd>] usb_stor_scan_thread+0x144/0x155 [usb_storage] (96)
 [<c0102305>] kernel_thread_helper+0x5/0xb (723714068)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: die+0x3a/0x191 / (do_invalid_op+0x10b/0x10d)
.. entry 2: print_traces+0x16/0x4a / (show_stack+0x80/0x96)

Code: e8 af f9 ff ff 89 f8 e8 fd af f5 ff e9 35 ff ff ff 0f 0b a5 00 e3 e8
2c c0 e9 da fe ff ff 0f 0b a4 00 e3 e8 2c c0 e9 c4 fe ff ff <0f> 0b 56 02
6f 75 2d c0 e9 3c fe ff ff e8 a8 5b 10 00 e9 22 ff
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org
------=_20041021101256_48369
Content-Type: application/x-gzip-compressed;
      name="config-2.6.9-rc4-mm1-RT-U8.0smp.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
      filename="config-2.6.9-rc4-mm1-RT-U8.0smp.gz"

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
D17ny77DewAA
------=_20041021101256_48369
Content-Type: application/x-gzip-compressed;
      name="config-2.6.9-rc4-mm1-RT-U8.1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config-2.6.9-rc4-mm1-RT-U8.1.gz"

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
2v5/HudWanSCAAA=
------=_20041021101256_48369--


