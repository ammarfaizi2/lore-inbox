Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbSKTBi5>; Tue, 19 Nov 2002 20:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267537AbSKTBi5>; Tue, 19 Nov 2002 20:38:57 -0500
Received: from dc-mx01.cluster1.charter.net ([209.225.8.11]:42440 "EHLO
	dc-mx01.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S267524AbSKTBis>; Tue, 19 Nov 2002 20:38:48 -0500
Message-ID: <000e01c29036$8bdc2790$420aa8c0@beast>
From: "Raptorfan" <raptorfan@earthlink.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>, <linux-kernel@vger.kernel.org>
References: <001b01c28ff8$61ad1670$420aa8c0@beast> <1604970000.1037732321@aslan.btc.adaptec.com>
Subject: Re: aic7xxx driver failing (2.4.19-ac4)
Date: Tue, 19 Nov 2002 20:45:46 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000B_01C2900C.A2B6C710"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C2900C.A2B6C710
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

From: "Justin T. Gibbs" <gibbs@scsiguy.com>
> Can you try to update your system with the driver version here:
> http://people.freebsd.org/~gibbs/linux/tarballs/aic79xx-linux-2.4.tar.gz
> The files are for the latest linux-2.4 tree, but should be easily
> modified to work with the kernel you are using.

A slight improvement: the kernel no longer oopses but still never completely
makes it thru boot.

I've attached the dmesg from the box at boot with the drivers compiled
in-kernel. The card appears to be detected, it appears to go through the IDs
and does find my devices but hangs after the last message. If I build the
driver as a module, the insmod hangs loading the module. Switching to
another terminal and viewing dmesg output show a similar message as
attached, except in this order:

- detection of the card ("scsi0: Adaptec AIC7XXX" etc etc)
- detection of the devices ("host 0 channel 0 id 2 lun 0\n  Vendor:HP" etc
etc)
- ONE instance of the failed detection message

I waited for ~ 5 minutes before deciding the detection was dead and
rebooted. insmod was the still hung and a 'lsmod' showed the aic7xxx driver
stuck as '(initializing).'

.. but at least there's no more oops. :)

Also, I find it interesting my dat drive is discovered as ID2.. when it's
ID3. This is confirmed by visual check, the adaptec card's boot detection
and $OTHER_OS using the drive. The Zipdrive is at ID6 (and appears to be
detected correctly.

-r

ps.. thanks for the help so far.

------=_NextPart_000_000B_01C2900C.A2B6C710
Content-Type: text/plain;
	name="dmesg2.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg2.txt"

Linux version 2.4.19-ac4 (root@otus) (gcc version 2.95.3 20010315 =
(release)) #40 Tue Nov 19 16:08:28 EST 2002=0D
=0DBIOS-provided physical RAM map:=0D
=0D BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)=0D
=0D BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)=0D
=0D BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)=0D
=0D BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)=0D
=0D BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)=0D
=0D BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)=0D
=0D BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)=0D
=0D511MB LOWMEM available.=0D
=0DOn node 0 totalpages: 131056=0D
=0Dzone(0): 4096 pages.=0D
=0Dzone(1): 126960 pages.=0D
=0Dzone(2): 0 pages.=0D
=0DKernel command line: BOOT_IMAGE=3DLinux-Serial ro root=3D303 =
hdd=3Dide-scsi console=3DttyS0,38400 console=3Dtty0=0D
=0Dide_setup: hdd=3Dide-scsi=0D
=0DLocal APIC disabled by BIOS -- reenabling.=0D
=0DFound and enabled local APIC!=0D
=0DInitializing CPU#0=0D
=0DDetected 798.111 MHz processor.=0D
=0DConsole: colour VGA+ 80x50=0D
=0DCalibrating delay loop... 1592.52 BogoMIPS=0D
=0DMemory: 515328k/524224k available (1017k kernel code, 8508k reserved, =
467k data, 88k init, 0k highmem)=0D
=0DDentry cache hash table entries: 65536 (order: 7, 524288 bytes)=0D
=0DInode cache hash table entries: 32768 (order: 6, 262144 bytes)=0D
=0DMount cache hash table entries: 512 (order: 0, 4096 bytes)=0D
=0DBuffer cache hash table entries: 32768 (order: 5, 131072 bytes)=0D
=0DPage-cache hash table entries: 131072 (order: 7, 524288 bytes)=0D
=0DCPU: L1 I cache: 16K, L1 D cache: 16K=0D
=0DCPU: L2 cache: 256K=0D
=0DIntel machine check architecture supported.=0D
=0DIntel machine check reporting enabled on CPU#0.=0D
=0DCPU: Intel Pentium III (Coppermine) stepping 06=0D
=0DEnabling fast FPU save and restore... done.=0D
=0DEnabling unmasked SIMD FPU exception support... done.=0D
=0DChecking 'hlt' instruction... OK.=0D
=0DPOSIX conformance testing by UNIFIX=0D
=0Denabled ExtINT on CPU#0=0D
=0DESR value before enabling vector: 00000000=0D
=0DESR value after enabling vector: 00000000=0D
=0DUsing local APIC timer interrupts.=0D
=0Dcalibrating APIC timer ...=0D
=0D..... CPU clock speed is 797.9774 MHz.=0D
=0D..... host bus clock speed is 132.9961 MHz.=0D
=0Dcpu: 0, clocks: 1329961, slice: 664980=0D
=0DCPU0<T0:1329952,T1:664960,D:12,S:664980,C:1329961>=0D
=0Dmtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)=0D
=0Dmtrr: detected mtrr type: Intel=0D
=0DPCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=3D1=0D
=0DPCI: Using configuration type 1=0D
=0DPCI: Probing PCI hardware=0D
=0DPCI: Using IRQ router VIA [1106/0686] at 00:07.0=0D
=0DPCI: Disabling Via external APIC routing=0D
=0DLinux NET4.0 for Linux 2.4=0D
=0DBased upon Swansea University Computer Society NET3.039=0D
=0DInitializing RT netlink socket=0D
=0DStarting kswapd=0D
=0Dpty: 512 Unix98 ptys configured=0D
=0DSerial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ =
SERIAL_PCI enabled=0D
=0DttyS00 at 0x03f8 (irq =3D 4) is a 16550A=0D
=0DttyS01 at 0x02f8 (irq =3D 3) is a 16550A=0D
=0Dblock: 992 slots per queue, batch=3D248=0D
=0DUniform Multi-Platform E-IDE driver Revision: 6.31=0D
=0Dide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0D
=0DVP_IDE: IDE controller on PCI bus 00 dev 39=0D
=0DVP_IDE: chipset revision 16=0D
=0DVP_IDE: not 100% native mode: will probe irqs later=0D
=0DVP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1=0D
=0D    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA=0D
=0D    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA=0D
=0DAEC6880R: IDE controller on PCI bus 00 dev 68=0D
=0DPCI: Found IRQ 7 for device 00:0d.0=0D
=0DAEC6880R: chipset revision 2=0D
=0DAEC6880R: not 100% native mode: will probe irqs later=0D
=0DAEC6880R: ROM enabled at 0xdffc0000=0D
=0D    ide2: BM-DMA at 0xb800-0xb807, BIOS settings: hde:pio, hdf:pio=0D
=0D    ide3: BM-DMA at 0xb808-0xb80f, BIOS settings: hdg:pio, hdh:pio=0D
=0Dhda: Maxtor 52049H3, ATA DISK drive=0D
=0Dhdb: WDC AC313000R, ATA DISK drive=0D
=0Dhdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive=0D
=0Dhdd: LG CD-RW CED-8120B, ATAPI CD/DVD-ROM drive=0D
=0Dhdf: MAXTOR 6L060J3, ATA DISK drive=0D
=0Dide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0D
=0Dide1 at 0x170-0x177,0x376 on irq 15=0D
=0Dide2 at 0xc800-0xc807,0xc402 on irq 7=0D
=0Dhda: host protected area =3D> 1=0D
=0Dhda: 40021632 sectors (20491 MB) w/2048KiB Cache, CHS=3D2491/255/63, =
UDMA(66)=0D
=0Dhdb: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error =
}
hdb: task_no_data_intr: error=3D0x04 { DriveStatusError }
hdb: host protected area =3D> 1
hdb: 25429824 sectors (13020 MB) w/512KiB Cache, CHS=3D1582/255/63, =
(U)DMA
hdf: host protected area =3D> 1
hdf: 117266688 sectors (60041 MB) w/1819KiB Cache, CHS=3D116336/16/63, =
UDMA(133)
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
hda: hda1 hda2 hda3
hdb: hdb1 hdb2
 hdf: hdf1 hdf2 hdf3 hdf4 < hdf5 hdf6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
