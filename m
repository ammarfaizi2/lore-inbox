Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263760AbTLOPrJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 10:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263762AbTLOPrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 10:47:08 -0500
Received: from 82-32-19-107.cable.ubr03.azte.blueyonder.co.uk ([82.32.19.107]:21132
	"EHLO amphibian.dyndns.org") by vger.kernel.org with ESMTP
	id S263760AbTLOPq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 10:46:57 -0500
Date: Mon, 15 Dec 2003 15:46:54 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: 'bad: scheduling while atomic!', preempt kernel, 2.6.1-test11, reading an apparently duff DVD-R
Message-ID: <20031215154654.GA7760@amphibian.dyndns.org>
References: <20031215135802.GA4332@amphibian.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20031215135802.GA4332@amphibian.dyndns.org>
User-Agent: Mutt/1.5.4i
From: Toad <toad@amphibian.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I recompiled the kernel with IDE-SCSI, preemption, taskfile, and a few
other things disabled. With the result that it worked. But of course I
can't _write_ DVDs without IDE-SCSI (short of obtaining a SCSI
writer)... I will now reenable features one by one to be sure it's an
IDE-SCSI problem. But it looks like IDE-SCSI has major problems reading
DVDs, mostly looking like this:

Dec 15 13:15:20 amphibian kernel: attempt to access beyond end of device
Dec 15 13:15:20 amphibian kernel: sr0: rw=3D0, want=3D2830152, limit=3D1329=
420
Dec 15 13:15:20 amphibian kernel: Buffer I/O error on device sr0,
logical block +707537

Either it gets such errors when mounting, or after mounting - almost
always when mounting.

Is there any way to record DVDs without using IDE-SCSI?

On Mon, Dec 15, 2003 at 01:58:02PM +0000, toad wrote:
> I got the following when trying to mount a particular DVD-R on Linux
> 2.6.0-test11, using an IDE DVD-RW drive, using SCSI emulation, with the
> preempt kernel option enabled, and taskfile I/O:
> (the middle bit was repeated several times):
>=20
> ide-scsi: reset called for 133
> bad: scheduling while atomic!
> Call Trace:
>  [<c0119acc>] schedule+0x55c/0x570
>  [<c01259ce>] schedule_timeout+0x5e/0xb0
>  [<c0125960>] process_timeout+0x0/0x10
>  [<c02add47>] idescsi_reset+0xf7/0x110
>  [<c02a7b82>] scsi_try_bus_device_reset+0x52/0x90
>  [<c02a7c1d>] scsi_eh_bus_device_reset+0x5d/0xe0
>  [<c02a8368>] scsi_eh_ready_devs+0x28/0x70
>  [<c02a84ef>] scsi_unjam_host+0xbf/0xd0
>  [<c02a85da>] scsi_error_handler+0xda/0x120
>  [<c02a8500>] scsi_error_handler+0x0/0x120
>  [<c0107329>] kernel_thread_helper+0x5/0xc
>=20
> SCSI error: host 0 id 0 lun 0 return code =3D 6000000
> Sense class 0, sense error 0, extended sense 0
> mount: No medium found
>=20
> I also suspect that it is refusing to read valid DVD-Rs, but it could
> just be my drive. One of them successfully mounted and then complained
> about attempt to access beyond end of device, and another 6 or so
> refused to mount for the same reason.
>=20
> If you require any further information, please ask me.
>=20
> Software: Kernel 2.6.0-test11, configured as above, Debian sid current
> (glibc2.3 IIRC), mount version 2.12, athlon XP 2800+, ATI's fglrx module
> loaded, sound (emu10k1) as moule, AGP, and some networking and lm_sensors
> stuff (all from stock kernel).
> --=20
> Matthew J Toseland - toad@amphibian.dyndns.org
> Freenet Project Official Codemonkey - http://freenetproject.org/
> ICTHUS - Nothing is impossible. Our Boss says so.



--=20
Matthew J Toseland - toad@amphibian.dyndns.org
Freenet Project Official Codemonkey - http://freenetproject.org/
ICTHUS - Nothing is impossible. Our Boss says so.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/3ddur5e+zmpNTm8RAhm1AJ436GxrzJ1XHaDN2sJU/QnDtmnGLACfYPyR
NY+XPgTrykpwBersH9s6axI=
=7tYc
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
