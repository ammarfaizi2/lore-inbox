Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVKKOAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVKKOAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 09:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVKKOAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 09:00:31 -0500
Received: from mx.laposte.net ([81.255.54.11]:35517 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1750767AbVKKOAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 09:00:31 -0500
Subject: How to speed up raid1 resync ?
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-loWOl3nvJVqpfAeBf5dP"
Organization: Perso
Date: Fri, 11 Nov 2005 15:00:18 +0100
Message-Id: <1131717619.4133.13.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 (2.4.1-7) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-loWOl3nvJVqpfAeBf5dP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm performing various lvm/raid experiments on my system. As a result,
I've trashed one of the two disks of a raid1 set. So now the raid is
rebuilding, as soon as it finished I intend to retry experimenting
(disconnect one drive in the raid set, experiment with the other, if big
mistake replug the other one and sync with it).

However mdmadm resync is dog slow (if gracefully backgrounded)

$ cat /proc/mdstat
Personalities : [raid1]
md0 : active raid1 hdc1[2] hda1[0]
      2096384 blocks [2/1] [U_]
        resync=3DDELAYED

md1 : active raid1 hdc3[2] hda3[0]
      76886976 blocks [2/1] [U_]
      [=3D>...................]  recovery =3D  5.6% (4374912/76886976)
finish=3D1164.8min speed=3D1036K/sec

Is there a way to speed it up ? I don't want to wait 1164.8min, and I
don't care if the resync monopolises most of the system.

Kernel is 2.6.14-git11 based (from Fedora Core Devel)

The two disks are identical PATA models :

ATA device, with non-removable media
        Model Number:       Maxtor 6Y080L0
        Serial Number:    =09
        Firmware Revision:  YAR41BW0
Standards:
        Supported: 7 6 5 4
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  160086528
        device size with M =3D 1024*1024:       78167 MBytes
        device size with M =3D 1000*1000:       81964 MBytes (81 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Standard, no device specific
minimum
        R/W multiple sector transfer: Max =3D 16  Current =3D 16
        Advanced power management level: unknown setting (0x0000)
        Recommended acoustic management value: 192, current value: 128
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5
*udma6
             Cycle time: min=3D120ns recommended=3D120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=3D120ns  IORDY flow control=3D120n=
s
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    Look-ahead
           *    Write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
           *    FLUSH CACHE EXT command
           *    Mandatory FLUSH CACHE command
           *    Device Configuration Overlay feature set
           *    Automatic Acoustic Management feature set
                SET MAX security extension
                Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
           *    SMART self-test
           *    SMART error logging
Security:
        Master password revision code =3D 65534
                supported
        not     enabled
        not     locked
                frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num =3D 0 determined by the jumper
Checksum: correct

on the following controller :=20

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a
[Master SecP PriP])
        Subsystem: Giga-byte Technology: Unknown device 5002
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at f000 [size=3D16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

Regards,

--=20
Nicolas Mailhot

--=-loWOl3nvJVqpfAeBf5dP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEABECAAYFAkN0o/IACgkQI2bVKDsp8g0vEACgjS27LjYmQsHeHegg5Vn/j35k
3AUAmwVx71mqRF6Ewo/Cj1cm0uk+vsi4
=1nIp
-----END PGP SIGNATURE-----

--=-loWOl3nvJVqpfAeBf5dP--

