Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbVKIKRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbVKIKRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 05:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbVKIKRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 05:17:24 -0500
Received: from smtp06.auna.com ([62.81.186.16]:48014 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1030360AbVKIKRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 05:17:24 -0500
Date: Wed, 9 Nov 2005 11:16:40 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linas <linas@austin.ibm.com>, Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
Message-ID: <20051109111640.757f399a@werewolf.auna.net>
In-Reply-To: <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com>
References: <20051107185621.GD19593@austin.ibm.com>
	<20051107190245.GA19707@kroah.com>
	<20051107193600.GE19593@austin.ibm.com>
	<20051107200257.GA22524@kroah.com>
	<20051107204136.GG19593@austin.ibm.com>
	<1131412273.14381.142.camel@localhost.localdomain>
	<20051108232327.GA19593@austin.ibm.com>
	<B68D1F72-F433-4E94-B755-98808482809D@mac.com>
	<20051109003048.GK19593@austin.ibm.com>
	<m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local>
	<20051109004808.GM19593@austin.ibm.com>
	<19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com>
X-Mailer: Sylpheed-Claws 1.9.100cvs4 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_F0EEq=pjaNcfuobBdG2iUNj";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.199] Login:jamagallon@able.es Fecha:Wed, 9 Nov 2005 11:17:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_F0EEq=pjaNcfuobBdG2iUNj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Nov 2005 20:51:25 -0500, Kyle Moffett <mrmacman_g4@mac.com> wrote:

>=20
> Pass by value in C:
> do_some_stuff(arg1, arg2);
>=20
> Pass by reference in C:
> do_some_stuff(&arg1, &arg2);
>=20
> This is very obvious what it does.  The compiler does type-checks to =20
> make sure you don't get it wrong.  There are tools to check stack =20
> usage of functions too.  This is inherently obvious what the code =20
> does without looking at a completely different file where the =20
> function is defined.
>=20
>=20
> Pass by value in C++:
> do_some_stuff(arg1, arg2);
>=20
> Pass by reference in C++:
> do_some_stuff(arg1, arg2);
>=20
> This is C++ being clever and hiding stuff from the programmer, which =20
> is Not Good(TM) for a kernel.  C++ may be an excellent language for =20
> userspace programmers (I say "may" here because some disagree, =20
> including myself), however, many of the features are extremely =20
> problematic for a kernel.
>=20

Why is it not good for kernel ?
You want to pass an struct to a function in the best way you can.
Reference just pases a pointer instead of copying, but you don't
realize.
If you want the funcion to be able to modify the struct, code it as

void do_some_stuff(T& arg1,T&  arg2)

If you DO NOT want the funcion to be able to modify the struct, code it as

void do_some_stuff(const T& arg1,const T& arg2)
This is far better than in C,. because you get the benefits from
reference pass without the problems of accidental modification of
pointer contents. And get rid of arrows -> ;).

If the function modifies the struct it should be obvious from its name,
not depending if you put an & in the call or not.
And you stop worrying about argument pass methods.
The person who programs the function decides and can even change it without
you user even noticing.
And gcc does nice optimizations when you mix const& and inlining...

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam1 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_F0EEq=pjaNcfuobBdG2iUNj
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDccyIRlIHNEGnKMMRAs3YAKCSARLhqSt8KQySF9P2TH3yGQTp1wCfUpvO
CgHQkA5DJ5ytROe2v9LV3Sk=
=3XuL
-----END PGP SIGNATURE-----

--Sig_F0EEq=pjaNcfuobBdG2iUNj--
