Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270263AbRIFNGj>; Thu, 6 Sep 2001 09:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270273AbRIFNGX>; Thu, 6 Sep 2001 09:06:23 -0400
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:35071
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S270263AbRIFNGN>; Thu, 6 Sep 2001 09:06:13 -0400
Message-ID: <3B97744E.7020007@dplanet.ch>
Date: Thu, 06 Sep 2001 15:04:14 +0200
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010819
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: OOPS: reproducible in vfs_follow_link 2.4.9,2.4.10-pre4
Content-Type: multipart/mixed;
 boundary="------------080907080507060809080905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080907080507060809080905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

Since yesterdey, every time I run a 2.4.9 or 2.4.10pre-4 without the 
"devfs=nomount" I
have two oops + /usr, /home /boot not mounted (all (also /): ext2).

2.4.9 worked fine before, thus maybe the cause is one of the new userspace
packages I updated. But anyway OOPS are kernel problems.

 Attached: the two oops and the output of dmesg and of lspci -vvv.

The system is pure (I've removed the nvidia module, but it change nothing)
(I need nvidia driver until xfree will support geoforce2, hoping that
nvidia will release all info about my card)

If you need other infos, ask!

    giacomo

--------------080907080507060809080905
Content-Type: text/plain;
 name="log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log"

ksymoops 2.4.2 on i686 2.4.10-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10-pre4/ (default)
     -m /boot/System.map (specified)

  Receiver lock-up bug exists -- enabling work-around.
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0138bf2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0138bf2>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010217
eax: cfc37fa4   ebx: cfc37fa4   ecx: cf839f40   edx: c021fd01
esi: cfc36000   edi: 00000000   ebp: 00000000   esp: cfc37f20
ds: 0018   es: 0018   ss: 0018
Process devfsd (pid: 25, stackpage=cfc37000)
Stack: cfa9c7c0 cfc36000 cfd50de0 cfc37fa4 c014fe40 cfc37fa4 00000000 c01369aa 
       cfa9c7c0 cfc37fa4 cfd50de0 c15bf000 00000000 cfc37fa4 bfffec6c 00000001 
       00000009 cfa9c7c0 c15bf005 00000003 00245c89 c0136e68 c15bf008 cfc37fa4 
Call Trace: [<c014fe40>] [<c01369aa>] [<c0136e68>] [<c012be66>] [<c0106b0b>] 
Code: 80 3f 2f 0f 85 b9 00 00 00 53 e8 17 d5 ff ff ba 00 e0 ff ff 

>>EIP; c0138bf2 <vfs_follow_link+1a/14c>   <=====
Trace; c014fe40 <devfs_follow_link+24/30>
Trace; c01369aa <path_walk+642/748>
Trace; c0136e68 <__user_walk+3c/58>
Trace; c012be66 <sys_chown+16/48>
Trace; c0106b0a <system_call+32/38>
Code;  c0138bf2 <vfs_follow_link+1a/14c>
00000000 <_EIP>:
Code;  c0138bf2 <vfs_follow_link+1a/14c>   <=====
   0:   80 3f 2f                  cmpb   $0x2f,(%edi)   <=====
Code;  c0138bf4 <vfs_follow_link+1c/14c>
   3:   0f 85 b9 00 00 00         jne    c2 <_EIP+0xc2> c0138cb4 <vfs_follow_link+dc/14c>
Code;  c0138bfa <vfs_follow_link+22/14c>
   9:   53                        push   %ebx
Code;  c0138bfc <vfs_follow_link+24/14c>
   a:   e8 17 d5 ff ff            call   ffffd526 <_EIP+0xffffd526> c0136118 <path_release+0/2c>
Code;  c0138c00 <vfs_follow_link+28/14c>
   f:   ba 00 e0 ff ff            mov    $0xffffe000,%edx

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0138ba4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0138ba4>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000fff   ecx: ffffffff   edx: 00000000
esi: 00000000   edi: 00000000   ebp: cfa3bfa4   esp: cfa3bf5c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 81, stackpage=cfa3b000)
Stack: c15ba940 00000000 00000fff c014fe0f c15ba940 bfffebc4 00000fff 00000000 
       cfd50de0 c0133f42 c15ba940 bfffebc4 00000fff cfd50de0 cfa3a000 0805b580 
       0805c920 00000002 c15ba940 c14472e0 c012c808 cfa3a000 00000025 00000008 
