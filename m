Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293483AbSB1XCZ>; Thu, 28 Feb 2002 18:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310188AbSB1XAg>; Thu, 28 Feb 2002 18:00:36 -0500
Received: from mailout5-1.nyroc.rr.com ([24.92.226.169]:19415 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S310186AbSB1W4I>; Thu, 28 Feb 2002 17:56:08 -0500
Subject: Re: ext3 and undeletion
From: James D Strandboge <jstrand1@rochester.rr.com>
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020228160552.C23019@devcon.net>
In-Reply-To: <20020226171634.GL4393@matchmail.com>
	<Pine.LNX.3.95.1020226130051.4315A-100000@chaos.analogic.com> 
	<20020228160552.C23019@devcon.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-7NpOy8ESTHF3l86mP/Z6"
X-Mailer: Evolution/1.0.2 
Date: 28 Feb 2002 17:55:42 -0500
Message-Id: <1014936942.18953.143.camel@hedwig.strandboge.cxm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7NpOy8ESTHF3l86mP/Z6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2002-02-28 at 10:05, Andreas Ferber wrote:
> On Tue, Feb 26, 2002 at 01:34:27PM -0500, Richard B. Johnson wrote:
>=20
> > All the deleted files, with the correct path(s), are now in the
> > top directory file the file-system ../lost+found directory. They
> > are still owned by the original user, still subject to the same
> > quota.
>=20
> And what about:
>=20
> - Luser rm's "foo.c"
> - Luser starts working on new version of "foo.c"
> - Luser recognizes, that the old version was better
> - Luser rm's new "foo.c"
> - Luser tries to unrm the old "foo.c" -> *bang*
As stated in a later post, a basic versioning could be implemented=20
where a ".1" or similar could be added to the end of the file.  This
could definitely cause problems with the disk filling up though (see
below).

> But a user will end up unable to /free/ any diskspace. User tries
> something, generates a /huge/ error log filling up the quota/disk,
> oops, has to call sysadmin before work can go on... Five minutes
> later, the fix just tried didn't work, oops, has to call admin again,
> and so on. Do you /really/ want this?
A special binary could be created that would be able to read the
contents of the .undelete directory based on the uid of the user running
it.  The binary could remove the file if desired.  The user space
implementation would require more thought, but there are several
possibilities that I can think of.

>=20
> And how do you want to handle temp files? If you don't exclude them
> from undeletion, they will fill up your diskspace soon. For the moment
> I can't think of any mechanism that identifies temp files reliably
> (without API changes).
This is a good point.  The kernel space code could just filter out
anything being removed from /tmp (and the various .undelete
directories).  But there would be other files.  A low priorotiy cron job
or daemon could remedy the others (being configurable in user space).=20
it could also remove files with a high version number if space was low.

> > All one needs is a compile-time switch to enable the following:
>=20
> And a system wide configurable switch, and a user configurable switch
> and so on.
>
I am not sure what this is referencing.  I was now thinking that a
kernel compile option (CONFIG_UNDELETE) could be used for those who
wanted this, and those that didn't could leave it out.  And for those
that do, but only on some mountpoints, the sysadmin could simply have
the .undelete just on those mounts that needed the undelete feature.=20
The kernel code would simply remove the file like normal if the
.undelete directory was not present.
=20
> Undeletion has /many/ implications, did you think through all of them?
>=20
I REALLY doubt it! :-)  But it is fun getting into the kernel code and
trying some stuff out.
=20
>=20
> Just as a personal note: personally I would simply /refuse/ to work on
> a system where I end up unable to delete even files I /own/, or at
> least I would end up implementing my own way of deleting files which
> circumvents undeletion (there will /always/ be a way to do it).
>=20
> If your employer didn't expressively forbid you to keep private data
> on your work account, you are allowed to do so, at least here in
> germany, and you can sue your employer if he takes actions to look
> into your private data without informing you /before/ doing it (taken
> strictly, if you are allowed to keep private data on your work
> account, you even have to be informed explicitly that the data may be
> backuped and recovered later from backup tapes). So in the end,
> undeletion is also a matter of privacy, and the ability to undelete
> may even pose legal problems on a company.
>=20
Valid points which leads me to think that a special suid/sgid user space
program would be needed.  The .undelete directory would have chmod 700
owned by root (or possibly 770 with 'chown root.undelete' ownership).

Jamie=20

--=20
Email:        jstrand1@rochester.rr.com
GPG/PGP ID:   26384A3A
Fingerprint:  D9FF DF4A 2D46 A353 A289  E8F5 AA75 DCBE 2638 4A3A

--=-7NpOy8ESTHF3l86mP/Z6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAjx+tW0ACgkQqnXcviY4Sjq4aQCfSqMCZGphr58WgRepSuHslue6
Gk8AoI9Nr5YM/ZEAfk/2oAZWPmEmpM+A
=vkiJ
-----END PGP SIGNATURE-----

--=-7NpOy8ESTHF3l86mP/Z6--

