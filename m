Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270924AbTGPPtD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 11:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270925AbTGPPtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 11:49:03 -0400
Received: from AMarseille-107-1-3-127.w80-11.abo.wanadoo.fr ([80.11.1.127]:18304
	"EHLO diablo") by vger.kernel.org with ESMTP id S270924AbTGPPsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 11:48:52 -0400
Message-ID: <3F157830.8030402@free.fr>
Date: Wed, 16 Jul 2003 18:07:12 +0200
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030704 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Oops report] ppp / 2.6.0-test1-mm1
Content-Type: multipart/mixed;
 boundary="------------000007060602090402070305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000007060602090402070305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I get the following oops when launching ppp on 2.6.0-test1-mm1 
(2.5.75-mm1 was fine, I've not yet tested 2.6.0-test1 itself but can do 
it if necessary). 100% reproductible.
I'm using ppp with pppoatm and the kernel speedtouch driver, but 
previous versions of 2.5 were working fine with the same configuration 
so far, so probably a recent change is to blame...

dmesg and lsmod output are attached. Please let me now if any further 
information/test is needed.

Vincent

---------------------------------------------------------------------
Unable to handle kernel NULL pointer dereference at virtual address 00000026
  printing eip:
c0274d4b
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c0274d4b>]    Not tainted VLI
EFLAGS: 00210206
EIP is at __vcc_connect+0x2b/0x230
eax: 0000000a   ebx: 00000000   ecx: 00000023   edx: c02ed11c
esi: ce241600   edi: 00000000   ebp: 00000023   esp: c857fe60
ds: 007b   es: 007b   ss: 0068
Process pppd (pid: 1198, threadinfo=c857e000 task=c8a17880)
Stack: c1149ad8 c0115e4d c857e000 00000000 cffcf1c0 ce241600 c8ef4080 
c0275007
        ce241600 00000000 00000008 00000023 00200246 00081600 c857e000 
cffcf1c0
        c857fee8 c8ef4080 c0272202 c8ef4080 00000000 00000008 00000023 
ffffffb3
Call Trace:
  [<c0115e4d>] pte_alloc_one+0x3d/0x50
  [<c0275007>] vcc_connect+0xb7/0x1f0
  [<c0272202>] pvc_bind+0xb2/0x150
  [<c0217595>] sys_connect+0x85/0xc0
  [<c027234f>] pvc_setsockopt+0x9f/0xf0
  [<c0217a48>] sys_setsockopt+0x78/0xc0
  [<c021813d>] sys_socketcall+0xcd/0x2a0
  [<c0109107>] syscall_call+0x7/0xb
 

Code: 83 ec 1c 8b 44 24 28 89 74 24 10 89 7c 24 14 89 6c 24 18 89 5c 24 
0c 8b 74 24 20 8b 7c 24 24 8b 6c 24 2c 83 c0 02 83 f8 01 76 0e <0f> be 
4f 26 8b 44 24 28 d3 f8 85 c0 75 14 8d 45 02 83 f8 01 76

--------------000007060602090402070305
Content-Type: text/plain;
 name="oops.2.6.0-test1-mm1.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.2.6.0-test1-mm1.dmesg"