Call Trace: [<c014fe0f>] [<c0133f42>] [<c012c808>] [<c0106b0b>] 
Code: f2 ae f7 d1 49 89 ce 39 de 0f 47 f3 56 52 8b 44 24 1c 50 e8 

>>EIP; c0138ba4 <vfs_readlink+24/58>   <=====
Trace; c014fe0e <devfs_readlink+2a/38>
Trace; c0133f42 <sys_readlink+82/9c>
Trace; c012c808 <sys_write+bc/c4>
Trace; c0106b0a <system_call+32/38>
Code;  c0138ba4 <vfs_readlink+24/58>
00000000 <_EIP>:
Code;  c0138ba4 <vfs_readlink+24/58>   <=====
   0:   f2 ae                     repnz scas %es:(%edi),%al   <=====
Code;  c0138ba6 <vfs_readlink+26/58>
   2:   f7 d1                     not    %ecx
Code;  c0138ba8 <vfs_readlink+28/58>
   4:   49                        dec    %ecx
Code;  c0138ba8 <vfs_readlink+28/58>
   5:   89 ce                     mov    %ecx,%esi
Code;  c0138baa <vfs_readlink+2a/58>
   7:   39 de                     cmp    %ebx,%esi
Code;  c0138bac <vfs_readlink+2c/58>
   9:   0f 47 f3                  cmova  %ebx,%esi
Code;  c0138bb0 <vfs_readlink+30/58>
   c:   56                        push   %esi
Code;  c0138bb0 <vfs_readlink+30/58>
   d:   52                        push   %edx
Code;  c0138bb2 <vfs_readlink+32/58>
   e:   8b 44 24 1c               mov    0x1c(%esp,1),%eax
Code;  c0138bb6 <vfs_readlink+36/58>
  12:   50                        push   %eax
Code;  c0138bb6 <vfs_readlink+36/58>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0138bbc <vfs_readlink+3c/58>

ds: no socket drivers loaded!

--------------080907080507060809080905
Content-Type: text/plain;
 name="log2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log2"

Linux version 2.4.10-pre4 (root@gmiabla) (gcc version 2.95.4 20010902 (Debian prerelease)) #12 Wed Sep 5 16:41:29 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffea800 (usable)
 BIOS-e820: 000000000ffea800 - 0000000010000000 (reserved)
 BIOS-e820: 00000000feea0000 - 00000000fef00000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
On node 0 totalpages: 65514
zone(0): 4096 pages.
zone(1): 61418 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=306 reboot=warm idebus=66
ide_setup: idebus=66
Initializing CPU#0
Detected 847.190 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 255740k/262056k available (895k kernel code, 5928k reserved, 292k data, 172k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/244c] at 00:1f.0
  got res[f2000000:f2000fff] for resource 0 of Texas Instruments PCI4451 PC card Cardbus Controller
  got res[f2001000:f2001fff] for resource 0 of Texas Instruments PCI4451 PC card Cardbus Controller (#2)
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
devfs: v0.107 (20010709) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x2
ACPI: Core Subsystem version [20010615]
ACPI: Subsystem enabled
Power Resource: found
ACPI: System firmware supports S0 S1 S3 S4 S5
Processor[0]: C0 C1 C2
Battery: socket found, battery absent
Battery: socket found, battery present
AC Adapter: found
Power Button: found
Sleep Button: found
Lid Switch: found
Thermal Zone: found
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10d
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 66MHz system bus speed for PIO modes
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xbfa0-0xbfa7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xbfa8-0xbfaf, BIOS settings: hdc:pio, hdd:pio
hda: IBM-DJSA-232, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 62506080 sectors (32003 MB) w/1874KiB Cache, CHS=3890/255/63, UDMA(66)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 p7 p8 p9 p10 p11 p12 > p3 p4
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:20:E0:68:DD:6D, IRQ 11.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 727095-002, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
  Receiver lock-up workaround activated.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel i815 chipset
agpgart: AGP aperture is 64M @ 0xe8000000
[drm] AGP 0.99 on Intel i815 @ 0xe8000000 64MB
[drm] Initialized i810 1.1.0 20010616 on minor 0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 172k freed
Adding Swap: 602396k swap-space (priority -1)
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
inserting floppy driver for 2.4.10-pre4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0138bf2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0138bf2>]
EFLAGS: 00010217
eax: cfc37fa4   ebx: cfc37fa4   ecx: cf839f40   edx: c021fd01
esi: cfc36000   edi: 00000000   ebp: 00000000   esp: cfc37f20
ds: 0018   es: 0018   ss: 0018
Process devfsd (pid: 25, stackpage=cfc37000)
Stack: cfa9c7c0 cfc36000 cfd50de0 cfc37fa4 c014fe40 cfc37fa4 00000000 c01369aa 
       cfa9c7c0 cfc37fa4 cfd50de0 c15bf000 00000000 cfc37fa4 bfffec6c 00000001 
       00000009 cfa9c7c0 c15bf005 00000003 00245c89 c0136e68 c15bf008 cfc37fa4 
