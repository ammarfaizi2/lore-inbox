Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129811AbQLPWV4>; Sat, 16 Dec 2000 17:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbQLPWVg>; Sat, 16 Dec 2000 17:21:36 -0500
Received: from mx2.core.com ([208.40.40.41]:61605 "EHLO smtp-2.core.com")
	by vger.kernel.org with ESMTP id <S129811AbQLPWV2>;
	Sat, 16 Dec 2000 17:21:28 -0500
Message-ID: <3A3BE424.4A7FB8D9@megsinet.net>
Date: Sat, 16 Dec 2000 15:52:36 -0600
From: "M.H.VanLeeuwen" <vanl@megsinet.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: trond.myklebust@fys.uio.no, neilb@cse.unsw.edu.au
CC: linux-kernel@vger.kernel.org
Subject: kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167! - reproducible
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond, Neil
 
I don't know if this is a loopback bug or an NFS bug but since
nfs_fs.h was implicated so I thought one of you may be interested.
 
Could you let me know if you know this problem has already been fixed
or if you need more info.
 
Martin
 
[1.] One line summary of the problem:
kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167!
 
[2.] Full description of the problem/report:
 
BUG while trying to read from NFS file mounted locally via loopback.
 
NFS client(heli, UP) & server(shadow, SMP) are 2.4.0-test12 NFSv3.
 
shadow mounted a file system image via loopback to a local mount point.
 
shadow:/mnt#mount
heli:/tmp on /mnt type nfs (rw,addr=192.168.0.2)
 
shadow:/mnt/uml# file root_fs_slackware_7.1_small
root_fs_slackware_7.1_small: x86 boot sector, extended partition table
 
shadow:/mnt/uml# mount -o loop root_fs_slackware_7.1_small /mnt1
 
shadow:/mnt/uml# mount
heli:/tmp on /mnt type nfs (rw,addr=192.168.0.2)
/mnt/uml/root_fs_slackware_7.1_small on /mnt1 type ext2 (rw,loop=/dev/loop/0)
 
shadow:/mnt/uml# cd /mnt1
shadow:/mnt1# lf
/usr/local/bin/lf: line 1:   585 Segmentation fault      ls $LS_OPTIONS $1
 
[3.] Keywords (i.e., modules, networking, kernel):
nfs, loopback
[4.] Kernel version (from /proc/version):
Linux version 2.4.0-test12 (mhvl@shadow) (gcc version 2.95.2 19991024 (release)) #1 SMP Tue Dec 12 20:46:11 CST 2000  
[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
ksymoops 2.3.5 on i686 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map-2.4.0-test12 (specified)
 
No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
activating NMI Watchdog ... done.
cpu: 0, clocks: 680220, slice: 226740
cpu: 1, clocks: 680220, slice: 226740
kernel BUG at /usr/src/linux/include/linux/nfs_fs.h:167!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c015c351>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000039   ebx: c8639ae0   ecx: 00000000   edx: 00000002
esi: cba46840   edi: c78592c0   ebp: c05f6000   esp: c05f7d08
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 585, stackpage=c05f7000)
Stack: c0231b65 c0231d40 000000a7 c081fda0 c0a473c0 00000000 c1018fd4 c015b30d
       c081fda0 c0a473c0 c1018fd4 00000000 00001000 c0a473c0 ffffffff c1018fd4
       c081fda0 fffffff4 c015bb11 c081fda0 c0a473c0 c1018fd4 c13a9b7c c1018fd4
Call Trace: [<c0231b65>] [<c0231d40>] [<c015b30d>] [<c015bb11>] [<c0125d33>] [<c01839bc>] [<c01838c4>]
       [<c0183ceb>] [<c01829cf>] [<c0182b4d>] [<c0182bb0>] [<c0182d37>] [<c015207d>] [<c0150725>] [<c0112e58>]
       [<c0124891>] [<c014086c>] [<c0140c3c>] [<c0140d97>] [<c0140c3c>] [<c0123578>] [<c010b073>]
Code: 0f 0b 83 c4 0c 89 7e 1c eb 26 90 8d 74 26 00 6a 00 8b 54 24
 
>>EIP; c015c351 <nfs_create_request+195/1e4>   <=====
Trace; c0231b65 <devfsd_buf_size+1c85/1196c>
Trace; c0231d40 <devfsd_buf_size+1e60/1196c>
Trace; c015b30d <nfs_readpage_async+13d/1c0>
Trace; c015bb11 <nfs_readpage+c5/12c>
Trace; c0125d33 <do_generic_file_read+32f/57c>
Trace; c01839bc <lo_receive+58/68>
Trace; c01838c4 <lo_read_actor+0/a0>
Trace; c0183ceb <do_lo_request+31f/414>
Trace; c01829cf <__make_request+5bb/638>
Trace; c0182b4d <generic_make_request+101/110>
Trace; c0182bb0 <submit_bh+54/5c>
Trace; c0182d37 <ll_rw_block+137/1a4>
Trace; c015207d <ext2_bread+d1/114>
Trace; c0150725 <ext2_readdir+91/37c>
Trace; c0112e58 <do_page_fault+0/3e8>
Trace; c0124891 <merge_segments+15d/18c>
Trace; c014086c <vfs_readdir+8c/e8>
Trace; c0140c3c <filldir64+0/10c>
Trace; c0140d97 <sys_getdents64+4f/b8>
Trace; c0140c3c <filldir64+0/10c>
Trace; c0123578 <sys_brk+b4/d8>
Trace; c010b073 <system_call+33/38>
Code;  c015c351 <nfs_create_request+195/1e4>
00000000 <_EIP>:
Code;  c015c351 <nfs_create_request+195/1e4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c015c353 <nfs_create_request+197/1e4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c015c356 <nfs_create_request+19a/1e4>
   5:   89 7e 1c                  mov    %edi,0x1c(%esi)
