Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLAIom>; Fri, 1 Dec 2000 03:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129248AbQLAIoW>; Fri, 1 Dec 2000 03:44:22 -0500
Received: from pobox5.csc.fi ([193.166.0.99]:7688 "EHLO smtp.csc.fi")
	by vger.kernel.org with ESMTP id <S129228AbQLAIoN>;
	Fri, 1 Dec 2000 03:44:13 -0500
Date: Fri, 1 Dec 2000 10:13:45 +0200 (EET)
From: Pekka Järveläinen <pj@csc.fi>
To: <linux-kernel@vger.kernel.org>
cc: <linux@csc.fi>
Subject: PROBLEM: 2.4.0-test11 SMP NFS repeatly OOPS
Message-ID: <Pine.LNX.4.30.0012010954500.945-100000@rubiini.csc.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[1.] 2.4.0-test11 SMP NFS repeatly oops

[2.] 2.4.0-test11 SMP OOPS again  (I reported the first one
Message-ID: <Pine.LNX.4.10.10011241326500.1727-100000@rubiini.csc.fi>
Subject: PROBLEM: kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:164!)

Now there isn't heavy load and runned program was opera 4b3static instead of
pine.

[5.]
ksymoops 2.3.5 on i686 2.4.0-test11.  Options used
     -v ../../vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m /usr/src/linux/System.map (default)

 kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:164!
 invalid operand: 0000
 CPU:    1
 EIP:    0010:[nfs_create_request+407/448]
 EFLAGS: 00010286
 eax: 00000039   ebx: c7e5c420   ecx: 00000000   edx: 00000000
 esi: c127f5a0   edi: c3b81bc0   ebp: c1c1c000   esp: c1c1dda4
 ds: 0018   es: 0018   ss: 0018
 Process opera (pid: 14913, stackpage=c1c1d000)
 Stack: c024c905 c024cae0 000000a4 c17603e0 c3119ec0 00000000 c3f697a0 c17603e0
        00000000 c0168f19 c3f697a0 c1177c7c 00000000 00001000 fffffff4 00000004
        c1177c7c c1177c7c c17603e0 ffffffff c1177c7c c17603e0 c3f697a0 c0169699
 Call Trace: [tvecs+58141/112824] [tvecs+58616/112824] [nfs_readpage_async+329/464] [nfs_readpage+121/192] [read_cluster_nonblocking+256/320] [unix_write_space+71/128] [filemap_nopage+325/912]
Dec  1 09:00:33 rubiini kernel: Code: 0f 0b 83 c4 0c 89 5f 1c c7 47 3c 01 00 00 00 f0 ff 06 f0 ff
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   89 5f 1c                  mov    %ebx,0x1c(%edi)
Code;  00000008 Before first symbol
   8:   c7 47 3c 01 00 00 00      movl   $0x1,0x3c(%edi)
Code;  0000000f Before first symbol
   f:   f0 ff 06                  lock incl (%esi)
Code;  00000012 Before first symbol
  12:   f0 ff 00                  lock incl (%eax)

[3.] nfs kernel

[4.]
cat /proc/version
Linux version 2.4.0-test11 (root@rubiini.csc.fi) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #4 SMP Wed Nov 22 18:51:23 EET 2000
[pj@rubiini ksymoops]$ cd ..

[7.]

[pj@rubiini scripts]$ sh ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux rubiini.csc.fi 2.4.0-test11 #4 SMP Wed Nov 22 18:51:23 EET 2000 i686 unknown
Kernel modules         2.3.21
Gnu C                  2.96
Gnu Make               3.79.1
Binutils               2.10.0.18
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         af_packet 3c59x cs4232 uart401 ad1848 sound
[pj@rubiini scripts]$ cat cat /proc/cpuinfo
cat: cat: No such file or directory
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 398.000780
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 796.26

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 398.000780
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 796.26

[pj@rubiini scripts]$ cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0534-0537 : Crystal audio controller
0800-083f : Intel Corporation 82371AB PIIX4 ACPI
  0800-0803 : acpi
  0804-0805 : acpi
  0808-080b : acpi
  080c-080f : acpi
0840-085f : Intel Corporation 82371AB PIIX4 ACPI
0cf8-0cff : PCI conf1
dc00-dc7f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  dc00-dc7f : eth0
dce0-dcff : Intel Corporation 82371AB PIIX4 USB
e000-efff : PCI Bus #02
  e800-e8ff : Adaptec AIC-7880U
    e800-e8fe : aic7xxx
  ec00-ecff : Adaptec AHA-2940U2/W / 7890
    ec00-ecfe : aic7xxx