SCSI subsystem driver Revision: 1.00
PCI: Found IRQ 9 for device 00:0c.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.21
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=3D7, 16/253 SCBs

(scsi0:A:3): 10.000MB/s transfers (10.000MHz, offset 8)
scsi0:0:1:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x18
ACCUM =3D 0x3, SINDEX =3D 0x20, DINDEX =3D 0xc0, ARG_2 =3D 0x0
HCNT =3D 0x0 SCBPTR =3D 0x2
SCSIPHASE[0x0] SCSIBUSL[0x0] LASTPHASE[0x1] SCSISEQ[0x12]=20
SBLKCTL[0x2] SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0]=20
SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4]=20
SXFRCTL0[0x80] DFCNTRL[0x4] DFSTATUS[0x6d]=20
STACK:
SCB count =3D 4
Kernel NEXTQSCB =3D 3
Card NEXTQSCB =3D 2
QINFIFO entries: 2=20
Waiting Queue entries:=20
Disconnected Queue entries:=20
QOUTFIFO entries:=20
Sequencer Free SCB List: 2 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1=20
Sequencer SCB Info:=20
  0 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  2 SCB_CONTROL[0x0] SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff]=20
  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]=20
Pending list:=20
  2 SCB_CONTROL[0x40] SCB_SCSIID[0x17] SCB_LUN[0x0]=20
