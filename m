Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292617AbSCDRgl>; Mon, 4 Mar 2002 12:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292612AbSCDRgd>; Mon, 4 Mar 2002 12:36:33 -0500
Received: from [195.199.63.65] ([195.199.63.65]:44817 "HELO csibe.fazekas.hu")
	by vger.kernel.org with SMTP id <S292589AbSCDRfc>;
	Mon, 4 Mar 2002 12:35:32 -0500
Date: Mon, 4 Mar 2002 18:34:25 +0100 (CET)
From: Kerekfy Peter <kerekfyp@fazekas.hu>
To: <linux-kernel@vger.kernel.org>
Cc: <urban@teststation.com>
Subject: linux kernel bug report
Message-ID: <Pine.LNX.4.33.0203041729450.10999-600000@pingvin.fazekas.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-943504833-2135313262-1015263265=:10999"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---943504833-2135313262-1015263265=:10999
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello!

I think I've discovered a bug related to the SMB filesystem.

I've got two machines at home: athene and thalia.
At thalia there is a FAT32 partition mounted to the /c directory with the
following options:

=09root@thalia:~ # mount
=09[...]
=09/dev/hda2 on /c type vfat (rw,nosuid,nodev,quiet,codepage=3D852,iocharse=
t=3Diso8859-2)
=09[...]

I'm running samba server on that machine (thalia) with the attached config
file.

Then I've mounted the /c directory of thalia on athene via SMB.

=09root@athene:~ # mount
=09[...]
=09//thalia/c on /mnt type smbfs (0)
=09[...]

There is a file in the /c directory of thalia which's name contains some
of the following characters: =FB=F5=E1=E9 etc. (It was created under windoz=
e.)

And when I tried to reach the directory which contained that specific file
from athene using the smbfs filesystem, the program (actually mc) ran into
a deadlock, and a kernel oops message apperad at console 10.

The oops message: the attached file oops.txt contains it.
The output of ksymoops < oops.txt: the attached file ksymoops.txt
contains it.

After I've renamed the file, which probably caused the oops, to a name
containing only 'normal' characteres, I was able to reach it without any
problem, just in normal cases.

And now, I'll try to tell you everything about the two computers:

I. athene: (based on SuSE 7.2, but with some self-compiled parts)
---------
1. kernel version:
root@athene:~ # cat /proc/version
Linux version 2.4.18 (root@athene) (gcc version 2.95.3 20010315 (SuSE)) #2
Sat Mar 2 11:36:17 CET 2002

2. output of ver_linux
root@athene:~ # sh /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux athene 2.4.18 #2 Sat Mar 2 11:36:17 CET 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.25
reiserfsprogs          3.x.0j
Linux C Library        x    1 root     root      1343073 May 11  2001
/lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         nls_iso8859-1 smbfs NVdriver mousedev usbmouse
usb-uhci input nfs lockd sunrpc de4x5 es1371 soundcore ac97_codec
nls_iso8859-2 nls_cp852 vfat fat ext2

3. CPU info
root@athene:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 0
cpu MHz         : 412.507
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 822.47

4. Module info
root@athene:~ # cat /proc/modules
nls_iso8859-1           2880   1 (autoclean)
smbfs                  31312   1 (autoclean)
NVdriver              723696   9 (autoclean)
mousedev                3808   2 (autoclean)
usbmouse                1776   0 (autoclean) (unused)
usb-uhci               21136   0 (autoclean) (unused)
input                   3264   0 (autoclean) [mousedev usbmouse]
nfs                    69200   3 (autoclean)
lockd                  46704   1 (autoclean) [nfs]
sunrpc                 58336   1 (autoclean) [nfs lockd]
de4x5                  38928   1 (autoclean)
es1371                 25968   0 (autoclean)
soundcore               3504   4 (autoclean) [es1371]
ac97_codec              9344   0 (autoclean) [es1371]
nls_iso8859-2           3392   2 (autoclean)
nls_cp852               3616   3 (autoclean)
vfat                    9296   2 (autoclean)
fat                    29152   0 (autoclean) [vfat]
ext2                   29968   1 (autoclean)

5. Loaded driver and hardware information
root@athene:~ # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d19ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0bffffff : System RAM
  00100000-001e6270 : Kernel code
  001e6271-00223cbf : Kernel data
e0000000-e7ffffff : Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge
e8000000-e9ffffff : PCI Bus #01
  e8000000-e8ffffff : nVidia Corporation Riva TnT [NV04]
ea000000-eaffffff : PCI Bus #01
  ea000000-eaffffff : nVidia Corporation Riva TnT [NV04]
ed000000-ed0003ff : Digital Equipment Corporation DECchip 21142/43
ffff0000-ffffffff : reserved
root@athene:~ # cat /proc/ioports
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
0376-0376 : ide1
03c0-03df : vga+
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB PIIX4 ACPI
c000-c01f : Intel Corp. 82371AB PIIX4 USB
  c000-c01f : usb-uhci
c400-c43f : Ensoniq ES1371 [AudioPCI-97]
  c400-c43f : es1371
c800-c87f : Digital Equipment Corporation DECchip 21142/43
  c800-c87f : DC21143 (eth0)
cc00-cc07 : Triones Technologies, Inc. HPT366 / HPT370
  cc00-cc07 : ide2
d000-d003 : Triones Technologies, Inc. HPT366 / HPT370
  d002-d002 : ide2
d400-d4ff : Triones Technologies, Inc. HPT366 / HPT370
  d400-d407 : ide2
  d410-d4ff : HPT366
