Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTFYJhn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 05:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264358AbTFYJhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 05:37:42 -0400
Received: from grendel.firewall.com ([66.28.56.41]:30614 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S264340AbTFYJhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 05:37:38 -0400
Date: Wed, 25 Jun 2003 11:51:26 +0200
From: Marek Habersack <grendel@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.73-mm1 XFS] restrict_chown and quotas
Message-ID: <20030625095126.GD1745@thanes.org>
Reply-To: grendel@debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BI5RvnYi6R4T2M87"
Content-Disposition: inline
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BI5RvnYi6R4T2M87
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello,

  I've discovered yesterday, by sheer accident (building a deb package which
process uses fakeroot) that the XFS in 2.5.73-mm1 (and probably in vanilla
2.5.73 as well) implements the restrict_chown policy and syscall while
defaulting to the relaxed chown behavior. That way a user can give away
their files/directories while retaining full control in the sense that the
owner of the containing directory can remove the chowned entries. Removing
the entries not owned/chowned by you but living in a directory owned by you is also
possible (both with restricted_chown in effect and when it's not effective)
on XFS filesystems.
  It also seems (although I haven't tested it, just looked at the source code)
that when one chowns a file/directory to another uid:gid when restrict_chown
is in effect, the quota is changed as well - it gets transferred to the
target uid:gid.
  For me both of the described situations seem to be a bug, but I might be
unaware of the rationale behind the functionality. If this is supposed to be
that way, maybe at least it would be better to default restrict_chown to
enabled initially? The behavior with restrict_chown is totally different to
what users/administrators are used to and, as shown in the debian package
build case, it might cause problems in usual situations. Also the quota
issue is likely to be an excellent tool for local DoS.
  So, am I wrong in thinking that it's a bug (or at least the quota part of
it) or not?

regards,

marek

--BI5RvnYi6R4T2M87
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++XCeq3909GIf5uoRApqRAJ9YmU33jWRi0cP2Ag35sWfrat/WbwCeOnwT
ae7xT+0FTcp9jURFPUPBvFM=
=KoiD
-----END PGP SIGNATURE-----

--BI5RvnYi6R4T2M87--
