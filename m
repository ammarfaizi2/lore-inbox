Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290478AbSAYBP2>; Thu, 24 Jan 2002 20:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290477AbSAYBPJ>; Thu, 24 Jan 2002 20:15:09 -0500
Received: from c007-h013.c007.snv.cp.net ([209.228.33.220]:21150 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S290472AbSAYBOt>;
	Thu, 24 Jan 2002 20:14:49 -0500
X-Sent: 25 Jan 2002 01:14:40 GMT
Message-ID: <3C50B180.E3545A58@bigfoot.com>
Date: Thu, 24 Jan 2002 17:14:40 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.21pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nicholas Lee <nj.lee@plumtree.co.nz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disk corruption - Abit KT7, 2.2.19+ide patches
In-Reply-To: <20020115202302.GA598@inktiger.kiwa.co.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried to approximate your basic test on an Abit KA7, but
cannot trigger i/o errors or oopsen.  Let me know if you
would like anything rerun/modified.

2.2.21pre1 + ide.2.2.19.05042001.patch.  Tests run at runlevel 5
with a moderate amount of the usual stuff.  vmstat was triggered
in a separate xterm and edited into the log at the appropriate
places.  I was surprised to find fewer context switches with
'ping -f -s 64000' than with no ping.

rgds,
tim.

*****

[17:04] abit:~ > cat io.log
Script started on Thu Jan 24 16:20:48 2002

[tim@abit tim]# /usr/bin/time dd if=/dev/hda of=/dev/null bs=1k & \
? /usr/bin/time dd if=/dev/hdc of=/dev/null bs=1k & \
? sleep 15; killall dd
[1] 9786
[2] 9788
[tim@abit tim]# Command terminated by signal 15
0.11user 6.10system 0:15.07elapsed 41%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (111major+16minor)pagefaults 0swaps
Command terminated by signal 15
0.18user 6.65system 0:15.16elapsed 45%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (112major+16minor)pagefaults 0swaps

[2]  + Exit 15                       /usr/bin/time dd if=/dev/hdc of=/dev/null bs=1k
[1]  + Exit 15                       /usr/bin/time dd if=/dev/hda of=/dev/null bs=1k

[16:23] abit:~ > vmstat -n 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0    116   2352 373500  18236   0   0     0     0  103   203   0   4  96
 3  0  0    116   3116 372476  18244   0   0     5     0  108   240   9   6  85
 2  0  0    116   2144 373384  18232   0   0 31102     0 7882  8510   7  88   6
 2  0  0    116   2784 372756  18220   0   0 31360     0 7944  8552   1  92   7
 4  0  0    116   2468 373080  18208   0   0 31163     7 7903  8674   2  91   7
 2  0  0    116   2948 372616  18192   0   0 31392     0 7952  8525   4  92   4
 3  0  0    116   2096 373520  18120   0   0 31552     0 7992  8501   4  95   1
 5  0  0    116   2596 373084  18060   0   0 32400     0 8207  8705   3  93   5
 5  0  0    116   2448 373240  18052   0   0 32148     0 8141  8695   4  90   6
 2  0  0    116   2152 373556  18032   0   0 31016     6 7864  8651   2  89   9
 3  0  0    116   2420 373288  18032   0   0 31476     0 7973  8497   3  91   6
 2  0  0    116   2608 373100  18032   0   0 31556     0 7993  8492   2  93   5
 4  0  0    116   2624 373088  18024   0   0 31340     0 7939  8486   4  88   8
 4  0  0    116   2972 373832  16844   0   0 30540     0 7739  8306   3  90   7
 4  0  0    116   2120 374664  16844   0   0 31552     0 7992  8500   3  94   3
 6  0  0    116   2452 374336  16844   0   0 31416     0 7958  8478   5  90   5
 0  0  0    116   2844 374200  16900   0   0 13226     0 3412  3820   7  42  51
 1  0  0    116   2840 374200  16900   0   0     0     0  103   169   1   4  95
 2  0  0    116   2836 374204  16900   0   0     6     0  117   220   0   4  96



[tim@abit tim]# /usr/bin/time dd if=/dev/hda of=/dev/null bs=1k & \
? /usr/bin/time dd if=/dev/hdc of=/dev/null bs=1k & \
? ping -f 192.168.1.11 &\
? sleep 15; killall ping dd
[1] 9794
[2] 9796
[3] 9798
PING 192.168.1.11 (192.168.1.11) from 192.168.1.10 : 56(84) bytes of data.
Warning: no SO_RCVTIMEO support, falling back to poll
0.08user 2.68system 0:15.25elapsed 18%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (111major+16minor)pagefaults 0swaps
Command terminated by signal 15
0.07user 2.82system 0:15.28elapsed 18%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (113major+16minor)pagefaults 0swaps

[3]  + Terminated                    ping -f 192.168.1.11
[2]  + Exit 15                       /usr/bin/time dd if=/dev/hdc of=/dev/null bs=1k
[1]  + Exit 15                       /usr/bin/time dd if=/dev/hda of=/dev/null bs=1k

[16:25] abit:~ > vmstat -n 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  0  0    116   2748 374216  16960   0   0     0     0  104   205   1   5  94
 4  0  0    116   2432 374228  16968   0   0    20     0  114   293  13   6  81
 4  0  0    116   2860 373672  16972   0   0 14795     0 6824 22553  14  86   0
 5  0  0    116   2364 373892  16972   0   0 11096     0 8049 25992  21  79   0
 5  0  0    116   2224 374040  16972   0   0 16016     0 10143 23148  24  76   0
 5  0  0    116   2572 373752  16972   0   0 17368     0 10537 22909  21  79   0
 5  0  0    116   2260 373996  16972   0   0 16623     7 9278 20696  21  79   0
 5  0  0    116   2548 373996  16972   0   0 13304     0 8033 20136  22  78   0
 5  0  0    116   2104 374404  16972   0   0 13460     0 7336 22157  18  82   0
 4  0  0    116   2064 374476  16972   0   0 17092     0 8340 19564  16  84   0
 4  0  0    116   2532 374016  16972   0   0 15536     0 8659 20688  27  73   0
 5  0  0    116   2416 373996  16972   0   0 15080    22 7954 19934  23  77   0
 5  0  0    116   2360 374192  16972   0   0 15424     0 8511 20816  17  83   0
 4  0  0    116   2956 373596  16972   0   0 17192     0 7081 17983  17  83   0
 4  0  0    116   2684 373864  16972   0   0 14728     0 6767 20708  16  84   0
 6  0  0    116   2712 373528  16972   0   0 12844     0 8386 22734  26  74   0
 1  0  0    116   3296 373656  16972   0   0 13180    11 6344 12894  16  61  23
 1  0  0    116   3296 373656  16972   0   0     0     0  299   622   3   4  93
 0  0  0    116   3296 373656  16972   0   0     0     0  103   168   2   2  96



[tim@abit tim]# /usr/bin/time dd if=/dev/hda of=/dev/null bs=1k & \
? /usr/bin/time dd if=/dev/hdc of=/dev/null bs=1k & \
? ping -f 192.168.1.11 -s 64000 &\
? sleep 15; killall ping dd
[1] 9802
[2] 9804
[3] 9806
PING 192.168.1.11 (192.168.1.11) from 192.168.1.10 : 64000(64028) bytes of data.
Warning: no SO_RCVTIMEO support, falling back to poll
[tim@abit tim]# Command terminated by signal 15
0.15user 5.49system 0:15.32elapsed 36%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (111major+16minor)pagefaults 0swaps
Command terminated by signal 15
0.17user 5.63system 0:15.32elapsed 37%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (111major+16minor)pagefaults 0swaps

[2]    Exit 15                       /usr/bin/time dd if=/dev/hdc of=/dev/null bs=1k
[1]  + Exit 15                       /usr/bin/time dd if=/dev/hda of=/dev/null bs=1k

[16:26] abit:~ > vmstat -n 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 5  0  0    116   2464 354208  37612   0   0     0     0  106   237  11   8  82
 4  0  0    116   2128 354208  37612   0   0     0     0 3470  2162  15  85   0
 3  0  0    116   2356 354204  37604   0   0 10100     0 5932  6888  12  88   0
 3  0  0    116   2280 354344  37604   0   0 16652     0 7632  8982  11  88   1
 3  0  0    116   2224 354492  37604   0   0 19732    13 8408  7217   5  84  11
 3  0  0    116   2616 357800  34204   0   0 20132     0 8552  7206   8  88   4
 3  0  0    116   2568 357864  34204   0   0 20544     0 8604  7352   8  87   5
 5  0  0    116   3008 357436  34204   0   0 20180     0 8453  7300   7  86   8
 5  0  0    116   2636 357808  34204   0   0 19828     0 8422  7303   8  80  13
 4  0  0    116   2360 358388  33904   0   0 19864     8 8427  7239  13  79   8
 7  0  0    116   2844 357908  33904   0   0 20256     0 8522  7199   9  82  10
 4  0  0    116   2512 358244  33900   0   0 19916     0 8378  7169  10  86   4
 5  0  0    116   2536 358220  33900   0   0 18536     0 8300  7213  17  78   6
 4  0  0    116   2392 358392  33892   0   0 19620     0 8358  7096  12  80   9
 5  0  0    116   2896 357892  33892   0   0 20236     0 8459  7221   5  85  10
 1  0  0    116   3152 358132  33948   0   0 12575     0 5395  4783  14  53  33
 1  0  0    116   3152 358132  33948   0   0     0     0  103   177   2   3  95
 0  0  0    116   3152 358132  33948   0   0     0     0  103   173   1   2  97



[tim@abit tim]# grep read_intr /var/log/messages

[tim@abit tim]# ping dell
PING dell.yoyodyne.org (192.168.1.11) from 192.168.1.10 : 56(84) bytes of data.
64 bytes from dell.yoyodyne.org (192.168.1.11): icmp_seq=0 ttl=255 time=270 usec
64 bytes from dell.yoyodyne.org (192.168.1.11): icmp_seq=1 ttl=255 time=235 usec
64 bytes from dell.yoyodyne.org (192.168.1.11): icmp_seq=2 ttl=255 time=239 usec

--- dell.yoyodyne.org ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max/mdev = 0.235/0.248/0.270/0.015 ms

[tim@abit tim]# cat /proc/ide/drivers
ide-scsi version 0.9
ide-disk version 1.09

[tim@abit tim]# hdparm -iv /dev/hd{a,c}

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2501/255/63, sectors = 40188960, start = 0

 Model=IC35L020AVER07-0, FwRev=ER2OA44A, SerialNo=SVPTV0L4268
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40188960
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5 

/dev/hdc:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2491/255/63, sectors = 40021632, start = 0

 Model=Maxtor 32049H2, FwRev=YAH814Y0, SerialNo=L21R7EKC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=40021632
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5 

[tim@abit tim]# dmesg
Linux version 2.2.21pre1 (root@abit) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 Mon Dec 31 17:38:18 PST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usable)
 BIOS-e820: 1ff00000 @ 00100000 (usable)