Code;  c015c359 <nfs_create_request+19d/1e4>
   8:   eb 26                     jmp    30 <_EIP+0x30> c015c381 <nfs_create_request+1c5/1e4>
Code;  c015c35b <nfs_create_request+19f/1e4>
   a:   90                        nop
Code;  c015c35c <nfs_create_request+1a0/1e4>
   b:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c015c360 <nfs_create_request+1a4/1e4>
   f:   6a 00                     push   $0x0
Code;  c015c362 <nfs_create_request+1a6/1e4>
  11:   8b 54 24 00               mov    0x0(%esp,1),%edx
 
 
1 warning issued.  Results may not be reliable. 
[6.] A small shell script or example program which triggers the
     problem (if possible)
see description of problem
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux shadow 2.4.0-test12 #1 SMP Tue Dec 12 20:46:11 CST 2000 i686 unknown
Kernel modules         2.3.21
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.1
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.2
Mount                  2.10q
Net-tools              1.57
Kbd                    1.00
Sh-utils               2.0
Modules Loaded
 
[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 476.085
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr
bogomips        : 950.27
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 476.085
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr
bogomips        : 950.27
[7.3.] Module information (from /proc/modules):
none 

 [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
shadow:/mnt1# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0213-0213 : isapnp read
0220-023f : eth0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
4000-403f : Intel Corporation 82371AB PIIX4 ACPI
5000-501f : Intel Corporation 82371AB PIIX4 ACPI
c000-cfff : PCI Bus #01
  c000-c0ff : ATI Technologies Inc Rage 128 RF
d000-d01f : Intel Corporation 82371AB PIIX4 USB
d400-d407 : Triones Technologies, Inc. HPT366
d800-d803 : Triones Technologies, Inc. HPT366
dc00-dcff : Triones Technologies, Inc. HPT366
  dc00-dc07 : ide2
  dc10-dcff : HPT366
e000-e007 : Triones Technologies, Inc. HPT366 (#2)
e400-e403 : Triones Technologies, Inc. HPT366 (#2)
e800-e8ff : Triones Technologies, Inc. HPT366 (#2)
  e800-e807 : ide3
  e810-e8ff : HPT366
f000-f00f : Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1                                                              shadow:/mnt1# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0bffffff : System RAM
  00100000-00268fa7 : Kernel code
  00268fa8-002809ff : Kernel data
d0000000-d3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
d4000000-d7ffffff : PCI Bus #01
  d4000000-d7ffffff : ATI Technologies Inc Rage 128 RF
    d4000000-d7ffffff : aty128fb FB
d8000000-d9ffffff : PCI Bus #01
  d9000000-d9003fff : ATI Technologies Inc Rage 128 RF
    d9000000-d9003fff : aty128fb MMIO
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
shadow:/mnt1# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2
 
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: d8000000-d9ffffff
        Prefetchable memory behind bridge: d4000000-d7ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
 
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]
 
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 0
        Region 4: I/O ports at d000 [size=32]
 
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
 
00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d400 [size=8]
        Region 1: I/O ports at d800 [size=4]
        Region 4: I/O ports at dc00 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
 
00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 18
        Region 0: I/O ports at e000 [size=8]
        Region 1: I/O ports at e400 [size=4]
        Region 4: I/O ports at e800 [size=256]
 
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RF (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0044
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at d9000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
shadow:/mnt1# cat /proc/mounts
/dev/ide/host0/bus0/target0/lun0/part1 / ext2 rw 0 0
none /dev devfs rw 0 0
proc /proc proc rw 0 0
none /dev/shm shm rw 0 0
/dev/discs/disc1/disc /backup/MUSIC ext2 rw 0 0
192.168.0.2:/lib /lib nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.0.2 0 0
192.168.0.2:/sbin /sbin nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.0.2 0 0
192.168.0.2:/bin /bin nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.0.2 0 0
192.168.0.2:/usr /usr nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.0.2 0 0
192.168.0.2:/usr/local /usr/local nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.0.2 0 0
192.168.0.2:/home /home nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.0.2 0 0
192.168.0.2:/wine /wine nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.0.2 0 0
192.168.0.2:/backup/LINUX /backup/LINUX nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.0.2 0 0
192.168.0.2:/backup2 /backup2 nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.0.2 0 0
192.168.0.2:/netboot /netboot nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=192.168.0.2 0 0
automount(pid141) /auto autofs rw 0 0
automount(pid156) /net autofs rw 0 0
heli:/tmp /mnt nfs rw,v3,rsize=8192,wsize=8192,hard,udp,lock,addr=heli 0 0
/dev/loop/0 /mnt1 ext2 rw 0
0
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