Call Trace: [<c014fe40>] [<c01369aa>] [<c0136e68>] [<c012be66>] [<c0106b0b>] 

Code: 80 3f 2f 0f 85 b9 00 00 00 53 e8 17 d5 ff ff ba 00 e0 ff ff 
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c0138ba4
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0138ba4>]
EFLAGS: 00010246
eax: 00000000   ebx: 00000fff   ecx: ffffffff   edx: 00000000
esi: 00000000   edi: 00000000   ebp: cfa3bfa4   esp: cfa3bf5c
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 81, stackpage=cfa3b000)
Stack: c15ba940 00000000 00000fff c014fe0f c15ba940 bfffebc4 00000fff 00000000 
       cfd50de0 c0133f42 c15ba940 bfffebc4 00000fff cfd50de0 cfa3a000 0805b580 
       0805c920 00000002 c15ba940 c14472e0 c012c808 cfa3a000 00000025 00000008 
Call Trace: [<c014fe0f>] [<c0133f42>] [<c012c808>] [<c0106b0b>] 

Code: f2 ae f7 d1 49 89 ce 39 de 0f 47 f3 56 52 8b 44 24 1c 50 e8 
usb.c: registered new driver hub
PCI: Found IRQ 11 for device 00:1f.2
PCI: Sharing IRQ 11 with 02:0f.0
PCI: Sharing IRQ 11 with 02:0f.1
PCI: Sharing IRQ 11 with 02:0f.2
PCI: Setting latency timer of device 00:1f.2 to 64
uhci.c: USB UHCI at I/O 0xbce0, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
uhci.c: :USB Universal Host Controller Interface driver
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
ds: no socket drivers loaded!
hub.c: USB new device connect on bus1/2, assigned device number 2
usb.c: USB device 2 (vend/prod 0x46d/0xc002) is not claimed by any active driver.

--------------080907080507060809080905
Content-Type: text/plain;
 name="log3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log3"

00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fc000000-fdffffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corporation: Unknown device 2448 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=10, sec-latency=32
	I/O behind bridge: 0000d000-0000ffff
	Memory behind bridge: f2000000-fbffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation: Unknown device 244c (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation: Unknown device 244a (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corporation: Unknown device 4541
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at bfa0 [size=16]

00:1f.2 USB Controller: Intel Corporation 82820 820 (Camino 2) Chipset USB (Hub A) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corporation: Unknown device 4541
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at bce0 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0112 (rev b2) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

02:03.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at f6ffe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=02, secondary=08, subordinate=08, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: f8000000-f9ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+
	Capabilities: [90] #06 [0000]

02:0f.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f2000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=32
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:0f.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f2001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=05, subordinate=05, sec-latency=32
	Memory window 0: 00000000-00000000 (prefetchable)
	Memory window 1: 00000000-00000000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:0f.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8027 (prog-if 10 [OHCI])
	Subsystem: Dell Computer Corporation: Unknown device 00a4
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f6ffd800 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at f6ff8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

08:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Action Tec Electronics Inc: Unknown device 1100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8fff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at ecc0 [size=64]
	Region 2: Memory at f8e00000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at f9000000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

08:08.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
	Subsystem: Action Tec Electronics Inc: Unknown device 2400
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f8ffec00 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at ecb8 [size=8]
	Region 2: I/O ports at e800 [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--------------080907080507060809080905--

