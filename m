Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317695AbSGVRFj>; Mon, 22 Jul 2002 13:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316684AbSGVRFj>; Mon, 22 Jul 2002 13:05:39 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:38703 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316682AbSGVRFh>; Mon, 22 Jul 2002 13:05:37 -0400
Date: Mon, 22 Jul 2002 19:08:40 +0200
From: Kurt Garloff <garloff@suse.de>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Patch for 256 disks in 2.4
Message-ID: <20020722170840.GB19587@nbkurt.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
References: <20020720195729.C20953@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <20020720195729.C20953@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pete,

On Sat, Jul 20, 2002 at 07:57:29PM -0400, Pete Zaitcev wrote:
> For those who do not follow, John Cagle allocated 8 more SCSI
> disk majors.

Have those officially been assigned to SCSI disks?
So disks 128 -- 255 have majors 128 thr. 135?

> Here's a patch to make use of them. I am not sure
> if we want a 2.5 version; it's going to be all devicefs anyhow...

I've written a patch for sd that makes the allocation of majors
dynamic. The driver just takes 8 at sd_init and further majors are=20
allocated when disks are attached. Which saves a lot of memory for
all the gendisk and hd_struct stuff in case you do not have a lot of=20
SCSI disks connected. The patch does support up to 160 SD majors,=20
though currently, it won't succeed getting more than 132 majors.

> It really is strange how many places know major assignments.

Indeed. I missed the sysrq stuff in my patch, BTW.=20
Do you have any idea why we can't just sync all mounted filesystems
in do_emergency_sync()? Or at least all that are backed by a real=20
device? The test for IDE and SCSI majors seems bogus to me. What
about DASD? LVM? EVMS? MD? Loop? NBD? DRBD? What's the rationale=20
of restricting the sync to only IDE and SCSI? Deadlock avoidance?

> I hope I found all of them which matter. Also, I think nobody
> uses min_major/max_major, do you guys know if that's right?

It's right. Kill them! I killed them as well in my patch.

> More comments?

I'm gonna post my patches tomorrow ...

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9PDwYxmLh6hyYd04RAsScAJ9n7GBvWm76ajZ+MPuNfl1DORkbyQCgmjiQ
alFllswva2r3qXG2s7+j8Js=
=KR7s
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
