Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUEKJwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUEKJwK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 05:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUEKJwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 05:52:10 -0400
Received: from maximus.kcore.de ([213.133.102.235]:23352 "EHLO
	maximus.kcore.de") by vger.kernel.org with ESMTP id S262476AbUEKJwC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 05:52:02 -0400
From: Oliver Feiler <kiza@gmx.net>
To: Andrew Morton <akpm@osdl.org>, John McGowan <jmcgowan@inch.com>
Subject: Re: Kernel 2.6.6: Removing the last large file does not reset filesystem properties
Date: Tue, 11 May 2004 11:53:32 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <20040511002008.GA2672@localhost.localdomain> <20040511004956.70f7e17d.akpm@osdl.org>
In-Reply-To: <20040511004956.70f7e17d.akpm@osdl.org>
X-PGP-Key-Fingerprint: E9DD 32F1 FA8A 0945 6A74  07DE 3A98 9F65 561D 4FD2
X-PGP-Key: http://kiza.kcore.de/pgpkey
X-Species: Snow Leopard
X-Operating-System: Linux
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_jKKoAmdnj1obRn0";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405111153.39614.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_jKKoAmdnj1obRn0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On Tuesday 11 May 2004 09:49, Andrew Morton wrote:

> >   3: Was using Gimp 2.0 and used a tool. Got a 6 Gig swap file in
> > /tmp/gimp2 (there must be a problem with that tool). Closed gimp, got r=
id
> > of the swap file. Upon the next boot I got:
> >        FAILED!!
> >        Dropping to root command line for system maintenance
> >      (such fun ... entering the root password got more error messages
> > about missing programmes such as "id" and "test" - well, I have "/usr" =
on
> > another partition and it was not mounted).
>
> I think this is really an e2fsck/initscript problem.
>
> fsck saw that there were no large files on the fs, then fixed up the
> superblock to say that then returned an exit code which says "I modified
> the fs".
>
> The initscripts see that exit code and have a heart attack.
>
> What should happen is that fsck returns an exit code which says "I modifi=
ed
> the fs, but everythig is OK".  And the initscripts should say "oh, cool"
> and keep booting.
>
> I don't know whether the problem lies with fsck or initscripts.

Yes, it's an issue with the initscripts (I'd say). I stumbled over this=20
problem as well when upgrading e2fsprogs on a fairly old Slackware install.=
=20
=46rom the manpage of fsck:

The exit code returned by fsck is the sum of the following
       conditions:
            0    - No errors
            1    - File system errors corrected
            2    - System should be rebooted
[...]

The old Slackware init scripts (from 7.0 days I think) checked

 if [ $EXITCODE -gt 1 ] ; then
panic!

Newer fscks however also seem to return exit code 2 for "some errors=20
corrected, please reboot". In Slack 9's initscripts this was changed to aut=
o=20
reboot in this case. I think this behaviour was changed in some version of=
=20
fsck, but I'm note sure.

But admittedly I also got a slight heart attack when our server stopped=20
booting with an error from fsck. ;)

	Oliver

=2D-=20
Oliver Feiler  -  http://kiza.kcore.de/

--Boundary-02=_jKKoAmdnj1obRn0
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAoKKjOpifZVYdT9IRAsVrAKDWK21S8riaNxYxkS5TODYKBBAQ9ACg0pI5
aBJqxguh/MK13XVhdRA8UEc=
=bfBj
-----END PGP SIGNATURE-----

--Boundary-02=_jKKoAmdnj1obRn0--

