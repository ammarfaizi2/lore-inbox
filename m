Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbVKJUyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbVKJUyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 15:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVKJUyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 15:54:20 -0500
Received: from smtp04.auna.com ([62.81.186.14]:52694 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S932115AbVKJUyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 15:54:18 -0500
Date: Thu, 10 Nov 2005 21:53:40 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: typedefs and structs
Message-ID: <20051110215340.1dfcf631@werewolf.auna.net>
In-Reply-To: <Pine.LNX.4.58.0511101127240.8572@shell2.speakeasy.net>
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
	<20051110091517.2e9db750@werewolf.auna.net>
	<17267.19126.260133.903822@gargle.gargle.HOWL>
	<253CB85C-E048-411E-B202-F7AB8DBFE2E7@mac.com>
	<Pine.LNX.4.58.0511101127240.8572@shell2.speakeasy.net>
X-Mailer: Sylpheed-Claws 1.9.100cvs7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_H.9gwXuSnF=ZOv/vMCnyncQ";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.199] Login:jamagallon@able.es Fecha:Thu, 10 Nov 2005 21:54:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_H.9gwXuSnF=ZOv/vMCnyncQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Nov 2005 11:28:27 -0800 (PST), Vadim Lobanov <vlobanov@speakeasy=
.net> wrote:

> On Thu, 10 Nov 2005, Kyle Moffett wrote:
>=20
> > On Nov 10, 2005, at 08:27:18, Nikita Danilov wrote:
> > > extern declaration in your version of bar() cannot refer to the
> > > automatic variable myvar in foo().
> >
> > int foo;
>=20
> Except foo is not an automatic variable within show(). When the variable
> is global, then there's no argument. It was a question of when foo is
> local and bar() would get a const pointer to the local.
>=20
> > void bar(const int *local_var) {
> >      foo =3D *local_var + 1;
> > }
> >
> > void show(void) {
> >      printf("%d\n", foo);
> >      bar(&foo);
> >      printf("%d\n", foo);
> > }
> >

You can tweak it all as you want:

int* foo_p;

void bar(const int *local_var) {
  *foo_p =3D *local_var + 1;
}

int main() {
  int foo;
  foo_p =3D &foo;
  printf("%d\n", foo);
  bar(&foo);
  printf("%d\n", foo);

  return 0;
}

The fact is that gcc can't suppose anything unless you say explicitly it ca=
n.
That is why 'pure' and 'const' __attributes__ exist, it supposes aliasing
by default and so on.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam1 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_H.9gwXuSnF=ZOv/vMCnyncQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDc7NURlIHNEGnKMMRAhs7AJ4hdk0LW4p6lQE91/3gQ9ywaJewkQCgiStY
E91UlfOjXsqTvqHgGNQ1i+w=
=MWRA
-----END PGP SIGNATURE-----

--Sig_H.9gwXuSnF=ZOv/vMCnyncQ--
