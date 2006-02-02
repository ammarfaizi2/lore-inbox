Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423376AbWBBIKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423376AbWBBIKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423373AbWBBIKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:10:20 -0500
Received: from smtp06.auna.com ([62.81.186.16]:37068 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1423376AbWBBIKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:10:18 -0500
Date: Thu, 2 Feb 2006 09:15:14 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Neil Brown <neilb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm4 i386 atomic operations broken on SMP (in modules
 at least)
Message-ID: <20060202091514.5e9f356e@werewolf.auna.net>
In-Reply-To: <17377.25947.81994.747575@cse.unsw.edu.au>
References: <17377.24090.486443.865483@cse.unsw.edu.au>
	<20060202023550.46f06ee1@werewolf.auna.net>
	<17377.25947.81994.747575@cse.unsw.edu.au>
X-Mailer: Sylpheed-Claws 2.0.0cvs2 (GTK+ 2.8.11; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_=jqG=qXohmarldhYEgD5URB";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.209.184] Login:jamagallon@able.es Fecha:Thu, 2 Feb 2006 09:10:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_=jqG=qXohmarldhYEgD5URB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Feb 2006 12:50:19 +1100, Neil Brown <neilb@suse.de> wrote:

> On Thursday February 2, jamagallon@able.es wrote:
> > On Thu, 2 Feb 2006 12:19:22 +1100, Neil Brown <neilb@suse.de> wrote:
> >=20
> > >=20
> > > I've been testing md/raid in 2.6.16-rc1-mm4 on a dual Xeon with most
> > > of the md personalities compiled as modules, and weird stuff if
> > > happening.
> > >=20
> > > In particular I'm getting lots of=20
> > >=20
> > >     BUG: atomic counter underflow at:
> > >=20
> > > reports in raid10 and raid5, which are modules.
> > >=20
> > >
> >=20
> > I also run this kernel (plus a couple patches) on a SATA raid5 setup, a=
nd
> > had no problems. People throws and gets files via SMB/AFP, mainly.
> >=20
> > My box is dual PIII@933.
>=20
> Is 'raid5' a module, or is it compiled in?
>=20

nada:/usr/src/linux# grep _MD_ .config
CONFIG_MD_LINEAR=3Dy
CONFIG_MD_RAID0=3Dy
CONFIG_MD_RAID1=3Dy
CONFIG_MD_RAID10=3Dy
CONFIG_MD_RAID5=3Dy
CONFIG_MD_RAID6=3Dy
CONFIG_MD_MULTIPATH=3Dm
# CONFIG_MD_FAULTY is not set

nada:/usr/src/linux# lsmod
Module                  Size  Used by
w83627hf               22512  0=20
hwmon_vid               2016  1 w83627hf
i2c_isa                 3392  1 w83627hf
i2c_viapro              7188  0=20
i2c_core               16640  3 w83627hf,i2c_isa,i2c_viapro
snd_ens1371            18656  0=20
snd_rawmidi            17312  1 snd_ens1371
snd_ac97_codec         87744  1 snd_ens1371
snd_ac97_bus            1760  1 snd_ac97_codec
snd_pcm                72772  2 snd_ens1371,snd_ac97_codec
snd_timer              18724  1 snd_pcm
snd_page_alloc          7784  1 snd_pcm
snd                    38104  5 snd_ens1371,snd_rawmidi,snd_ac97_codec,snd_=
pcm,snd_timer
e100                   31620  0=20
ide_cd                 35264  0=20
loop                   11816  0=20
via82cxxx               8132  0 [permanent]
ide_core              109844  2 ide_cd,via82cxxx
via_agp                 7584  1=20
agpgart                25352  1 via_agp
microcode               5592  0=20
sata_promise            8868  7=20
libata                 63956  1 sata_promise
uhci_hcd               20044  0=20
sg                     20984  0=20
st                     34880  0=20
sr_mod                 14020  0=20
cdrom                  34320  2 ide_cd,sr_mod

nada:/usr/src/linux# grep BUG /var/log/syslog
nada:/usr/src/linux# grep BUG /var/log/messages
nada:/usr/src/linux#=20

;)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.15-jam7 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_=jqG=qXohmarldhYEgD5URB
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD4b+SRlIHNEGnKMMRAgYsAJ9RD3M9zGliX1kdu7JsOjxNEHJ0wQCeJ8CP
cvE5ykNg0YF7ykADAo8LbY4=
=Obis
-----END PGP SIGNATURE-----

--Sig_=jqG=qXohmarldhYEgD5URB--
