Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVAOQD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVAOQD3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 11:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVAOQD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 11:03:29 -0500
Received: from lug-owl.de ([195.71.106.12]:37043 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S262293AbVAOQDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 11:03:21 -0500
Date: Sat, 15 Jan 2005 17:03:21 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Avishay Traeger <atraeger@cs.sunysb.edu>
Subject: Re: Adding a new system call from a module in 2.6
Message-ID: <20050115160321.GN28037@lug-owl.de>
Mail-Followup-To: Linux kernel <linux-kernel@vger.kernel.org>,
	Avishay Traeger <atraeger@cs.sunysb.edu>
References: <1105735760.3253.23.camel@avishay.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0501141554530.6747@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501141554530.6747@chaos.analogic.com>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--o+ZCuNqY+dEAKBWl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-01-14 16:12:38 -0500, linux-os <linux-os@analogic.com>
wrote in message <Pine.LNX.4.61.0501141554530.6747@chaos.analogic.com>:
> On Fri, 14 Jan 2005, Avishay Traeger wrote:
> >Now that the sys_call_table is no longer exported, what would be the
> >best way to add a new system call from a module in 2.6?  I have only

Actually, there's no "correct" or good way to do that at all. Currently,
the system call number is used as an index to a pointer table on most
archs (with a bit of added complexity possibly because of supported
different APIs, eg. on MIPS).

However, that's not always true. For the VAX port, we've considered
having structs per syscall, not only a single pointer.

Also, adding syscalls somewhere won't lead to a stable API, so you may
run into problems off the user space...

> >seen the system call table in assembly code (such as in
> >arch/i386/kernel/entry.S) and do not know how to export it.  I know that
> >doing this is not recommended, but it would save me a lot of time while
> >developing new system calls (no need to recompile kernel and reboot for
> >every change).  Thanks in advance for any suggestions.

For testing purposes, you'd add some dummy entry at the end and register
(through an exported function you've got to add to the core kernel) your
function pointer with it.

However, the basic question is: you you *really* need to have new
syscalls? Just right now, we've already got too many of 'em... So what's
the main goal you want to achieve with your software?

> Just don't expect this to be put into a standard kernel.

Seconded...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB6T7JHb1edYOZ4bsRAi26AJ45lqglqgVAYLgek+KutP/VfuFqvwCeLMLr
MFRziIfLwZUXQEovb58YQN8=
=yf4b
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--