Linux version 2.6.0-test1-mm1 (root@diablo) (gcc version 3.3.1 20030626 (Debian prerelease)) #1 Wed Jul 16 11:48:24 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff8000 (ACPI data)
 BIOS-e820: 000000000fff8000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65520
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61424 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1540.100 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3031.04 BogoMIPS
Memory: 256380k/262080k available (1507k kernel code, 4972k reserved, 589k data, 104k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1800+ stepping 02
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v2.0 (20020519)
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Linux Plug and Play Support v0.96 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f7440
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x616b, dseg 0xf0000
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1106/3147] at 0000:00:11.0
PCI: IRQ 0 for device 0000:00:11.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Hardcoded IRQ 14 for device 0000:00:11.1
pty: 256 Unix98 ptys configured
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Enabling SEP on CPU 0
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Initializing Cryptographic API
Real Time Clock Driver v1.11
8139too Fast Ethernet driver 0.9.26
eth0: RealTek RTL8139 Fast Ethernet at 0xd0800f00, 00:20:ed:3d:28:06, IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
PCI: Hardcoded IRQ 14 for device 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L080AVVA07-0, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IBM-DTLA-307045, ATA DISK drive
hdd: LITE-ON LTR-32123S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
hdc: max request size: 128KiB
hdc: host protected area => 1
hdc: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63, UDMA(100)
 /dev/ide/host0/bus1/target0/lun0: p1
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 1984kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
mice: PS/2 mouse device common for all mice
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda1) for (hda1)
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 104k freed
Adding 265064k swap on /dev/hda2.  Priority:-1 extents:1
registering 0-004c
NTFS driver 2.1.4 [Flags: R/W MODULE].
NTFS volume version 3.0.
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda4, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda4) for (hda4)
Using r5 hash to sort names
cdrom: open failed.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:14.2: VIA Technologies, In USB 2.0
ehci_hcd 0000:00:14.2: irq 10, pci mem d0a0fe00
ehci_hcd 0000:00:14.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:14.2: USB 2.0 enabled, EHCI 0.95, driver 2003-Jun-13
hub 1-0:0: USB hub found
hub 1-0:0: 4 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:11.2: VIA Technologies, In USB
uhci-hcd 0000:00:11.2: irq 10, io base 0000e800
uhci-hcd 0000:00:11.2: new USB bus registered, assigned bus number 2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
uhci-hcd 0000:00:11.3: VIA Technologies, In USB (#2)
uhci-hcd 0000:00:11.3: irq 10, io base 0000e400
uhci-hcd 0000:00:11.3: new USB bus registered, assigned bus number 3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
uhci-hcd 0000:00:14.0: VIA Technologies, In USB (#3)
uhci-hcd 0000:00:14.0: irq 10, io base 0000dc00
uhci-hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
uhci-hcd 0000:00:14.1: VIA Technologies, In USB (#4)
uhci-hcd 0000:00:14.1: irq 10, io base 0000d800
uhci-hcd 0000:00:14.1: new USB bus registered, assigned bus number 5
hub 5-0:0: USB hub found
hub 5-0:0: 2 ports detected
hub 3-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 3-0:0: new USB device on port 1, assigned address 2
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
blk: queue c033a51c, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c033ae5c, I/O limit 4095Mb (mask 0xffffffff)
sensors: numerical sysctl 7 2 1 is obsolete.
sensord: numerical sysctl 7 2 1 is obsolete.
ip_tables: (C) 2000-2002 Netfilter core team
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 300 bytes per conntrack
Linux video capture interface: v1.00
bttv: driver version 0.9.4 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is VIA Technologies, In VT8366/A/7 [Apollo K
bttv: Bt8xx card found (0).
bttv0: Bt848 (rev 18) at 0000:00:0c.0, irq: 10, latency: 32, mmio: 0xdddff000
bttv0: using: BT848A(Lifeview FlyVideo 98/ M) [card=27,insmod option]
bttv0: gpio config override: mask=0xffff, mux=0x1000,0x800,0x800,0x800,0x800
bttv0: FlyVideo Radio=no  RemoteControl=no  Tuner=2 gpio=0x10ffff
bttv0: FlyVideo  LR90=no  tda9821/tda9820=no  capture_only=no 
bttv0: using tuner=3
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tuner: chip found @ 0xc0
tuner: type set to 3 (Philips (SECAM+PAL_BG) (FI1216MF, FM1216MF, FR1216MF))
registering 1-0060
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
cdrom: This disc doesn't have any tracks I recognize!
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
Unable to handle kernel NULL pointer dereference at virtual address 00000026
 printing eip:
c0274d4b
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c0274d4b>]    Not tainted VLI
EFLAGS: 00210206
EIP is at __vcc_connect+0x2b/0x230
eax: 0000000a   ebx: 00000000   ecx: 00000023   edx: c02ed11c
esi: ce241600   edi: 00000000   ebp: 00000023   esp: c857fe60
ds: 007b   es: 007b   ss: 0068
Process pppd (pid: 1198, threadinfo=c857e000 task=c8a17880)
Stack: c1149ad8 c0115e4d c857e000 00000000 cffcf1c0 ce241600 c8ef4080 c0275007 
       ce241600 00000000 00000008 00000023 00200246 00081600 c857e000 cffcf1c0 
       c857fee8 c8ef4080 c0272202 c8ef4080 00000000 00000008 00000023 ffffffb3 
Call Trace:
 [<c0115e4d>] pte_alloc_one+0x3d/0x50
 [<c0275007>] vcc_connect+0xb7/0x1f0
 [<c0272202>] pvc_bind+0xb2/0x150
 [<c0217595>] sys_connect+0x85/0xc0
 [<c027234f>] pvc_setsockopt+0x9f/0xf0
 [<c0217a48>] sys_setsockopt+0x78/0xc0
 [<c021813d>] sys_socketcall+0xcd/0x2a0
 [<c0109107>] syscall_call+0x7/0xb

Code: 83 ec 1c 8b 44 24 28 89 74 24 10 89 7c 24 14 89 6c 24 18 89 5c 24 0c 8b 74 24 20 8b 7c 24 24 8b 6c 24 2c 83 c0 02 83 f8 01 76 0e <0f> be 4f 26 8b 44 24 28 d3 f8 85 c0 75 14 8d 45 02 83 f8 01 76 
 

--------------000007060602090402070305
Content-Type: text/plain;
 name="oops.2.6.0-test1-mm1.modules"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.2.6.0-test1-mm1.modules"

Module                  Size  Used by
pppoatm                 4864  0 
ppp_generic            26320  1 pppoatm
slhc                    6464  1 ppp_generic
tuner                  14412  0 
bttv                  100868  0 
video_buf              16644  1 bttv
i2c_algo_bit            9288  1 bttv
v4l2_common             3840  1 bttv
videodev                8672  1 bttv
ip_conntrack_ftp       70932  0 
ipt_MASQUERADE          2752  2 
iptable_mangle          2048  0 
iptable_nat            19756  2 ipt_MASQUERADE
ipt_REJECT              4800  8 
ipt_limit               1792  29 
ipt_state               1344  4 
ip_conntrack           24944  4 ip_conntrack_ftp,ipt_MASQUERADE,iptable_nat,ipt_state
ipt_LOG                 4800  15 
ipt_ULOG                5608  12 
iptable_filter          2112  1 
ip_tables              15488  9 ipt_MASQUERADE,iptable_mangle,iptable_nat,ipt_REJECT,ipt_limit,ipt_state,ipt_LOG,ipt_ULOG,iptable_filter
af_packet              16840  2 
snd_seq_midi            6496  0 
snd_seq_oss            32000  0 
snd_seq_midi_event      5888  2 snd_seq_midi,snd_seq_oss
snd_seq                51344  5 snd_seq_midi,snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            48548  0 
snd_mixer_oss          16768  2 snd_pcm_oss
snd_ens1371            19556  1 
snd_rawmidi            20256  2 snd_seq_midi,snd_ens1371
snd_seq_device          6536  4 snd_seq_midi,snd_seq_oss,snd_seq,snd_rawmidi
snd_pcm                85540  2 snd_pcm_oss,snd_ens1371
snd_page_alloc          7812  1 snd_pcm
snd_timer              21636  2 snd_seq,snd_pcm
snd_ac97_codec         48132  1 snd_ens1371
snd                    43428  12 snd_seq_midi,snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_ens1371,snd_rawmidi,snd_seq_device,snd_pcm,snd_timer,snd_ac97_codec
soundcore               7168  3 bttv,snd
uhci_hcd               29264  0 
ehci_hcd               21956  0 
usbcore                97116  4 uhci_hcd,ehci_hcd
isofs                  32120  0 
zlib_inflate           21184  1 isofs
nls_cp437               5376  1 
vfat                   13120  1 
fat                    42560  1 vfat
nls_iso8859_1           3712  2 
ntfs                   96684  1 
it87                   21704  0 
adm1021                11080  0 
i2c_sensor              2432  2 it87,adm1021
i2c_viapro              5836  0 
i2c_core               20168  7 tuner,bttv,i2c_algo_bit,it87,adm1021,i2c_sensor,i2c_viapro

--------------000007060602090402070305--

