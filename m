Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTFYN1c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 09:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTFYN1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 09:27:32 -0400
Received: from grendel.firewall.com ([66.28.56.41]:57751 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S264266AbTFYN12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 09:27:28 -0400
Date: Wed, 25 Jun 2003 15:41:29 +0200
From: Marek Habersack <grendel@debian.org>
To: Steve Lord <lord@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.73-mm1 XFS] restrict_chown and quotas
Message-ID: <20030625134129.GG1745@thanes.org>
Reply-To: grendel@debian.org
References: <20030625095126.GD1745@thanes.org> <1056545505.1170.19.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline
In-Reply-To: <1056545505.1170.19.camel@laptop.americas.sgi.com>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2003 at 07:51:43AM -0500, Steve Lord scribbled:
[snip]
> >   For me both of the described situations seem to be a bug, but I might=
 be
> > unaware of the rationale behind the functionality. If this is supposed =
to be
> > that way, maybe at least it would be better to default restrict_chown to
> > enabled initially? The behavior with restrict_chown is totally differen=
t to
> > what users/administrators are used to and, as shown in the debian packa=
ge
> > build case, it might cause problems in usual situations. Also the quota
> > issue is likely to be an excellent tool for local DoS.
> >   So, am I wrong in thinking that it's a bug (or at least the quota par=
t of
> > it) or not?
>=20
> Sorry about this, the defaults for the systunes have been messed up
> recently. This is supposed to be on by default, irix_sgid_inherit
> is on, but should be off by default.=20
>=20
> You can switch the behavior with /proc/sys/fs/xfs/restrict_chown
> and irix_sgid_inherit.
Yep, that's what I did. I was just caught by surprise discovering the new
behavior :) and it if it was to be the default, it would have created a big
problem for distributions compatibility-wise.
=20
> You can also edit xfs_globals.c to switch the default at boot time.
> We will switch it back in the next update to Linus.
Great, that's good enough.
=20
> As for the quota operation, the normal chown situation is going
> from root to another id, and in that case, you want the quota to
> go to the end user. In the non restricted chown case, if the
> quota remained with the original user, how do you decide which
> user's quota to remove the file space from when it is deleted,
> once a file is chowned, there is no record of who it was created
> as. The quota has to stick with the uid of the file.
Right, but that way you're granting a non-privileged user the superuser
rights without proper authentication/authorization. I see use for
non-restricted chown in tight groups of cooperating people, but in general
it looks to be more a hazard than an advantage. I might be wrong, though...
And what about the right to partially control the file whose ownership you
transferred to another user? Currently it is possible to chmod a file to
0600 (or directory to 0700), chown it to root and then remove it - but you
cannot write to it not even open it. Also, an administrator might expect
that a file created with the root rights in the user's directory will remain
untouchable/unreadable/inmutable to the user, but this is not so - the user
can remove any files created by root whether or not restricted_chown is in
effect. That might be quite a nightmare for the admins. Or at the very least
it's inconsistent with other filesystems.=20
Anyhow, maybe I'm completely wrong on the above topics, but it does seem
like a security problem in general..

regards,

marek


--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++aaJq3909GIf5uoRAiYyAJ4jYKElO+nAdEclF4dLThA9Zed9pQCeIGqR
kFWibw5YgT62ZS3gvfVMANI=
=zwhe
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--
