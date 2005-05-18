Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVERLL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVERLL4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 07:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVERLKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 07:10:54 -0400
Received: from home.leonerd.org.uk ([217.147.80.44]:22975 "EHLO
	home.leonerd.org.uk") by vger.kernel.org with ESMTP id S262173AbVERLKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 07:10:18 -0400
Date: Wed, 18 May 2005 12:10:13 +0100
From: Paul LeoNerd Evans <leonerd@leonerd.org.uk>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix to virtual terminal UTF-8 mode handling
Message-ID: <20050518121013.65398e64@nim.leo>
In-Reply-To: <20050518031030.GA20086@nevyn.them.org>
References: <20050518030513.7fe55ef1@nim.leo>
	<20050517195848.4a09318d.akpm@osdl.org>
	<20050518031030.GA20086@nevyn.them.org>
X-Mailer: Sylpheed-Claws 1.9.6cvs45 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Wed__18_May_2005_12_10_13_+0100_Ll.APH6dB29dvIgZ;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature_Wed__18_May_2005_12_10_13_+0100_Ll.APH6dB29dvIgZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 May 2005 23:10:30 -0400
Daniel Jacobowitz <dan@debian.org> wrote:

> I'd be inclined to think that this is more of a terminfo issue.  If you
> want your terminal to reset into UTF-8, use a terminfo entry with the
> appropriate command string instead of the current one - this would be
> the 'rs1' capability:
>=20
>   rs1=3D\Ec\E]R
>=20
> That's reset console to default, reset palette.

Unfortunately, that doesn't work. Doing it that way means that any
program running on a host whose terminfo is so configured, would force
UTF-8 mode on, when it issues a reset to a Linux console, regardless of
which machine that is on (e.g. telnet, ssh,...). Furthermore, it would do
so regardless of whether we want UTF-8 mode, or not. Again with my patch
it is a user configurable matter whether they want UTF-8 or not. This
terminfo entry forces it to happen.

That said, I am planning a whole bunch of other changes to terminfo; my
repeated wrestling with xterm recently on the regard of modified cursor
keys (e.g. Ctrl+left) has lead me to conclude the whole system needs a
bit of an overhaul... But that's somewhat off-topic to the kernel.. :)

--=20
Paul "LeoNerd" Evans

leonerd@leonerd.org.uk
ICQ# 4135350       |  Registered Linux# 179460
http://www.leonerd.org.uk/

--Signature_Wed__18_May_2005_12_10_13_+0100_Ll.APH6dB29dvIgZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCiyKYvcPg11V/1hgRAsnLAKCBJZFFon1tkV/7gU8ToUA+I77qhACfXlCZ
DQvgc4Fk8Laq4HAxcx8pWF8=
=XYRQ
-----END PGP SIGNATURE-----

--Signature_Wed__18_May_2005_12_10_13_+0100_Ll.APH6dB29dvIgZ--
