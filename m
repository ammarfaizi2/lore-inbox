Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318572AbSGZW3R>; Fri, 26 Jul 2002 18:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318584AbSGZW3R>; Fri, 26 Jul 2002 18:29:17 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:12134 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S318572AbSGZW3O>; Fri, 26 Jul 2002 18:29:14 -0400
Date: Sat, 27 Jul 2002 00:32:24 +0200
From: Kurt Garloff <garloff@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Alexander Viro <viro@math.psu.edu>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] sd_many done right (1/5)
Message-ID: <20020726223224.GJ19721@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Christoph Hellwig <hch@infradead.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20020726154533.GD19721@nbkurt.etpnet.phys.tue.nl> <Pine.GSO.4.21.0207261245070.21586-100000@weyl.math.psu.edu> <20020726165411.GI19721@nbkurt.etpnet.phys.tue.nl> <20020726175027.GC2746@clusterfs.com> <20020726185545.B18629@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S0GG+JvAI2G0KxBG"
Content-Disposition: inline
In-Reply-To: <20020726185545.B18629@infradead.org>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--S0GG+JvAI2G0KxBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Christoph, Andreas,

On Fri, Jul 26, 2002 at 06:55:45PM +0100, Christoph Hellwig wrote:
> On Fri, Jul 26, 2002 at 11:50:27AM -0600, Andreas Dilger wrote:
> > Actually, one interesting aspect of the EVMS vs. device-mapper argument
> > going on that has totally been missed is that EVMS can do management of
> > ALL disk block devices.
>=20
> That's only natural as it try to duplicate the whole Linux block layer.
> But it's everything but a good idea.

I won't go into that discussion ... Duplicating the Linux block layer is
certainly not such a good idea as the block layer is getting really nice
nowadays. But I have no idea to what extent something like this is done in
EVMS.

But the idea of having a number of majors assigned to disks, no matter what
the driver below is looks certainly like a good idea. With the current
approach, we'll need way too many majors, even if we'd have some more bits
in the future. Why not have a pool of disk majors and sd, hd, dasd, rd
(DAC960), the IDE-Raids, and ... allocate some of these as needed.

driverfs + some userspace tool will be needed to provide a consistent view
on them and to handle the permissions. Fortunately, disk devs tend to all
have the same perms, so we can start before this is addressed to its
full extent.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--S0GG+JvAI2G0KxBG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Qc34xmLh6hyYd04RArTyAJ0Uig6iiCc+2TVB41EQJuZJ3aJ22QCgj9X6
U9rTa6iLaVo8Tis9ryARyBc=
=NRTi
-----END PGP SIGNATURE-----

--S0GG+JvAI2G0KxBG--
