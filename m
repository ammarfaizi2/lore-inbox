Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264672AbTAAVWJ>; Wed, 1 Jan 2003 16:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264679AbTAAVWJ>; Wed, 1 Jan 2003 16:22:09 -0500
Received: from [81.5.149.242] ([81.5.149.242]:48863 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id <S264672AbTAAVWI>;
	Wed, 1 Jan 2003 16:22:08 -0500
Date: Wed, 1 Jan 2003 21:30:34 +0000
From: Athanasius <link@miggy.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-pre21 - Dodgy DMA with PIIX4
Message-ID: <20030101213034.GB10404@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20021227134551.GH1878@miggy.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20021227134551.GH1878@miggy.org>
User-Agent: Mutt/1.3.28i
X-gpg-fingerprint: 95DFC4A7
X-gpg-key: http://www.fysh.org/~athan/gpg-key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 27, 2002 at 01:45:51PM +0000, Athanasius wrote:
> Hi,
>   I've a machine based around a Gigabyte GA-686BX motherboard, using the
> Intel 440BX/ZX chipset:
>=20
> On kernel 2.4.18-pre8 I was able to set MDMA modes on all 4 of my hard
> disks:
>=20
> /dev/hda: Model=3DST32122A, FwRev=3D3.02, SerialNo=3DXKF67385
> /dev/hdb: Model=3DMaxtor 82560 A4 -, FwRev=3DAA8Z2225, SerialNo=3DC40AHFXA
> /dev/hdc: Model=3DMaxtor 94098U8, FwRev=3DFA500S60, SerialNo=3DG80EK51C
> /dev/hdd: Model=3DMaxtor 4G120J6, FwRev=3DGAK819K0, SerialNo=3DG60E058E
>=20
> using:
>=20
> /sbin/hdparm -u1 -d1 -X34 /dev/hda
> /sbin/hdparm -u1 -d1 -X34 /dev/hdb
> /sbin/hdparm -u1 -d1 -X34 /dev/hdc
> /sbin/hdparm -u1 -d1 -X34 /dev/hdd
>=20
> The motherboard doesn't do UltraDMA, so these MDMA modes were the best I

   I was wrong about this, I'm sure I'd looked at the docs before and
found it didn't do UDMA ho hum, anyway...

>   On 2.4.21-pre21 I can set this for hda and hdb, but then quickly end
> up with the machine locked up with DMA failing on hda.  It did so whilst
> editting the command to rerun it for hdc, i.e. within 10-15s.

   Looks like the problematic thing on 2.4.21pre2 is the -u1 switch to
hdparm.  I'd carefully tested this before and never had any trouble with
it.  I guess the IDE code has changed such that this is now a bad idea.

   I'm now on UDMA2 for hda,c,d which works fine, nice 24MB/s or so off
the hdc/d which are the big drives.  hdb is still acting weird though:

21:28:05 0$ hdparm -d1 -X34 /dev/hdb

/dev/hdb:
 setting using_dma to 1 (on)
 setting xfermode to 34 (multiword DMA mode2)
 using_dma    =3D  1 (on)
root@jimblewix:~;
21:28:45 0$ hdparm -i /dev/hdb

/dev/hdb:

 Model=3DMaxtor 82560 A4 -, FwRev=3DAA8Z2225, SerialNo=3DC40AHFXA
 Config=3D{ Fixed }
 RawCHS=3D4962/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D20
 BuffType=3DDualPortCache, BuffSize=3D256kB, MaxMultSect=3D16, MultSect=3D16
 CurCHS=3D4962/16/63, CurSects=3D5001696, LBA=3Dyes, LBAsects=3D5001728
 IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4=20
 DMA modes: mdma0 mdma1 mdma2=20
 AdvancedPM=3Dno WriteCache=3Denabled
 Drive Supports : ATA/ATAPI-4 X3T13 1153D revision 7 : ATA-1 ATA-2 ATA-3=20

So, that's MDMA2 set, but hdparm -i doesn't show it (no * next to ANY
DMA or PIO mode).  Similar results for setting lower MDMA modes or any
PIO mode.  Nothing in dmesg after doing this.

-Ath
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj4TXfoACgkQzbc+I5XfxKeKpACglUdduLRov2vgcRkRIWqGCKmx
USQAmwfmDNvr+M1GtXNl4zMZQni50dGe
=vvZ0
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
