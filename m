Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266014AbUHWQb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266014AbUHWQb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 12:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUHWPpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:45:40 -0400
Received: from advect.atmos.washington.edu ([128.95.89.50]:29880 "EHLO
	advect.atmos.washington.edu") by vger.kernel.org with ESMTP
	id S265784AbUHWPj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:39:26 -0400
Message-Id: <200408231539.i7NFdHeq004255@moist.atmos.washington.edu>
Date: Mon, 23 Aug 2004 08:39:15 -0700 (PDT)
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: page allocation or what in 2.6.8.1
From: Harry Edmon <harry@atmos.washington.edu>
X-Mailer: Ishmail 2.1.0-20021115-i686-pc-linux-gnu <http://ishmail.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----------10ljewotmynzu1ntcunde0my5hz2z5y25rqgf0bw9zlndhc2hp"
X-Spam-Score: -15.903 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*************************************************************************
* This message has been formatted as a MIME message.  If you are reading
* this, your mail reader does not support MIME.  To display the non-text
* portions of this message you will need a MIME-capable mail reader such
* as Ishmail (http://ishmail.sourceforge.net).
*************************************************************************

------------10ljewotmynzu1ntcunde0my5hz2z5y25rqgf0bw9zlndhc2hp
Content-Type: text/enriched

Sorry if this is the incorrect place, but this one has me stumped.  This
problem also occurs in 2.6.7.


[1.] One line summary of the problem:


	Kernel crash in nfsd, swapper, etc.  

 

[2.] Full description of the problem/report:


	System crashes every 3-4 days with what seems to be memory allocation
errors in different processes


[3.] Keywords (i.e., modules, networking, kernel):


	kernel


[4.] Kernel version (from /proc/version):


	Linux version 2.6.8.1-debug (root@funnel) (gcc version 3.3.4 (Debian
1:3.3.4-6sarge1)) #3 SMP Thu Aug 19 11:50:31 PDT 2004


[5.] Output of Oops.. message (if applicable) with symbolic information 

     resolved (see Documentation/oops-tracing.txt)


Oops: 0000 [#1]

PREEMPT SMP DEBUG_PAGEALLOC

Modules linked in: nfs nfsd exportfs lockd sunrpc autofs capability
commoncap ip

v6 eepro100 uhci_hcd usbcore pciehp shpchp pci_hotplug floppy pcspkr
evdev e100 

mii sd_mod 3w_xxxx scsi_mod ide_cd cdrom rtc reiserfs isofs ext2 ext3
jbd mbcach

e ide_generic siimage aec62xx trm290 alim15x3 hpt34x hpt366 ide_disk
cmd64x piix

 rz1000 slc90e66 generic cs5530 cs5520 sc1200 triflex atiixp
pdc202xx_old pdc202

xx_new opti621 ns87415 cy82c693 amd74xx sis5513 via82cxxx serverworks
ide_core r

aid1 md unix

CPU:    1

EIP:    0060:[<<c0178616>]    Not tainted

EFLAGS: 00010202   (2.6.8.1-debug) 

EIP is at iput+0x4e/0x7c

eax: e96cfdf8   ebx: c52a5eb4   ecx: 00000001   edx: c01785af

esi: da451f68   edi: c52a5eb4   ebp: ea498000   esp: ea499a28

ds: 007b   es: 007b   ss: 0068

Process nfsd (pid: 2146, threadinfo=ea498000 task=eba4aa60)

Stack: c52a5ed0 c02d852c ea498000 c0174cce c52a5eb4 c035ef80 da451f68
ea498000 

       c69c9f68 c0175363 da451f68 ea499a54 0000001a 00000080 ea498000
00000001 

       f7ffeb1c c017593d 00000080 c0147b2a 00000080 000000d0 0000301e
c20247a0 

Call Trace:

 [<<c0174cce>] dput+0x11a/0x25b

 [<<c0175363>] prune_dcache+0x1bb/0x247

 [<<c017593d>] shrink_dcache_memory+0x1f/0x45

 [<<c0147b2a>] shrink_slab+0x150/0x1a4

 [<<c0148f9b>] try_to_free_pages+0xd6/0x1a1

 [<<c013f7e8>] __alloc_pages+0x1bf/0x36b

 [<<c013f9b9>] __get_free_pages+0x25/0x3f

 [<<c01787b7>] update_atime+0xd0/0xd5

 [<<c01430a2>] kmem_getpages+0x21/0xc9

 [<<c014468e>] cache_grow+0xde/0x1d2

 [<<c0170301>] vfs_readdir+0xbd/0xbf

 [<<c0144d57>] cache_alloc_refill+0x1cb/0x283

 [<<c01452ef>] kmem_cache_alloc+0x8f/0x93

 [<<c0175f63>] d_lookup+0x29/0x52

 [<<c0175983>] d_alloc+0x20/0x1cc

 [<<c016bd69>] __lookup_hash+0x8b/0xd6

 [<<c016bdd3>] lookup_hash+0x1f/0x23

 [<<c016be3e>] lookup_one_len+0x67/0x74

 [<<f8960690>] find_exported_dentry+0x690/0x812 [exportfs]

 [<<c022a14c>] kfree_skbmem+0x24/0x2c

 [<<c022a14c>] kfree_skbmem+0x24/0x2c

 [<<c02554bb>] tcp_recvmsg+0x2fc/0x73d

 [<<c0229cf4>] sock_common_recvmsg+0x5a/0x75

 [<<c0226209>] sock_recvmsg+0xb8/0xd3

 [<<c0118ed4>] recalc_task_prio+0x93/0x188

 [<<c0119059>] activate_task+0x90/0xa4

 [<<c011b24e>] __wake_up_common+0x3f/0x5e

 [<<c01187e8>] __change_page_attr+0x2f/0x16f

 [<<c0118ad7>] kernel_map_pages+0x31/0x5d

 [<<c0144979>] cache_free_debugcheck+0x185/0x2af

 [<<f89d38e8>] reiserfs_decode_fh+0xc2/0xea [reiserfs]

 [<<f8e372bc>] nfsd_acceptable+0x0/0x139 [nfsd]

 [<<f8e375d6>] fh_verify+0x1e1/0x57c [nfsd]

 [<<f8e372bc>] nfsd_acceptable+0x0/0x139 [nfsd]

 [<<c0294c7a>] schedule_timeout+0x75/0xbf

 [<<f8e403c8>] nfsd3_proc_getattr+0x81/0xb5 [nfsd]

 [<<f8e35835>] nfsd_dispatch+0xd9/0x1d8 [nfsd]

 [<<f8de4711>] svc_process+0x4b0/0x611 [sunrpc]

 [<<f8e3552b>] nfsd+0x23b/0x46c [nfsd]

 [<<f8e352f0>] nfsd+0x0/0x46c [nfsd]

 [<<c0104271>] kernel_thread_helper+0x5/0xb

Code: 8b 40 24 85 c0 74 08 8b 40 18 85 c0 0f 45 d0 89 1c 24 ff d2 

 <<6>note: nfsd[2146] exited with preempt_count 1


[6.] A small shell script or example program which triggers the

     problem (if possible)

	

NONE


[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

If some fields are empty or look unusual you may have an old version.

Compare to the current minimal requirements in Documentation/Changes.

 

Linux funnel 2.6.8.1-debug #3 SMP Thu Aug 19 11:50:31 PDT 2004 i686
GNU/Linux

 

Gnu C                  3.3.4

Gnu make               3.80

binutils               2.14.90.0.7

util-linux             2.12

mount                  2.12

module-init-tools      3.1-pre5

e2fsprogs              1.35

nfs-utils              1.0.6

Linux C Library        2.3.2

Dynamic linker (ldd)   2.3.2

Procps                 3.2.1

Net-tools              1.60

Console-tools          0.2.3

Sh-utils               5.2.1

Modules Loaded         nfs nfsd exportfs lockd sunrpc autofs capability
commoncap ipv6 eepro100 uhci_hcd usbcore pciehp shpchp pci_hotplug
floppy pcspkr evdev e100 mii sd_mod 3w_xxxx scsi_mod ide_cd cdrom rtc
reiserfs isofs ext2 ext3 jbd mbcache ide_generic siimage aec62xx trm290
alim15x3 hpt34x hpt366 ide_disk cmd64x piix rz1000 slc90e66 generic
cs5530 cs5520 sc1200 triflex atiixp pdc202xx_old pdc202xx_new opti621
ns87415 cy82c693 amd74xx sis5513 via82cxxx serverworks ide_core raid1 md
unix


[7.2.] Processor information (from /proc/cpuinfo):


processor       : 0

vendor_id       : GenuineIntel

cpu family      : 15

model           : 2

model name      : Intel(R) Xeon(TM) CPU 3.06GHz

stepping        : 9

cpu MHz         : 3067.211

cache size      : 512 KB

physical id     : 0

siblings        : 1

fdiv_bug        : no

hlt_bug         : no

f00f_bug        : no

coma_bug        : no

fpu             : yes

fpu_exception   : yes

cpuid level     : 2

wp              : yes

flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid

bogomips        : 6078.46


processor       : 1

vendor_id       : GenuineIntel

cpu family      : 15

model           : 2

model name      : Intel(R) Xeon(TM) CPU 3.06GHz

stepping        : 9

cpu MHz         : 3067.211

cache size      : 512 KB

physical id     : 0

siblings        : 1

fdiv_bug        : no

hlt_bug         : no

f00f_bug        : no

coma_bug        : no

fpu             : yes

fpu_exception   : yes

cpuid level     : 2

wp              : yes

flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid

bogomips        : 6127.61


[7.3.] Module information (from /proc/modules):

nfs 194108 4 - Live 0xf8e04000

nfsd 199200 8 - Live 0xf8e35000

exportfs 7936 1 nfsd, Live 0xf8960000

lockd 63816 3 nfs,nfsd, Live 0xf8d68000

sunrpc 156644 8 nfs,nfsd,lockd, Live 0xf8ddc000

autofs 18816 3 - Live 0xf8d4e000

capability 5768 0 - Live 0xf8cc4000

commoncap 8320 1 capability, Live 0xf8cc8000

ipv6 277508 41 - Live 0xf8d97000

eepro100 32140 0 - Live 0xf8cb1000

uhci_hcd 33936 0 - Live 0xf8ccf000

usbcore 119780 3 uhci_hcd, Live 0xf8cf4000

pciehp 97804 0 - Live 0xf8d2e000

shpchp 101260 0 - Live 0xf8d14000

pci_hotplug 35644 2 pciehp,shpchp, Live 0xf8cea000

floppy 61556 0 - Live 0xf8cd9000

pcspkr 4812 0 - Live 0xf8cae000

evdev 10624 0 - Live 0xf8bb7000

e100 35584 0 - Live 0xf8cba000

mii 6272 2 eepro100,e100, Live 0xf89ba000

sd_mod 22656 2 - Live 0xf89c1000

3w_xxxx 42532 1 - Live 0xf8996000

scsi_mod 125764 2 sd_mod,3w_xxxx, Live 0xf8bbb000

ide_cd 43140 0 - Live 0xf89ae000

cdrom 40736 1 ide_cd, Live 0xf89a3000

rtc 14920 0 - Live 0xf891c000

reiserfs 246128 2 - Live 0xf89c8000

isofs 38332 0 - Live 0xf8921000

ext2 73576 0 - Live 0xf893e000

ext3 127336 0 - Live 0xf8963000

jbd 69400 1 ext3, Live 0xf892c000

mbcache 11012 2 ext2,ext3, Live 0xf8912000

ide_generic 2432 0 [permanent], Live 0xf8901000

siimage 13952 0 [permanent], Live 0xf8908000

aec62xx 11420 0 [permanent], Live 0xf8904000

trm290 5508 0 [permanent], Live 0xf88ef000

alim15x3 11660 0 [permanent], Live 0xf88fb000

hpt34x 6656 0 [permanent], Live 0xf8895000

hpt366 23108 0 [permanent], Live 0xf88f4000

ide_disk 20096 7 hpt366, Live 0xf88dc000

cmd64x 13340 0 [permanent], Live 0xf88e7000

piix 14112 0 [permanent], Live 0xf88e2000

rz1000 3584 0 [permanent], Live 0xf8898000

slc90e66 9224 0 [permanent], Live 0xf88d8000

generic 4992 0 [permanent], Live 0xf88d5000

cs5530 7176 0 [permanent], Live 0xf88ab000

cs5520 7176 0 [permanent], Live 0xf88a2000

sc1200 9480 0 [permanent], Live 0xf88d1000

triflex 6148 0 [permanent], Live 0xf8857000

atiixp 9880 0 [permanent], Live 0xf889e000

pdc202xx_old 17308 0 [permanent], Live 0xf88a5000

pdc202xx_new 11676 0 [permanent], Live 0xf889a000

opti621 5892 0 [permanent], Live 0xf8892000

ns87415 5192 0 [permanent], Live 0xf885d000

cy82c693 5632 0 [permanent], Live 0xf885a000

amd74xx 13724 0 [permanent], Live 0xf888d000

sis5513 15496 0 [permanent], Live 0xf8888000

via82cxxx 13212 0 [permanent], Live 0xf8875000

serverworks 12308 0 [permanent], Live 0xf8870000

ide_core 137296 28
ide_cd,ide_generic,siimage,aec62xx,trm290,alim15x3,hpt34x,hpt366,ide_disk,cmd64x,piix,rz1000,slc90e66,generic,cs5530,cs5520,sc1200,triflex,atiixp,pdc202xx_old,pdc202xx_new,opti621,ns87415,cy82c693,amd74xx,sis5513,via82cxxx,serverworks,
Live 0xf88ae000

raid1 19456 2 - Live 0xf886a000

md 51016 3 raid1, Live 0xf887a000

unix 31536 48 - Live 0xf8861000


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)


------------10ljewotmynzu1ntcunde0my5hz2z5y25rqgf0bw9zlndhc2hp
Content-Type: text/plain
Content-Disposition: attachment;
	filename=iomem

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Adapter ROM
000c9800-000cafff : Adapter ROM
000cb000-000cf1ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-7ffeffff : System RAM
  00100000-00295f79 : Kernel code
  00295f7a-0035f27f : Kernel data
7fff0000-7fffefff : ACPI Tables
7ffff000-7fffffff : ACPI Non-volatile Storage
80000000-800003ff : 0000:00:1f.1
fc000000-fcffffff : 0000:01:02.0
fd3a0000-fd3bffff : 0000:01:01.0
  fd3a0000-fd3bffff : e100
fd3fe000-fd3fefff : 0000:01:01.0
  fd3fe000-fd3fefff : e100
fd3ff000-fd3fffff : 0000:01:02.0
fd400000-fd6fffff : PCI Bus #02
  fd400000-fd4fffff : PCI Bus #03
  fd500000-fd5fffff : PCI Bus #04
  fd6fe000-fd6fefff : 0000:02:1c.0
  fd6ff000-fd6fffff : 0000:02:1e.0
fd700000-feafffff : PCI Bus #05
  fd700000-fe8fffff : PCI Bus #06
    fe000000-fe7fffff : 0000:06:05.0
    fe8ff800-fe8ff8ff : 0000:06:04.0
      fe8ff800-fe8ff8ff : SiI680
    fe8ffc00-fe8ffc0f : 0000:06:05.0
  fe900000-fe9fffff : PCI Bus #07
    fe9c0000-fe9dffff : 0000:07:01.0
      fe9c0000-fe9dffff : e1000
    fe9e0000-fe9fffff : 0000:07:01.1
      fe9e0000-fe9fffff : e1000
  feafe000-feafefff : 0000:05:1c.0
  feaff000-feafffff : 0000:05:1e.0
fec00000-fecfffff : reserved
fee00000-fee00fff : reserved
ff400000-ff6fffff : PCI Bus #02
  ff400000-ff4fffff : PCI Bus #03
  ff500000-ff5fffff : PCI Bus #04
ff700000-ff9fffff : PCI Bus #05
  ff700000-ff7fffff : PCI Bus #06
  ff800000-ff8fffff : PCI Bus #07
ffb80000-ffffffff : reserved

------------10ljewotmynzu1ntcunde0my5hz2z5y25rqgf0bw9zlndhc2hp
Content-Type: text/plain
Content-Disposition: attachment;
	filename=ioports

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
0290-0297 : pnp 00:0c
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial
0400-047f : 0000:00:1f.0
04d0-04d1 : pnp 00:0d
0500-053f : 0000:00:1f.0
0540-055f : 0000:00:1f.3
0cf8-0cff : PCI conf1
9800-98ff : 0000:01:02.0
9c00-9c3f : 0000:01:01.0
  9c00-9c3f : e100
a000-bfff : PCI Bus #02
  a000-bfff : PCI Bus #03
c000-dfff : PCI Bus #05
  c000-cfff : PCI Bus #06
    c080-c08f : 0000:06:04.0
    c400-c403 : 0000:06:04.0
    c480-c487 : 0000:06:04.0
    c800-c803 : 0000:06:04.0
    c880-c887 : 0000:06:04.0
    cc00-cc0f : 0000:06:05.0
      cc00-cc0f : 3ware Storage Controller
  d000-dfff : PCI Bus #07
    d880-d8bf : 0000:07:01.0
      d880-d8bf : e1000
    dc00-dc3f : 0000:07:01.1
      dc00-dc3f : e1000
ec00-ec1f : 0000:00:1d.0
  ec00-ec1f : uhci_hcd
ffa0-ffaf : 0000:00:1f.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

------------10ljewotmynzu1ntcunde0my5hz2z5y25rqgf0bw9zlndhc2hp
Content-Type: text/enriched



[7.5.] PCI information ('lspci -vvv' as root)


------------10ljewotmynzu1ntcunde0my5hz2z5y25rqgf0bw9zlndhc2hp
Content-Type: text/plain
Content-Disposition: attachment;
	filename=lspci

0000:00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

0000:00:02.0 PCI bridge: Intel Corp. E7500/E7501 Hub Interface B PCI-to-PCI Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=05, subordinate=07, sec-latency=0
	I/O behind bridge: 0000c000-0000dfff
	Memory behind bridge: fd700000-feafffff
	Prefetchable memory behind bridge: ff700000-ff9fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:03.0 PCI bridge: Intel Corp. E7500/E7501 Hub Interface C PCI-to-PCI Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=04, sec-latency=0
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: fd400000-fd6fffff
	Prefetchable memory behind bridge: ff400000-ff6fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 2480
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at ec00 [size=32]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 42) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: fb300000-fd3fffff
	Prefetchable memory behind bridge: ff300000-ff3fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 2480
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]
	Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device 2480
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 0540 [size=32]

0000:01:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
	Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fd3fe000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 9c00 [size=64]
	Region 2: Memory at fd3a0000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: <available only to root>

0000:01:02.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage XL
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 9800 [size=256]
	Region 2: Memory at fd3ff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fd3c0000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fd6fe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=02, secondary=04, subordinate=04, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fd500000-fd5fffff
	Prefetchable memory behind bridge: 00000000ff500000-00000000ff500000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fd6ff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 0000a000-0000bfff
	Memory behind bridge: fd400000-fd4fffff
	Prefetchable memory behind bridge: 00000000ff400000-00000000ff400000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:05:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:05:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=05, secondary=07, subordinate=07, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe900000-fe9fffff
	Prefetchable memory behind bridge: 00000000ff800000-00000000ff800000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:05:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20 [IO(X)-APIC])
	Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>

