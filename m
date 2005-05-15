Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVEORvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVEORvE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 13:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVEORvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 13:51:04 -0400
Received: from mail.aei.ca ([206.123.6.14]:64456 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261172AbVEORtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 13:49:36 -0400
Subject: 2.6.12-rc4 Oops, EIP is at cache_alloc_refill
From: Shane Shrybman <shrybman@aei.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 15 May 2005 13:49:18 -0400
Message-Id: <1116179359.5542.32.camel@mars>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  (Please CC me)

I am trying to stabilize a new box built on an ASUS A7N8X-X board
(nforce2). It is for a Home theater PC, (dmesg output at bottom). I am
using the ivtv drivers for the MPEG2 card as well as lirc and the
realtime module. I am also using dm striping across two ide disks on a
Promise TX133 and using NFSv3 to share that storage.  

I have been working on this for a few weeks trying noapic, nolapic,
acpi=off, various bios options, (bios is at the latest level), etc. with
no success. I have tried two brand new sticks of ram with the same
results.

The Oopsen come at random times but seem more likely when both the ivtv
and bttv cards are going at the same time.

Do these oopsen point to a kernel problem or should I go get another
motherboard? (non-nforce!)

0000:00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev c1)
0000:00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 0
(rev c1)
0000:00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4
(rev c1)
0000:00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3
(rev c1)
0000:00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2
(rev c1)
0000:00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5
(rev c1)
0000:00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
0000:00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
0000:00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4)
0000:00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4)
0000:00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller
(rev a4)
0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet
Controller (rev a1)
0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce2
AC97 Audio Controler (MCP) (rev a1)
0000:00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge
(rev a3)
0000:00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
0000:00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
0000:01:07.0 Multimedia video controller: Internext Compression Inc
iTVC16 (CX23416) MPEG-2 Encoder (rev 01)
0000:01:08.0 Multimedia audio controller: C-Media Electronics Inc CM8738
(rev 10)
0000:01:09.0 Multimedia video controller: Brooktree Corporation Bt878
Video Capture (rev 11)
0000:01:09.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
0000:01:0a.0 Unknown mass storage controller: Promise Technology, Inc.
20269 (rev 02)
0000:02:00.0 VGA compatible controller: nVidia Corporation NV11
[GeForce2 MX/MX 400] (rev a1)

Oops with: elevator=cfq noapic nolapic acpi=off

