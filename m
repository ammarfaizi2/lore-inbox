Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261447AbSJUSrZ>; Mon, 21 Oct 2002 14:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSJUSrZ>; Mon, 21 Oct 2002 14:47:25 -0400
Received: from eos.telenet-ops.be ([195.130.132.40]:62107 "EHLO
	eos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S261447AbSJUSrW>; Mon, 21 Oct 2002 14:47:22 -0400
X-Qmail-Scanner-Mail-From: devilkin-lkml@blindguardian.org via whocares
X-Qmail-Scanner: 1.14 (Clear:. Processed in 0.095056 secs)
From: DevilKin-LKML <devilkin-lkml@blindguardian.org>
To: "Nicholas Berry" <nikberry@med.umich.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre10-ac2: i/o error on cdrom diskdump
Date: Mon, 21 Oct 2002 20:53:22 +0200
User-Agent: KMail/1.4.3
References: <sdb40e59.000@mail-02.med.umich.edu>
In-Reply-To: <sdb40e59.000@mail-02.med.umich.edu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_YSHCRF95AASP6K44FL67"
Message-Id: <200210212053.22584.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_YSHCRF95AASP6K44FL67
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 21 October 2002 20:25, Nicholas Berry wrote:
> More clues please (h/w, error, command, etc.)

Kernel: 2.4.20-pre10-ac2. Configuration is attached.
Hardware platform: x86, AMD TBird 2000XP.

Details: the scsi cdrom (writer) fails to read the immage correctly, wher=
eas=20
the other two (ide-scsi) devices read the image perfectly.

Loaded modules:
--------------------
agpgart   es1371  ac97_codec  soundcore  usb-storage  usb-uhci  usbcore =20
via686a  i2c-isa  i2c-viapro  i2c-proc  i2c-core  ide-scsi  aic7xxx   sg =
=20
sr_mod  cdrom  sd_mod  scsi_mod  smbfs  nfs  lockd  sunrpc  loop  lp =20
parport_pc  parport  rtc  3c59x

SCSI Controller
----------------
00:0f.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
        Subsystem: Adaptec AHA-2904/Integrated AIC-7850
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r-=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
-=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [disabled] [size=3D256]
        Region 1: Memory at fb002000 (32-bit, non-prefetchable) [size=3D4=
K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

CDROM device:
------------------
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=3D7, 3/253 SCBs
  Vendor: PLEXTOR   Model: CD-R   PX-W4220T  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
(scsi0:A:4): 10.000MB/s transfers (10.000MHz, offset 8)
sr0: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray

Device file:
-------------
devilkin@whocares:/tmp$ ls -l /dev/scd0
brw-rw-rw-    1 root     disk      11,   0 Jul 18  1994 /dev/scd0

Command executed with valid cdrom in drive:
---------------------------------------------------
devilkin@whocares:/tmp$ dd if=3D/dev/scd0 of=3D/tmp/image.iso
dd: reading `/dev/writer': Input/output error
1264984+0 records in
1264984+0 records out

Errors in the system log:
---------------------------
scsi0: ERROR on channel 0, id 4, lun 0, CDB: Read (10) 00 00 04 d3 24 00 =
00 3f=20
00
Info fld=3D0x4d356, Current sd0b:00: sense key Medium Error
Additional sense indicates L-EC uncorrectable error
 I/O error: dev 0b:00, sector 1264984
scsi0: ERROR on channel 0, id 4, lun 0, CDB: Read (10) 00 00 04 d3 57 00 =
00 0c=20
00
Info fld=3D0x4d357, Current sd0b:00: sense key Medium Error
 I/O error: dev 0b:00, sector 1264988
scsi0: ERROR on channel 0, id 4, lun 0, CDB: Read (10) 00 00 04 d3 58 00 =
00 0b=20
00
Info fld=3D0x4d358, Current sd0b:00: sense key Medium Error
 I/O error: dev 0b:00, sector 1264992
scsi0: ERROR on channel 0, id 4, lun 0, CDB: Read (10) 00 00 04 d3 56 00 =
00 01=20
00
Info fld=3D0x4d356, Current sd0b:00: sense key Medium Error
Additional sense indicates L-EC uncorrectable error
 I/O error: dev 0b:00, sector 1264984
scsi0: ERROR on channel 0, id 4, lun 0, CDB: Read (10) 00 00 04 d3 57 00 =
00 01=20
00
Info fld=3D0x4d357, Current sd0b:00: sense key Medium Error
 I/O error: dev 0b:00, sector 1264988


This happens with close to EVERY cdrom, and I can always read them perfec=
tly=20
in the other drives. Just doing a file-copy from the disk in the scsi dri=
ve=20
also works. Writing also gives no problems at all.

Strange things are afoot...

DK
--=20
Bradley's Bromide:
=09If computers get too powerful, we can organize them into a
committee -- that will do them in.


--------------Boundary-00=_YSHCRF95AASP6K44FL67
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config.gz"

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

--------------Boundary-00=_YSHCRF95AASP6K44FL67--

