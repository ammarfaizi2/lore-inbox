Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265729AbUFOPst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265729AbUFOPst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 11:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265727AbUFOPst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 11:48:49 -0400
Received: from mail.riseup.net ([216.162.217.191]:8388 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S265732AbUFOPsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 11:48:32 -0400
Date: Tue, 15 Jun 2004 10:47:45 -0500
From: Micah Anderson <micah@riseup.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.6 grinds to a halt with moderate I/O
Message-ID: <20040615154745.GD22650@riseup.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Following the format from REPORTING-BUGS please see the below information.
I unfortunately cannot subscribe to the list, but will follow the thread. I
have searched high and low, read a number of threads somewhat tangential to
this problem, and asked a few times in #kernelnewbies before I got to my
wits end and now will try here. I really appreciate any insight anyone has,
and will be happy to provide more information or additional tests

1. When doing moderate I/O on a 2.6.6 system the machine becomes unusable.

2. I found that with HIGHMEM support compiled into the kernel, when I did a
cp -vr /var /usr/tmp it would work fine until it got about halfway through =
the=20
large ldap.log file (approximately 500 megs) when the system would no longer
be able to fork new processes. Your existing shell would function, but
if you tried to run top, free, etc. it would hang. vmstat 1 would print
the first line, but never continue. I ran a million different kernel configs
to try and isolate things, and I thought I had it nailed down with passing
apic=3Doff to the kernel at boot because the large logfile copy test would
pass, but when rsyncing maildirs tonight the same problem appeared. Early
in my tests I thought the problem was dm-crypt, but the problem existed
even when no encrypted filesystems were involved, and existed when I
removed dm-crypt support from the kernel. Disabling HIGHMEM support seems
to make the problem go away.

Machine requires a powercycle to get it back. Memory was memtested for over
24 hours. Machine is a HP netserver lh1000r with megaraid controller, no ID=
E.

3. kernel, i/o

4. Linux version 2.6.6 (root@willow) (gcc version 3.3.3 (Debian 20040422)) =
#9 SMP Fri Jun 11 17:43:06 PDT 2004
=20
5. No oops available

6. see above for reproducable test

7.  Environment

7.1 Linux willow 2.6.6 #9 SMP Fri Jun 11 17:43:06 PDT 2004 i686 GNU/Linux
=20
Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre10
e2fsprogs              1.35
PPP                    2.4.2
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91

7.2 cat /proc/cpuinfo=20
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 6
cpu MHz         : 933.936
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov=20
pat pse36 mmx fxsr sse
bogomips        : 1843.20

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 933.936
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov=20
pat pse36 mmx fxsr sse
bogomips        : 1863.68

7.3 No module support in kernel

7.4 cat /proc/ioports=20
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1400-14ff : 0000:00:07.0
1800-183f : 0000:00:02.0
  1800-183f : e100
1840-187f : 0000:00:08.0
  1840-187f : e100
1880-188f : 0000:00:0f.1
2000-20ff : 0000:01:05.0
2400-24ff : 0000:01:05.1
3000-3fff : PCI Bus #02
  3000-30ff : 0000:02:01.0

cat /proc/iomem=20
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ca7ff : Video ROM
000ca800-000cbfff : Adapter ROM
000cc000-000cd7ff : Adapter ROM
000cd800-000cdfff : Adapter ROM
000ce000-000cfdff : Adapter ROM
000f0000-000fffff : System ROM
00100000-7fffffff : System RAM
  00100000-002f88b1 : Kernel code
  002f88b2-0038725f : Kernel data
e8001000-e8001fff : 0000:00:02.0
  e8001000-e8001fff : e100
e8002000-e8002fff : 0000:00:07.0
e8003000-e8003fff : 0000:00:08.0
  e8003000-e8003fff : e100
e8004000-e8004fff : 0000:00:0f.2
e8100000-e81fffff : 0000:00:02.0
  e8100000-e81fffff : e100
e8200000-e82fffff : 0000:00:08.0
  e8200000-e82fffff : e100
e9000000-e9ffffff : 0000:00:07.0
ea000000-ea001fff : 0000:01:05.0
ea002000-ea003fff : 0000:01:05.1
ea004000-ea0043ff : 0000:01:05.0
ea004400-ea0047ff : 0000:01:05.1
ea100000-ea1fffff : PCI Bus #02
  ea100000-ea100fff : 0000:02:01.0
f0000000-f7ffffff : PCI Bus #02
  f0000000-f7ffffff : PCI Bus #03
    f0000000-f7ffffff : 0000:03:00.0
      f0000000-f000007f : megaraid
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved


7.5 lspci -vvv=20

0000:00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort+ >SERR- <PERR-
	Latency: 48, Cache Line Size: 0x08 (32 bytes)

0000:00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)

