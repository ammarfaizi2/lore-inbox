Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319118AbSIDKWE>; Wed, 4 Sep 2002 06:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319120AbSIDKWE>; Wed, 4 Sep 2002 06:22:04 -0400
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:58106 "EHLO
	mg.homelinux.net") by vger.kernel.org with ESMTP id <S319118AbSIDKWA>;
	Wed, 4 Sep 2002 06:22:00 -0400
Date: Wed, 4 Sep 2002 12:26:06 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: ext3 corruption on 2.4.18 (LVM, vt82c586b, no DMA)
Message-ID: <20020904102605.GB8576@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Message-Flag: If you do not see this message correctly, stop using Outlook.
X-GPG-Fingerprint: 8121 AD32 F00A 8094 748A  6CD0 9157 445D E7A6 D78F
X-GPG-Key: http://ice.dammit.lt/~mgedmin/mg-pgp-key.txt
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There's an old Compaq Deskpro 2000 (Pentium MMX 166 MHz, 384M RAM)
that's being used as an Internet gateway (NAT) and FTP server for about
200 users.  It was previously running that other operating system, and I
helped convert it to Linux (Debian 3.0).

There are three disk drives.  Two and a half are used for a single ext3
filesystem using LVM.  That 140GB partition is only used for FTP.

About 20 hours after mke2fs the first erros started cropping up:

  kernel: EXT3-fs error (device lvm(58,0)): ext3_add_entry: bad entry in di=
rectory #8568833: rec_len %% 4 !=3D 0 - offset=3D0, inode=3D1104134607, rec=
_len=3D16847, name_len=3D207
  kernel: EXT3-fs error (device lvm(58,0)): ext3_add_entry: bad entry in di=
rectory #8568833: rec_len %% 4 !=3D 0 - offset=3D0, inode=3D1104134607, rec=
_len=3D16847, name_len=3D207
  kernel: EXT3-fs error (device lvm(58,0)): ext3_add_entry: bad entry in di=
rectory #8650753: rec_len %% 4 !=3D 0 - offset=3D0, inode=3D1054162645, rec=
_len=3D16093, name_len=3D213
  kernel: EXT3-fs error (device lvm(58,0)): ext3_add_entry: bad entry in di=
rectory #8650753: rec_len %% 4 !=3D 0 - offset=3D0, inode=3D1054162645, rec=
_len=3D16093, name_len=3D213
  kernel: EXT3-fs error (device lvm(58,0)): ext3_add_entry: bad entry in di=
rectory #8650753: rec_len %% 4 !=3D 0 - offset=3D0, inode=3D1503025555, rec=
_len=3D22942, name_len=3D147
  [...]
  kernel: EXT3-fs error (device lvm(58,0)): ext3_readdir: bad entry in dire=
ctory #8847362: rec_len %% 4 !=3D 0 - offset=3D0, inode=3D1861709558, rec_l=
en=3D28414, name_len=3D247
  [...]
  kernel: EXT3-fs warning (device lvm(58,0)): empty_dir: bad directory (dir=
 #8830978) - no `.' or `..'
  kernel: EXT3-fs warning (device lvm(58,0)): ext3_rmdir: empty directory h=
as nlink!=3D2 (3)
  [...]
  kernel: EXT3-fs error (device lvm(58,0)): ext3_readdir: bad entry in dire=
ctory #8683521: rec_len is too small for name_len - offset=3D0, inode=3D113=
05005, rec_len=3D44, name_len=3D45
  kernel: attempt to access beyond end of device
  kernel: 3a:00: rw=3D0, want=3D1123713500, limit=3D154509312
  kernel: attempt to access beyond end of device
  kernel: 3a:00: rw=3D0, want=3D586860000, limit=3D154509312
  [...]

Unfortunately I noticed this only two days later.  e2fsck found *lots*
of errors, and it keeps restarting from the beginning for some reason.
I'm starting to have doubts if it will ever finish.

Is this an unfortunate interaction between ext3 and LVM, or should I
suspect flaky hardware?  RAM, disks, IDE cable?  There were problems
with /dev/hdd earlier that hinted a broken cable (borken model name in
hdparm -i), and the cable was replaced with a new one.

I gather from Configure.help that DMA is broken on Via VP2, but it is
turned off here.  I see only one series of hardware-related messages in
syslog:

  kernel: hda: status timeout: status=3D0xd0 { Busy }
  kernel: hda: no DRQ after issuing WRITE
  kernel: ide0: reset timed-out, status=3D0x80

But these appeared about 4 hours after the first EXT3 error messages.

The kernel comes from a Debian package (2.4.18-586tsc).  LVM also
(lvm10-1:1.0.4-4).

Exceprt from dmesg:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c586b (rev 31) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1408-0x140f, BIOS settings: hdc:DMA, hdd:DMA
hda: IC35L040AVVN07-0, ATA DISK drive
hdc: MAXTOR 6L060J3, ATA DISK drive
hdd: MAXTOR 6L080J4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=3D79780/16/63
hdc: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=3D116336/16/63
hdd: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=3D155114/16/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [PTBL] [5005/255/63] p1 p2 p3 p4
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [7299/255/63] p1 < p5 >
 /dev/ide/host0/bus1/target1/lun0: [PTBL] [9732/255/63] p1

/proc/ide/via:

----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.29
South Bridge:                       VIA vt82c586b
Revision:                           ISA 0x31 IDE 0x6
Highest DMA rate:                   UDMA33
BM-DMA base:                        0x1400
PCI clock:                          33MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:       30ns     120ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      30ns      30ns
Cycle Time:         120ns     600ns     120ns     120ns
Transfer Rate:   16.5MB/s   3.3MB/s  16.5MB/s  16.5MB/s

lspci -v

00:00.0 Host bridge: VIA Technologies, Inc. VT82C595/97 [Apollo VP2/97] (re=
v 03)
        Flags: bus master, 66Mhz, medium devsel, latency 8

00:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev =
10)
        Subsystem: Compex: Unknown device 8139
        Flags: bus master, medium devsel, latency 66, IRQ 11
        I/O ports at 1800 [size=3D256]
        Memory at 44000000 (32-bit, non-prefetchable) [size=3D256]
        Expansion ROM at <unassigned> [disabled] [size=3D64K]
        Capabilities: [50] Power Management version 2

00:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev =
10)
        Subsystem: Compex: Unknown device 8139
        Flags: bus master, medium devsel, latency 66, IRQ 11
        I/O ports at 2000 [size=3D256]
        Memory at 44200000 (32-bit, non-prefetchable) [size=3D256]
        Expansion ROM at <unassigned> [disabled] [size=3D64K]
        Capabilities: [50] Power Management version 2

00:04.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev =
10)
        Subsystem: Compex: Unknown device 8139
        Flags: bus master, medium devsel, latency 66, IRQ 11
        I/O ports at 1c00 [size=3D256]
        Memory at 44100000 (32-bit, non-prefetchable) [size=3D256]
        Expansion ROM at <unassigned> [disabled] [size=3D64K]
        Capabilities: [50] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo =
VP] (rev 31)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog=
-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 66
        I/O ports at 1400 [size=3D16]

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 0=
0 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 66, IRQ 11
        I/O ports at 1420 [size=3D32]

00:07.3 Non-VGA unclassified device: VIA Technologies, Inc. VT82C586B ACPI
        Flags: medium devsel
        I/O ports at 1000 [size=3D256]

00:0f.0 VGA compatible controller: S3 Inc. Trio 64V2/DX or /GX (rev 04) (pr=
og-if 00 [VGA])
        Subsystem: Compaq Computer Corporation: Unknown device b031
        Flags: medium devsel, IRQ 11
        Memory at 40000000 (32-bit, non-prefetchable) [size=3D64M]
        Expansion ROM at <unassigned> [disabled] [size=3D64K]


hdparm -i /dev/hda

/dev/hda:

 Model=3DIC35L040AVVN07-0, FwRev=3DVA2OAG0A, SerialNo=3DVNP210B2R7MVGB
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D52
 BuffType=3DDualPortCache, BuffSize=3D1863kB, MaxMultSect=3D16, MultSect=3D=
off
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D80418240
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4=20
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5=20
 AdvancedPM=3Dyes: disabled (255) WriteCache=3Denabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-=
5=20

hdparm -i /dev/hdc

/dev/hdc:

 Model=3DMAXTOR 6L060J3, FwRev=3DA93.0500, SerialNo=3D663202014354
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D32256, SectSize=3D21298, ECCbytes=3D4
 BuffType=3DDualPortCache, BuffSize=3D1819kB, MaxMultSect=3D16, MultSect=3D=
off
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D117266688
 IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4=20
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6=20
 AdvancedPM=3Dno WriteCache=3Denabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3 ATA-=
4 ATA-5=20

hdparm -i /dev/hdd

/dev/hdd:

 Model=3DMAXTOR 6L080J4, FwRev=3DA93.0500, SerialNo=3D664203751576
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D32256, SectSize=3D21298, ECCbytes=3D4
 BuffType=3DDualPortCache, BuffSize=3D1819kB, MaxMultSect=3D16, MultSect=3D=
off
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D156355584
 IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4=20
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 udma6=20
 AdvancedPM=3Dno WriteCache=3Denabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3 ATA-=
4 ATA-5=20


Marius Gedminas
--=20
This host is a black hole at HTTP wavelengths. GETs go in, and nothing
comes out, not even Hawking radiation.
		-- Graaagh the Mighty on rec.games.roguelike.angband

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9dd+9kVdEXeem148RAp6EAJ9BpMCvT2Fu5R5f+kF2QXxzqbY4jgCfb8Vu
71bTZcBPIDSLeHWciAm5qLo=
=KlE6
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