Detected 848393 kHz processor.
ide_setup: hdb=ide-scsi
ide_setup: hdd=ide-scsi
Console: colour VGA+ 80x25
Calibrating delay loop... 1690.82 BogoMIPS
Memory: 517020k/524288k available (1196k kernel code, 412k reserved, 5592k data, 68k init)
Dentry hash table entries: 65536 (order 7, 512k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 131072 (order 7, 512k)
CPU: L1 I Cache: 64K  L1 D Cache: 64K
CPU: L2 Cache: 512K
CPU: AMD Athlon(tm) Processor stepping 02
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
PCI: PCI BIOS revision 2.10 entry at 0xfb4d0
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
parport0: PC-style at 0x378 [SPP,PS2,EPP]
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.09
Crystal 4280/461x + AC97 Audio, version 0.13, 17:39:20 Dec 31 2001
cs461x: Card found at 0xd7106000 and 0xd7000000, IRQ 5
cs461x: Voyetra at 0xd7106000/0xd7000000, IRQ 5
ac97_codec: AC97 Audio codec, vendor id1: 0x4352, id2: 0x5914 (Unknown)
cs461x: Found 1 audio device(s).
loop: registered device at major 7
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L020AVER07-0, ATA DISK drive
hdb: YAMAHA CRW4416E, ATAPI CDROM drive
hdc: Maxtor 32049H2, ATA DISK drive
hdd: BCD-F520D CD-ROM, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: IC35L020AVER07-0, 19623MB w/1916kB Cache, CHS=2501/255/63, UDMA(66)
hdc: Maxtor 32049H2, 19541MB w/2048kB Cache, CHS=39704/16/63, UDMA(66)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ppa: Version 2.07 (for Linux 2.2.x)
WARNING - no ppa compatible devices found.
  As of 31/Aug/1998 Iomega started shipping parallel
  port ZIP drives with a different interface which is
  supported by the imm (ZIP Plus) driver. If the
  cable is marked with "AutoDetect", this is what has
  happened.
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
scsi : 1 host.
  Vendor: YAMAHA    Model: CRW4416E          Rev: 1.0e
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
  Vendor: BCD       Model: F520D CD-ROM      Rev: 2.41
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
scsi : detected 2 SCSI generics 2 SCSI cdroms total.
sr0: scsi3-mmc drive: 16x/16x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.11
sr1: scsi3-mmc drive: 1x/52x cd/rw xa/form2 cdda tray
tulip.c:v0.91g-ppc 7/16/99 becker@cesdis.gsfc.nasa.gov
eth0: Lite-On 82c168 PNIC rev 32 at 0xec00, 00:A0:CC:57:89:93, IRQ 11.
eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
 hdc: [PTBL] [2491/255/63] hdc1 hdc2 hdc3 hdc4
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 68k freed
Adding Swap: 257032k swap-space (priority 1)
Adding Swap: 530104k swap-space (priority 1)
eth0: Setting full-duplex based on MII#1 link partner capability of 41e1.
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 0
VFS: Disk change detected on device sr(11,1)
VFS: Disk change detected on device sr(11,1)
ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 0

[tim@abit tim]# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0391 (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set
        Region 0: Memory at d0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8391 (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d2000000-d3ffffff
        Prefetchable memory behind bridge: d4000000-d5ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Region 4: I/O ports at e000
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 FireWire (IEEE 1394): Texas Instruments TSB12LV23 OHCI Compliant IEEE-1394 Controller (prog-if 10 [OHCI])
        Subsystem: Ads Technologies Inc: Unknown device 0000
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 3 min, 4 max, 32 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d7104000 (32-bit, non-prefetchable)
        Region 1: Memory at d7100000 (32-bit, non-prefetchable)
        Capabilities: [44] Power Management version 1
                Flags: PMEClk- AuxPwr+ DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: Voyetra Technologies: Unknown device 3357
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 4 min, 24 max, 32 set
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at d7106000 (32-bit, non-prefetchable)
        Region 1: Memory at d7000000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
        Subsystem: Netgear FA310TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 set
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ec00
        Region 1: Memory at d7105000 (32-bit, non-prefetchable)

01:00.0 VGA compatible controller: nVidia Corporation Riva TNT2 Model 64 (rev 11) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 5 min, 1 max, 32 set
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d2000000 (32-bit, non-prefetchable)
        Region 1: Memory at d4000000 (32-bit, prefetchable)
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[tim@abit tim]# ps -ef
UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 Jan15 ?        00:00:05 init
root         2     1  0 Jan15 ?        00:00:02 [kflushd]
root         3     1  0 Jan15 ?        00:00:02 [kupdate]
root         4     1  0 Jan15 ?        00:00:08 [kswapd]
root         5     1  0 Jan15 ?        00:00:00 [keventd]
bin        305     1  0 Jan15 ?        00:00:00 portmap
rpcuser    333     1  0 Jan15 ?        00:00:00 rpc.statd
root       358     1  0 Jan15 ?        00:00:00 rpc.mountd
root       367     1  0 Jan15 ?        00:00:00 [nfsd]
root       368     1  0 Jan15 ?        00:00:00 [nfsd]
root       369     1  0 Jan15 ?        00:00:00 [nfsd]
root       370     1  0 Jan15 ?        00:00:00 [nfsd]
root       371     1  0 Jan15 ?        00:00:00 [nfsd]
root       372     1  0 Jan15 ?        00:00:00 [nfsd]
root       373     1  0 Jan15 ?        00:00:00 [nfsd]
root       374     1  0 Jan15 ?        00:00:00 [nfsd]
root       375   367  0 Jan15 ?        00:00:00 [lockd]
root       376   375  0 Jan15 ?        00:00:00 [rpciod]
root       432     1  0 Jan15 ?        00:00:01 nscd
root       437   432  0 Jan15 ?        00:00:00 nscd
root       438   437  0 Jan15 ?        00:00:01 nscd
root       439   437  0 Jan15 ?        00:00:02 nscd
root       447     1  0 Jan15 ?        00:00:02 syslogd -r -l dell:asus:smp:lap -m 0
root       456     1  0 Jan15 ?        00:00:00 klogd
nobody     470     1  0 Jan15 ?        00:00:00 identd -e -o
nobody     473   470  0 Jan15 ?        00:00:00 identd -e -o
nobody     474   473  0 Jan15 ?        00:00:00 identd -e -o
nobody     475   473  0 Jan15 ?        00:00:00 identd -e -o
nobody     476   473  0 Jan15 ?        00:00:00 identd -e -o
daemon     488     1  0 Jan15 ?        00:00:00 /usr/sbin/atd
root       502     1  0 Jan15 ?        00:00:00 crond
root       516     1  0 Jan15 ?        00:00:00 inetd
root       527     1  0 Jan15 ?        00:00:00 sshd
root       543     1  0 Jan15 ?        00:00:00 xntpd -A
root       557     1  0 Jan15 ?        00:00:00 lpd -l
root       604     1  0 Jan15 ?        00:00:00 sendmail: accepting connections
xfs        667     1  0 Jan15 ?        00:00:00 xfs -droppriv -daemon -port -1
root       693     1  0 Jan15 tty1     00:00:00 /sbin/mingetty tty1
root       694     1  0 Jan15 tty2     00:00:00 /sbin/mingetty tty2
root       695     1  0 Jan15 tty3     00:00:00 /sbin/mingetty tty3
root       696     1  0 Jan15 tty4     00:00:00 /sbin/mingetty tty4
root       697     1  0 Jan15 tty5     00:00:00 /sbin/mingetty tty5
root       698     1  0 Jan15 tty6     00:00:00 /sbin/mingetty tty6
root       699     1  0 Jan15 ?        00:00:00 /usr/X11R6/bin/xdm -nodaemon
root       710   699  1 Jan15 ?        02:53:46 /etc/X11/X -auth /usr/X11R6/lib/X11/xdm/authdir/authfiles/A:0-F1dWBe
root       711   699  0 Jan15 ?        00:00:00 -:0                         
tim        722   711  0 Jan15 ?        00:04:18 /usr/X11R6/bin/afterstep
tim        766     1  0 Jan15 ?        00:00:01 /usr/bin/X11/xclipboard -geometry 357x178+1241+351
root       767     1  1 Jan15 ?        03:50:53 xosview -geometry 253x302+1345+0
tim        768     1  0 Jan15 ?        00:00:00 xcalc -geometry 188x231+1408+329
tim        769     1  0 Jan15 ?        00:00:03 xterm -cm -ls -sl 4500 -sb -vb -rv -bg white -fg black -fn 9x15bold -geometry 15
tim        780   769  0 Jan15 ttyp3    00:00:00 -tcsh
tim        889     1  0 Jan15 ?        00:00:03 ical -geom 1x25+0+15 -iconic
tim       5190   722  0 Jan17 ?        00:00:00 /usr/X11R6/bin/Animate --window 0 --context 8
tim       5191   722  0 Jan17 ?        00:00:01 /usr/X11R6/bin/Wharf --window 0 --context 8
tim       5193     1  0 Jan17 ?        00:00:00 asclock -shape -12 -led green -exe /home/tim/bin/ical_launch
tim       5194   722  0 Jan17 ?        00:00:06 /usr/X11R6/bin/Pager --window 0 --context 8 0 0
tim       5196     1  0 Jan17 ?        00:00:01 ascpu -u 2 -samples 15
tim       5198     1  0 Jan17 ?        00:00:00 asmix -shape
tim      10580     1  0 Jan18 ?        00:00:00 csh /home/tim/bin/x11 -r smp
tim      10581 10580  0 Jan18 ?        00:00:00 rsh -n -l tim smp /usr/bin/X11/xterm -ls -sb -sl 3500 -fg black -bg white -displ
tim      14310     1  0 Jan19 ?        00:00:00 csh /home/tim/bin/x11 -r smp
tim      14311 14310  0 Jan19 ?        00:00:00 rsh -n -l tim smp /usr/bin/X11/xterm -ls -sb -sl 3500 -fg black -bg white -displ
tim      29379     1  0 Jan21 ?        00:00:14 xterm -geometry 90x30 -cm -ls -sl 4500 -sb -vb -rv -bg white -fg black -fn 9x15b
tim      29382 29379  0 Jan21 ttyp4    00:00:00 -tcsh
root      6169     1  0 Jan23 ttyp4    00:00:00 su - nobody -c /usr/sbin/junkbuster /etc/junkbuster/config
nobody    6174  6169  0 Jan23 ttyp4    00:00:01 /usr/sbin/junkbuster /etc/junkbuster/config
tim       8459   780  0 02:11 ttyp3    00:00:00 tail -n 300 -f /var/log/messages
tim       8460   780  0 02:11 ttyp3    00:00:00 egrep -v  named.* [UNX]S|:80 | alive
tim       8529     1  0 02:26 ?        00:00:00 csh /usr/bin/netscape
tim       8530  8529  0 02:26 ?        00:01:43 /opt/netscape/netscape
tim       9836 29382  0 17:00 ttyp4    00:00:00 ps -ef


[tim@abit tim]# exit

Script done on Thu Jan 24 16:29:08 2002
[17:04] abit:~ > 


--