0000:00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 08)
	Subsystem: Hewlett-Packard Company NetServer 10/100TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at e8001000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 1800 [size=3D64]
	Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=3D1M]
	Capabilities: <available only to root>

0000:00:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 6=
5) (prog-if 00 [VGA])
	Subsystem: Hewlett-Packard Company: Unknown device 10e1
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Region 0: Memory at e9000000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 1400 [size=3D256]
	Region 2: Memory at e8002000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: <available only to root>

0000:00:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] =
(rev 08)
	Subsystem: Hewlett-Packard Company NetServer 10/100TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 23
	Region 0: Memory at e8003000 (32-bit, non-prefetchable)
	Region 1: I/O ports at 1840 [size=3D64]
	Region 2: Memory at e8200000 (32-bit, non-prefetchable) [size=3D1M]
	Capabilities: <available only to root>

0000:00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
	Subsystem: ServerWorks OSB4 South Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Steppi=
ng- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR+ <PERR-
	Latency: 0

0000:00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Ma=
ster SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 1880 [size=3D16]

0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev=
 04) (prog-if 10 [OHCI])
	Subsystem: ServerWorks OSB4/CSB5 OHCI USB Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 33
	Region 0: Memory at e8004000 (32-bit, non-prefetchable)

0000:01:02.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge (prog-if 00 [N=
ormal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D01, secondary=3D02, subordinate=3D03, sec-latency=3D36
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: ea100000-ea1fffff
	Prefetchable memory behind bridge: 00000000f0000000-00000000f7f00000
	Expansion ROM at 00003000 [disabled] [size=3D4K]
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:01:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ult=
ra3 SCSI Adapter (rev 01)
	Subsystem: Hewlett-Packard Company: Unknown device 60b0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 4500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at 2000
	Region 1: Memory at ea004000 (64-bit, non-prefetchable) [size=3D1K]
	Region 3: Memory at ea000000 (64-bit, non-prefetchable) [size=3D8K]
	Capabilities: <available only to root>

0000:01:05.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ult=
ra3 SCSI Adapter (rev 01)
	Subsystem: Hewlett-Packard Company: Unknown device 60b0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 4500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 25
	Region 0: I/O ports at 2400
	Region 1: Memory at ea004400 (64-bit, non-prefetchable) [size=3D1K]
	Region 3: Memory at ea002000 (64-bit, non-prefetchable) [size=3D8K]
	Capabilities: <available only to root>

0000:02:00.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge (prog-if 00 [N=
ormal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D02, secondary=3D03, subordinate=3D03, sec-latency=3D36
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: 00000000f0000000-00000000f7f00000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:02:01.0 SCSI storage controller: QLogic Corp. ISP12160 Dual Channel Ul=
tra3 SCSI Processor (rev 06)
	Subsystem: American Megatrends Inc. QLA12160 on AMI MegaRAID
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Steppi=
ng- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 29
	Region 0: I/O ports at 3000
	Region 1: Memory at ea100000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: <available only to root>

0000:03:00.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 25)
	Subsystem: Hewlett-Packard Company: Unknown device 60e8
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Steppi=
ng- SERR+ FastB2B+
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f0000000 (32-bit, prefetchable)
	Capabilities: <available only to root>

7.6 cat  /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD 0 RAID5  140G Rev:   K=20
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 05 Id: 11 Lun: 00
  Vendor: SDR      Model: GEM318           Rev: 0  =20
  Type:   Processor                        ANSI SCSI revision: 02
micah@willow:/tmp$=20

7.7 Machine is a HP netserver lh1000r with megaraid controller, no IDE.



--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzxoh9n4qXRzy1ioRAiKnAJ9qRQNL96pva1j9fgB3pXjAgO++WACfZAnD
ev5tgs/oTJyT4QBNk7fPFLo=
=VXjZ
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