Kernel Free SCB list: 1 0=20
Untagged Q(1): 2=20
DevQ(0:1:0): 0 waiting
DevQ(0:3:0): 0 waiting
scsi0:0:1:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002
scsi0:0:1:0: Attempting to queue a TARGET RESET message
scsi0:0:1:0: Is not an active device
aic7xxx_dev_reset returns 0x2002
scsi0:0:1:0: Attempting to queue an ABORT message
scsi0: Dumping Card State while idle, at SEQADDR 0x18
ACCUM =3D 0x2, SINDEX =3D 0x20, DINDEX =3D 0xc0, ARG_2 =3D 0x0
HCNT =3D 0x0 SCBPTR =3D 0x2
SCSIPHASE[0x0] SCSIBUSL[0x0] LASTPHASE[0x1] SCSISEQ[0x12]=20
SBLKCTL[0x2] SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0]=20
SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4]=20
SXFRCTL0[0x80] DFCNTRL[0x4] DFSTATUS[0x6d]=20
STACK:
SCB count =3D 4
Kernel NEXTQSCB =3D 2
Card NEXTQSCB =3D 3
QINFIFO entries: 3=20
Waiting Queue entries:=20
Disconnected Queue entries:=20
QOUTFIFO entries:=20
Sequencer Free SCB List: 2 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0  1 0 =
1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 =
1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 =
1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 =
1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 =
1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 =
1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 =
1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =0D
=0DSequencer SCB Info: =0D
=0D  0 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  2 SCB_CONTROL[0x0] SCB_SCSIID[0x17] SCB_LUN[0x0] SCB_TAG[0xff] =0D
=0D  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0DPending list: =0D
=0D  3 SCB_CONTROL[0x50] SCB_SCSIID[0x17] SCB_LUN[0x0] =0D
=0DKernel Free SCB list: 1 0 =0D
=0DUntagged Q(1): 3 =0D
=0DDevQ(0:1:0): 0 waiting=0D
=0DDevQ(0:3:0): 0 waiting=0D
=0Dscsi0:0:1:0: Cmd aborted from QINFIFO=0D
=0Daic7xxx_abort returns 0x2002=0D
=0Dscsi: device set offline - not ready or command retry failed after =
bus reset: host 0 channel 0 id 1 lun 0=0D
=0Dscsi0:0:2:0: Attempting to queue an ABORT message=0D
=0Dscsi0: Dumping Card State while idle, at SEQADDR 0x18=0D
=0DACCUM =3D 0x3, SINDEX =3D 0x20, DINDEX =3D 0xc0, ARG_2 =3D 0x0=0D
=0DHCNT =3D 0x0 SCBPTR =3D 0x2=0D
=0DSCSIPHASE[0x0] SCSIBUSL[0x0] LASTPHASE[0x1] SCSISEQ[0x12] =0D
=0DSBLKCTL[0x2] SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0] =0D
=0DSSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4] =0D
=0DSXFRCTL0[0x80] DFCNTRL[0x4] DFSTATUS[0x6d] =0D
=0DSTACK:=0D
=0DSCB count =3D 4=0D
=0DKernel NEXTQSCB =3D 3=0D
=0DCard NEXTQSCB =3D 2=0D
=0DQINFIFO entries: 2 =0D
=0DWaiting Queue entries: =0D
=0DDisconnected Queue entries: =0D
=0DQOUTFIFO entries: =0D
=0DSequencer Free SCB List: 2 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =0D
=0DSequencer SCB Info: =0D
=0D  0 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  2 SCB_CONTROL[0x0] SCB_SCSIID[0x17] SCB_LUN[0x0] SCB_TAG[0xff] =0D
=0D  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0DPending list: =0D
=0D  2 SCB_CONTROL[0x40] SCB_SCSIID[0x27] SCB_LUN[0x0] =0D
=0DKernel Free SCB list: 1 0 =0D
=0DUntagged Q(2): 2 =0D
=0DDevQ(0:2:0): 0 waiting=0D
=0DDevQ(0:3:0): 0 waiting=0D
=0Dscsi0:0:2:0: Cmd aborted from QINFIFO=0D
=0Daic7xxx_abort returns 0x2002=0D
=0Dscsi0:0:2:0: Attempting to queue a TARGET RESET message=0D
=0Dscsi0:0:2:0: Is not an active device=0D
=0Daic7xxx_dev_reset returns 0x2002=0D
=0Dscsi0:0:2:0: Attempting to queue an ABORT message=0D
=0Dscsi0: Dumping Card State while idle, at SEQADDR 0x18=0D
=0DACCUM =3D 0x2, SINDEX =3D 0x20, DINDEX =3D 0xc0, ARG_2 =3D 0x0=0D
=0DHCNT =3D 0x0 SCBPTR =3D 0x2=0D
=0DSCSIPHASE[0x0] SCSIBUSL[0x0] LASTPHASE[0x1] SCSISEQ[0x12] =0D
=0DSBLKCTL[0x2] SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0] =0D
=0DSSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4] =0D
=0DSXFRCTL0[0x80] DFCNTRL[0x4] DFSTATUS[0x6d] =0D
=0DSTACK:=0D
=0DSCB count =3D 4=0D
=0DKernel NEXTQSCB =3D 2=0D
=0DCard NEXTQSCB =3D 3=0D
=0DQINFIFO entries: 3 =0D
=0DWaiting Queue entries: =0D
=0DDisconnected Queue entries: =0D
=0DQOUTFIFO entries: =0D
=0DSequencer Free SCB List: 2 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =0D
=0DSequencer SCB Info: =0D
=0D  0 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  2 SCB_CONTROL[0x0] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0xff] =0D
=0D  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0DPending list: =0D
=0D  3 SCB_CONTROL[0x50] SCB_SCSIID[0x27] SCB_LUN[0x0] =0D
=0DKernel Free SCB list: 1 0 =0D
=0DUntagged Q(2): 3 =0D
=0DDevQ(0:2:0): 0 waiting=0D
=0DDevQ(0:3:0): 0 waiting=0D
=0Dscsi0:0:2:0: Cmd aborted from QINFIFO=0D
=0Daic7xxx_abort returns 0x2002=0D
=0Dscsi0:0:2:0: Attempting to queue an ABORT message=0D
=0Dscsi0: Dumping Card State while idle, at SEQADDR 0x18=0D
=0DACCUM =3D 0x2, SINDEX =3D 0x20, DINDEX =3D 0xc0, ARG_2 =3D 0x0=0D
=0DHCNT =3D 0x0 SCBPTR =3D 0x2=0D
=0DSCSIPHASE[0x0] SCSIBUSL[0x0] LASTPHASE[0x1] SCSISEQ[0x12] =0D
=0DSBLKCTL[0x2] SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0] =0D
=0DSSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4] =0D
=0DSXFRCTL0[0x80] DFCNTRL[0x4] DFSTATUS[0x6d] =0D
=0DSTACK:=0D
=0DSCB count =3D 4=0D
=0DKernel NEXTQSCB =3D 2=0D
=0DCard NEXTQSCB =3D 3=0D
=0DQINFIFO entries: 3 =0D
=0DWaiting Queue entries: =0D
=0DDisconnected Queue entries: =0D
=0DQOUTFIFO entries: =0D
=0DSequencer Free SCB List: 2 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =0D
=0DSequencer SCB Info: =0D
=0D  0 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  2 SCB_CONTROL[0x0] SCB_SCSIID[0x27] SCB_LUN[0x0] SCB_TAG[0xff] =0D
=0D  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0DPending list: =0D
=0D  3 SCB_CONTROL[0x50] SCB_SCSIID[0x27] SCB_LUN[0x0] =0D
=0DKernel Free SCB list: 1 0 =0D
=0DUntagged Q(2): 3 =0D
=0DDevQ(0:2:0): 0 waiting=0D
=0DDevQ(0:3:0): 0 waiting=0D
=0Dscsi0:0:2:0: Cmd aborted from QINFIFO=0D
=0Daic7xxx_abort returns 0x2002=0D
=0Dscsi: device set offline - not ready or command retry failed after =
bus reset: host 0 channel 0 id 2 lun 0=0D
=0D  Vendor: HP        Model: C1533A            Rev: 9608=0D
=0D  Type:   Sequential-Access                  ANSI SCSI revision: =
02=0D
=0Dscsi0:0:6:0: Attempting to queue an ABORT message=0D
=0Dscsi0: Dumping Card State while idle, at SEQADDR 0x18=0D
=0DACCUM =3D 0x3, SINDEX =3D 0x20, DINDEX =3D 0xc0, ARG_2 =3D 0x0=0D
=0DHCNT =3D 0x0 SCBPTR =3D 0x2=0D
=0DSCSIPHASE[0x0] SCSIBUSL[0x0] LASTPHASE[0x1] SCSISEQ[0x12] =0D
=0DSBLKCTL[0x2] SEQCTL[0x10] SEQ_FLAGS[0xc0] SSTAT0[0x0] =0D
=0DSSTAT1[0x2] SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4] =0D
=0DSXFRCTL0[0x80] DFCNTRL[0x4] DFSTATUS[0x6d] =0D
=0DSTACK:=0D
=0DSCB count =3D 4=0D
=0DKernel NEXTQSCB =3D 3=0D
=0DCard NEXTQSCB =3D 2=0D
=0DQINFIFO entries: 2 =0D
=0DWaiting Queue entries: =0D
=0DDisconnected Queue entries: =0D
=0DQOUTFIFO entries: =0D
=0DSequencer Free SCB List: 2 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =
0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 =0D
=0DSequencer SCB Info: =0D
=0D  0 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  2 SCB_CONTROL[0x0] SCB_SCSIID[0x57] SCB_LUN[0x0] SCB_TAG[0xff] =0D
=0D  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0D 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] =0D
=0DPending list: =0D
=0D  2 SCB_CONTROL[0x40] SCB_SCSIID[0x67] SCB_LUN[0x0] =0D
=0DKernel Free SCB list: 1 0 =0D
=0DUntagged Q(6): 2 =0D
=0DDevQ(0:3:0): 0 waiting=0D
=0DDevQ(0:6:0): 0 waiting=0D
=0Dscsi0:0:6:0: Cmd aborted from QINFIFO=0D
=0Daic7xxx_abort returns 0x2002=0D
=0D(scsi0:A:6:0): refuses WIDE negotiation.  Using 8bit transfers=0D
=0D(scsi0:A:6:0): refuses synchronous negotiation. Using asynchronous =
transfers=0D
=0D  Vendor: IOMEGA    Model: ZIP 250           R


------=_NextPart_000_000B_01C2900C.A2B6C710--