0000:05:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=05, secondary=06, subordinate=06, sec-latency=64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fd700000-fe8fffff
	Prefetchable memory behind bridge: 00000000ff700000-00000000ff700000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:06:04.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) PCI0680 Ultra ATA-133 Host Controller (rev 02)
	Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) Winic W-680 (Silicon Image 680 based)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x01 (4 bytes)
	Interrupt: pin A routed to IRQ 25
	Region 0: I/O ports at c880 [size=8]
	Region 1: I/O ports at c800 [size=4]
	Region 2: I/O ports at c480 [size=8]
	Region 3: I/O ports at c400 [size=4]
	Region 4: I/O ports at c080 [size=16]
	Region 5: Memory at fe8ff800 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at fe800000 [disabled] [size=512K]
	Capabilities: <available only to root>

0000:06:05.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
	Subsystem: 3ware Inc 3ware Inc 3ware 7xxx/8xxx-series PATA/SATA-RAID
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2250ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 26
	Region 0: I/O ports at cc00 [size=16]
	Region 1: Memory at fe8ffc00 (32-bit, non-prefetchable) [size=16]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at fe8e0000 [disabled] [size=64K]
	Capabilities: <available only to root>

0000:07:01.0 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)
	Subsystem: Intel Corp. PRO/1000 MT Dual Port Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at fe9c0000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at d880 [size=64]
	Capabilities: <available only to root>

