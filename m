Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265910AbUI0NdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUI0NdQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 09:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUI0NdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 09:33:16 -0400
Received: from sero.dbtech.de ([195.4.70.70]:7438 "HELO mx0.dbtech.de")
	by vger.kernel.org with SMTP id S265910AbUI0NdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 09:33:13 -0400
From: Christian Fischer <Christian.Fischer@fischundfischer.com>
Organization: Fisch+Fischer Veranstaltungstechnik
To: Frank van Maarseveen <frankvm@xs4all.nl>
Subject: Re: NFS TUNING: #define NFS3_MAXGROUPS
Date: Mon, 27 Sep 2004 15:38:47 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <200409261638.36011.Christian.Fischer@fischundfischer.com> <200409261643.29571.Christian.Fischer@fischundfischer.com> <20040926222856.GA22758@janus>
In-Reply-To: <20040926222856.GA22758@janus>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4837655.enxCI0BN4S";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409271538.47987.Christian.Fischer@fischundfischer.com>
X-Spam-HITS: 0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4837655.enxCI0BN4S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 27 September 2004 00:28, Frank van Maarseveen wrote:

> That limit is hardcoded in the SUNRPC protocol (part of NFS) and
> _cannot_ be changed: it is a fundamental constant in NFS with AUTH_UNIX
> authentication. However, there is a trick to bypass this protocol
> limitation, see http://www.frankvm.com/nfs-ngroups for a 2.4.x patch.
>
> The 2.6.x patch is under development.

Thanks for this link. It isn't no more necessary to patch anything since i'=
ve=20
reduced the number of groups per uid to the limit. Well, i'd been reading t=
he=20
sunRPC rfc before, bringing a lot of trouble to me.=20

The main problem was that users in the seventeenth (or higher) group (they=
=20
should not have any permissions for this group because of NFS_MAXGROUPS) we=
re=20
able to change without permissions into those directories. I think a user o=
r=20
group should have permission or NOT, and not a "bit of permissions". =20

Christian

root@terminalserver # ls -al /home/henry/shared/
[...]
drwxrws---    not_henry    17th_grp      work
[...]

henry@terminalserver # cd /home/henry/shared/work/
henry@terminalserver work # ls
ls: reading directory .: Permission denied

# groups henry
[...]   17th_grp   18th_grp   [...]
=2D-=20

--nextPart4837655.enxCI0BN4S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.9.10 (GNU/Linux)

iD4DBQBBWBfnszmQKstIgt4RAqOsAJ9X5SWhM6qN8HK/IHrusn5B8DOHEACYijRh
SHhbWM4ThR2tlLvbc9X1Rg==
=2lc1
-----END PGP SIGNATURE-----

--nextPart4837655.enxCI0BN4S--

