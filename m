Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbQKPBTN>; Wed, 15 Nov 2000 20:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQKPBTD>; Wed, 15 Nov 2000 20:19:03 -0500
Received: from rom.oit.gatech.edu ([130.207.167.32]:62110 "EHLO
	rom.oit.gatech.edu") by vger.kernel.org with ESMTP
	id <S129415AbQKPBS4>; Wed, 15 Nov 2000 20:18:56 -0500
Date: Wed, 15 Nov 2000 19:48:56 -0500
From: Will Day <willday@rom.oit.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: Can't get UDMA to work...
Message-ID: <20001115194856.A27996@rom.oit.gatech.edu>
Reply-To: Will Day <willday@rom.oit.gatech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="d6Gm4EdcadzBjdND"; micalg=pgp-md5;
	protocol="application/pgp-signature"
User-Agent: Mutt/1.1.2i
X-no-archive: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

I just picked up a 13gb Western Digital drive to put in a linux machine,
but am having difficulty getting it to use UDMA.  On bootup, it reports:

   Partition check:
    sda: sda1 sda2
    hda:hda: timeout waiting for DMA
   hda: irq timeout: status=3D0x58 { DriveReady SeekComplete DataRequest }
   hda: timeout waiting for DMA
   hda: irq timeout: status=3D0x58 { DriveReady SeekComplete DataRequest }
   hda: timeout waiting for DMA
   hda: irq timeout: status=3D0x58 { DriveReady SeekComplete DataRequest }
   hda: timeout waiting for DMA
   hda: irq timeout: status=3D0x58 { DriveReady SeekComplete DataRequest }
   hda: DMA disabled
   ide0: reset: success
    hda1 hda2

The system was installed on a borrowed scsi disk, so it's booting the
system fine; the goal is to move the system to the IDE disk, but first I
want to get it talking to the disk properly.  After boot, 'hdparm /dev/hda'
reports:

   /dev/hda:
    multcount    =3D 16 (on)
    I/O support  =3D  0 (default 16-bit)
    unmaskirq    =3D  0 (off)
    using_dma    =3D  0 (off)
    keepsettings =3D  0 (off)
    nowerr       =3D  0 (off)
    readonly     =3D  0 (off)
    readahead    =3D  8 (on)
    geometry     =3D 1662/255/63, sectors =3D 26712000, start =3D 0

Trying to enable DMA with "hdparm -d1" at this point also produces the
timeout errors.

I read over the Ultra-DMA Mini-Howto, and applied the ide patch to the
kernel (2.2.17), with these options:

   CONFIG_BLK_DEV_IDE=3Dy
   # CONFIG_BLK_DEV_HD_IDE is not set
   CONFIG_BLK_DEV_IDEDISK=3Dy
   # CONFIG_BLK_DEV_IDETAPE is not set
   # CONFIG_BLK_DEV_IDEFLOPPY is not set
   # CONFIG_BLK_DEV_IDESCSI is not set
   CONFIG_BLK_DEV_IDEPCI=3Dy
   CONFIG_IDEPCI_SHARE_IRQ=3Dy
   CONFIG_BLK_DEV_IDEDMA=3Dy
   CONFIG_IDEDMA_AUTO=3Dy
   CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=3Dy
   CONFIG_IDEDMA_PCI_EXPERIMENTAL=3Dy
   # CONFIG_IDEDMA_PCI_WIP is not set
   CONFIG_BLK_DEV_PIIX=3Dy
   CONFIG_PIIX_TUNING=3Dy
   # CONFIG_IDEDMA_IVB is not set
   # CONFIG_IDE_CHIPSETS is not set
   CONFIG_BLK_DEV_IDE_MODES=3Dy

It still gives the above errors, now with an additional message:

   ide_dmaproc: chipset supported ide_dma_timeout func only: 14

I also downloaded and ran the utility from the WD website (wd_ata66.exe), to
switch the drive from UDMA/66 to only UDMA/33, since the BX-based BH6
motherboard only supports 33.  That didn't seem to make any difference.

I also tried disabling UDMA, as well as setting PIO modes, in the BH6 bios,
but this didn't seem to make any difference.  I was overclocking the system
bus, so I set it back to 100MHz, but that didn't seem to make any
difference either.

Other ide messages from boot:
   Uniform Multi-Platform E-IDE driver Revision: 6.30
   ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=
=3Dxx
   PIIX4: IDE controller on PCI bus 00 dev 39
   PIIX4: chipset revision 1
   PIIX4: not 100% native mode: will probe irqs later
       ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
       ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
   hda: WDC AC313600D, ATA DISK drive
   hdb: CD620E, ATAPI CDROM drive
   ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
   hda: WDC AC313600D, 13042MB w/1966kB Cache, CHS=3D1662/255/63, UDMA(33)
   hdb: ATAPI 5X CD-ROM drive, 240kB Cache

And from 'hdparm -i /dev/hda':
   Model=3DWDC AC313600D, FwRev=3DJ7JOA30K, SerialNo=3DWD-WT6710449014
   Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
   RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D34
   BuffType=3DDualPortCache, BuffSize=3D1966kB, MaxMultSect=3D16, MultSect=
=3D16
   CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D26712000
   IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
   PIO modes: pio0 pio1 pio2 pio3 pio4=20
   DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2=20

And from 'hdparm -I /dev/hda':
   Model=3DCA136300 D                      , FwRev=3D3AK0DW C, SerialNo=3D6=
T17409410 4
   Config=3D{ }
   RawCHS=3D16/0/0, TrkSize=3D63, SectSize=3D0, ECCbytes=3D19023
   BuffType=3D34, BuffSize=3D9499kB, MaxMultSect=3D0
   (maybe): CurCHS=3D63/64528/251, CurSects=3D-1749024496, LBA=3Dyes, LBAse=
cts=3D458752
   IORDY=3Dno
   PIO modes: pio0=20
   DMA modes:=20

And, from 'lspci':
   00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge=
 (rev 03)
   00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (=
rev 03)
   00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
   00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
   00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
   00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
   00:09.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c87=
5 (rev 26)
   00:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
   00:0d.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
   00:0f.0 VGA compatible controller: Alliance Semiconductor Corporation Pr=
oMotion AT3D (rev 02)

And, from /proc/interrupts:
              CPU0      =20
     0:     132975          XT-PIC  timer
     1:          2          XT-PIC  keyboard
     2:          0          XT-PIC  cascade
     4:       1297          XT-PIC  serial
     8:          1          XT-PIC  rtc
    10:      46786          XT-PIC  eth0
    12:      19420          XT-PIC  sym53c8xx, PS/2 Mouse
    13:          1          XT-PIC  fpu
    14:         12          XT-PIC  ide0
    15:          7          XT-PIC  ide1
   NMI:          0

And from /proc/ide/drivers:
   ide-cdrom version 4.58
   ide-disk version 1.09

And from /proc/ide/piix:
                                 Intel PIIX4 Ultra 33 Chipset.
   ------------- Primary Channel ---------------- Secondary Channel -------=
----
                  enabled                          enabled
   ------------- drive0 --------- drive1 -------- drive0 ---------- drive1 =
----
   DMA enabled:    no               no              yes               no=20
   UDMA enabled:   yes              no              no                no=20
   UDMA enabled:   2                X               X                 X
   UDMA
   DMA
   PIO

Right now, I'm kinda at a loss - I'm not sure what else to try.  I did some
searching on dejanews and of various HTML archives of the linux-kernel list,
but couldn't find any solutions that seemed to apply.

Also, I'm really more familiar with SCSI - the only IDE drives I've ever had
before now were 2gb or less - so I really know little to nothing about these
new-fangled PIO and UDMA things. :)  Thus, I may be missing something obvio=
us.

Any hints would be appreciated.

Thanks,
--=20
Will Day     <PGP mail preferred>     OIT / O&E / Technical Support
willday@rom.oit.gatech.edu            Georgia Tech, Atlanta 30332-0715
  -> Opinions expressed are mine alone and do not reflect OIT policy <-
Those who would give up essential Liberty, to purchase a little temporary
Safety, deserve neither Liberty nor Safety.
    Benjamin Franklin, Pennsylvania Assembly, Nov. 11, 1755

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.2 (Solaris)
Comment: http://rom.oit.gatech.edu/~willday/pubkey.asc

iQCVAwUBOhMu9xDHlOdPw2ZdAQEI7QQAon4xlQl8hHj2S2K+C+y6HgA1fD2j2vum
jf9RNqzCO7aKYrVdcXkaKaH4n3c3SpPTwhN9oG/BA4G72HJdtdWSQxmn2/gEH9l6
WQKm15l9lw6l5zAUVy5JdHPl1HYuo9usFSrpoFKmH2UfXYbJGFPkwhypqzQwq4W3
rGs8Ju70Hfg=
=Yif6
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
