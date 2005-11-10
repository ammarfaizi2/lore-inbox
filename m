Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVKJIP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVKJIP6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 03:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVKJIP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 03:15:58 -0500
Received: from smtp06.auna.com ([62.81.186.16]:921 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S1751191AbVKJIP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 03:15:57 -0500
Date: Thu, 10 Nov 2005 09:15:17 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: typedefs and structs
Message-ID: <20051110091517.2e9db750@werewolf.auna.net>
In-Reply-To: <Pine.LNX.4.58.0511091347570.31338@shell3.speakeasy.net>
References: <20051107204136.GG19593@austin.ibm.com>
	<1131412273.14381.142.camel@localhost.localdomain>
	<20051108232327.GA19593@austin.ibm.com>
	<B68D1F72-F433-4E94-B755-98808482809D@mac.com>
	<20051109003048.GK19593@austin.ibm.com>
	<m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local>
	<20051109004808.GM19593@austin.ibm.com>
	<19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com>
	<20051109111640.757f399a@werewolf.auna.net>
	<Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net>
	<20051109192028.GP19593@austin.ibm.com>
	<Pine.LNX.4.61.0511091459440.12760@chaos.analogic.com>
	<Pine.LNX.4.58.0511091347570.31338@shell3.speakeasy.net>
X-Mailer: Sylpheed-Claws 1.9.100cvs4 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_2LwNOs9SKxHNzVm=EZskKjt";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.199] Login:jamagallon@able.es Fecha:Thu, 10 Nov 2005 09:15:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_2LwNOs9SKxHNzVm=EZskKjt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Nov 2005 14:12:38 -0800 (PST), Vadim Lobanov <vlobanov@speakeasy.=
net> wrote:

> On Wed, 9 Nov 2005, linux-os \(Dick Johnson\) wrote:
>=20
> >
> > On Wed, 9 Nov 2005, linas wrote:
> >
> > > On Wed, Nov 09, 2005 at 08:22:15AM -0800, Vadim Lobanov was heard to =
remark:
> > >> On Wed, 9 Nov 2005, J.A. Magallon wrote:
> > >>
> > >>> void do_some_stuff(T& arg1,T&  arg2)
> > >>
> > >> A diligent C programmer would write this as follows:
> > >> 	void do_some_stuff (struct T * a, struct T * b);
> > >> So I don't see C++ winning at all here.
> > >
> > > I guess the real point that I'd wanted to make, and seems
> > > to have gotten lost, was that by avoiding using pointers,
> > > you end up designing code in a very different way, and you
> > > can find out that often/usually, you don't need structs
> > > filled with a zoo of pointers.
> > >
> >
> > But you can't avoid pointers unless you make your entire
> > program have global scope. That may be great for performance,
> > but a killer if for have any bugs.
>=20
> Just to extract some useful technical knowledge from the current ongoing
> "flamewar"...
> I'm not entirely sure if the above statement regarding performance is
> correct. Some enlightenment would be appreciated.
>=20
> Suppose you have the following code:
> 	int myvar;
> 	void foo (void) {
> 		printf("%d\n", myvar);
> 		bar();
> 		printf("%d\n", myvar);
> 	}
> If bar is declared in _another_ file as
> 	void bar (void);
> then I believe the compiler has to reread the global 'myvar' from memory
> for the second printf().
>=20
> However, if the code is as follows:
> 	void foo (void) {
> 		int myvar =3D 0;
> 		printf("%d\n", myvar);
> 		bar(&myvar);
> 		printf("%d\n", myvar);
> 	}
> If bar is declared in _another_ file as
> 	void bar (const int * var);
> then I think the compiler can validly cache the value of 'myvar' for the
> second printf without re-reading it. Correct/incorrect?
>=20

Nope. You can't trust bar() not doing something like

bar(const int* local_var)
{
   ... use local_var as ro...
   extern int myvar;
   myvar =3D 7;
}

For the compiler to do that, you must tag bar() with attribute(pure).

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam1 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_2LwNOs9SKxHNzVm=EZskKjt
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDcwGVRlIHNEGnKMMRAvFXAJ40SxVt/WdK8uom3j5X6Hw+rXi6RwCdF9+w
5Zlqc9Cg9m1xq39cGapw2V4=
=zor0
-----END PGP SIGNATURE-----

--Sig_2LwNOs9SKxHNzVm=EZskKjt--
