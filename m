Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261212AbRERAOz>; Thu, 17 May 2001 20:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262002AbRERAOp>; Thu, 17 May 2001 20:14:45 -0400
Received: from cc265407-a.hwrd1.md.home.com ([24.3.45.174]:49361 "EHLO
	athens.nanticoke.ellicott-city.md.us") by vger.kernel.org with ESMTP
	id <S261212AbRERAOm>; Thu, 17 May 2001 20:14:42 -0400
Date: Thu, 17 May 2001 20:14:40 -0400
From: Tim Meushaw <meushaw@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: meushaw@pobox.com
Subject: Workaround Found for Re: CD-RW ide-scsi problem presists with 2.4.4 (was Re: Problem with 2.4.1/2.4.3 and CD-RW ide-scsi drive)
Message-ID: <20010517201439.B15994@pobox.com>
In-Reply-To: <20010411225356.A574@pobox.com> <20010428143750.A689@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010428143750.A689@pobox.com>; from meushaw@pobox.com on Sat, Apr 28, 2001 at 02:37:50PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks to an email I got (hi Thomas!), I was able to use a workaround to
the problem described below.  I don't know if it's the accepted fix or
not, but it worked for me.

What I did was set the DMA mode of the drive differently.  I used the
following hdparm command:
	hdparm -d 1 -X 34 /dev/hdd

After running that, I didn't have any problems.  I wasn't able to tell
what the mode was before running that, as I received errors from hdparm
for half the parameters, presumably because of the SCSI emulation
<shrug>.

I'm no longer subscribed to this list (too much traffic!), but wanted to
report this workaround, and thanks to Thomas Baecker for giving me this
answer when the same thing worked for him.  :-)

Tim

On Sat, Apr 28, 2001 at 02:37:50PM -0400, Tim Meushaw wrote:
> I had received info that this may have been fixed in 2.4.3-ac5.  I
> didn't get the chance to test it there, but I installed 2.4.4 this
> morning.  Alas, I receive exactly the same errors with 2.4.4 as I did
> previously with 2.4.3.
>=20
> One thing that did differ, though, shortly after I sent this first
> email, magically the drive started working properly.  I was able to
> mount disks perfectly.  However, I had to reboot for some reason or
> another, and the problem came back and has stayed with me ever since.
> As far as I know I didn't do anything to make it work when it did, it
> just "started working", which isn't an answer I like, but that's all I
> can say.... :-)
>=20
> Tim
>=20
> On Wed, Apr 11, 2001 at 10:53:57PM -0400, Tim Meushaw wrote:
> > Hi there.  I just got a new CD-RW drive and am trying to get it working
> > under Linux.  I've got the ide-scsi modules all loaded, but have weird
> > errors when trying to mount a disk.
> >=20
> > Here are the messages from "dmesg" that I get when the ide-cd and
> > ide-scsi modules are loaded.  My DVD-ROM is /dev/hdc, and the CD-RW is
> > /dev/hdd (or /dev/sr0):
> >=20
> > -----------------------------------------------------
> > hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
> > Uniform CD-ROM driver Revision: 3.12
> > ide-cd: ignoring drive hdd
> > scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> >   Vendor: SONY      Model: CD-RW  CRX160E    Rev: 1.0e
> >   Type:   CD-ROM                             ANSI SCSI revision: 02
> > Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> > sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
> > -----------------------------------------------------
> >=20
> > So, it looks like the drive is attached to /dev/sr0 properly.  Then, I
> > run "cdrecord -scanbus" to make sure:
> >=20
> > -----------------------------------------------------
> > Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 J=F6rg Schilli=
ng
> > Linux sg driver version: 3.1.17
> > Using libscg version 'schily-0.1'
> > scsibus0:
> >         0,0,0     0) 'SONY    ' 'CD-RW  CRX160E  ' '1.0e' Removable CD-=
ROM
> > -----------------------------------------------------
> >=20
> > So, it REALLY looks like it's working.  However, here's what I get when
> > I try to mount an ordinary data CD:
> >=20
> > -----------------------------------------------------
> > athens:~# mount -t iso9660 /dev/sr0 /cdrw
> > mount: block device /dev/sr0 is write-protected, mounting read-only
> > SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code =3D 28000000
> > [valid=3D0] Info fld=3D0x0, Current sd0b:00: sense key Hardware Error
> > Additional sense indicates Logical unit communication CRC error (Ultra-=
DMA/32)
> >  I/O error: dev 0b:00, sector 64
> > isofs_read_super: bread failed, dev=3D0b:00, iso_blknum=3D16, block=3D32
> > mount: wrong fs type, bad option, bad superblock on /dev/sr0,
> >        or too many mounted file systems
> > -----------------------------------------------------
> >=20
> > I've tried this with both kernel 2.4.1 and 2.4.3 and have the exact same
> > error.  I've also tried multiple data CDs and have the same messages.
> > The CD-RW is a Sony CRX-160E, plugged in to an Asus A7V motherboard (the
> > PCI bus is described by "lspci" as "VIA Technologies, Inc. VT8363/8365
> > [KT133/KM133 AGP]").  I'm not sure what other information I can provide,
> > but I'll be happy to give anything else that might be needed to help fix
> > this problem.
> >=20
> > Thanks a lot!
> > Tim
> >=20
> > --=20
> > Timothy A. Meushaw
> > meushaw@pobox.com
> > http://www.pobox.com/~meushaw/
>=20
>=20
>=20
> --=20
> Timothy A. Meushaw
> meushaw@pobox.com
> http://www.pobox.com/~meushaw/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Timothy A. Meushaw
meushaw@pobox.com
http://www.pobox.com/~meushaw/

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7BGlvMVO+gCLjJFkRAlj+AKCcRzApOIB0dG7tYNztX5RceTlFyQCeKUm7
JObl7rLZrp4k7sc/8VlWwLg=
=4sKO
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
