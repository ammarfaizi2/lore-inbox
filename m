Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132546AbRDAUCO>; Sun, 1 Apr 2001 16:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132547AbRDAUCE>; Sun, 1 Apr 2001 16:02:04 -0400
Received: from kotako.analogself.com ([207.181.249.20]:19209 "HELO
	kotako.analogself.com") by vger.kernel.org with SMTP
	id <S132546AbRDAUBu>; Sun, 1 Apr 2001 16:01:50 -0400
Date: Sun, 1 Apr 2001 12:49:58 -0700
From: Jag <agrajag@linuxpower.org>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Temporary disk space leak
Message-ID: <20010401124958.A13901@kotako.analogself.com>
Mail-Followup-To: Giuliano Pochini <pochini@denise.shiny.it>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3AC5A16A.9F0147E4@denise.shiny.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="4vgOdmpzXGVCiUly"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AC5A16A.9F0147E4@denise.shiny.it>; from pochini@denise.shiny.it on Sat, Mar 31, 2001 at 11:20:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4vgOdmpzXGVCiUly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 31 Mar 2001, Giuliano Pochini wrote:

>=20
> [root@Jay Giu]# du -c /home
> [...]
> 320120	/home
> 320120	total
> [root@Jay Giu]# df
> Filesystem           1k-blocks      Used Available Use% Mounted on
> /dev/sda8               253823     65909    174807  27% /
> /dev/sda7              2158320    750672   1296240  37% /usr
> /dev/sda5              2193082   1898198    183474  91% /home
> /dev/sda9              1013887    899924     61586  94% /opt
>=20
>=20
> It happened after I wrote and deleted very large files (~750MB) a
> few times in my home dir.
> Then I logged out and I relogged in as root to check what happened
> and "df" shown everything was right again:
>=20
> /dev/sda5              2193082    320122   1761550  15% /home
>=20
>=20
> ...strange...

Was the 750M file opened by a program when it was deleted?  When a file
is deleted, if it is opened, it will still be there and taking up file
space (as shown in df) until it is completely closed.  However, even if
the file is opened by a process and not really deleted, the file's space
will no longer show up in du because the file can no longer be accessed
through the filesystem.

It sounds like this is what happened, and whatever program had the file
open was closed when you logged out.


Jag

--4vgOdmpzXGVCiUly
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6x4Zm+pq97aGGtXARAvI6AJ0Ze08TmsY+wMnIi7rWFvZCb4j6xACfYGfc
+mzUVAroZd2CbbHrPuqBXGU=
=/+ii
-----END PGP SIGNATURE-----

--4vgOdmpzXGVCiUly--