d800-d807 : Triones Technologies, Inc. HPT366 / HPT370 (#2)
  d800-d807 : ide3
dc00-dc03 : Triones Technologies, Inc. HPT366 / HPT370 (#2)
  dc02-dc02 : ide3
e000-e0ff : Triones Technologies, Inc. HPT366 / HPT370 (#2)
  e000-e007 : ide3
  e010-e0ff : HPT366
f000-f00f : Intel Corp. 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

6. PCI info
root@athene:~ # lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=3D31 SBA+ 64bit- FW- Rate=3Dx1,x2
                Command: RQ=3D0 SBA- AGP+ 64bit- FW- Rate=3Dx2

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: ea000000-eaffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=3D16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at c000 [size=3D32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at c400 [size=3D64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=3D0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0d.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (5000ns min, 10000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at c800 [size=3D128]
        Region 1: Memory at ed000000 (32-bit, non-prefetchable) [size=3D1K]
        Expansion ROM at eb000000 [disabled] [size=3D256K]

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at cc00 [size=3D8]
        Region 1: I/O ports at d000 [size=3D4]
        Region 4: I/O ports at d400 [size=3D256]
        Expansion ROM at ec000000 [disabled] [size=3D128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc. HPT366
(rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 11
        Region 0: I/O ports at d800 [size=3D8]
        Region 1: I/O ports at dc00 [size=3D4]
        Region 4: I/O ports at e000 [size=3D256]

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT 128 [NV04]
(rev 04) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc. V3400 TNT
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=3D16M=
]
        Region 1: Memory at ea000000 (32-bit, prefetchable) [size=3D16M]
        Expansion ROM at <unassigned> [disabled] [size=3D64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
        Capabilities: [44] AGP version 1.0
                Status: RQ=3D15 SBA+ 64bit- FW- Rate=3Dx1,x2
                Command: RQ=3D15 SBA- AGP+ 64bit- FW- Rate=3Dx2


II. thalia (based on SuSE 7.2, but with some self-compiled parts)
----------

1. kernel version
root@thalia:~ # cat /proc/version
Linux version 2.4.18 (root@thalia) (gcc version 2.95.3 20010315 (release))
#1 Sat Mar 2 13:03:07 CET 2002

2. output of ver_linux
root@thalia:~ # sh /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux thalia 2.4.18 #1 Sat Mar 2 13:03:07 CET 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.91.0.4
util-linux             2.11b
mount                  2.11b
modutils               2.4.5
e2fsprogs              1.25
reiserfsprogs          3.x.0j
Linux C Library        x    1 root     root      1343073 May 11  2001
/lib/libc.so.6
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         nls_iso8859-1 nls_cp437 floppy NVdriver mousedev
usbmouse usb-uhci input vmnet vmmon nfs lockd sunrpc 3c59x cmpci soundcore
nls_iso8859-2 nls_cp852 vfat fat ext2

3. CPU info
root@thalia:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1141.627
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2274.09

4. Module info
root@thalia:~ # cat /proc/modules
nls_iso8859-1           2880   0 (autoclean)
nls_cp437               4384   0 (autoclean)
floppy                 46000   0 (autoclean)
NVdriver              820480  14 (autoclean)
mousedev                3904   1 (autoclean)
usbmouse                1776   0 (autoclean) (unused)
usb-uhci               21616   0 (autoclean) (unused)
input                   3360   0 (autoclean) [mousedev usbmouse]
vmnet                  17952   4
vmmon                  18400   0 (unused)
nfs                    71216   3 (autoclean)
lockd                  48304   1 (autoclean) [nfs]
sunrpc                 59840   1 (autoclean) [nfs lockd]
3c59x                  25120   1 (autoclean)
cmpci                  30672   1 (autoclean)
soundcore               3600   4 (autoclean) [cmpci]
nls_iso8859-2           3392   2 (autoclean)
nls_cp852               3616   2 (autoclean)
vfat                    9520   2 (autoclean)
fat                    29760   0 (autoclean) [vfat]
ext2                   30384   1 (autoclean)

5. SMB server
root@thalia:~ # smbd -V
Version 2.2.0
It is the original SuSE 7.2 binary. (I hope)

I think it must be enough.

I've also attached the kernel config files of both machines.
(I used the utilities listed above to compile the kernels.)

Well, that's all...

I hope you'll be able to fix this bug soon. Good luck.

Bye,
Peter.

---943504833-2135313262-1015263265=:10999
Content-Type: TEXT/plain; name="oops.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0203041834250.10999@pingvin.fazekas.hu>
Content-Description: 
Content-Disposition: attachment; filename="oops.txt"

TWFyICA0IDE2OjQ0OjU0IGF0aGVuZSBrZXJuZWw6IFVuYWJsZSB0byBoYW5k
bGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcyBj
YzAwMDAwMA0KTWFyICA0IDE2OjQ0OjU0IGF0aGVuZSBrZXJuZWw6ICBwcmlu
dGluZyBlaXA6DQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5lIGtlcm5lbDogZDFh
OTA5NDcNCk1hciAgNCAxNjo0NDo1NCBhdGhlbmUga2VybmVsOiAqcGRlID0g
MDAwMDAwMDANCk1hciAgNCAxNjo0NDo1NCBhdGhlbmUga2VybmVsOiBPb3Bz
OiAwMDAwDQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5lIGtlcm5lbDogQ1BVOiAg
ICAwDQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5lIGtlcm5lbDogRUlQOiAgICAw
MDEwOls8ZDFhOTA5NDc+XSAgICBOb3QgdGFpbnRlZA0KTWFyICA0IDE2OjQ0
OjU0IGF0aGVuZSBrZXJuZWw6IEVGTEFHUzogMDAwMTAyODINCk1hciAgNCAx
Njo0NDo1NCBhdGhlbmUga2VybmVsOiBlYXg6IDhjMWVhMzBiICAgZWJ4OiBj
YzAwMDAwMCAgIGVjeDogZmI2NWEzZmQgICBlZHg6IDRmMzk1M2NmDQpNYXIg
IDQgMTY6NDQ6NTQgYXRoZW5lIGtlcm5lbDogZXNpOiA2Nzc2OTllNSAgIGVk
aTogYzgzOTdlMzQgICBlYnA6IGM4Mzk3ZWNjICAgZXNwOiBjODM5N2RlNA0K
TWFyICA0IDE2OjQ0OjU0IGF0aGVuZSBrZXJuZWw6IGRzOiAwMDE4ICAgZXM6
IDAwMTggICBzczogMDAxOA0KTWFyICA0IDE2OjQ0OjU0IGF0aGVuZSBrZXJu
ZWw6IFByb2Nlc3MgbWMgKHBpZDogNTc4LCBzdGFja3BhZ2U9YzgzOTcwMDAp
DQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5lIGtlcm5lbDogU3RhY2s6IGMwMTNi
YzMwIGM4Mzk3ZTljIGQxYTlhMjVlIDAwMDAwMDAxIDAwMDAwMDAwIDAwMDAw
MDAwIDAwMDAwMDAwIGMxYzBjZGMwIA0KTWFyICA0IDE2OjQ0OjU0IGF0aGVu
ZSBrZXJuZWw6ICAgICAgICBjYWUzNzhjMCAwMDAwMDAwMCAwMDAzNjk4NyBj
OTViZDk0MCAwMDAwMDAwMCAwMDAwMDAwMCBjYmJlZTAwMCAwMDAwMDAwNCAN
Ck1hciAgNCAxNjo0NDo1NCBhdGhlbmUga2VybmVsOiAgICAgICAgMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDEgMDAwMDAwMDYgZDFhOGYyM2QgYzc3Mzhj
YzAgYzgzOTdmYjAgYzAxM2JjMzAgDQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5l
IGtlcm5lbDogQ2FsbCBUcmFjZTogW2ZpbGxkaXI2NCswLzI3Nl0gWzxkMWE4
ZjIzZD5dIFtmaWxsZGlyNjQrMC8yNzZdIFtmaWxsZGlyNjQrMC8yNzZdIFs8
ZDFhOGYyZDA+XSANCk1hciAgNCAxNjo0NDo1NCBhdGhlbmUga2VybmVsOiAg
ICBbZmlsbGRpcjY0KzAvMjc2XSBbPGQxYTkwMWFiPl0gW2ZpbGxkaXI2NCsw
LzI3Nl0gW3Zmc19yZWFkZGlyKzkxLzEyNF0gW2ZpbGxkaXI2NCswLzI3Nl0g
W3N5c19nZXRkZW50czY0Kzc5LzE3OV0gDQpNYXIgIDQgMTY6NDQ6NTQgYXRo
ZW5lIGtlcm5lbDogICAgW2ZpbGxkaXI2NCswLzI3Nl0gW3N5c19mY250bDY0
KzEyNy8xMzZdIFtzeXN0ZW1fY2FsbCs1MS81Nl0gDQpNYXIgIDQgMTY6NDQ6
NTQgYXRoZW5lIGtlcm5lbDogDQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5lIGtl
cm5lbDogQ29kZTogMGYgYjYgMDMgNDMgODkgYzIgYzEgZTIgMDQgMDEgZjIg
YzEgZTggMDQgMDEgYzIgOGQgMDQgOTIgOGQgDQo=
---943504833-2135313262-1015263265=:10999
Content-Type: TEXT/plain; name="ksymoops.txt"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0203041834251.10999@pingvin.fazekas.hu>
Content-Description: 
Content-Disposition: attachment; filename="ksymoops.txt"

a3N5bW9vcHMgMi40LjQgb24gaTY4NiAyLjQuMTguICBPcHRpb25zIHVzZWQN
CiAgICAgLVYgKGRlZmF1bHQpDQogICAgIC1rIC9wcm9jL2tzeW1zIChkZWZh
dWx0KQ0KICAgICAtbCAvcHJvYy9tb2R1bGVzIChkZWZhdWx0KQ0KICAgICAt
byAvbGliL21vZHVsZXMvMi40LjE4LyAoZGVmYXVsdCkNCiAgICAgLW0gL3Vz
ci9zcmMvbGludXgvU3lzdGVtLm1hcCAoZGVmYXVsdCkNCg0KV2FybmluZzog
WW91IGRpZCBub3QgdGVsbCBtZSB3aGVyZSB0byBmaW5kIHN5bWJvbCBpbmZv
cm1hdGlvbi4gIEkgd2lsbA0KYXNzdW1lIHRoYXQgdGhlIGxvZyBtYXRjaGVz
IHRoZSBrZXJuZWwgYW5kIG1vZHVsZXMgdGhhdCBhcmUgcnVubmluZw0Kcmln
aHQgbm93IGFuZCBJJ2xsIHVzZSB0aGUgZGVmYXVsdCBvcHRpb25zIGFib3Zl
IGZvciBzeW1ib2wgcmVzb2x1dGlvbi4NCklmIHRoZSBjdXJyZW50IGtlcm5l
bCBhbmQvb3IgbW9kdWxlcyBkbyBub3QgbWF0Y2ggdGhlIGxvZywgeW91IGNh
biBnZXQNCm1vcmUgYWNjdXJhdGUgb3V0cHV0IGJ5IHRlbGxpbmcgbWUgdGhl
IGtlcm5lbCB2ZXJzaW9uIGFuZCB3aGVyZSB0byBmaW5kDQptYXAsIG1vZHVs
ZXMsIGtzeW1zIGV0Yy4gIGtzeW1vb3BzIC1oIGV4cGxhaW5zIHRoZSBvcHRp
b25zLg0KDQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5lIGtlcm5lbDogVW5hYmxl
IHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBh
ZGRyZXNzIGNjMDAwMDAwDQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5lIGtlcm5l
bDogZDFhOTA5NDcNCk1hciAgNCAxNjo0NDo1NCBhdGhlbmUga2VybmVsOiAq
cGRlID0gMDAwMDAwMDANCk1hciAgNCAxNjo0NDo1NCBhdGhlbmUga2VybmVs
OiBPb3BzOiAwMDAwDQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5lIGtlcm5lbDog
Q1BVOiAgICAwDQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5lIGtlcm5lbDogRUlQ
OiAgICAwMDEwOls8ZDFhOTA5NDc+XSAgICBOb3QgdGFpbnRlZA0KVXNpbmcg
ZGVmYXVsdHMgZnJvbSBrc3ltb29wcyAtdCBlbGYzMi1pMzg2IC1hIGkzODYN
Ck1hciAgNCAxNjo0NDo1NCBhdGhlbmUga2VybmVsOiBFRkxBR1M6IDAwMDEw
MjgyDQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5lIGtlcm5lbDogZWF4OiA4YzFl
YTMwYiAgIGVieDogY2MwMDAwMDAgICBlY3g6IGZiNjVhM2ZkICAgZWR4OiA0
ZjM5NTNjZg0KTWFyICA0IDE2OjQ0OjU0IGF0aGVuZSBrZXJuZWw6IGVzaTog
Njc3Njk5ZTUgICBlZGk6IGM4Mzk3ZTM0ICAgZWJwOiBjODM5N2VjYyAgIGVz
cDogYzgzOTdkZTQNCk1hciAgNCAxNjo0NDo1NCBhdGhlbmUga2VybmVsOiBk
czogMDAxOCAgIGVzOiAwMDE4ICAgc3M6IDAwMTgNCk1hciAgNCAxNjo0NDo1
NCBhdGhlbmUga2VybmVsOiBQcm9jZXNzIG1jIChwaWQ6IDU3OCwgc3RhY2tw
YWdlPWM4Mzk3MDAwKQ0KTWFyICA0IDE2OjQ0OjU0IGF0aGVuZSBrZXJuZWw6
IFN0YWNrOiBjMDEzYmMzMCBjODM5N2U5YyBkMWE5YTI1ZSAwMDAwMDAwMSAw
MDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCBjMWMwY2RjMCANCk1hciAgNCAx
Njo0NDo1NCBhdGhlbmUga2VybmVsOiAgICAgICAgY2FlMzc4YzAgMDAwMDAw
MDAgMDAwMzY5ODcgYzk1YmQ5NDAgMDAwMDAwMDAgMDAwMDAwMDAgY2JiZWUw
MDAgMDAwMDAwMDQgDQpNYXIgIDQgMTY6NDQ6NTQgYXRoZW5lIGtlcm5lbDog
ICAgICAgIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAxIDAwMDAwMDA2IGQx
YThmMjNkIGM3NzM4Y2MwIGM4Mzk3ZmIwIGMwMTNiYzMwIA0KTWFyICA0IDE2
OjQ0OjU0IGF0aGVuZSBrZXJuZWw6IENhbGwgVHJhY2U6IFtmaWxsZGlyNjQr
MC8yNzZdIFs8ZDFhOGYyM2Q+XSBbZmlsbGRpcjY0KzAvMjc2XSBbZmlsbGRp
cjY0KzAvMjc2XSBbPGQxYThmMmQwPl0gDQpNYXIgIDQgMTY6NDQ6NTQgYXRo
ZW5lIGtlcm5lbDogQ29kZTogMGYgYjYgMDMgNDMgODkgYzIgYzEgZTIgMDQg
MDEgZjIgYzEgZTggMDQgMDEgYzIgOGQgMDQgOTIgOGQgDQoNCj4+RUlQOyBk
MWE5MDk0NyA8RU5EX09GX0NPREUrNTA3OGY4OC8/Pz8/PiAgIDw9PT09PQ0K
Q29kZTsgIGQxYTkwOTQ3IDxFTkRfT0ZfQ09ERSs1MDc4Zjg4Lz8/Pz8+DQow
MDAwMDAwMCA8X0VJUD46DQpDb2RlOyAgZDFhOTA5NDcgPEVORF9PRl9DT0RF
KzUwNzhmODgvPz8/Pz4gICA8PT09PT0NCiAgIDA6ICAgMGYgYjYgMDMgICAg
ICAgICAgICAgICAgICBtb3Z6YmwgKCVlYngpLCVlYXggICA8PT09PT0NCkNv
ZGU7ICBkMWE5MDk0YSA8RU5EX09GX0NPREUrNTA3OGY4Yi8/Pz8/Pg0KICAg
MzogICA0MyAgICAgICAgICAgICAgICAgICAgICAgIGluYyAgICAlZWJ4DQpD
b2RlOyAgZDFhOTA5NGIgPEVORF9PRl9DT0RFKzUwNzhmOGMvPz8/Pz4NCiAg
IDQ6ICAgODkgYzIgICAgICAgICAgICAgICAgICAgICBtb3YgICAgJWVheCwl
ZWR4DQpDb2RlOyAgZDFhOTA5NGQgPEVORF9PRl9DT0RFKzUwNzhmOGUvPz8/
Pz4NCiAgIDY6ICAgYzEgZTIgMDQgICAgICAgICAgICAgICAgICBzaGwgICAg
JDB4NCwlZWR4DQpDb2RlOyAgZDFhOTA5NTAgPEVORF9PRl9DT0RFKzUwNzhm
OTEvPz8/Pz4NCiAgIDk6ICAgMDEgZjIgICAgICAgICAgICAgICAgICAgICBh
ZGQgICAgJWVzaSwlZWR4DQpDb2RlOyAgZDFhOTA5NTIgPEVORF9PRl9DT0RF
KzUwNzhmOTMvPz8/Pz4NCiAgIGI6ICAgYzEgZTggMDQgICAgICAgICAgICAg
ICAgICBzaHIgICAgJDB4NCwlZWF4DQpDb2RlOyAgZDFhOTA5NTUgPEVORF9P
Rl9DT0RFKzUwNzhmOTYvPz8/Pz4NCiAgIGU6ICAgMDEgYzIgICAgICAgICAg
ICAgICAgICAgICBhZGQgICAgJWVheCwlZWR4DQpDb2RlOyAgZDFhOTA5NTcg
PEVORF9PRl9DT0RFKzUwNzhmOTgvPz8/Pz4NCiAgMTA6ICAgOGQgMDQgOTIg
ICAgICAgICAgICAgICAgICBsZWEgICAgKCVlZHgsJWVkeCw0KSwlZWF4DQpD
b2RlOyAgZDFhOTA5NWEgPEVORF9PRl9DT0RFKzUwNzhmOWIvPz8/Pz4NCiAg
MTM6ICAgOGQgMDAgICAgICAgICAgICAgICAgICAgICBsZWEgICAgKCVlYXgp
LCVlYXgNCg0KDQoxIHdhcm5pbmcgaXNzdWVkLiAgUmVzdWx0cyBtYXkgbm90
IGJlIHJlbGlhYmxlLg0K
---943504833-2135313262-1015263265=:10999
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; name="smb.conf"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0203041834252.10999@pingvin.fazekas.hu>
Content-Description: 
Content-Disposition: attachment; filename="smb.conf"

W2dsb2JhbF0NCiAgICBicm93c2VhYmxlID0geWVzDQogICAgZGVidWcgbGV2
ZWwgPSAxDQogICAgc2VydmVyIHN0cmluZyA9IE9LIFN6YWuCcnSLaSBJcm9k
YSBDbGllbnQgMw0KIyAgICBzZXJ2ZXIgc3RyaW5nID0gT0sgU3pha+lydPVp
IElyb2RhIENsaWVudCAzDQogICAgd29ya2dyb3VwID0gb2sNCiAgICBjcmVh
dGUgbWFzayA9IDA2NDQNCiAgICBkaXJlY3RvcnkgbWFzayA9IDA3NTUNCiAg
ICBtYXAgYXJjaGl2ZSA9IG5vDQogICAgb3MgbGV2ZWwgPSAyDQogICAgc2Vj
dXJpdHkgPSBzaGFyZQ0KICAgIGRvbWFpbiBsb2dvbnMgPSBubw0KICAgIGRv
bWFpbiBtYXN0ZXIgPSBubw0KICAgIGxvY2FsIG1hc3RlciA9IG5vDQogICAg
cHJlZmVycmVkIG1hc3RlciA9IG5vDQogICAgbmFtZSByZXNvbHZlIG9yZGVy
ID0gbG1ob3N0cyBob3N0IHdpbnMgYmNhc3QNCiAgICBkbnMgcHJveHkgPSBu
bw0KICAgIHNoYXJlIG1vZGVzID0geWVzDQogICAgY2xpZW50IGNvZGUgcGFn
ZSA9IDg1Mg0KICAgIGNoYXJhY3RlciBzZXQgPSBJU084ODU5LTINCiAgICBk
b3MgZmlsZXRpbWUgcmVzb2x1dGlvbiA9IHRydWUNCiAgICBkb3MgZmlsZXRp
bWVzID0gdHJ1ZQ0KICAgIHRpbWUgc2VydmVyID0gbm8NCiAgICBwcmVzZXJ2
ZSBjYXNlID0geWVzDQogICAgc2hvcnQgcHJlc2VydmUgY2FzZSA9IHllcw0K
ICAgIGludGVyZmFjZXMgPSAxOTIuMTY4LjEwMC4xMi8yNTUuMjU1LjI1NS4w
DQogICAgd2lucyBzdXBwb3J0ID0gbm8NCiAgICB3aW5zIHNlcnZlciA9IDE5
Mi4xNjguMTAwLjINCiAgICBlbmNyeXB0IHBhc3N3b3JkcyA9IG5vDQogICAg
bWF4IGxvZyBzaXplID0gMjA0ODANCiAgICBob3N0cyBhbGxvdyA9IDE5Mi4x
NjguMTAwLjAvMjU1LjI1NS4yNTUuMA0KICAgIGd1ZXN0IG9rID0geWVzDQog
ICAgZ3Vlc3Qgb25seSA9IHllcw0KICAgIG1hcCB0byBndWVzdCA9IGJhZCBw
YXNzd29yZA0KDQpbY10NCiAgICBjb21tZW50ID0gQy1Ecml2ZQ0KICAgIHBh
dGggPSAvYw0KICAgIGJyb3dzZWFibGUgPSB5ZXMNCiAgICByZWFkIG9ubHkg
PSB5ZXMNCiAgICBndWVzdCBvayA9IHllcw0KICAgIGd1ZXN0IG9ubHkgPSB5
ZXMNCg0KW2RdDQogICAgY29tbWVudCA9IEQtRHJpdmUNCiAgICBwYXRoID0g
L2QNCiAgICBicm93c2VhYmxlID0geWVzDQogICAgcmVhZCBvbmx5ID0geWVz
DQogICAgZ3Vlc3Qgb2sgPSB5ZXMNCiAgICBndWVzdCBvbmx5ID0geWVzDQo=
---943504833-2135313262-1015263265=:10999
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="athene.config"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0203041834253.10999@pingvin.fazekas.hu>
Content-Description: 
Content-Disposition: attachment; filename="athene.config"

Iw0KIyBBdXRvbWF0aWNhbGx5IGdlbmVyYXRlZCBieSBtYWtlIG1lbnVjb25m
aWc6IGRvbid0IGVkaXQNCiMNCkNPTkZJR19YODY9eQ0KQ09ORklHX0lTQT15
DQojIENPTkZJR19TQlVTIGlzIG5vdCBzZXQNCkNPTkZJR19VSUQxNj15DQoN
CiMNCiMgQ29kZSBtYXR1cml0eSBsZXZlbCBvcHRpb25zDQojDQpDT05GSUdf
RVhQRVJJTUVOVEFMPXkNCg0KIw0KIyBMb2FkYWJsZSBtb2R1bGUgc3VwcG9y
dA0KIw0KQ09ORklHX01PRFVMRVM9eQ0KQ09ORklHX01PRFZFUlNJT05TPXkN
CkNPTkZJR19LTU9EPXkNCg0KIw0KIyBQcm9jZXNzb3IgdHlwZSBhbmQgZmVh
dHVyZXMNCiMNCiMgQ09ORklHX00zODYgaXMgbm90IHNldA0KIyBDT05GSUdf
TTQ4NiBpcyBub3Qgc2V0DQojIENPTkZJR19NNTg2IGlzIG5vdCBzZXQNCiMg
Q09ORklHX001ODZUU0MgaXMgbm90IHNldA0KIyBDT05GSUdfTTU4Nk1NWCBp
cyBub3Qgc2V0DQpDT05GSUdfTTY4Nj15DQojIENPTkZJR19NUEVOVElVTUlJ
SSBpcyBub3Qgc2V0DQojIENPTkZJR19NUEVOVElVTTQgaXMgbm90IHNldA0K
IyBDT05GSUdfTUs2IGlzIG5vdCBzZXQNCiMgQ09ORklHX01LNyBpcyBub3Qg
c2V0DQojIENPTkZJR19NRUxBTiBpcyBub3Qgc2V0DQojIENPTkZJR19NQ1JV
U09FIGlzIG5vdCBzZXQNCiMgQ09ORklHX01XSU5DSElQQzYgaXMgbm90IHNl
dA0KIyBDT05GSUdfTVdJTkNISVAyIGlzIG5vdCBzZXQNCiMgQ09ORklHX01X
SU5DSElQM0QgaXMgbm90IHNldA0KIyBDT05GSUdfTUNZUklYSUlJIGlzIG5v
dCBzZXQNCkNPTkZJR19YODZfV1BfV09SS1NfT0s9eQ0KQ09ORklHX1g4Nl9J
TlZMUEc9eQ0KQ09ORklHX1g4Nl9DTVBYQ0hHPXkNCkNPTkZJR19YODZfWEFE
RD15DQpDT05GSUdfWDg2X0JTV0FQPXkNCkNPTkZJR19YODZfUE9QQURfT0s9
eQ0KIyBDT05GSUdfUldTRU1fR0VORVJJQ19TUElOTE9DSyBpcyBub3Qgc2V0
DQpDT05GSUdfUldTRU1fWENIR0FERF9BTEdPUklUSE09eQ0KQ09ORklHX1g4
Nl9MMV9DQUNIRV9TSElGVD01DQpDT05GSUdfWDg2X1RTQz15DQpDT05GSUdf
WDg2X0dPT0RfQVBJQz15DQpDT05GSUdfWDg2X1BHRT15DQpDT05GSUdfWDg2
X1VTRV9QUFJPX0NIRUNLU1VNPXkNCkNPTkZJR19YODZfUFBST19GRU5DRT15
DQojIENPTkZJR19UT1NISUJBIGlzIG5vdCBzZXQNCiMgQ09ORklHX0k4SyBp
cyBub3Qgc2V0DQpDT05GSUdfTUlDUk9DT0RFPW0NCkNPTkZJR19YODZfTVNS
PW0NCkNPTkZJR19YODZfQ1BVSUQ9bQ0KQ09ORklHX05PSElHSE1FTT15DQoj
IENPTkZJR19ISUdITUVNNEcgaXMgbm90IHNldA0KIyBDT05GSUdfSElHSE1F
TTY0RyBpcyBub3Qgc2V0DQojIENPTkZJR19NQVRIX0VNVUxBVElPTiBpcyBu
b3Qgc2V0DQpDT05GSUdfTVRSUj15DQojIENPTkZJR19TTVAgaXMgbm90IHNl
dA0KQ09ORklHX1g4Nl9VUF9BUElDPXkNCkNPTkZJR19YODZfVVBfSU9BUElD
PXkNCkNPTkZJR19YODZfTE9DQUxfQVBJQz15DQpDT05GSUdfWDg2X0lPX0FQ
SUM9eQ0KDQojDQojIEdlbmVyYWwgc2V0dXANCiMNCkNPTkZJR19ORVQ9eQ0K
Q09ORklHX1BDST15DQojIENPTkZJR19QQ0lfR09CSU9TIGlzIG5vdCBzZXQN
CiMgQ09ORklHX1BDSV9HT0RJUkVDVCBpcyBub3Qgc2V0DQpDT05GSUdfUENJ
X0dPQU5ZPXkNCkNPTkZJR19QQ0lfQklPUz15DQpDT05GSUdfUENJX0RJUkVD
VD15DQpDT05GSUdfUENJX05BTUVTPXkNCiMgQ09ORklHX0VJU0EgaXMgbm90
IHNldA0KIyBDT05GSUdfTUNBIGlzIG5vdCBzZXQNCkNPTkZJR19IT1RQTFVH
PXkNCg0KIw0KIyBQQ01DSUEvQ2FyZEJ1cyBzdXBwb3J0DQojDQojIENPTkZJ
R19QQ01DSUEgaXMgbm90IHNldA0KDQojDQojIFBDSSBIb3RwbHVnIFN1cHBv
cnQNCiMNCiMgQ09ORklHX0hPVFBMVUdfUENJIGlzIG5vdCBzZXQNCiMgQ09O
RklHX0hPVFBMVUdfUENJX0NPTVBBUSBpcyBub3Qgc2V0DQojIENPTkZJR19I
T1RQTFVHX1BDSV9DT01QQVFfTlZSQU0gaXMgbm90IHNldA0KQ09ORklHX1NZ
U1ZJUEM9eQ0KIyBDT05GSUdfQlNEX1BST0NFU1NfQUNDVCBpcyBub3Qgc2V0
DQpDT05GSUdfU1lTQ1RMPXkNCkNPTkZJR19LQ09SRV9FTEY9eQ0KIyBDT05G
SUdfS0NPUkVfQU9VVCBpcyBub3Qgc2V0DQpDT05GSUdfQklORk1UX0FPVVQ9
eQ0KQ09ORklHX0JJTkZNVF9FTEY9eQ0KQ09ORklHX0JJTkZNVF9NSVNDPXkN
CkNPTkZJR19QTT15DQojIENPTkZJR19BQ1BJIGlzIG5vdCBzZXQNCkNPTkZJ
R19BUE09eQ0KIyBDT05GSUdfQVBNX0lHTk9SRV9VU0VSX1NVU1BFTkQgaXMg
bm90IHNldA0KIyBDT05GSUdfQVBNX0RPX0VOQUJMRSBpcyBub3Qgc2V0DQoj
IENPTkZJR19BUE1fQ1BVX0lETEUgaXMgbm90IHNldA0KIyBDT05GSUdfQVBN
X0RJU1BMQVlfQkxBTksgaXMgbm90IHNldA0KIyBDT05GSUdfQVBNX1JUQ19J
U19HTVQgaXMgbm90IHNldA0KIyBDT05GSUdfQVBNX0FMTE9XX0lOVFMgaXMg
bm90IHNldA0KIyBDT05GSUdfQVBNX1JFQUxfTU9ERV9QT1dFUl9PRkYgaXMg
bm90IHNldA0KDQojDQojIE1lbW9yeSBUZWNobm9sb2d5IERldmljZXMgKE1U
RCkNCiMNCiMgQ09ORklHX01URCBpcyBub3Qgc2V0DQoNCiMNCiMgUGFyYWxs
ZWwgcG9ydCBzdXBwb3J0DQojDQpDT05GSUdfUEFSUE9SVD1tDQpDT05GSUdf
UEFSUE9SVF9QQz1tDQpDT05GSUdfUEFSUE9SVF9QQ19DTUwxPW0NCiMgQ09O
RklHX1BBUlBPUlRfU0VSSUFMIGlzIG5vdCBzZXQNCkNPTkZJR19QQVJQT1JU
X1BDX0ZJRk89eQ0KIyBDT05GSUdfUEFSUE9SVF9QQ19TVVBFUklPIGlzIG5v
dCBzZXQNCiMgQ09ORklHX1BBUlBPUlRfQU1JR0EgaXMgbm90IHNldA0KIyBD
T05GSUdfUEFSUE9SVF9NRkMzIGlzIG5vdCBzZXQNCiMgQ09ORklHX1BBUlBP
UlRfQVRBUkkgaXMgbm90IHNldA0KIyBDT05GSUdfUEFSUE9SVF9HU0MgaXMg
bm90IHNldA0KIyBDT05GSUdfUEFSUE9SVF9TVU5CUFAgaXMgbm90IHNldA0K
IyBDT05GSUdfUEFSUE9SVF9PVEhFUiBpcyBub3Qgc2V0DQpDT05GSUdfUEFS
UE9SVF8xMjg0PXkNCg0KIw0KIyBQbHVnIGFuZCBQbGF5IGNvbmZpZ3VyYXRp
b24NCiMNCkNPTkZJR19QTlA9eQ0KQ09ORklHX0lTQVBOUD15DQoNCiMNCiMg
QmxvY2sgZGV2aWNlcw0KIw0KQ09ORklHX0JMS19ERVZfRkQ9bQ0KIyBDT05G
SUdfQkxLX0RFVl9YRCBpcyBub3Qgc2V0DQojIENPTkZJR19QQVJJREUgaXMg
bm90IHNldA0KIyBDT05GSUdfQkxLX0NQUV9EQSBpcyBub3Qgc2V0DQojIENP
TkZJR19CTEtfQ1BRX0NJU1NfREEgaXMgbm90IHNldA0KIyBDT05GSUdfQkxL
X0RFVl9EQUM5NjAgaXMgbm90IHNldA0KQ09ORklHX0JMS19ERVZfTE9PUD1t
DQojIENPTkZJR19CTEtfREVWX05CRCBpcyBub3Qgc2V0DQpDT05GSUdfQkxL
X0RFVl9SQU09bQ0KQ09ORklHX0JMS19ERVZfUkFNX1NJWkU9NDA5Ng0KIyBD
T05GSUdfQkxLX0RFVl9JTklUUkQgaXMgbm90IHNldA0KDQojDQojIE11bHRp
LWRldmljZSBzdXBwb3J0IChSQUlEIGFuZCBMVk0pDQojDQojIENPTkZJR19N
RCBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtfREVWX01EIGlzIG5vdCBzZXQN
CiMgQ09ORklHX01EX0xJTkVBUiBpcyBub3Qgc2V0DQojIENPTkZJR19NRF9S
QUlEMCBpcyBub3Qgc2V0DQojIENPTkZJR19NRF9SQUlEMSBpcyBub3Qgc2V0
DQojIENPTkZJR19NRF9SQUlENSBpcyBub3Qgc2V0DQojIENPTkZJR19NRF9N
VUxUSVBBVEggaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9MVk0gaXMg
bm90IHNldA0KDQojDQojIE5ldHdvcmtpbmcgb3B0aW9ucw0KIw0KQ09ORklH
X1BBQ0tFVD15DQojIENPTkZJR19QQUNLRVRfTU1BUCBpcyBub3Qgc2V0DQoj
IENPTkZJR19ORVRMSU5LX0RFViBpcyBub3Qgc2V0DQojIENPTkZJR19ORVRG
SUxURVIgaXMgbm90IHNldA0KIyBDT05GSUdfRklMVEVSIGlzIG5vdCBzZXQN
CkNPTkZJR19VTklYPXkNCkNPTkZJR19JTkVUPXkNCkNPTkZJR19JUF9NVUxU
SUNBU1Q9eQ0KIyBDT05GSUdfSVBfQURWQU5DRURfUk9VVEVSIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX0lQX1BOUCBpcyBub3Qgc2V0DQojIENPTkZJR19ORVRf
SVBJUCBpcyBub3Qgc2V0DQojIENPTkZJR19ORVRfSVBHUkUgaXMgbm90IHNl
dA0KIyBDT05GSUdfSVBfTVJPVVRFIGlzIG5vdCBzZXQNCiMgQ09ORklHX0FS
UEQgaXMgbm90IHNldA0KIyBDT05GSUdfSU5FVF9FQ04gaXMgbm90IHNldA0K
IyBDT05GSUdfU1lOX0NPT0tJRVMgaXMgbm90IHNldA0KIyBDT05GSUdfSVBW
NiBpcyBub3Qgc2V0DQojIENPTkZJR19LSFRUUEQgaXMgbm90IHNldA0KIyBD
T05GSUdfQVRNIGlzIG5vdCBzZXQNCiMgQ09ORklHX1ZMQU5fODAyMVEgaXMg
bm90IHNldA0KIyBDT05GSUdfSVBYIGlzIG5vdCBzZXQNCiMgQ09ORklHX0FU
QUxLIGlzIG5vdCBzZXQNCiMgQ09ORklHX0RFQ05FVCBpcyBub3Qgc2V0DQoj
IENPTkZJR19CUklER0UgaXMgbm90IHNldA0KIyBDT05GSUdfWDI1IGlzIG5v
dCBzZXQNCiMgQ09ORklHX0xBUEIgaXMgbm90IHNldA0KIyBDT05GSUdfTExD
IGlzIG5vdCBzZXQNCiMgQ09ORklHX05FVF9ESVZFUlQgaXMgbm90IHNldA0K
IyBDT05GSUdfRUNPTkVUIGlzIG5vdCBzZXQNCiMgQ09ORklHX1dBTl9ST1VU
RVIgaXMgbm90IHNldA0KIyBDT05GSUdfTkVUX0ZBU1RST1VURSBpcyBub3Qg
c2V0DQojIENPTkZJR19ORVRfSFdfRkxPV0NPTlRST0wgaXMgbm90IHNldA0K
DQojDQojIFFvUyBhbmQvb3IgZmFpciBxdWV1ZWluZw0KIw0KIyBDT05GSUdf
TkVUX1NDSEVEIGlzIG5vdCBzZXQNCg0KIw0KIyBUZWxlcGhvbnkgU3VwcG9y
dA0KIw0KIyBDT05GSUdfUEhPTkUgaXMgbm90IHNldA0KIyBDT05GSUdfUEhP
TkVfSVhKIGlzIG5vdCBzZXQNCiMgQ09ORklHX1BIT05FX0lYSl9QQ01DSUEg
aXMgbm90IHNldA0KDQojDQojIEFUQS9JREUvTUZNL1JMTCBzdXBwb3J0DQoj
DQpDT05GSUdfSURFPXkNCg0KIw0KIyBJREUsIEFUQSBhbmQgQVRBUEkgQmxv
Y2sgZGV2aWNlcw0KIw0KQ09ORklHX0JMS19ERVZfSURFPXkNCiMgQ09ORklH
X0JMS19ERVZfSERfSURFIGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZf
SEQgaXMgbm90IHNldA0KQ09ORklHX0JMS19ERVZfSURFRElTSz15DQpDT05G
SUdfSURFRElTS19NVUxUSV9NT0RFPXkNCiMgQ09ORklHX0JMS19ERVZfSURF
RElTS19WRU5ET1IgaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9JREVE
SVNLX0ZVSklUU1UgaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9JREVE
SVNLX0lCTSBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtfREVWX0lERURJU0tf
TUFYVE9SIGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfSURFRElTS19R
VUFOVFVNIGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfSURFRElTS19T
RUFHQVRFIGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfSURFRElTS19X
RCBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtfREVWX0NPTU1FUklBTCBpcyBu
b3Qgc2V0DQojIENPTkZJR19CTEtfREVWX1RJVk8gaXMgbm90IHNldA0KIyBD
T05GSUdfQkxLX0RFVl9JREVDUyBpcyBub3Qgc2V0DQpDT05GSUdfQkxLX0RF
Vl9JREVDRD15DQojIENPTkZJR19CTEtfREVWX0lERVRBUEUgaXMgbm90IHNl
dA0KIyBDT05GSUdfQkxLX0RFVl9JREVGTE9QUFkgaXMgbm90IHNldA0KIyBD
T05GSUdfQkxLX0RFVl9JREVTQ1NJIGlzIG5vdCBzZXQNCkNPTkZJR19CTEtf
REVWX0NNRDY0MD15DQojIENPTkZJR19CTEtfREVWX0NNRDY0MF9FTkhBTkNF
RCBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtfREVWX0lTQVBOUCBpcyBub3Qg
c2V0DQpDT05GSUdfQkxLX0RFVl9SWjEwMDA9eQ0KQ09ORklHX0JMS19ERVZf
SURFUENJPXkNCkNPTkZJR19JREVQQ0lfU0hBUkVfSVJRPXkNCkNPTkZJR19C
TEtfREVWX0lERURNQV9QQ0k9eQ0KQ09ORklHX0JMS19ERVZfQURNQT15DQoj
IENPTkZJR19CTEtfREVWX09GRkJPQVJEIGlzIG5vdCBzZXQNCkNPTkZJR19J
REVETUFfUENJX0FVVE89eQ0KQ09ORklHX0JMS19ERVZfSURFRE1BPXkNCiMg
Q09ORklHX0lERURNQV9QQ0lfV0lQIGlzIG5vdCBzZXQNCiMgQ09ORklHX0lE
RURNQV9ORVdfRFJJVkVfTElTVElOR1MgaXMgbm90IHNldA0KIyBDT05GSUdf
QkxLX0RFVl9BRUM2MlhYIGlzIG5vdCBzZXQNCiMgQ09ORklHX0FFQzYyWFhf
VFVOSU5HIGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfQUxJMTVYMyBp
cyBub3Qgc2V0DQojIENPTkZJR19XRENfQUxJMTVYMyBpcyBub3Qgc2V0DQoj
IENPTkZJR19CTEtfREVWX0FNRDc0WFggaXMgbm90IHNldA0KIyBDT05GSUdf
QU1ENzRYWF9PVkVSUklERSBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtfREVW
X0NNRDY0WCBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtfREVWX0NZODJDNjkz
IGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfQ1M1NTMwIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX0JMS19ERVZfSFBUMzRYIGlzIG5vdCBzZXQNCiMgQ09O
RklHX0hQVDM0WF9BVVRPRE1BIGlzIG5vdCBzZXQNCkNPTkZJR19CTEtfREVW
X0hQVDM2Nj15DQojIENPTkZJR19CTEtfREVWX1BJSVggaXMgbm90IHNldA0K
IyBDT05GSUdfUElJWF9UVU5JTkcgaXMgbm90IHNldA0KIyBDT05GSUdfQkxL
X0RFVl9OUzg3NDE1IGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfT1BU
STYyMSBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtfREVWX1BEQzIwMlhYIGlz
IG5vdCBzZXQNCiMgQ09ORklHX1BEQzIwMlhYX0JVUlNUIGlzIG5vdCBzZXQN
CiMgQ09ORklHX1BEQzIwMlhYX0ZPUkNFIGlzIG5vdCBzZXQNCiMgQ09ORklH
X0JMS19ERVZfU1ZXS1MgaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9T
SVM1NTEzIGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfU0xDOTBFNjYg
aXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9UUk0yOTAgaXMgbm90IHNl
dA0KIyBDT05GSUdfQkxLX0RFVl9WSUE4MkNYWFggaXMgbm90IHNldA0KIyBD
T05GSUdfSURFX0NISVBTRVRTIGlzIG5vdCBzZXQNCkNPTkZJR19JREVETUFf
QVVUTz15DQojIENPTkZJR19JREVETUFfSVZCIGlzIG5vdCBzZXQNCiMgQ09O
RklHX0RNQV9OT05QQ0kgaXMgbm90IHNldA0KQ09ORklHX0JMS19ERVZfSURF
X01PREVTPXkNCiMgQ09ORklHX0JMS19ERVZfQVRBUkFJRCBpcyBub3Qgc2V0
DQojIENPTkZJR19CTEtfREVWX0FUQVJBSURfUERDIGlzIG5vdCBzZXQNCiMg
Q09ORklHX0JMS19ERVZfQVRBUkFJRF9IUFQgaXMgbm90IHNldA0KDQojDQoj
IFNDU0kgc3VwcG9ydA0KIw0KIyBDT05GSUdfU0NTSSBpcyBub3Qgc2V0DQoN
CiMNCiMgRnVzaW9uIE1QVCBkZXZpY2Ugc3VwcG9ydA0KIw0KIyBDT05GSUdf
RlVTSU9OIGlzIG5vdCBzZXQNCiMgQ09ORklHX0ZVU0lPTl9CT09UIGlzIG5v
dCBzZXQNCiMgQ09ORklHX0ZVU0lPTl9JU0VOU0UgaXMgbm90IHNldA0KIyBD
T05GSUdfRlVTSU9OX0NUTCBpcyBub3Qgc2V0DQojIENPTkZJR19GVVNJT05f
TEFOIGlzIG5vdCBzZXQNCg0KIw0KIyBJRUVFIDEzOTQgKEZpcmVXaXJlKSBz
dXBwb3J0IChFWFBFUklNRU5UQUwpDQojDQojIENPTkZJR19JRUVFMTM5NCBp
cyBub3Qgc2V0DQoNCiMNCiMgSTJPIGRldmljZSBzdXBwb3J0DQojDQojIENP
TkZJR19JMk8gaXMgbm90IHNldA0KIyBDT05GSUdfSTJPX1BDSSBpcyBub3Qg
c2V0DQojIENPTkZJR19JMk9fQkxPQ0sgaXMgbm90IHNldA0KIyBDT05GSUdf
STJPX0xBTiBpcyBub3Qgc2V0DQojIENPTkZJR19JMk9fU0NTSSBpcyBub3Qg
c2V0DQojIENPTkZJR19JMk9fUFJPQyBpcyBub3Qgc2V0DQoNCiMNCiMgTmV0
d29yayBkZXZpY2Ugc3VwcG9ydA0KIw0KQ09ORklHX05FVERFVklDRVM9eQ0K
DQojDQojIEFSQ25ldCBkZXZpY2VzDQojDQojIENPTkZJR19BUkNORVQgaXMg
bm90IHNldA0KIyBDT05GSUdfRFVNTVkgaXMgbm90IHNldA0KIyBDT05GSUdf
Qk9ORElORyBpcyBub3Qgc2V0DQojIENPTkZJR19FUVVBTElaRVIgaXMgbm90
IHNldA0KIyBDT05GSUdfVFVOIGlzIG5vdCBzZXQNCiMgQ09ORklHX0VUSEVS
VEFQIGlzIG5vdCBzZXQNCiMgQ09ORklHX05FVF9TQjEwMDAgaXMgbm90IHNl
dA0KDQojDQojIEV0aGVybmV0ICgxMCBvciAxMDBNYml0KQ0KIw0KQ09ORklH
X05FVF9FVEhFUk5FVD15DQojIENPTkZJR19TVU5MQU5DRSBpcyBub3Qgc2V0
DQojIENPTkZJR19IQVBQWU1FQUwgaXMgbm90IHNldA0KIyBDT05GSUdfU1VO
Qk1BQyBpcyBub3Qgc2V0DQojIENPTkZJR19TVU5RRSBpcyBub3Qgc2V0DQoj
IENPTkZJR19TVU5HRU0gaXMgbm90IHNldA0KIyBDT05GSUdfTkVUX1ZFTkRP
Ul8zQ09NIGlzIG5vdCBzZXQNCiMgQ09ORklHX0xBTkNFIGlzIG5vdCBzZXQN
CiMgQ09ORklHX05FVF9WRU5ET1JfU01DIGlzIG5vdCBzZXQNCiMgQ09ORklH
X05FVF9WRU5ET1JfUkFDQUwgaXMgbm90IHNldA0KIyBDT05GSUdfQVQxNzAw
IGlzIG5vdCBzZXQNCiMgQ09ORklHX0RFUENBIGlzIG5vdCBzZXQNCiMgQ09O
RklHX0hQMTAwIGlzIG5vdCBzZXQNCiMgQ09ORklHX05FVF9JU0EgaXMgbm90
IHNldA0KQ09ORklHX05FVF9QQ0k9eQ0KIyBDT05GSUdfUENORVQzMiBpcyBu
b3Qgc2V0DQojIENPTkZJR19BREFQVEVDX1NUQVJGSVJFIGlzIG5vdCBzZXQN
CiMgQ09ORklHX0FDMzIwMCBpcyBub3Qgc2V0DQojIENPTkZJR19BUFJJQ09U
IGlzIG5vdCBzZXQNCiMgQ09ORklHX0NTODl4MCBpcyBub3Qgc2V0DQojIENP
TkZJR19UVUxJUCBpcyBub3Qgc2V0DQpDT05GSUdfREU0WDU9bQ0KIyBDT05G
SUdfREdSUyBpcyBub3Qgc2V0DQojIENPTkZJR19ETTkxMDIgaXMgbm90IHNl
dA0KIyBDT05GSUdfRUVQUk8xMDAgaXMgbm90IHNldA0KIyBDT05GSUdfTE5F
MzkwIGlzIG5vdCBzZXQNCiMgQ09ORklHX0ZFQUxOWCBpcyBub3Qgc2V0DQoj
IENPTkZJR19OQVRTRU1JIGlzIG5vdCBzZXQNCiMgQ09ORklHX05FMktfUENJ
IGlzIG5vdCBzZXQNCiMgQ09ORklHX05FMzIxMCBpcyBub3Qgc2V0DQojIENP
TkZJR19FUzMyMTAgaXMgbm90IHNldA0KIyBDT05GSUdfODEzOUNQIGlzIG5v
dCBzZXQNCiMgQ09ORklHXzgxMzlUT08gaXMgbm90IHNldA0KIyBDT05GSUdf
ODEzOVRPT19QSU8gaXMgbm90IHNldA0KIyBDT05GSUdfODEzOVRPT19UVU5F
X1RXSVNURVIgaXMgbm90IHNldA0KIyBDT05GSUdfODEzOVRPT184MTI5IGlz
IG5vdCBzZXQNCiMgQ09ORklHXzgxMzlfTkVXX1JYX1JFU0VUIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX1NJUzkwMCBpcyBub3Qgc2V0DQojIENPTkZJR19FUElD
MTAwIGlzIG5vdCBzZXQNCiMgQ09ORklHX1NVTkRBTkNFIGlzIG5vdCBzZXQN
CiMgQ09ORklHX1RMQU4gaXMgbm90IHNldA0KIyBDT05GSUdfVklBX1JISU5F
IGlzIG5vdCBzZXQNCiMgQ09ORklHX1ZJQV9SSElORV9NTUlPIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX1dJTkJPTkRfODQwIGlzIG5vdCBzZXQNCiMgQ09ORklH
X05FVF9QT0NLRVQgaXMgbm90IHNldA0KDQojDQojIEV0aGVybmV0ICgxMDAw
IE1iaXQpDQojDQojIENPTkZJR19BQ0VOSUMgaXMgbm90IHNldA0KIyBDT05G
SUdfREwySyBpcyBub3Qgc2V0DQojIENPTkZJR19NWVJJX1NCVVMgaXMgbm90
IHNldA0KIyBDT05GSUdfTlM4MzgyMCBpcyBub3Qgc2V0DQojIENPTkZJR19I
QU1BQ0hJIGlzIG5vdCBzZXQNCiMgQ09ORklHX1lFTExPV0ZJTiBpcyBub3Qg
c2V0DQojIENPTkZJR19TSzk4TElOIGlzIG5vdCBzZXQNCiMgQ09ORklHX0ZE
REkgaXMgbm90IHNldA0KIyBDT05GSUdfSElQUEkgaXMgbm90IHNldA0KIyBD
T05GSUdfUExJUCBpcyBub3Qgc2V0DQojIENPTkZJR19QUFAgaXMgbm90IHNl
dA0KIyBDT05GSUdfU0xJUCBpcyBub3Qgc2V0DQoNCiMNCiMgV2lyZWxlc3Mg
TEFOIChub24taGFtcmFkaW8pDQojDQojIENPTkZJR19ORVRfUkFESU8gaXMg
bm90IHNldA0KDQojDQojIFRva2VuIFJpbmcgZGV2aWNlcw0KIw0KIyBDT05G
SUdfVFIgaXMgbm90IHNldA0KIyBDT05GSUdfTkVUX0ZDIGlzIG5vdCBzZXQN
CiMgQ09ORklHX1JDUENJIGlzIG5vdCBzZXQNCiMgQ09ORklHX1NIQVBFUiBp
cyBub3Qgc2V0DQoNCiMNCiMgV2FuIGludGVyZmFjZXMNCiMNCiMgQ09ORklH
X1dBTiBpcyBub3Qgc2V0DQoNCiMNCiMgQW1hdGV1ciBSYWRpbyBzdXBwb3J0
DQojDQojIENPTkZJR19IQU1SQURJTyBpcyBub3Qgc2V0DQoNCiMNCiMgSXJE
QSAoaW5mcmFyZWQpIHN1cHBvcnQNCiMNCiMgQ09ORklHX0lSREEgaXMgbm90
IHNldA0KDQojDQojIElTRE4gc3Vic3lzdGVtDQojDQojIENPTkZJR19JU0RO
IGlzIG5vdCBzZXQNCg0KIw0KIyBPbGQgQ0QtUk9NIGRyaXZlcnMgKG5vdCBT
Q1NJLCBub3QgSURFKQ0KIw0KIyBDT05GSUdfQ0RfTk9fSURFU0NTSSBpcyBu
b3Qgc2V0DQoNCiMNCiMgSW5wdXQgY29yZSBzdXBwb3J0DQojDQpDT05GSUdf
SU5QVVQ9bQ0KIyBDT05GSUdfSU5QVVRfS0VZQkRFViBpcyBub3Qgc2V0DQpD
T05GSUdfSU5QVVRfTU9VU0VERVY9bQ0KQ09ORklHX0lOUFVUX01PVVNFREVW
X1NDUkVFTl9YPTEwMjQNCkNPTkZJR19JTlBVVF9NT1VTRURFVl9TQ1JFRU5f
WT03NjgNCiMgQ09ORklHX0lOUFVUX0pPWURFViBpcyBub3Qgc2V0DQojIENP
TkZJR19JTlBVVF9FVkRFViBpcyBub3Qgc2V0DQoNCiMNCiMgQ2hhcmFjdGVy
IGRldmljZXMNCiMNCkNPTkZJR19WVD15DQpDT05GSUdfVlRfQ09OU09MRT15
DQpDT05GSUdfU0VSSUFMPW0NCiMgQ09ORklHX1NFUklBTF9FWFRFTkRFRCBp
cyBub3Qgc2V0DQojIENPTkZJR19TRVJJQUxfTk9OU1RBTkRBUkQgaXMgbm90
IHNldA0KQ09ORklHX1VOSVg5OF9QVFlTPXkNCkNPTkZJR19VTklYOThfUFRZ
X0NPVU5UPTI1Ng0KQ09ORklHX1BSSU5URVI9bQ0KIyBDT05GSUdfTFBfQ09O
U09MRSBpcyBub3Qgc2V0DQojIENPTkZJR19QUERFViBpcyBub3Qgc2V0DQoN
CiMNCiMgSTJDIHN1cHBvcnQNCiMNCiMgQ09ORklHX0kyQyBpcyBub3Qgc2V0
DQoNCiMNCiMgTWljZQ0KIw0KIyBDT05GSUdfQlVTTU9VU0UgaXMgbm90IHNl
dA0KQ09ORklHX01PVVNFPXkNCkNPTkZJR19QU01PVVNFPXkNCiMgQ09ORklH
XzgyQzcxMF9NT1VTRSBpcyBub3Qgc2V0DQojIENPTkZJR19QQzExMF9QQUQg
aXMgbm90IHNldA0KDQojDQojIEpveXN0aWNrcw0KIw0KIyBDT05GSUdfSU5Q
VVRfR0FNRVBPUlQgaXMgbm90IHNldA0KIyBDT05GSUdfSU5QVVRfTlM1NTgg
aXMgbm90IHNldA0KIyBDT05GSUdfSU5QVVRfTElHSFROSU5HIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX0lOUFVUX1BDSUdBTUUgaXMgbm90IHNldA0KIyBDT05G
SUdfSU5QVVRfQ1M0NjFYIGlzIG5vdCBzZXQNCiMgQ09ORklHX0lOUFVUX0VN
VTEwSzEgaXMgbm90IHNldA0KIyBDT05GSUdfSU5QVVRfU0VSSU8gaXMgbm90
IHNldA0KIyBDT05GSUdfSU5QVVRfU0VSUE9SVCBpcyBub3Qgc2V0DQojIENP
TkZJR19JTlBVVF9BTkFMT0cgaXMgbm90IHNldA0KIyBDT05GSUdfSU5QVVRf
QTNEIGlzIG5vdCBzZXQNCiMgQ09ORklHX0lOUFVUX0FESSBpcyBub3Qgc2V0
DQojIENPTkZJR19JTlBVVF9DT0JSQSBpcyBub3Qgc2V0DQojIENPTkZJR19J
TlBVVF9HRjJLIGlzIG5vdCBzZXQNCiMgQ09ORklHX0lOUFVUX0dSSVAgaXMg
bm90IHNldA0KIyBDT05GSUdfSU5QVVRfSU5URVJBQ1QgaXMgbm90IHNldA0K
IyBDT05GSUdfSU5QVVRfVE1EQyBpcyBub3Qgc2V0DQojIENPTkZJR19JTlBV
VF9TSURFV0lOREVSIGlzIG5vdCBzZXQNCiMgQ09ORklHX0lOUFVUX0lGT1JD
RV9VU0IgaXMgbm90IHNldA0KIyBDT05GSUdfSU5QVVRfSUZPUkNFXzIzMiBp
cyBub3Qgc2V0DQojIENPTkZJR19JTlBVVF9XQVJSSU9SIGlzIG5vdCBzZXQN
CiMgQ09ORklHX0lOUFVUX01BR0VMTEFOIGlzIG5vdCBzZXQNCiMgQ09ORklH
X0lOUFVUX1NQQUNFT1JCIGlzIG5vdCBzZXQNCiMgQ09ORklHX0lOUFVUX1NQ
QUNFQkFMTCBpcyBub3Qgc2V0DQojIENPTkZJR19JTlBVVF9TVElOR0VSIGlz
IG5vdCBzZXQNCiMgQ09ORklHX0lOUFVUX0RCOSBpcyBub3Qgc2V0DQojIENP
TkZJR19JTlBVVF9HQU1FQ09OIGlzIG5vdCBzZXQNCiMgQ09ORklHX0lOUFVU
X1RVUkJPR1JBRlggaXMgbm90IHNldA0KIyBDT05GSUdfUUlDMDJfVEFQRSBp
cyBub3Qgc2V0DQoNCiMNCiMgV2F0Y2hkb2cgQ2FyZHMNCiMNCiMgQ09ORklH
X1dBVENIRE9HIGlzIG5vdCBzZXQNCiMgQ09ORklHX0lOVEVMX1JORyBpcyBu
b3Qgc2V0DQojIENPTkZJR19OVlJBTSBpcyBub3Qgc2V0DQpDT05GSUdfUlRD
PXkNCiMgQ09ORklHX0RUTEsgaXMgbm90IHNldA0KIyBDT05GSUdfUjM5NjQg
aXMgbm90IHNldA0KIyBDT05GSUdfQVBQTElDT00gaXMgbm90IHNldA0KIyBD
T05GSUdfU09OWVBJIGlzIG5vdCBzZXQNCg0KIw0KIyBGdGFwZSwgdGhlIGZs
b3BweSB0YXBlIGRldmljZSBkcml2ZXINCiMNCiMgQ09ORklHX0ZUQVBFIGlz
IG5vdCBzZXQNCkNPTkZJR19BR1A9eQ0KQ09ORklHX0FHUF9JTlRFTD15DQoj
IENPTkZJR19BR1BfSTgxMCBpcyBub3Qgc2V0DQojIENPTkZJR19BR1BfVklB
IGlzIG5vdCBzZXQNCiMgQ09ORklHX0FHUF9BTUQgaXMgbm90IHNldA0KIyBD
T05GSUdfQUdQX1NJUyBpcyBub3Qgc2V0DQojIENPTkZJR19BR1BfQUxJIGlz
IG5vdCBzZXQNCiMgQ09ORklHX0FHUF9TV09SS1MgaXMgbm90IHNldA0KQ09O
RklHX0RSTT15DQojIENPTkZJR19EUk1fT0xEIGlzIG5vdCBzZXQNCkNPTkZJ
R19EUk1fTkVXPXkNCiMgQ09ORklHX0RSTV9UREZYIGlzIG5vdCBzZXQNCiMg
Q09ORklHX0RSTV9SMTI4IGlzIG5vdCBzZXQNCiMgQ09ORklHX0RSTV9SQURF
T04gaXMgbm90IHNldA0KIyBDT05GSUdfRFJNX0k4MTAgaXMgbm90IHNldA0K
IyBDT05GSUdfRFJNX01HQSBpcyBub3Qgc2V0DQojIENPTkZJR19EUk1fU0lT
IGlzIG5vdCBzZXQNCiMgQ09ORklHX01XQVZFIGlzIG5vdCBzZXQNCg0KIw0K
IyBNdWx0aW1lZGlhIGRldmljZXMNCiMNCiMgQ09ORklHX1ZJREVPX0RFViBp
cyBub3Qgc2V0DQoNCiMNCiMgRmlsZSBzeXN0ZW1zDQojDQojIENPTkZJR19R
VU9UQSBpcyBub3Qgc2V0DQojIENPTkZJR19BVVRPRlNfRlMgaXMgbm90IHNl
dA0KIyBDT05GSUdfQVVUT0ZTNF9GUyBpcyBub3Qgc2V0DQpDT05GSUdfUkVJ
U0VSRlNfRlM9eQ0KIyBDT05GSUdfUkVJU0VSRlNfQ0hFQ0sgaXMgbm90IHNl
dA0KIyBDT05GSUdfUkVJU0VSRlNfUFJPQ19JTkZPIGlzIG5vdCBzZXQNCkNP
TkZJR19BREZTX0ZTPW0NCiMgQ09ORklHX0FERlNfRlNfUlcgaXMgbm90IHNl
dA0KQ09ORklHX0FGRlNfRlM9bQ0KQ09ORklHX0hGU19GUz1tDQpDT05GSUdf
QkZTX0ZTPW0NCkNPTkZJR19FWFQzX0ZTPW0NCkNPTkZJR19KQkQ9bQ0KIyBD
T05GSUdfSkJEX0RFQlVHIGlzIG5vdCBzZXQNCkNPTkZJR19GQVRfRlM9bQ0K
Q09ORklHX01TRE9TX0ZTPW0NCkNPTkZJR19VTVNET1NfRlM9bQ0KQ09ORklH
X1ZGQVRfRlM9bQ0KQ09ORklHX0VGU19GUz1tDQojIENPTkZJR19KRkZTX0ZT
IGlzIG5vdCBzZXQNCiMgQ09ORklHX0pGRlMyX0ZTIGlzIG5vdCBzZXQNCkNP
TkZJR19DUkFNRlM9bQ0KQ09ORklHX1RNUEZTPXkNCkNPTkZJR19SQU1GUz1t
DQpDT05GSUdfSVNPOTY2MF9GUz1tDQpDT05GSUdfSk9MSUVUPXkNCkNPTkZJ
R19aSVNPRlM9eQ0KQ09ORklHX01JTklYX0ZTPW0NCkNPTkZJR19WWEZTX0ZT
PW0NCkNPTkZJR19OVEZTX0ZTPW0NCiMgQ09ORklHX05URlNfUlcgaXMgbm90
IHNldA0KQ09ORklHX0hQRlNfRlM9bQ0KQ09ORklHX1BST0NfRlM9eQ0KIyBD
T05GSUdfREVWRlNfRlMgaXMgbm90IHNldA0KIyBDT05GSUdfREVWRlNfTU9V
TlQgaXMgbm90IHNldA0KIyBDT05GSUdfREVWRlNfREVCVUcgaXMgbm90IHNl
dA0KQ09ORklHX0RFVlBUU19GUz15DQpDT05GSUdfUU5YNEZTX0ZTPW0NCiMg
Q09ORklHX1FOWDRGU19SVyBpcyBub3Qgc2V0DQpDT05GSUdfUk9NRlNfRlM9
bQ0KQ09ORklHX0VYVDJfRlM9bQ0KQ09ORklHX1NZU1ZfRlM9bQ0KQ09ORklH
X1VERl9GUz1tDQojIENPTkZJR19VREZfUlcgaXMgbm90IHNldA0KQ09ORklH
X1VGU19GUz1tDQojIENPTkZJR19VRlNfRlNfV1JJVEUgaXMgbm90IHNldA0K
DQojDQojIE5ldHdvcmsgRmlsZSBTeXN0ZW1zDQojDQpDT05GSUdfQ09EQV9G
Uz1tDQojIENPTkZJR19JTlRFUk1FWlpPX0ZTIGlzIG5vdCBzZXQNCkNPTkZJ
R19ORlNfRlM9bQ0KQ09ORklHX05GU19WMz15DQojIENPTkZJR19ST09UX05G
UyBpcyBub3Qgc2V0DQpDT05GSUdfTkZTRD1tDQpDT05GSUdfTkZTRF9WMz15
DQpDT05GSUdfU1VOUlBDPW0NCkNPTkZJR19MT0NLRD1tDQpDT05GSUdfTE9D
S0RfVjQ9eQ0KQ09ORklHX1NNQl9GUz1tDQpDT05GSUdfU01CX05MU19ERUZB
VUxUPXkNCkNPTkZJR19TTUJfTkxTX1JFTU9URT0iY3A4NTIiDQojIENPTkZJ
R19OQ1BfRlMgaXMgbm90IHNldA0KIyBDT05GSUdfTkNQRlNfUEFDS0VUX1NJ
R05JTkcgaXMgbm90IHNldA0KIyBDT05GSUdfTkNQRlNfSU9DVExfTE9DS0lO
RyBpcyBub3Qgc2V0DQojIENPTkZJR19OQ1BGU19TVFJPTkcgaXMgbm90IHNl
dA0KIyBDT05GSUdfTkNQRlNfTkZTX05TIGlzIG5vdCBzZXQNCiMgQ09ORklH
X05DUEZTX09TMl9OUyBpcyBub3Qgc2V0DQojIENPTkZJR19OQ1BGU19TTUFM
TERPUyBpcyBub3Qgc2V0DQojIENPTkZJR19OQ1BGU19OTFMgaXMgbm90IHNl
dA0KIyBDT05GSUdfTkNQRlNfRVhUUkFTIGlzIG5vdCBzZXQNCkNPTkZJR19a
SVNPRlNfRlM9bQ0KQ09ORklHX1pMSUJfRlNfSU5GTEFURT1tDQoNCiMNCiMg
UGFydGl0aW9uIFR5cGVzDQojDQojIENPTkZJR19QQVJUSVRJT05fQURWQU5D
RUQgaXMgbm90IHNldA0KQ09ORklHX01TRE9TX1BBUlRJVElPTj15DQpDT05G
SUdfU01CX05MUz15DQpDT05GSUdfTkxTPXkNCg0KIw0KIyBOYXRpdmUgTGFu
Z3VhZ2UgU3VwcG9ydA0KIw0KQ09ORklHX05MU19ERUZBVUxUPSJpc284ODU5
LTEiDQpDT05GSUdfTkxTX0NPREVQQUdFXzQzNz1tDQpDT05GSUdfTkxTX0NP
REVQQUdFXzczNz1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzc3NT1tDQpDT05G
SUdfTkxTX0NPREVQQUdFXzg1MD1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzg1
Mj1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzg1NT1tDQpDT05GSUdfTkxTX0NP
REVQQUdFXzg1Nz1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzg2MD1tDQpDT05G
SUdfTkxTX0NPREVQQUdFXzg2MT1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzg2
Mj1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzg2Mz1tDQpDT05GSUdfTkxTX0NP
REVQQUdFXzg2ND1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzg2NT1tDQpDT05G
SUdfTkxTX0NPREVQQUdFXzg2Nj1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzg2
OT1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzkzNj1tDQpDT05GSUdfTkxTX0NP
REVQQUdFXzk1MD1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzkzMj1tDQpDT05G
SUdfTkxTX0NPREVQQUdFXzk0OT1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzg3
ND1tDQpDT05GSUdfTkxTX0lTTzg4NTlfOD1tDQpDT05GSUdfTkxTX0NPREVQ
QUdFXzEyNTA9bQ0KQ09ORklHX05MU19DT0RFUEFHRV8xMjUxPW0NCkNPTkZJ
R19OTFNfSVNPODg1OV8xPW0NCkNPTkZJR19OTFNfSVNPODg1OV8yPW0NCkNP
TkZJR19OTFNfSVNPODg1OV8zPW0NCkNPTkZJR19OTFNfSVNPODg1OV80PW0N
CkNPTkZJR19OTFNfSVNPODg1OV81PW0NCkNPTkZJR19OTFNfSVNPODg1OV82
PW0NCkNPTkZJR19OTFNfSVNPODg1OV83PW0NCkNPTkZJR19OTFNfSVNPODg1
OV85PW0NCkNPTkZJR19OTFNfSVNPODg1OV8xMz1tDQpDT05GSUdfTkxTX0lT
Tzg4NTlfMTQ9bQ0KQ09ORklHX05MU19JU084ODU5XzE1PW0NCkNPTkZJR19O
TFNfS09JOF9SPW0NCkNPTkZJR19OTFNfS09JOF9VPW0NCkNPTkZJR19OTFNf
VVRGOD1tDQoNCiMNCiMgQ29uc29sZSBkcml2ZXJzDQojDQpDT05GSUdfVkdB
X0NPTlNPTEU9eQ0KQ09ORklHX1ZJREVPX1NFTEVDVD15DQojIENPTkZJR19N
REFfQ09OU09MRSBpcyBub3Qgc2V0DQoNCiMNCiMgRnJhbWUtYnVmZmVyIHN1
cHBvcnQNCiMNCiMgQ09ORklHX0ZCIGlzIG5vdCBzZXQNCg0KIw0KIyBTb3Vu
ZA0KIw0KQ09ORklHX1NPVU5EPW0NCiMgQ09ORklHX1NPVU5EX0JUODc4IGlz
IG5vdCBzZXQNCiMgQ09ORklHX1NPVU5EX0NNUENJIGlzIG5vdCBzZXQNCiMg
Q09ORklHX1NPVU5EX0VNVTEwSzEgaXMgbm90IHNldA0KIyBDT05GSUdfTUlE
SV9FTVUxMEsxIGlzIG5vdCBzZXQNCiMgQ09ORklHX1NPVU5EX0ZVU0lPTiBp
cyBub3Qgc2V0DQojIENPTkZJR19TT1VORF9DUzQyODEgaXMgbm90IHNldA0K
IyBDT05GSUdfU09VTkRfRVMxMzcwIGlzIG5vdCBzZXQNCkNPTkZJR19TT1VO
RF9FUzEzNzE9bQ0KIyBDT05GSUdfU09VTkRfRVNTU09MTzEgaXMgbm90IHNl
dA0KIyBDT05GSUdfU09VTkRfTUFFU1RSTyBpcyBub3Qgc2V0DQojIENPTkZJ
R19TT1VORF9NQUVTVFJPMyBpcyBub3Qgc2V0DQojIENPTkZJR19TT1VORF9J
Q0ggaXMgbm90IHNldA0KIyBDT05GSUdfU09VTkRfUk1FOTZYWCBpcyBub3Qg
c2V0DQojIENPTkZJR19TT1VORF9TT05JQ1ZJQkVTIGlzIG5vdCBzZXQNCiMg
Q09ORklHX1NPVU5EX1RSSURFTlQgaXMgbm90IHNldA0KIyBDT05GSUdfU09V
TkRfTVNORENMQVMgaXMgbm90IHNldA0KIyBDT05GSUdfU09VTkRfTVNORFBJ
TiBpcyBub3Qgc2V0DQojIENPTkZJR19TT1VORF9WSUE4MkNYWFggaXMgbm90
IHNldA0KIyBDT05GSUdfTUlESV9WSUE4MkNYWFggaXMgbm90IHNldA0KIyBD
T05GSUdfU09VTkRfT1NTIGlzIG5vdCBzZXQNCiMgQ09ORklHX1NPVU5EX1RW
TUlYRVIgaXMgbm90IHNldA0KDQojDQojIFVTQiBzdXBwb3J0DQojDQpDT05G
SUdfVVNCPXkNCiMgQ09ORklHX1VTQl9ERUJVRyBpcyBub3Qgc2V0DQpDT05G
SUdfVVNCX0RFVklDRUZTPXkNCiMgQ09ORklHX1VTQl9CQU5EV0lEVEggaXMg
bm90IHNldA0KIyBDT05GSUdfVVNCX0xPTkdfVElNRU9VVCBpcyBub3Qgc2V0
DQpDT05GSUdfVVNCX1VIQ0k9bQ0KIyBDT05GSUdfVVNCX1VIQ0lfQUxUIGlz
IG5vdCBzZXQNCiMgQ09ORklHX1VTQl9PSENJIGlzIG5vdCBzZXQNCiMgQ09O
RklHX1VTQl9BVURJTyBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfQkxVRVRP
T1RIIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9TVE9SQUdFIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX1VTQl9TVE9SQUdFX0RFQlVHIGlzIG5vdCBzZXQNCiMg
Q09ORklHX1VTQl9TVE9SQUdFX0RBVEFGQUIgaXMgbm90IHNldA0KIyBDT05G
SUdfVVNCX1NUT1JBR0VfRlJFRUNPTSBpcyBub3Qgc2V0DQojIENPTkZJR19V
U0JfU1RPUkFHRV9JU0QyMDAgaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX1NU
T1JBR0VfRFBDTSBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfU1RPUkFHRV9I
UDgyMDBlIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9TVE9SQUdFX1NERFIw
OSBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfU1RPUkFHRV9KVU1QU0hPVCBp
cyBub3Qgc2V0DQojIENPTkZJR19VU0JfQUNNIGlzIG5vdCBzZXQNCiMgQ09O
RklHX1VTQl9QUklOVEVSIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9ISUQg
aXMgbm90IHNldA0KIyBDT05GSUdfVVNCX0hJRERFViBpcyBub3Qgc2V0DQoj
IENPTkZJR19VU0JfS0JEIGlzIG5vdCBzZXQNCkNPTkZJR19VU0JfTU9VU0U9
bQ0KIyBDT05GSUdfVVNCX1dBQ09NIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VT
Ql9EQzJYWCBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfTURDODAwIGlzIG5v
dCBzZXQNCiMgQ09ORklHX1VTQl9TQ0FOTkVSIGlzIG5vdCBzZXQNCiMgQ09O
RklHX1VTQl9NSUNST1RFSyBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfSFBV
U0JTQ1NJIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9QRUdBU1VTIGlzIG5v
dCBzZXQNCiMgQ09ORklHX1VTQl9LQVdFVEggaXMgbm90IHNldA0KIyBDT05G
SUdfVVNCX0NBVEMgaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX0NEQ0VUSEVS
IGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9VU0JORVQgaXMgbm90IHNldA0K
IyBDT05GSUdfVVNCX1VTUzcyMCBpcyBub3Qgc2V0DQoNCiMNCiMgVVNCIFNl
cmlhbCBDb252ZXJ0ZXIgc3VwcG9ydA0KIw0KIyBDT05GSUdfVVNCX1NFUklB
TCBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfU0VSSUFMX0dFTkVSSUMgaXMg
bm90IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9CRUxLSU4gaXMgbm90IHNl
dA0KIyBDT05GSUdfVVNCX1NFUklBTF9XSElURUhFQVQgaXMgbm90IHNldA0K
IyBDT05GSUdfVVNCX1NFUklBTF9ESUdJX0FDQ0VMRVBPUlQgaXMgbm90IHNl
dA0KIyBDT05GSUdfVVNCX1NFUklBTF9FTVBFRyBpcyBub3Qgc2V0DQojIENP
TkZJR19VU0JfU0VSSUFMX0ZURElfU0lPIGlzIG5vdCBzZXQNCiMgQ09ORklH
X1VTQl9TRVJJQUxfVklTT1IgaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX1NF
UklBTF9JUEFRIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9TRVJJQUxfSVIg
aXMgbm90IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9FREdFUE9SVCBpcyBu
b3Qgc2V0DQojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fUERBIGlzIG5v
dCBzZXQNCiMgQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTiBpcyBub3Qgc2V0
DQojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fVVNBMjggaXMgbm90IHNl
dA0KIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTI4WCBpcyBub3Qg
c2V0DQojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fVVNBMjhYQSBpcyBu
b3Qgc2V0DQojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fVVNBMjhYQiBp
cyBub3Qgc2V0DQojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fVVNBMTkg
aXMgbm90IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTE4
WCBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5fVVNB
MTlXIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9V
U0E0OVcgaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9NQ1RfVTIz
MiBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfU0VSSUFMX0tMU0kgaXMgbm90
IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9QTDIzMDMgaXMgbm90IHNldA0K
IyBDT05GSUdfVVNCX1NFUklBTF9DWUJFUkpBQ0sgaXMgbm90IHNldA0KIyBD
T05GSUdfVVNCX1NFUklBTF9YSVJDT00gaXMgbm90IHNldA0KIyBDT05GSUdf
VVNCX1NFUklBTF9PTU5JTkVUIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9S
SU81MDAgaXMgbm90IHNldA0KDQojDQojIEJsdWV0b290aCBzdXBwb3J0DQoj
DQojIENPTkZJR19CTFVFWiBpcyBub3Qgc2V0DQoNCiMNCiMgS2VybmVsIGhh
Y2tpbmcNCiMNCkNPTkZJR19ERUJVR19LRVJORUw9eQ0KIyBDT05GSUdfREVC
VUdfSElHSE1FTSBpcyBub3Qgc2V0DQojIENPTkZJR19ERUJVR19TTEFCIGlz
IG5vdCBzZXQNCiMgQ09ORklHX0RFQlVHX0lPVklSVCBpcyBub3Qgc2V0DQpD
T05GSUdfTUFHSUNfU1lTUlE9eQ0KIyBDT05GSUdfREVCVUdfU1BJTkxPQ0sg
aXMgbm90IHNldA0KIyBDT05GSUdfREVCVUdfQlVHVkVSQk9TRSBpcyBub3Qg
c2V0DQo=
---943504833-2135313262-1015263265=:10999
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="thalia.config"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0203041834254.10999@pingvin.fazekas.hu>
Content-Description: 
Content-Disposition: attachment; filename="thalia.config"

Iw0KIyBBdXRvbWF0aWNhbGx5IGdlbmVyYXRlZCBieSBtYWtlIG1lbnVjb25m
aWc6IGRvbid0IGVkaXQNCiMNCkNPTkZJR19YODY9eQ0KQ09ORklHX0lTQT15
DQojIENPTkZJR19TQlVTIGlzIG5vdCBzZXQNCkNPTkZJR19VSUQxNj15DQoN
CiMNCiMgQ29kZSBtYXR1cml0eSBsZXZlbCBvcHRpb25zDQojDQpDT05GSUdf
RVhQRVJJTUVOVEFMPXkNCg0KIw0KIyBMb2FkYWJsZSBtb2R1bGUgc3VwcG9y
dA0KIw0KQ09ORklHX01PRFVMRVM9eQ0KQ09ORklHX01PRFZFUlNJT05TPXkN
CkNPTkZJR19LTU9EPXkNCg0KIw0KIyBQcm9jZXNzb3IgdHlwZSBhbmQgZmVh
dHVyZXMNCiMNCiMgQ09ORklHX00zODYgaXMgbm90IHNldA0KIyBDT05GSUdf
TTQ4NiBpcyBub3Qgc2V0DQojIENPTkZJR19NNTg2IGlzIG5vdCBzZXQNCiMg
Q09ORklHX001ODZUU0MgaXMgbm90IHNldA0KIyBDT05GSUdfTTU4Nk1NWCBp
cyBub3Qgc2V0DQojIENPTkZJR19NNjg2IGlzIG5vdCBzZXQNCiMgQ09ORklH
X01QRU5USVVNSUlJIGlzIG5vdCBzZXQNCiMgQ09ORklHX01QRU5USVVNNCBp
cyBub3Qgc2V0DQojIENPTkZJR19NSzYgaXMgbm90IHNldA0KQ09ORklHX01L
Nz15DQojIENPTkZJR19NRUxBTiBpcyBub3Qgc2V0DQojIENPTkZJR19NQ1JV
U09FIGlzIG5vdCBzZXQNCiMgQ09ORklHX01XSU5DSElQQzYgaXMgbm90IHNl
dA0KIyBDT05GSUdfTVdJTkNISVAyIGlzIG5vdCBzZXQNCiMgQ09ORklHX01X
SU5DSElQM0QgaXMgbm90IHNldA0KIyBDT05GSUdfTUNZUklYSUlJIGlzIG5v
dCBzZXQNCkNPTkZJR19YODZfV1BfV09SS1NfT0s9eQ0KQ09ORklHX1g4Nl9J
TlZMUEc9eQ0KQ09ORklHX1g4Nl9DTVBYQ0hHPXkNCkNPTkZJR19YODZfWEFE
RD15DQpDT05GSUdfWDg2X0JTV0FQPXkNCkNPTkZJR19YODZfUE9QQURfT0s9
eQ0KIyBDT05GSUdfUldTRU1fR0VORVJJQ19TUElOTE9DSyBpcyBub3Qgc2V0
DQpDT05GSUdfUldTRU1fWENIR0FERF9BTEdPUklUSE09eQ0KQ09ORklHX1g4
Nl9MMV9DQUNIRV9TSElGVD02DQpDT05GSUdfWDg2X1RTQz15DQpDT05GSUdf
WDg2X0dPT0RfQVBJQz15DQpDT05GSUdfWDg2X1VTRV8zRE5PVz15DQpDT05G
SUdfWDg2X1BHRT15DQpDT05GSUdfWDg2X1VTRV9QUFJPX0NIRUNLU1VNPXkN
CiMgQ09ORklHX1RPU0hJQkEgaXMgbm90IHNldA0KIyBDT05GSUdfSThLIGlz
IG5vdCBzZXQNCkNPTkZJR19NSUNST0NPREU9bQ0KQ09ORklHX1g4Nl9NU1I9
bQ0KQ09ORklHX1g4Nl9DUFVJRD1tDQpDT05GSUdfTk9ISUdITUVNPXkNCiMg
Q09ORklHX0hJR0hNRU00RyBpcyBub3Qgc2V0DQojIENPTkZJR19ISUdITUVN
NjRHIGlzIG5vdCBzZXQNCiMgQ09ORklHX01BVEhfRU1VTEFUSU9OIGlzIG5v
dCBzZXQNCkNPTkZJR19NVFJSPXkNCiMgQ09ORklHX1NNUCBpcyBub3Qgc2V0
DQpDT05GSUdfWDg2X1VQX0FQSUM9eQ0KQ09ORklHX1g4Nl9VUF9JT0FQSUM9
eQ0KQ09ORklHX1g4Nl9MT0NBTF9BUElDPXkNCkNPTkZJR19YODZfSU9fQVBJ
Qz15DQoNCiMNCiMgR2VuZXJhbCBzZXR1cA0KIw0KQ09ORklHX05FVD15DQpD
T05GSUdfUENJPXkNCiMgQ09ORklHX1BDSV9HT0JJT1MgaXMgbm90IHNldA0K
IyBDT05GSUdfUENJX0dPRElSRUNUIGlzIG5vdCBzZXQNCkNPTkZJR19QQ0lf
R09BTlk9eQ0KQ09ORklHX1BDSV9CSU9TPXkNCkNPTkZJR19QQ0lfRElSRUNU
PXkNCkNPTkZJR19QQ0lfTkFNRVM9eQ0KIyBDT05GSUdfRUlTQSBpcyBub3Qg
c2V0DQojIENPTkZJR19NQ0EgaXMgbm90IHNldA0KQ09ORklHX0hPVFBMVUc9
eQ0KDQojDQojIFBDTUNJQS9DYXJkQnVzIHN1cHBvcnQNCiMNCiMgQ09ORklH
X1BDTUNJQSBpcyBub3Qgc2V0DQoNCiMNCiMgUENJIEhvdHBsdWcgU3VwcG9y
dA0KIw0KIyBDT05GSUdfSE9UUExVR19QQ0kgaXMgbm90IHNldA0KIyBDT05G
SUdfSE9UUExVR19QQ0lfQ09NUEFRIGlzIG5vdCBzZXQNCiMgQ09ORklHX0hP
VFBMVUdfUENJX0NPTVBBUV9OVlJBTSBpcyBub3Qgc2V0DQpDT05GSUdfU1lT
VklQQz15DQojIENPTkZJR19CU0RfUFJPQ0VTU19BQ0NUIGlzIG5vdCBzZXQN
CkNPTkZJR19TWVNDVEw9eQ0KQ09ORklHX0tDT1JFX0VMRj15DQojIENPTkZJ
R19LQ09SRV9BT1VUIGlzIG5vdCBzZXQNCkNPTkZJR19CSU5GTVRfQU9VVD15
DQpDT05GSUdfQklORk1UX0VMRj15DQpDT05GSUdfQklORk1UX01JU0M9eQ0K
Q09ORklHX1BNPXkNCiMgQ09ORklHX0FDUEkgaXMgbm90IHNldA0KQ09ORklH
X0FQTT15DQojIENPTkZJR19BUE1fSUdOT1JFX1VTRVJfU1VTUEVORCBpcyBu
b3Qgc2V0DQojIENPTkZJR19BUE1fRE9fRU5BQkxFIGlzIG5vdCBzZXQNCiMg
Q09ORklHX0FQTV9DUFVfSURMRSBpcyBub3Qgc2V0DQojIENPTkZJR19BUE1f
RElTUExBWV9CTEFOSyBpcyBub3Qgc2V0DQojIENPTkZJR19BUE1fUlRDX0lT
X0dNVCBpcyBub3Qgc2V0DQojIENPTkZJR19BUE1fQUxMT1dfSU5UUyBpcyBu
b3Qgc2V0DQojIENPTkZJR19BUE1fUkVBTF9NT0RFX1BPV0VSX09GRiBpcyBu
b3Qgc2V0DQoNCiMNCiMgTWVtb3J5IFRlY2hub2xvZ3kgRGV2aWNlcyAoTVRE
KQ0KIw0KIyBDT05GSUdfTVREIGlzIG5vdCBzZXQNCg0KIw0KIyBQYXJhbGxl
bCBwb3J0IHN1cHBvcnQNCiMNCkNPTkZJR19QQVJQT1JUPW0NCkNPTkZJR19Q
QVJQT1JUX1BDPW0NCkNPTkZJR19QQVJQT1JUX1BDX0NNTDE9bQ0KIyBDT05G
SUdfUEFSUE9SVF9TRVJJQUwgaXMgbm90IHNldA0KQ09ORklHX1BBUlBPUlRf
UENfRklGTz15DQojIENPTkZJR19QQVJQT1JUX1BDX1NVUEVSSU8gaXMgbm90
IHNldA0KIyBDT05GSUdfUEFSUE9SVF9BTUlHQSBpcyBub3Qgc2V0DQojIENP
TkZJR19QQVJQT1JUX01GQzMgaXMgbm90IHNldA0KIyBDT05GSUdfUEFSUE9S
VF9BVEFSSSBpcyBub3Qgc2V0DQojIENPTkZJR19QQVJQT1JUX0dTQyBpcyBu
b3Qgc2V0DQojIENPTkZJR19QQVJQT1JUX1NVTkJQUCBpcyBub3Qgc2V0DQoj
IENPTkZJR19QQVJQT1JUX09USEVSIGlzIG5vdCBzZXQNCkNPTkZJR19QQVJQ
T1JUXzEyODQ9eQ0KDQojDQojIFBsdWcgYW5kIFBsYXkgY29uZmlndXJhdGlv
bg0KIw0KQ09ORklHX1BOUD15DQpDT05GSUdfSVNBUE5QPXkNCg0KIw0KIyBC
bG9jayBkZXZpY2VzDQojDQpDT05GSUdfQkxLX0RFVl9GRD1tDQojIENPTkZJ
R19CTEtfREVWX1hEIGlzIG5vdCBzZXQNCiMgQ09ORklHX1BBUklERSBpcyBu
b3Qgc2V0DQojIENPTkZJR19CTEtfQ1BRX0RBIGlzIG5vdCBzZXQNCiMgQ09O
RklHX0JMS19DUFFfQ0lTU19EQSBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtf
REVWX0RBQzk2MCBpcyBub3Qgc2V0DQpDT05GSUdfQkxLX0RFVl9MT09QPW0N
CiMgQ09ORklHX0JMS19ERVZfTkJEIGlzIG5vdCBzZXQNCkNPTkZJR19CTEtf
REVWX1JBTT1tDQpDT05GSUdfQkxLX0RFVl9SQU1fU0laRT00MDk2DQojIENP
TkZJR19CTEtfREVWX0lOSVRSRCBpcyBub3Qgc2V0DQoNCiMNCiMgTXVsdGkt
ZGV2aWNlIHN1cHBvcnQgKFJBSUQgYW5kIExWTSkNCiMNCiMgQ09ORklHX01E
IGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfTUQgaXMgbm90IHNldA0K
IyBDT05GSUdfTURfTElORUFSIGlzIG5vdCBzZXQNCiMgQ09ORklHX01EX1JB
SUQwIGlzIG5vdCBzZXQNCiMgQ09ORklHX01EX1JBSUQxIGlzIG5vdCBzZXQN
CiMgQ09ORklHX01EX1JBSUQ1IGlzIG5vdCBzZXQNCiMgQ09ORklHX01EX01V
TFRJUEFUSCBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtfREVWX0xWTSBpcyBu
b3Qgc2V0DQoNCiMNCiMgTmV0d29ya2luZyBvcHRpb25zDQojDQpDT05GSUdf
UEFDS0VUPXkNCiMgQ09ORklHX1BBQ0tFVF9NTUFQIGlzIG5vdCBzZXQNCiMg
Q09ORklHX05FVExJTktfREVWIGlzIG5vdCBzZXQNCiMgQ09ORklHX05FVEZJ
TFRFUiBpcyBub3Qgc2V0DQojIENPTkZJR19GSUxURVIgaXMgbm90IHNldA0K
Q09ORklHX1VOSVg9eQ0KQ09ORklHX0lORVQ9eQ0KQ09ORklHX0lQX01VTFRJ
Q0FTVD15DQojIENPTkZJR19JUF9BRFZBTkNFRF9ST1VURVIgaXMgbm90IHNl
dA0KIyBDT05GSUdfSVBfUE5QIGlzIG5vdCBzZXQNCiMgQ09ORklHX05FVF9J
UElQIGlzIG5vdCBzZXQNCiMgQ09ORklHX05FVF9JUEdSRSBpcyBub3Qgc2V0
DQojIENPTkZJR19JUF9NUk9VVEUgaXMgbm90IHNldA0KIyBDT05GSUdfQVJQ
RCBpcyBub3Qgc2V0DQojIENPTkZJR19JTkVUX0VDTiBpcyBub3Qgc2V0DQoj
IENPTkZJR19TWU5fQ09PS0lFUyBpcyBub3Qgc2V0DQojIENPTkZJR19JUFY2
IGlzIG5vdCBzZXQNCiMgQ09ORklHX0tIVFRQRCBpcyBub3Qgc2V0DQojIENP
TkZJR19BVE0gaXMgbm90IHNldA0KIyBDT05GSUdfVkxBTl84MDIxUSBpcyBu
b3Qgc2V0DQojIENPTkZJR19JUFggaXMgbm90IHNldA0KIyBDT05GSUdfQVRB
TEsgaXMgbm90IHNldA0KIyBDT05GSUdfREVDTkVUIGlzIG5vdCBzZXQNCiMg
Q09ORklHX0JSSURHRSBpcyBub3Qgc2V0DQojIENPTkZJR19YMjUgaXMgbm90
IHNldA0KIyBDT05GSUdfTEFQQiBpcyBub3Qgc2V0DQojIENPTkZJR19MTEMg
aXMgbm90IHNldA0KIyBDT05GSUdfTkVUX0RJVkVSVCBpcyBub3Qgc2V0DQoj
IENPTkZJR19FQ09ORVQgaXMgbm90IHNldA0KIyBDT05GSUdfV0FOX1JPVVRF
UiBpcyBub3Qgc2V0DQojIENPTkZJR19ORVRfRkFTVFJPVVRFIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX05FVF9IV19GTE9XQ09OVFJPTCBpcyBub3Qgc2V0DQoN
CiMNCiMgUW9TIGFuZC9vciBmYWlyIHF1ZXVlaW5nDQojDQojIENPTkZJR19O
RVRfU0NIRUQgaXMgbm90IHNldA0KDQojDQojIFRlbGVwaG9ueSBTdXBwb3J0
DQojDQojIENPTkZJR19QSE9ORSBpcyBub3Qgc2V0DQojIENPTkZJR19QSE9O
RV9JWEogaXMgbm90IHNldA0KIyBDT05GSUdfUEhPTkVfSVhKX1BDTUNJQSBp
cyBub3Qgc2V0DQoNCiMNCiMgQVRBL0lERS9NRk0vUkxMIHN1cHBvcnQNCiMN
CkNPTkZJR19JREU9eQ0KDQojDQojIElERSwgQVRBIGFuZCBBVEFQSSBCbG9j
ayBkZXZpY2VzDQojDQpDT05GSUdfQkxLX0RFVl9JREU9eQ0KIyBDT05GSUdf
QkxLX0RFVl9IRF9JREUgaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9I
RCBpcyBub3Qgc2V0DQpDT05GSUdfQkxLX0RFVl9JREVESVNLPXkNCkNPTkZJ
R19JREVESVNLX01VTFRJX01PREU9eQ0KIyBDT05GSUdfQkxLX0RFVl9JREVE
SVNLX1ZFTkRPUiBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtfREVWX0lERURJ
U0tfRlVKSVRTVSBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtfREVWX0lERURJ
U0tfSUJNIGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfSURFRElTS19N
QVhUT1IgaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9JREVESVNLX1FV
QU5UVU0gaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9JREVESVNLX1NF
QUdBVEUgaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9JREVESVNLX1dE
IGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfQ09NTUVSSUFMIGlzIG5v
dCBzZXQNCiMgQ09ORklHX0JMS19ERVZfVElWTyBpcyBub3Qgc2V0DQojIENP
TkZJR19CTEtfREVWX0lERUNTIGlzIG5vdCBzZXQNCkNPTkZJR19CTEtfREVW
X0lERUNEPXkNCiMgQ09ORklHX0JMS19ERVZfSURFVEFQRSBpcyBub3Qgc2V0
DQojIENPTkZJR19CTEtfREVWX0lERUZMT1BQWSBpcyBub3Qgc2V0DQojIENP
TkZJR19CTEtfREVWX0lERVNDU0kgaXMgbm90IHNldA0KQ09ORklHX0JMS19E
RVZfQ01ENjQwPXkNCiMgQ09ORklHX0JMS19ERVZfQ01ENjQwX0VOSEFOQ0VE
IGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfSVNBUE5QIGlzIG5vdCBz
ZXQNCkNPTkZJR19CTEtfREVWX1JaMTAwMD15DQpDT05GSUdfQkxLX0RFVl9J
REVQQ0k9eQ0KQ09ORklHX0lERVBDSV9TSEFSRV9JUlE9eQ0KQ09ORklHX0JM
S19ERVZfSURFRE1BX1BDST15DQpDT05GSUdfQkxLX0RFVl9BRE1BPXkNCiMg
Q09ORklHX0JMS19ERVZfT0ZGQk9BUkQgaXMgbm90IHNldA0KQ09ORklHX0lE
RURNQV9QQ0lfQVVUTz15DQpDT05GSUdfQkxLX0RFVl9JREVETUE9eQ0KIyBD
T05GSUdfSURFRE1BX1BDSV9XSVAgaXMgbm90IHNldA0KIyBDT05GSUdfSURF
RE1BX05FV19EUklWRV9MSVNUSU5HUyBpcyBub3Qgc2V0DQojIENPTkZJR19C
TEtfREVWX0FFQzYyWFggaXMgbm90IHNldA0KIyBDT05GSUdfQUVDNjJYWF9U
VU5JTkcgaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9BTEkxNVgzIGlz
IG5vdCBzZXQNCiMgQ09ORklHX1dEQ19BTEkxNVgzIGlzIG5vdCBzZXQNCiMg
Q09ORklHX0JMS19ERVZfQU1ENzRYWCBpcyBub3Qgc2V0DQojIENPTkZJR19B
TUQ3NFhYX09WRVJSSURFIGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZf
Q01ENjRYIGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfQ1k4MkM2OTMg
aXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9DUzU1MzAgaXMgbm90IHNl
dA0KIyBDT05GSUdfQkxLX0RFVl9IUFQzNFggaXMgbm90IHNldA0KIyBDT05G
SUdfSFBUMzRYX0FVVE9ETUEgaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RF
Vl9IUFQzNjYgaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9QSUlYIGlz
IG5vdCBzZXQNCiMgQ09ORklHX1BJSVhfVFVOSU5HIGlzIG5vdCBzZXQNCiMg
Q09ORklHX0JMS19ERVZfTlM4NzQxNSBpcyBub3Qgc2V0DQojIENPTkZJR19C
TEtfREVWX09QVEk2MjEgaXMgbm90IHNldA0KIyBDT05GSUdfQkxLX0RFVl9Q
REMyMDJYWCBpcyBub3Qgc2V0DQojIENPTkZJR19QREMyMDJYWF9CVVJTVCBp
cyBub3Qgc2V0DQojIENPTkZJR19QREMyMDJYWF9GT1JDRSBpcyBub3Qgc2V0
DQojIENPTkZJR19CTEtfREVWX1NWV0tTIGlzIG5vdCBzZXQNCiMgQ09ORklH
X0JMS19ERVZfU0lTNTUxMyBpcyBub3Qgc2V0DQojIENPTkZJR19CTEtfREVW
X1NMQzkwRTY2IGlzIG5vdCBzZXQNCiMgQ09ORklHX0JMS19ERVZfVFJNMjkw
IGlzIG5vdCBzZXQNCkNPTkZJR19CTEtfREVWX1ZJQTgyQ1hYWD15DQojIENP
TkZJR19JREVfQ0hJUFNFVFMgaXMgbm90IHNldA0KQ09ORklHX0lERURNQV9B
VVRPPXkNCiMgQ09ORklHX0lERURNQV9JVkIgaXMgbm90IHNldA0KIyBDT05G
SUdfRE1BX05PTlBDSSBpcyBub3Qgc2V0DQpDT05GSUdfQkxLX0RFVl9JREVf
TU9ERVM9eQ0KIyBDT05GSUdfQkxLX0RFVl9BVEFSQUlEIGlzIG5vdCBzZXQN
CiMgQ09ORklHX0JMS19ERVZfQVRBUkFJRF9QREMgaXMgbm90IHNldA0KIyBD
T05GSUdfQkxLX0RFVl9BVEFSQUlEX0hQVCBpcyBub3Qgc2V0DQoNCiMNCiMg
U0NTSSBzdXBwb3J0DQojDQojIENPTkZJR19TQ1NJIGlzIG5vdCBzZXQNCg0K
Iw0KIyBGdXNpb24gTVBUIGRldmljZSBzdXBwb3J0DQojDQojIENPTkZJR19G
VVNJT04gaXMgbm90IHNldA0KIyBDT05GSUdfRlVTSU9OX0JPT1QgaXMgbm90
IHNldA0KIyBDT05GSUdfRlVTSU9OX0lTRU5TRSBpcyBub3Qgc2V0DQojIENP
TkZJR19GVVNJT05fQ1RMIGlzIG5vdCBzZXQNCiMgQ09ORklHX0ZVU0lPTl9M
QU4gaXMgbm90IHNldA0KDQojDQojIElFRUUgMTM5NCAoRmlyZVdpcmUpIHN1
cHBvcnQgKEVYUEVSSU1FTlRBTCkNCiMNCkNPTkZJR19JRUVFMTM5ND1tDQoj
IENPTkZJR19JRUVFMTM5NF9QQ0lMWU5YIGlzIG5vdCBzZXQNCkNPTkZJR19J
RUVFMTM5NF9PSENJMTM5ND1tDQpDT05GSUdfSUVFRTEzOTRfVklERU8xMzk0
PW0NCiMgQ09ORklHX0lFRUUxMzk0X1NCUDIgaXMgbm90IHNldA0KQ09ORklH
X0lFRUUxMzk0X1JBV0lPPW0NCiMgQ09ORklHX0lFRUUxMzk0X1ZFUkJPU0VE
RUJVRyBpcyBub3Qgc2V0DQoNCiMNCiMgSTJPIGRldmljZSBzdXBwb3J0DQoj
DQojIENPTkZJR19JMk8gaXMgbm90IHNldA0KIyBDT05GSUdfSTJPX1BDSSBp
cyBub3Qgc2V0DQojIENPTkZJR19JMk9fQkxPQ0sgaXMgbm90IHNldA0KIyBD
T05GSUdfSTJPX0xBTiBpcyBub3Qgc2V0DQojIENPTkZJR19JMk9fU0NTSSBp
cyBub3Qgc2V0DQojIENPTkZJR19JMk9fUFJPQyBpcyBub3Qgc2V0DQoNCiMN
CiMgTmV0d29yayBkZXZpY2Ugc3VwcG9ydA0KIw0KQ09ORklHX05FVERFVklD
RVM9eQ0KDQojDQojIEFSQ25ldCBkZXZpY2VzDQojDQojIENPTkZJR19BUkNO
RVQgaXMgbm90IHNldA0KIyBDT05GSUdfRFVNTVkgaXMgbm90IHNldA0KIyBD
T05GSUdfQk9ORElORyBpcyBub3Qgc2V0DQojIENPTkZJR19FUVVBTElaRVIg
aXMgbm90IHNldA0KIyBDT05GSUdfVFVOIGlzIG5vdCBzZXQNCiMgQ09ORklH
X0VUSEVSVEFQIGlzIG5vdCBzZXQNCiMgQ09ORklHX05FVF9TQjEwMDAgaXMg
bm90IHNldA0KDQojDQojIEV0aGVybmV0ICgxMCBvciAxMDBNYml0KQ0KIw0K
Q09ORklHX05FVF9FVEhFUk5FVD15DQojIENPTkZJR19TVU5MQU5DRSBpcyBu
b3Qgc2V0DQojIENPTkZJR19IQVBQWU1FQUwgaXMgbm90IHNldA0KIyBDT05G
SUdfU1VOQk1BQyBpcyBub3Qgc2V0DQojIENPTkZJR19TVU5RRSBpcyBub3Qg
c2V0DQojIENPTkZJR19TVU5HRU0gaXMgbm90IHNldA0KQ09ORklHX05FVF9W
RU5ET1JfM0NPTT15DQojIENPTkZJR19FTDEgaXMgbm90IHNldA0KIyBDT05G
SUdfRUwyIGlzIG5vdCBzZXQNCiMgQ09ORklHX0VMUExVUyBpcyBub3Qgc2V0
DQojIENPTkZJR19FTDE2IGlzIG5vdCBzZXQNCiMgQ09ORklHX0VMMyBpcyBu
b3Qgc2V0DQojIENPTkZJR18zQzUxNSBpcyBub3Qgc2V0DQojIENPTkZJR19F
TE1DIGlzIG5vdCBzZXQNCiMgQ09ORklHX0VMTUNfSUkgaXMgbm90IHNldA0K
Q09ORklHX1ZPUlRFWD1tDQojIENPTkZJR19MQU5DRSBpcyBub3Qgc2V0DQoj
IENPTkZJR19ORVRfVkVORE9SX1NNQyBpcyBub3Qgc2V0DQojIENPTkZJR19O
RVRfVkVORE9SX1JBQ0FMIGlzIG5vdCBzZXQNCiMgQ09ORklHX0FUMTcwMCBp
cyBub3Qgc2V0DQojIENPTkZJR19ERVBDQSBpcyBub3Qgc2V0DQojIENPTkZJ
R19IUDEwMCBpcyBub3Qgc2V0DQojIENPTkZJR19ORVRfSVNBIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX05FVF9QQ0kgaXMgbm90IHNldA0KIyBDT05GSUdfTkVU
X1BPQ0tFVCBpcyBub3Qgc2V0DQoNCiMNCiMgRXRoZXJuZXQgKDEwMDAgTWJp
dCkNCiMNCiMgQ09ORklHX0FDRU5JQyBpcyBub3Qgc2V0DQojIENPTkZJR19E
TDJLIGlzIG5vdCBzZXQNCiMgQ09ORklHX01ZUklfU0JVUyBpcyBub3Qgc2V0
DQojIENPTkZJR19OUzgzODIwIGlzIG5vdCBzZXQNCiMgQ09ORklHX0hBTUFD
SEkgaXMgbm90IHNldA0KIyBDT05GSUdfWUVMTE9XRklOIGlzIG5vdCBzZXQN
CiMgQ09ORklHX1NLOThMSU4gaXMgbm90IHNldA0KIyBDT05GSUdfRkRESSBp
cyBub3Qgc2V0DQojIENPTkZJR19ISVBQSSBpcyBub3Qgc2V0DQojIENPTkZJ
R19QTElQIGlzIG5vdCBzZXQNCiMgQ09ORklHX1BQUCBpcyBub3Qgc2V0DQoj
IENPTkZJR19TTElQIGlzIG5vdCBzZXQNCg0KIw0KIyBXaXJlbGVzcyBMQU4g
KG5vbi1oYW1yYWRpbykNCiMNCiMgQ09ORklHX05FVF9SQURJTyBpcyBub3Qg
c2V0DQoNCiMNCiMgVG9rZW4gUmluZyBkZXZpY2VzDQojDQojIENPTkZJR19U
UiBpcyBub3Qgc2V0DQojIENPTkZJR19ORVRfRkMgaXMgbm90IHNldA0KIyBD
T05GSUdfUkNQQ0kgaXMgbm90IHNldA0KIyBDT05GSUdfU0hBUEVSIGlzIG5v
dCBzZXQNCg0KIw0KIyBXYW4gaW50ZXJmYWNlcw0KIw0KIyBDT05GSUdfV0FO
IGlzIG5vdCBzZXQNCg0KIw0KIyBBbWF0ZXVyIFJhZGlvIHN1cHBvcnQNCiMN
CiMgQ09ORklHX0hBTVJBRElPIGlzIG5vdCBzZXQNCg0KIw0KIyBJckRBIChp
bmZyYXJlZCkgc3VwcG9ydA0KIw0KIyBDT05GSUdfSVJEQSBpcyBub3Qgc2V0
DQoNCiMNCiMgSVNETiBzdWJzeXN0ZW0NCiMNCiMgQ09ORklHX0lTRE4gaXMg
bm90IHNldA0KDQojDQojIE9sZCBDRC1ST00gZHJpdmVycyAobm90IFNDU0ks
IG5vdCBJREUpDQojDQojIENPTkZJR19DRF9OT19JREVTQ1NJIGlzIG5vdCBz
ZXQNCg0KIw0KIyBJbnB1dCBjb3JlIHN1cHBvcnQNCiMNCkNPTkZJR19JTlBV
VD1tDQojIENPTkZJR19JTlBVVF9LRVlCREVWIGlzIG5vdCBzZXQNCkNPTkZJ
R19JTlBVVF9NT1VTRURFVj1tDQpDT05GSUdfSU5QVVRfTU9VU0VERVZfU0NS
RUVOX1g9MTAyNA0KQ09ORklHX0lOUFVUX01PVVNFREVWX1NDUkVFTl9ZPTc2
OA0KIyBDT05GSUdfSU5QVVRfSk9ZREVWIGlzIG5vdCBzZXQNCiMgQ09ORklH
X0lOUFVUX0VWREVWIGlzIG5vdCBzZXQNCg0KIw0KIyBDaGFyYWN0ZXIgZGV2
aWNlcw0KIw0KQ09ORklHX1ZUPXkNCkNPTkZJR19WVF9DT05TT0xFPXkNCkNP
TkZJR19TRVJJQUw9bQ0KIyBDT05GSUdfU0VSSUFMX0VYVEVOREVEIGlzIG5v
dCBzZXQNCiMgQ09ORklHX1NFUklBTF9OT05TVEFOREFSRCBpcyBub3Qgc2V0
DQpDT05GSUdfVU5JWDk4X1BUWVM9eQ0KQ09ORklHX1VOSVg5OF9QVFlfQ09V
TlQ9MjU2DQpDT05GSUdfUFJJTlRFUj1tDQojIENPTkZJR19MUF9DT05TT0xF
IGlzIG5vdCBzZXQNCiMgQ09ORklHX1BQREVWIGlzIG5vdCBzZXQNCg0KIw0K
IyBJMkMgc3VwcG9ydA0KIw0KIyBDT05GSUdfSTJDIGlzIG5vdCBzZXQNCg0K
Iw0KIyBNaWNlDQojDQojIENPTkZJR19CVVNNT1VTRSBpcyBub3Qgc2V0DQpD
T05GSUdfTU9VU0U9eQ0KQ09ORklHX1BTTU9VU0U9eQ0KIyBDT05GSUdfODJD
NzEwX01PVVNFIGlzIG5vdCBzZXQNCiMgQ09ORklHX1BDMTEwX1BBRCBpcyBu
b3Qgc2V0DQoNCiMNCiMgSm95c3RpY2tzDQojDQojIENPTkZJR19JTlBVVF9H
QU1FUE9SVCBpcyBub3Qgc2V0DQojIENPTkZJR19JTlBVVF9OUzU1OCBpcyBu
b3Qgc2V0DQojIENPTkZJR19JTlBVVF9MSUdIVE5JTkcgaXMgbm90IHNldA0K
IyBDT05GSUdfSU5QVVRfUENJR0FNRSBpcyBub3Qgc2V0DQojIENPTkZJR19J
TlBVVF9DUzQ2MVggaXMgbm90IHNldA0KIyBDT05GSUdfSU5QVVRfRU1VMTBL
MSBpcyBub3Qgc2V0DQojIENPTkZJR19JTlBVVF9TRVJJTyBpcyBub3Qgc2V0
DQojIENPTkZJR19JTlBVVF9TRVJQT1JUIGlzIG5vdCBzZXQNCiMgQ09ORklH
X0lOUFVUX0FOQUxPRyBpcyBub3Qgc2V0DQojIENPTkZJR19JTlBVVF9BM0Qg
aXMgbm90IHNldA0KIyBDT05GSUdfSU5QVVRfQURJIGlzIG5vdCBzZXQNCiMg
Q09ORklHX0lOUFVUX0NPQlJBIGlzIG5vdCBzZXQNCiMgQ09ORklHX0lOUFVU
X0dGMksgaXMgbm90IHNldA0KIyBDT05GSUdfSU5QVVRfR1JJUCBpcyBub3Qg
c2V0DQojIENPTkZJR19JTlBVVF9JTlRFUkFDVCBpcyBub3Qgc2V0DQojIENP
TkZJR19JTlBVVF9UTURDIGlzIG5vdCBzZXQNCiMgQ09ORklHX0lOUFVUX1NJ
REVXSU5ERVIgaXMgbm90IHNldA0KIyBDT05GSUdfSU5QVVRfSUZPUkNFX1VT
QiBpcyBub3Qgc2V0DQojIENPTkZJR19JTlBVVF9JRk9SQ0VfMjMyIGlzIG5v
dCBzZXQNCiMgQ09ORklHX0lOUFVUX1dBUlJJT1IgaXMgbm90IHNldA0KIyBD
T05GSUdfSU5QVVRfTUFHRUxMQU4gaXMgbm90IHNldA0KIyBDT05GSUdfSU5Q
VVRfU1BBQ0VPUkIgaXMgbm90IHNldA0KIyBDT05GSUdfSU5QVVRfU1BBQ0VC
QUxMIGlzIG5vdCBzZXQNCiMgQ09ORklHX0lOUFVUX1NUSU5HRVIgaXMgbm90
IHNldA0KIyBDT05GSUdfSU5QVVRfREI5IGlzIG5vdCBzZXQNCiMgQ09ORklH
X0lOUFVUX0dBTUVDT04gaXMgbm90IHNldA0KIyBDT05GSUdfSU5QVVRfVFVS
Qk9HUkFGWCBpcyBub3Qgc2V0DQojIENPTkZJR19RSUMwMl9UQVBFIGlzIG5v
dCBzZXQNCg0KIw0KIyBXYXRjaGRvZyBDYXJkcw0KIw0KIyBDT05GSUdfV0FU
Q0hET0cgaXMgbm90IHNldA0KIyBDT05GSUdfSU5URUxfUk5HIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX05WUkFNIGlzIG5vdCBzZXQNCkNPTkZJR19SVEM9eQ0K
IyBDT05GSUdfRFRMSyBpcyBub3Qgc2V0DQojIENPTkZJR19SMzk2NCBpcyBu
b3Qgc2V0DQojIENPTkZJR19BUFBMSUNPTSBpcyBub3Qgc2V0DQojIENPTkZJ
R19TT05ZUEkgaXMgbm90IHNldA0KDQojDQojIEZ0YXBlLCB0aGUgZmxvcHB5
IHRhcGUgZGV2aWNlIGRyaXZlcg0KIw0KIyBDT05GSUdfRlRBUEUgaXMgbm90
IHNldA0KQ09ORklHX0FHUD15DQojIENPTkZJR19BR1BfSU5URUwgaXMgbm90
IHNldA0KIyBDT05GSUdfQUdQX0k4MTAgaXMgbm90IHNldA0KQ09ORklHX0FH
UF9WSUE9eQ0KIyBDT05GSUdfQUdQX0FNRCBpcyBub3Qgc2V0DQojIENPTkZJ
R19BR1BfU0lTIGlzIG5vdCBzZXQNCiMgQ09ORklHX0FHUF9BTEkgaXMgbm90
IHNldA0KIyBDT05GSUdfQUdQX1NXT1JLUyBpcyBub3Qgc2V0DQpDT05GSUdf
RFJNPXkNCiMgQ09ORklHX0RSTV9PTEQgaXMgbm90IHNldA0KQ09ORklHX0RS
TV9ORVc9eQ0KIyBDT05GSUdfRFJNX1RERlggaXMgbm90IHNldA0KIyBDT05G
SUdfRFJNX1IxMjggaXMgbm90IHNldA0KIyBDT05GSUdfRFJNX1JBREVPTiBp
cyBub3Qgc2V0DQojIENPTkZJR19EUk1fSTgxMCBpcyBub3Qgc2V0DQojIENP
TkZJR19EUk1fTUdBIGlzIG5vdCBzZXQNCiMgQ09ORklHX0RSTV9TSVMgaXMg
bm90IHNldA0KIyBDT05GSUdfTVdBVkUgaXMgbm90IHNldA0KDQojDQojIE11
bHRpbWVkaWEgZGV2aWNlcw0KIw0KIyBDT05GSUdfVklERU9fREVWIGlzIG5v
dCBzZXQNCg0KIw0KIyBGaWxlIHN5c3RlbXMNCiMNCiMgQ09ORklHX1FVT1RB
IGlzIG5vdCBzZXQNCiMgQ09ORklHX0FVVE9GU19GUyBpcyBub3Qgc2V0DQoj
IENPTkZJR19BVVRPRlM0X0ZTIGlzIG5vdCBzZXQNCkNPTkZJR19SRUlTRVJG
U19GUz15DQojIENPTkZJR19SRUlTRVJGU19DSEVDSyBpcyBub3Qgc2V0DQoj
IENPTkZJR19SRUlTRVJGU19QUk9DX0lORk8gaXMgbm90IHNldA0KQ09ORklH
X0FERlNfRlM9bQ0KIyBDT05GSUdfQURGU19GU19SVyBpcyBub3Qgc2V0DQpD
T05GSUdfQUZGU19GUz1tDQpDT05GSUdfSEZTX0ZTPW0NCkNPTkZJR19CRlNf
RlM9bQ0KQ09ORklHX0VYVDNfRlM9bQ0KQ09ORklHX0pCRD1tDQojIENPTkZJ
R19KQkRfREVCVUcgaXMgbm90IHNldA0KQ09ORklHX0ZBVF9GUz1tDQpDT05G
SUdfTVNET1NfRlM9bQ0KQ09ORklHX1VNU0RPU19GUz1tDQpDT05GSUdfVkZB
VF9GUz1tDQpDT05GSUdfRUZTX0ZTPW0NCiMgQ09ORklHX0pGRlNfRlMgaXMg
bm90IHNldA0KIyBDT05GSUdfSkZGUzJfRlMgaXMgbm90IHNldA0KQ09ORklH
X0NSQU1GUz1tDQpDT05GSUdfVE1QRlM9eQ0KQ09ORklHX1JBTUZTPW0NCkNP
TkZJR19JU085NjYwX0ZTPW0NCkNPTkZJR19KT0xJRVQ9eQ0KQ09ORklHX1pJ
U09GUz15DQpDT05GSUdfTUlOSVhfRlM9bQ0KQ09ORklHX1ZYRlNfRlM9bQ0K
Q09ORklHX05URlNfRlM9bQ0KIyBDT05GSUdfTlRGU19SVyBpcyBub3Qgc2V0
DQpDT05GSUdfSFBGU19GUz1tDQpDT05GSUdfUFJPQ19GUz15DQojIENPTkZJ
R19ERVZGU19GUyBpcyBub3Qgc2V0DQojIENPTkZJR19ERVZGU19NT1VOVCBp
cyBub3Qgc2V0DQojIENPTkZJR19ERVZGU19ERUJVRyBpcyBub3Qgc2V0DQpD
T05GSUdfREVWUFRTX0ZTPXkNCkNPTkZJR19RTlg0RlNfRlM9bQ0KIyBDT05G
SUdfUU5YNEZTX1JXIGlzIG5vdCBzZXQNCkNPTkZJR19ST01GU19GUz1tDQpD
T05GSUdfRVhUMl9GUz1tDQpDT05GSUdfU1lTVl9GUz1tDQpDT05GSUdfVURG
X0ZTPW0NCiMgQ09ORklHX1VERl9SVyBpcyBub3Qgc2V0DQpDT05GSUdfVUZT
X0ZTPW0NCiMgQ09ORklHX1VGU19GU19XUklURSBpcyBub3Qgc2V0DQoNCiMN
CiMgTmV0d29yayBGaWxlIFN5c3RlbXMNCiMNCkNPTkZJR19DT0RBX0ZTPW0N
CiMgQ09ORklHX0lOVEVSTUVaWk9fRlMgaXMgbm90IHNldA0KQ09ORklHX05G
U19GUz1tDQpDT05GSUdfTkZTX1YzPXkNCiMgQ09ORklHX1JPT1RfTkZTIGlz
IG5vdCBzZXQNCkNPTkZJR19ORlNEPW0NCkNPTkZJR19ORlNEX1YzPXkNCkNP
TkZJR19TVU5SUEM9bQ0KQ09ORklHX0xPQ0tEPW0NCkNPTkZJR19MT0NLRF9W
ND15DQpDT05GSUdfU01CX0ZTPW0NCkNPTkZJR19TTUJfTkxTX0RFRkFVTFQ9
eQ0KQ09ORklHX1NNQl9OTFNfUkVNT1RFPSJjcDg1MiINCiMgQ09ORklHX05D
UF9GUyBpcyBub3Qgc2V0DQojIENPTkZJR19OQ1BGU19QQUNLRVRfU0lHTklO
RyBpcyBub3Qgc2V0DQojIENPTkZJR19OQ1BGU19JT0NUTF9MT0NLSU5HIGlz
IG5vdCBzZXQNCiMgQ09ORklHX05DUEZTX1NUUk9ORyBpcyBub3Qgc2V0DQoj
IENPTkZJR19OQ1BGU19ORlNfTlMgaXMgbm90IHNldA0KIyBDT05GSUdfTkNQ
RlNfT1MyX05TIGlzIG5vdCBzZXQNCiMgQ09ORklHX05DUEZTX1NNQUxMRE9T
IGlzIG5vdCBzZXQNCiMgQ09ORklHX05DUEZTX05MUyBpcyBub3Qgc2V0DQoj
IENPTkZJR19OQ1BGU19FWFRSQVMgaXMgbm90IHNldA0KQ09ORklHX1pJU09G
U19GUz1tDQpDT05GSUdfWkxJQl9GU19JTkZMQVRFPW0NCg0KIw0KIyBQYXJ0
aXRpb24gVHlwZXMNCiMNCiMgQ09ORklHX1BBUlRJVElPTl9BRFZBTkNFRCBp
cyBub3Qgc2V0DQpDT05GSUdfTVNET1NfUEFSVElUSU9OPXkNCkNPTkZJR19T
TUJfTkxTPXkNCkNPTkZJR19OTFM9eQ0KDQojDQojIE5hdGl2ZSBMYW5ndWFn
ZSBTdXBwb3J0DQojDQpDT05GSUdfTkxTX0RFRkFVTFQ9Imlzbzg4NTktMSIN
CkNPTkZJR19OTFNfQ09ERVBBR0VfNDM3PW0NCkNPTkZJR19OTFNfQ09ERVBB
R0VfNzM3PW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfNzc1PW0NCkNPTkZJR19O
TFNfQ09ERVBBR0VfODUwPW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODUyPW0N
CkNPTkZJR19OTFNfQ09ERVBBR0VfODU1PW0NCkNPTkZJR19OTFNfQ09ERVBB
R0VfODU3PW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODYwPW0NCkNPTkZJR19O
TFNfQ09ERVBBR0VfODYxPW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODYyPW0N
CkNPTkZJR19OTFNfQ09ERVBBR0VfODYzPW0NCkNPTkZJR19OTFNfQ09ERVBB
R0VfODY0PW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODY1PW0NCkNPTkZJR19O
TFNfQ09ERVBBR0VfODY2PW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODY5PW0N
CkNPTkZJR19OTFNfQ09ERVBBR0VfOTM2PW0NCkNPTkZJR19OTFNfQ09ERVBB
R0VfOTUwPW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfOTMyPW0NCkNPTkZJR19O
TFNfQ09ERVBBR0VfOTQ5PW0NCkNPTkZJR19OTFNfQ09ERVBBR0VfODc0PW0N
CkNPTkZJR19OTFNfSVNPODg1OV84PW0NCkNPTkZJR19OTFNfQ09ERVBBR0Vf
MTI1MD1tDQpDT05GSUdfTkxTX0NPREVQQUdFXzEyNTE9bQ0KQ09ORklHX05M
U19JU084ODU5XzE9bQ0KQ09ORklHX05MU19JU084ODU5XzI9bQ0KQ09ORklH
X05MU19JU084ODU5XzM9bQ0KQ09ORklHX05MU19JU084ODU5XzQ9bQ0KQ09O
RklHX05MU19JU084ODU5XzU9bQ0KQ09ORklHX05MU19JU084ODU5XzY9bQ0K
Q09ORklHX05MU19JU084ODU5Xzc9bQ0KQ09ORklHX05MU19JU084ODU5Xzk9
bQ0KQ09ORklHX05MU19JU084ODU5XzEzPW0NCkNPTkZJR19OTFNfSVNPODg1
OV8xND1tDQpDT05GSUdfTkxTX0lTTzg4NTlfMTU9bQ0KQ09ORklHX05MU19L
T0k4X1I9bQ0KQ09ORklHX05MU19LT0k4X1U9bQ0KQ09ORklHX05MU19VVEY4
PW0NCg0KIw0KIyBDb25zb2xlIGRyaXZlcnMNCiMNCkNPTkZJR19WR0FfQ09O
U09MRT15DQpDT05GSUdfVklERU9fU0VMRUNUPXkNCiMgQ09ORklHX01EQV9D
T05TT0xFIGlzIG5vdCBzZXQNCg0KIw0KIyBGcmFtZS1idWZmZXIgc3VwcG9y
dA0KIw0KIyBDT05GSUdfRkIgaXMgbm90IHNldA0KDQojDQojIFNvdW5kDQoj
DQpDT05GSUdfU09VTkQ9bQ0KIyBDT05GSUdfU09VTkRfQlQ4NzggaXMgbm90
IHNldA0KQ09ORklHX1NPVU5EX0NNUENJPW0NCkNPTkZJR19TT1VORF9DTVBD
SV9GTT15DQpDT05GSUdfU09VTkRfQ01QQ0lfRk1JTz0zODgNCkNPTkZJR19T
T1VORF9DTVBDSV9GTUlPPTM4OA0KQ09ORklHX1NPVU5EX0NNUENJX01JREk9
eQ0KQ09ORklHX1NPVU5EX0NNUENJX01QVUlPPTMzMA0KQ09ORklHX1NPVU5E
X0NNUENJX0pPWVNUSUNLPXkNCkNPTkZJR19TT1VORF9DTVBDSV9DTTg3Mzg9
eQ0KIyBDT05GSUdfU09VTkRfQ01QQ0lfU1BESUZJTlZFUlNFIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX1NPVU5EX0NNUENJX1NQRElGTE9PUCBpcyBub3Qgc2V0
DQpDT05GSUdfU09VTkRfQ01QQ0lfU1BFQUtFUlM9Mg0KIyBDT05GSUdfU09V
TkRfRU1VMTBLMSBpcyBub3Qgc2V0DQojIENPTkZJR19NSURJX0VNVTEwSzEg
aXMgbm90IHNldA0KIyBDT05GSUdfU09VTkRfRlVTSU9OIGlzIG5vdCBzZXQN
CiMgQ09ORklHX1NPVU5EX0NTNDI4MSBpcyBub3Qgc2V0DQojIENPTkZJR19T
T1VORF9FUzEzNzAgaXMgbm90IHNldA0KIyBDT05GSUdfU09VTkRfRVMxMzcx
IGlzIG5vdCBzZXQNCiMgQ09ORklHX1NPVU5EX0VTU1NPTE8xIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX1NPVU5EX01BRVNUUk8gaXMgbm90IHNldA0KIyBDT05G
SUdfU09VTkRfTUFFU1RSTzMgaXMgbm90IHNldA0KIyBDT05GSUdfU09VTkRf
SUNIIGlzIG5vdCBzZXQNCiMgQ09ORklHX1NPVU5EX1JNRTk2WFggaXMgbm90
IHNldA0KIyBDT05GSUdfU09VTkRfU09OSUNWSUJFUyBpcyBub3Qgc2V0DQoj
IENPTkZJR19TT1VORF9UUklERU5UIGlzIG5vdCBzZXQNCiMgQ09ORklHX1NP
VU5EX01TTkRDTEFTIGlzIG5vdCBzZXQNCiMgQ09ORklHX1NPVU5EX01TTkRQ
SU4gaXMgbm90IHNldA0KIyBDT05GSUdfU09VTkRfVklBODJDWFhYIGlzIG5v
dCBzZXQNCiMgQ09ORklHX01JRElfVklBODJDWFhYIGlzIG5vdCBzZXQNCiMg
Q09ORklHX1NPVU5EX09TUyBpcyBub3Qgc2V0DQojIENPTkZJR19TT1VORF9U
Vk1JWEVSIGlzIG5vdCBzZXQNCg0KIw0KIyBVU0Igc3VwcG9ydA0KIw0KQ09O
RklHX1VTQj15DQojIENPTkZJR19VU0JfREVCVUcgaXMgbm90IHNldA0KQ09O
RklHX1VTQl9ERVZJQ0VGUz15DQojIENPTkZJR19VU0JfQkFORFdJRFRIIGlz
IG5vdCBzZXQNCiMgQ09ORklHX1VTQl9MT05HX1RJTUVPVVQgaXMgbm90IHNl
dA0KQ09ORklHX1VTQl9VSENJPW0NCiMgQ09ORklHX1VTQl9VSENJX0FMVCBp
cyBub3Qgc2V0DQojIENPTkZJR19VU0JfT0hDSSBpcyBub3Qgc2V0DQojIENP
TkZJR19VU0JfQVVESU8gaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX0JMVUVU
T09USCBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfU1RPUkFHRSBpcyBub3Qg
c2V0DQojIENPTkZJR19VU0JfU1RPUkFHRV9ERUJVRyBpcyBub3Qgc2V0DQoj
IENPTkZJR19VU0JfU1RPUkFHRV9EQVRBRkFCIGlzIG5vdCBzZXQNCiMgQ09O
RklHX1VTQl9TVE9SQUdFX0ZSRUVDT00gaXMgbm90IHNldA0KIyBDT05GSUdf
VVNCX1NUT1JBR0VfSVNEMjAwIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9T
VE9SQUdFX0RQQ00gaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX1NUT1JBR0Vf
SFA4MjAwZSBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfU1RPUkFHRV9TRERS
MDkgaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX1NUT1JBR0VfSlVNUFNIT1Qg
aXMgbm90IHNldA0KIyBDT05GSUdfVVNCX0FDTSBpcyBub3Qgc2V0DQojIENP
TkZJR19VU0JfUFJJTlRFUiBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfSElE
IGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9ISURERVYgaXMgbm90IHNldA0K
IyBDT05GSUdfVVNCX0tCRCBpcyBub3Qgc2V0DQpDT05GSUdfVVNCX01PVVNF
PW0NCiMgQ09ORklHX1VTQl9XQUNPTSBpcyBub3Qgc2V0DQojIENPTkZJR19V
U0JfREMyWFggaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX01EQzgwMCBpcyBu
b3Qgc2V0DQojIENPTkZJR19VU0JfU0NBTk5FUiBpcyBub3Qgc2V0DQojIENP
TkZJR19VU0JfTUlDUk9URUsgaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX0hQ
VVNCU0NTSSBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfUEVHQVNVUyBpcyBu
b3Qgc2V0DQojIENPTkZJR19VU0JfS0FXRVRIIGlzIG5vdCBzZXQNCiMgQ09O
RklHX1VTQl9DQVRDIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9DRENFVEhF
UiBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfVVNCTkVUIGlzIG5vdCBzZXQN
CiMgQ09ORklHX1VTQl9VU1M3MjAgaXMgbm90IHNldA0KDQojDQojIFVTQiBT
ZXJpYWwgQ29udmVydGVyIHN1cHBvcnQNCiMNCiMgQ09ORklHX1VTQl9TRVJJ
QUwgaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9HRU5FUklDIGlz
IG5vdCBzZXQNCiMgQ09ORklHX1VTQl9TRVJJQUxfQkVMS0lOIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX1VTQl9TRVJJQUxfV0hJVEVIRUFUIGlzIG5vdCBzZXQN
CiMgQ09ORklHX1VTQl9TRVJJQUxfRElHSV9BQ0NFTEVQT1JUIGlzIG5vdCBz
ZXQNCiMgQ09ORklHX1VTQl9TRVJJQUxfRU1QRUcgaXMgbm90IHNldA0KIyBD
T05GSUdfVVNCX1NFUklBTF9GVERJX1NJTyBpcyBub3Qgc2V0DQojIENPTkZJ
R19VU0JfU0VSSUFMX1ZJU09SIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9T
RVJJQUxfSVBBUSBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfU0VSSUFMX0lS
IGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9TRVJJQUxfRURHRVBPUlQgaXMg
bm90IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1BEQSBpcyBu
b3Qgc2V0DQojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU4gaXMgbm90IHNl
dA0KIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTI4IGlzIG5vdCBz
ZXQNCiMgQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9VU0EyOFggaXMgbm90
IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTI4WEEgaXMg
bm90IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTI4WEIg
aXMgbm90IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VTQTE5
IGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9TRVJJQUxfS0VZU1BBTl9VU0Ex
OFggaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9LRVlTUEFOX1VT
QTE5VyBpcyBub3Qgc2V0DQojIENPTkZJR19VU0JfU0VSSUFMX0tFWVNQQU5f
VVNBNDlXIGlzIG5vdCBzZXQNCiMgQ09ORklHX1VTQl9TRVJJQUxfTUNUX1Uy
MzIgaXMgbm90IHNldA0KIyBDT05GSUdfVVNCX1NFUklBTF9LTFNJIGlzIG5v
dCBzZXQNCiMgQ09ORklHX1VTQl9TRVJJQUxfUEwyMzAzIGlzIG5vdCBzZXQN
CiMgQ09ORklHX1VTQl9TRVJJQUxfQ1lCRVJKQUNLIGlzIG5vdCBzZXQNCiMg
Q09ORklHX1VTQl9TRVJJQUxfWElSQ09NIGlzIG5vdCBzZXQNCiMgQ09ORklH
X1VTQl9TRVJJQUxfT01OSU5FVCBpcyBub3Qgc2V0DQojIENPTkZJR19VU0Jf
UklPNTAwIGlzIG5vdCBzZXQNCg0KIw0KIyBCbHVldG9vdGggc3VwcG9ydA0K
Iw0KIyBDT05GSUdfQkxVRVogaXMgbm90IHNldA0KDQojDQojIEtlcm5lbCBo
YWNraW5nDQojDQpDT05GSUdfREVCVUdfS0VSTkVMPXkNCiMgQ09ORklHX0RF
QlVHX0hJR0hNRU0gaXMgbm90IHNldA0KIyBDT05GSUdfREVCVUdfU0xBQiBp
cyBub3Qgc2V0DQojIENPTkZJR19ERUJVR19JT1ZJUlQgaXMgbm90IHNldA0K
Q09ORklHX01BR0lDX1NZU1JRPXkNCiMgQ09ORklHX0RFQlVHX1NQSU5MT0NL
IGlzIG5vdCBzZXQNCiMgQ09ORklHX0RFQlVHX0JVR1ZFUkJPU0UgaXMgbm90
IHNldA0K
---943504833-2135313262-1015263265=:10999--