0000:07:01.1 Ethernet controller: Intel Corp. 82546EB Gigabit Ethernet Controller (Copper) (rev 01)
	Subsystem: Intel Corp. PRO/1000 MT Dual Port Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin B routed to IRQ 49
	Region 0: Memory at fe9e0000 (64-bit, non-prefetchable) [size=128K]
	Region 4: I/O ports at dc00 [size=64]
	Capabilities: <available only to root>


------------10ljewotmynzu1ntcunde0my5hz2z5y25rqgf0bw9zlndhc2hp
Content-Type: text/enriched



[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:

Host: scsi0 Channel: 00 Id: 00 Lun: 00

  Vendor: 3ware    Model: Logical Disk 0   Rev: 1.2 

  Type:   Direct-Access                    ANSI SCSI revision: ffffffff


[7.7.] Other information that might be relevant to the problem

       (please look in /proc and include all information that you

       think to be relevant):


I compiled the kernel with some debugging turned on.  There are some
messages that showed up after I rebooted, but I do not understand them
all.


Complete copy of console output (3.3 MB) can be found at:


	ftp://ftp.atmos.washington.edu/harry/funnel.log


[X.] Other notes, patches, fixes, workarounds:
------------10ljewotmynzu1ntcunde0my5hz2z5y25rqgf0bw9zlndhc2hp
Content-Description: Signature
Content-Type: text/plain


-- 
 Dr. Harry Edmon			E-MAIL: harry@atmos.washington.edu
 206-543-0547				harry@u.washington.edu
 Dept of Atmospheric Sciences		FAX:	206-543-0308
 University of Washington, Box 351640, Seattle, WA 98195-1640

------------10ljewotmynzu1ntcunde0my5hz2z5y25rqgf0bw9zlndhc2hp--