kernel: saa7115: decoder enable output
kernel: c0141b42
kernel: PREEMPT 
kernel: Modules linked in: lirc_i2c lirc_dev msp3400 saa7115 ivtv nfsd
exportfs lockd sunrpc i2c_nforce2 nvidia_agp tuner tvaudio bttv
video_buf firmware_class btcx_risc tveeprom snd_cm
snd_opl3_lib snd_hwdep snd_mpu401_uart snd_rawmidi snd_seq_device
snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer
snd soundcore snd_page_alloc forcedeth ehci_hcd ohci_hcd
usbcore agpgart dm_mod realtime rtc
kernel: CPU:    0
kernel: EIP:    0060:[cache_alloc_refill+210/544]    Not tainted VLI
kernel: EFLAGS: 00010046   (2.6.12-rc4) 
kernel: EIP is at cache_alloc_refill+0xd2/0x220
kernel: eax: 55596267   ebx: c14dda00   ecx: 00000023   edx: dffe75ec
kernel: esi: d3af7000   edi: d3af7018   ebp: c14dda10   esp: dade7c40
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process nfsd (pid: 2907, threadinfo=dade6000 task=dad87a00)
kernel: Stack: 000000d0 ffffffff c7504258 d3af7018 dffe75ec dffe75f4
00000296 00000648 
kernel:        c9e3e100 000000d0 c0141e8e dffe75e0 000000d0 ce46ee20
c029e505 dffe75e0 
kernel:        000000d0 ce46ee20 00000000 c9e3e100 d99ea480 c02c14b8
00000648 000000d0 
kernel: Call Trace:
kernel:  [kmem_cache_alloc+62/64] kmem_cache_alloc+0x3e/0x40
kernel:  [alloc_skb+37/224] alloc_skb+0x25/0xe0
kernel:  [tcp_sendmsg+2248/4000] tcp_sendmsg+0x8c8/0xfa0
kernel:  [avc_alloc_node+28/400] avc_alloc_node+0x1c/0x190
kernel:  [inet_sendmsg+77/96] inet_sendmsg+0x4d/0x60
kernel:  [sock_sendmsg+282/288] sock_sendmsg+0x11a/0x120
kernel:  [__do_page_cache_readahead+231/368] __do_page_cache_readahead
+0xe7/0x170
kernel:  [avc_has_perm+110/144] avc_has_perm+0x6e/0x90
kernel:  [make_ahead_window+122/176] make_ahead_window+0x7a/0xb0
kernel:  [inode_has_perm+85/144] inode_has_perm+0x55/0x90
kernel:  [page_cache_readahead+165/400] page_cache_readahead+0xa5/0x190
kernel:  [autoremove_wake_function+0/96] autoremove_wake_function
+0x0/0x60
kernel:  [find_get_page+45/96] find_get_page+0x2d/0x60
kernel:  [kernel_sendmsg+70/96] kernel_sendmsg+0x46/0x60
kernel:  [sock_no_sendpage+112/128] sock_no_sendpage+0x70/0x80
kernel:  [tcp_sendpage+77/160] tcp_sendpage+0x4d/0xa0
kernel:  [pg0+542560281/1068884992] svc_sendto+0x169/0x2a0 [sunrpc]
kernel:  [pg0+542564685/1068884992] svc_tcp_sendto+0x3d/0xa0 [sunrpc]
kernel:  [pg0+542566764/1068884992] svc_send+0xac/0xf0 [sunrpc]
kernel:  [pg0+542557322/1068884992] svc_process+0x18a/0x640 [sunrpc]
kernel:  [pg0+542950421/1068884992] nfsd+0x1b5/0x350 [nfsd]
kernel:  [pg0+542949984/1068884992] nfsd+0x0/0x350 [nfsd]
kernel:  [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
kernel: Code: 8b 56 10 0f b7 46 14 42 89 56 10 8b 7c 24 0c 0f b7 04 47
66 89 46 14 8b 44 24 2c 3b 50 3c 73 06 49 83 f9 ff 75 c3 8b 56 04 8b 06
<89> 50 04 89 02 c7 46 04 00 02 20 00 66 83 7e 14 ff c7 06 00 01 
kernel:  <6>note: nfsd[2907] exited with preempt_count 1
kernel: ivtv: ENC: User stopped capture.
kernel: Kernel logging (proc) stopped.

Here is an earlier Ooops:

kernel: Unable to handle kernel paging request at virtual address
82807f83
kernel:  printing eip:
kernel: c016adf0
kernel: *pde = 00000000
kernel: Oops: 0000 [#1]
kernel: PREEMPT
kernel: Modules linked in: lirc_i2c lirc_dev msp3400 saa7115 ivtv nfsd
exportfs lockd sunrpc i2c_nforce2 nvidia_agp snd_bt87x tuner tvaudio
bttv video_buf firmware_class btcx_risc tveeprom 3c59x mii snd_cmipci
gameport snd_opl3_lib snd_hwdep snd_mpu401_uart snd_rawmidi
snd_seq_device snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer snd soundcore snd_page_alloc forcedeth ehci_hcd
ohci_hcd usbcore agpgart dm_mod realtime rtc
kernel: CPU:    0
kernel: EIP:    0060:[poll_freewait+16/80]    Not tainted VLI
kernel: EFLAGS: 00010282   (2.6.12-rc4)
kernel: EIP is at poll_freewait+0x10/0x50
kernel: eax: 00000000   ebx: c76a3008   ecx: 00000212   edx: c1334a78
kernel: esi: c76a3008   edi: 82807f7f   ebp: 00000004   esp: da4bded8
kernel: ds: 007b   es: 007b   ss: 0068
kernel: Process sshd (pid: 3335, threadinfo=da4bc000 task=d9f30040)
kernel: Stack: 00000000 00000008 00000004 c016b197 da4bdf38 00000000
00000000 00000000
kernel:        00000008 00000000 00000000 00000008 00000041 00000008
da4bc000 c6386e8c
kernel:        c6386e88 c6386e84 c6386e98 c6386e94 c6386e90 7fffffff
00000001 00000000
kernel: Call Trace:
kernel:  [do_select+439/720] do_select+0x1b7/0x2d0
kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
kernel:  [sys_select+648/1056] sys_select+0x288/0x420
kernel:  [sys_close+97/160] sys_close+0x61/0xa0
kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
kernel: Code: 00 30 ae 16 c0 c7 40 08 00 00 00 00 c7 40 04 00 00 00 00
c3 8d b4 26 00 00 00 00 57 56 53 8b 44 24 10 8b 78 04 85 ff 74 30 89 f6
<8b> 5f 04 8d 77 08 83 eb 1c 8b 43 18 8d 53 04 e8 fc 43 fc ff 8b
kernel:  ivtv: ENC: User stopped capture.

Linux version 2.6.12-rc4 (shane@mars) (gcc version 3.3.5 (Debian
1:3.3.5-2)) #1 Fri May 13 14:40:35 EDT 2005
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: auto BOOT_IMAGE=2.6.12-rc4 root=302 elevator=cfq
noapic nolapic acpi=off
mapped APIC to ffffd000 (01402000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2004.482 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 515012k/524224k available (2083k kernel code, 8656k reserved,
1085k data, 260k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay loop... 3964.92 BogoMIPS (lpj=1982464)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1cbfbff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000020 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Sempron(tm)   2800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfb4a0, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
ACPI: Interpreter disabled.
SCSI subsystem initialized
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: nForce2 C1 Halt Disconnect fixup
Boot video device is 0000:02:00.0
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router default [10de/01e0] at 0000:00:00.0
Machine check exception polling timer started.
Initializing Cryptographic API
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: QUANTUM FIREBALL EL5.1A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
PDC20269: IDE controller at PCI slot 0000:01:0a.0
PDC20269: chipset revision 2
PDC20269: 100% native mode on irq 11
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: ST3200822A, ATA DISK drive
ide2 at 0x9400-0x9407,0x9802 on irq 11
Probing IDE interface ide3...
hdg: ST3200822A, ATA DISK drive
ide3 at 0x9c00-0x9c07,0xa002 on irq 11
Probing IDE interface ide1...
Probing IDE interface ide4...
Probing IDE interface ide5...
hda: max request size: 128KiB
hda: 10018890 sectors (5129 MB) w/418KiB Cache, CHS=10602/15/63,
UDMA(33)
hda: cache flushes not supported
hda: hda1 hda2 hda3
hde: max request size: 1024KiB
hde: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63,
UDMA(100)
hde: cache flushes supported
hde: hde1
hdg: max request size: 1024KiB
hdg: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63,
UDMA(100)
hdg: cache flushes supported
hdg: hdg1
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
EISA: Probing bus 0 at eisa.0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
input: AT Translated Set 2 keyboard on isa0060/serio0
logips2pp: Detected unknown logitech mouse model 11
input: PS/2 Logitech Mouse on isa0060/serio1
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 260k freed
Adding 522104k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda2, internal journal
Real Time Clock Driver v1.12
selinux_register_security:  Registering secondary module realtime
Realtime LSM initialized (group 512, mlock=1)
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
spurious 8259A interrupt: IRQ7.
spurious 8259A interrupt: IRQ15.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on dm-0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Linux agpgart interface v0.101 (c) Dave Jones
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: nVidia Corporation nForce2 USB Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 7, io mem 0xe8002000
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: fminterval a7782edf
ohci_hcd 0000:00:02.0: hcca frame #0003
ohci_hcd 0000:00:02.0: roothub.a 01000203 POTPGT=1 NPS NDP=3
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.0: supports USB remote wakeup
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: nVidia Corporation nForce2 USB Controller
usb usb1: Manufacturer: Linux 2.6.12-rc4 ohci_hcd
usb usb1: SerialNumber: 0000:00:02.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: state 5 ports 3 chg 0000 evt 0000
usb 1-0:1.0: hotplug
ohci_hcd 0000:00:02.0: created debug files
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: nVidia Corporation nForce2 USB Controller (#2)
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.1: irq 5, io mem 0xe8003000
ohci_hcd 0000:00:02.1: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:02.1: OHCI controller state
ohci_hcd 0000:00:02.1: OHCI 1.0, NO legacy support registers
ohci_hcd 0000:00:02.1: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.1: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.1: fminterval a7782edf
ohci_hcd 0000:00:02.1: hcca frame #0003
ohci_hcd 0000:00:02.1: roothub.a 01000203 POTPGT=1 NPS NDP=3
ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.1: supports USB remote wakeup
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: nVidia Corporation nForce2 USB Controller (#2)
usb usb2: Manufacturer: Linux 2.6.12-rc4 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.1
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: global over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
hub 2-0:1.0: no over-current condition exists
hub 2-0:1.0: state 5 ports 3 chg 0000 evt 0000
usb 2-0:1.0: hotplug
ohci_hcd 0000:00:02.1: created debug files
ohci_hcd 0000:00:02.0: suspend root hub
ohci_hcd 0000:00:02.1: suspend root hub
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
ehci_hcd 0000:00:02.2: reset hcs_params 0x102486 dbg=1 cc=2 pcc=4 !ppc
ports=6
ehci_hcd 0000:00:02.2: reset portroute 0 0 1 1 1 0 
ehci_hcd 0000:00:02.2: reset hcc_params a082 caching frame 256/512/1024
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: capability 0001 at a0
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: irq 11, io mem 0xe8004000
ehci_hcd 0000:00:02.2: reset command 080002 (park)=0 ithresh=8
period=1024 Reset HALT
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: init command 010009 (park)=0 ithresh=1 period=256
RUN
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec
2004
ehci_hcd 0000:00:02.2: supports USB remote wakeup
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: nVidia Corporation nForce2 USB Controller
usb usb3: Manufacturer: Linux 2.6.12-rc4 ehci_hcd
usb usb3: SerialNumber: 0000:00:02.2
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 6 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: Single TT
hub 3-0:1.0: TT requires at most 8 FS bit times
hub 3-0:1.0: power on to power good time: 20ms
hub 3-0:1.0: local power source is good
hub 3-0:1.0: state 5 ports 6 chg 0000 evt 0000
usb 3-0:1.0: hotplug
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.31.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 01043:80a7 bound to 0000:00:04.0
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49748 usecs
intel8x0: clocking to 47442
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:01:09.0, irq: 11, latency: 32, mmio:
0xdc000000
bttv0: detected: AVerMedia TVPhone98 [card=41], PCI subsystem ID is
1461:0003
bttv0: using: AVerMedia TVCapture 98 [card=13,insmod option]
bttv0: gpio config override: mask=0xffffffff,
mux=0xff44e,0xffffffff,0xffffffff,0xffffffff,0xffffffff
bttv0: gpio: en=00000000, out=00000000 in=00fcf7c3 [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [11]
bttv0: Avermedia eeprom[0x4803]: tuner=2 radio:yes remote control:yes
bttv0: using tuner=2
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for MSP34xx (alternate address) @ 0x88... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54 (PV951),ta8874z
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner: Ignoring new-style parameters in presence of obsolete ones
tuner: chip found at addr 0xc2 i2c-bus bt878 #0 [sw]
tuner: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles)) by
bt878 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: add subdevice "remote0"
agpgart: Detected NVIDIA nForce2 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-2: nForce2 SMBus adapter at 0x5500
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
ivtv: ==================== START INIT IVTV ====================
ivtv: version 0.2.0 (rc3j) loading
ivtv: Linux version: 2.6.12-rc4 preempt K7 gcc-3.3
ivtv: In case of problems please include the debug info
ivtv: between the START INIT IVTV and END INIT IVTV lines when
ivtv: mailing the ivtv-devel mailinglist.
ivtv: Autodetected WinTV PVR 250 card
ivtv: Found an iTVC16 based chip
ivtv: Unreasonably low latency timer, setting to 64 (was 32)
ivtv: XXX PCI device: 0x01e0 vendor: 0x10de
ivtv: i2c attach [client=tveeprom,ok]
tuner: chip found at addr 0xc2 i2c-bus ivtv i2c driver #0
ivtv: i2c attach [client=(tuner unset),ok]
tveeprom: Hauppauge: model = 32032, rev = B182, serial# = 2779289
tveeprom: tuner = LG TAPC H791F (idx = 82, type = 39)
tveeprom: tuner fmt = NTSC(M) (eeprom = 0x08, v4l2 = 0x00001000)
tveeprom: audio_processor = MSP3440 (type = 11)
ivtv: Tuner Type 39, Tuner formats 0x00001000, Radio: yes, Model
0x00891612, Revision 0xe0ad1cec
ivtv: NTSC tuner detected
ivtv: Radio detected
saa7115: starting probe for adapter bt878 #0 [sw] (0x10005)
saa7115: starting probe for adapter SMBus nForce2 adapter at 5000 (0x0)
saa7115: starting probe for adapter SMBus nForce2 adapter at 5500 (0x0)
saa7115: starting probe for adapter ivtv i2c driver #0 (0x10005)
saa7115: detecting saa7115 client on address 0x42
saa7115: writing init values
ivtv: i2c attach [client=saa7115[50],ok]
saa7115: status: (1E) 0x48, (1F) 0xc0
msp34xx: ivtv version
msp34xx: init: chip=MSP3448W-B3, has NICAM support, simple (D) mode,
simpler (G) no-thread mode
msp34xx: $Id$ compiled on: May 13 2005 16:11:16
ivtv: i2c attach [client=MSP3448W-B3,ok]
ivtv: Encoder revision: 0x02040024
ivtv: Encoder Firmware may be buggy, use version 0x02040011
ivtv: Configuring WinTV PVR 250 card with 5 streams
ivtv: Create DMA stream 0 using 256 16384 byte buffers  4194304 kbytes
total
ivtv: Registered v4l2 device, streamtype 0 minor 1
ivtv: Create DMA stream 1 
ivtv: Registered v4l2 device, streamtype 1 minor 32
ivtv: Create stream 2 using 40 52224 byte buffers  2097152 kbytes total
ivtv: Registered v4l2 device, streamtype 2 minor 225
ivtv: Create DMA stream 3 using 455 4608 byte buffers  2097152 kbytes
total
ivtv: Registered v4l2 device, streamtype 3 minor 24
ivtv: Create stream 4 
ivtv: Registered v4l2 device, streamtype 4 minor 64
ivtv: Setting Tuner 39
tuner: type set to 39 (LG NTSC (newer TAPC series)) by ivtv i2c driver
#0
saa7115: decoder set input (4)
saa7115: now setting Composite input
ivtv: Setting audio matrix to input 3, output 1
ivtv: Switching standard to NTSC.
ivtv: ivtv_enc_thread: pid = 3040, itv = 0xe0ac6be0
saa7115: decoder set norm NTSC
saa7115: set audio: 0x01
ivtv: Initialized WinTV PVR 250, card #0
ivtv: ====================  END INIT IVTV  ====================
lirc_dev: IR Remote Control driver registered, at major 61 
lirc_i2c: chip found @ 0x18 (Hauppauge IR)
ivtv: i2c attach [client=Hauppauge IR,ok]
lirc_dev: lirc_register_plugin: sample_rate: 10
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
might be trying access hardware directly.
atkbd.c: Spurious ACK on isa0060/serio0. Some program, like XFree86,
might be trying access hardware directly.
saa7115: decoder set size

Regards,

Shane