ffa0-ffaf : Intel Corporation 82371AB PIIX4 IDE
  ffa0-ffa7 : ide0
[pj@rubiini scripts]$ cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cc7ff : Extension ROM
000d0000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffdfff : System RAM
  00100000-0028d8c7 : Kernel code
  0028d8c8-002a6dbf : Kernel data
07ffe000-07ffffff : reserved
ec000000-efffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
f1000000-f1ffffff : PCI Bus #02
f2000000-f5ffffff : PCI Bus #01
  f4000000-f5ffffff : Matrox Graphics, Inc. MGA G400 AGP
fa000000-fbffffff : PCI Bus #02
  faffe000-faffefff : Adaptec AIC-7880U
  fafff000-faffffff : Adaptec AHA-2940U2/W / 7890
fc000000-fdffffff : PCI Bus #01
  fc000000-fc7fffff : Matrox Graphics, Inc. MGA G400 AGP
  fcffc000-fcffffff : Matrox Graphics, Inc. MGA G400 AGP
fe000000-fe00007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
ffe00000-ffffffff : reserved
[pj@rubiini scripts]$ lspci -vvv
lspci: Command not found.
[pj@rubiini scripts]$ /sbin/lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 0080
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fc000000-fdffffff
        Prefetchable memory behind bridge: f2000000-f5ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 19
        Region 4: I/O ports at dce0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
        Subsystem: Dell Computer Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 19
        Region 0: I/O ports at dc00 [size=128]
        Region 1: Memory at fe000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at f9000000 [disabled] [size=128K]
        Capabilities: <available only to root>

00:13.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fa000000-fbffffff
        Prefetchable memory behind bridge: 00000000f1000000-00000000f1f00000
        BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: <available only to root>

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SGRAM
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f4000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at fcffc000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at fc000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at 80000000 [disabled] [size=64K]
        Capabilities: <available only to root>

02:0a.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
        Subsystem: Dell Computer Corporation: Unknown device 0080
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (9750ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        BIST result: 00
        Region 0: I/O ports at ec00 [size=256]
        Region 1: Memory at fafff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at fb000000 [disabled] [size=128K]
        Capabilities: <available only to root>

02:0e.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
        Subsystem: Adaptec AIC-7880P Ultra/Ultra Wide SCSI Chipset
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at faffe000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at fb000000 [disabled] [size=64K]
        Capabilities: <available only to root>

cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: VIKING II 9.1WLS Rev: 5520
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:465 Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
[pj@rubiini scripts]$ df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda1              1921156   1362024    461540  75% /
/dev/sda3              1921188   1452848    370748  80% /opt
/dev/sda5              1415164    101652   1241624   8% /tmp
/dev/hda2             12096756   1468836  10013436  13% /alt
/dev/sda6              1284992    146816   1138176  12% /dos
/dev/sda2              1951897    643607   1308290  33% /mnt/nt
mds2:/mnt/mds/linux22_i386
                      88867488   1962352  11715280  15% /mnt/mds/linux22_i386
mds2:/mnt/mds/src
                      88867488   3417032  11715280  23% /mnt/mds/src
mds2:/mnt/mds/gen
                      88867488  11227712  11715280  49% /mnt/mds/gen
mds4:/mnt/mds/asdu_csc
                      88868736  37408680  49934368  43% /mnt/mds/asdu_csc
mds7:/mnt/mds/metawrk
                     533212032 436648240  95496096  83% /mnt/mds/metawrk
mds1:/mnt/mds/csc   88867488  11766104  31975024  27% /mnt/mds/csc
mds6:/mnt/mds/www.csc.fi
                      88867000  10554968  52029912  17% /mnt/mds/www.csc.fi
mds6:/mnt/mds/veppi.csc.fi
                      88867000   5254096  52029912  10% /mnt/mds/veppi.csc.fi
/dev/scd0               114570    114570         0 100% /mnt/cdrom

Pekka Järveläinen                       Tel. +358 9  457 2467
Centre for Scientific Computing         GSM  +358 40 543 7856
Tekniikantie 15a D, P.O. Box 405        fax. +358 9  457 2302
02101 ESPOO, FINLAND                    pj@csc.fi


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
