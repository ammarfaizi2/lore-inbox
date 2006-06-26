Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWFZJSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWFZJSK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 05:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWFZJSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 05:18:10 -0400
Received: from mail.gmx.net ([213.165.64.21]:18368 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751307AbWFZJSJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 05:18:09 -0400
X-Authenticated: #5108953
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Fwd: Re: linux-2.6.17.1: undefined reference to `online_page'
Date: Mon, 26 Jun 2006 11:17:55 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart13396758.Dg5YFjhAkk";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606261117.55594.toralf.foerster@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart13396758.Dg5YFjhAkk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



=2D---------  Weitergeleitete Nachricht  ----------

Subject: Re: linux-2.6.17.1: undefined reference to `online_page'
Date: Monday 26 June 2006 11:14
=46rom: Toralf F=F6rster <toralf.foerster@gmx.de>
To: Yasunori Goto <y-goto@jp.fujitsu.com>

Am Monday 26 June 2006 09:39 schrieben Sie:
> > In-Reply-To: <200606231001.33766.toralf.foerster@gmx.de>
> >=20
> > On Fri, 23 Jun 2006 10:01:33 +0200, Toralf Foerster wrote:
> >=20
> > > I got the compile error :
> > >=20
> > > ...
> > >   UPD     include/linux/compile.h
> > >   CC      init/version.o
> > >   LD      init/built-in.o
> > >   LD      .tmp_vmlinux1
> > > mm/built-in.o: In function `online_pages':
> > > : undefined reference to `online_page'
> > > make: *** [.tmp_vmlinux1] Error 1
> > >=20
> > > with this config:
> >=20
> > > CONFIG_X86_32=3Dy
> >=20
> > > CONFIG_NOHIGHMEM=3Dy
> >=20
> > > CONFIG_SPARSEMEM_MANUAL=3Dy
> > > CONFIG_SPARSEMEM=3Dy
> > > CONFIG_HAVE_MEMORY_PRESENT=3Dy
> > > CONFIG_SPARSEMEM_STATIC=3Dy
> > > CONFIG_MEMORY_HOTPLUG=3Dy
> >=20
> > Yes, that config is broken. mm/memory_hotplug.c::online_pages() calls
> > online_page() but without HIGHMEM that doesn't get built and no dummy
> > function gets defined.
>=20
> Toralf-san. How is this patch?
> Or do you want to use memory hotplug without highmem?
>=20
> Bye.
>=20
> ---
>=20
> add_memory() for i386 add memory to highmem. So, if CONFIG_HIGHMEM
> is not set, CONFIG_MEMORY_HOTPLUG shouldn't be set.
>=20
>=20
> Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
>=20
> ---
>  mm/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: linux-2.6.17/mm/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.17.orig/mm/Kconfig	2006-06-26 14:19:11.000000000 +0900
> +++ linux-2.6.17/mm/Kconfig	2006-06-26 14:19:53.000000000 +0900
> @@ -115,7 +115,7 @@ config SPARSEMEM_EXTREME
>  # eventually, we can have this option just 'select SPARSEMEM'
>  config MEMORY_HOTPLUG
>  	bool "Allow for memory hot-add"
> -	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND
> +	depends on SPARSEMEM && HOTPLUG && !SOFTWARE_SUSPEND && !(X86_32 && !HI=
GHMEM)
> =20
>  comment "Memory hotplug is currently incompatible with Software Suspend"
>  	depends on SPARSEMEM && HOTPLUG && SOFTWARE_SUSPEND
>=20

Works fine with that patch, thanks :-)

BTW, I created the .config using the command sequence "make randconfig && <=
adapt .config to local machine> &&
make oldconfig".


=2D-=20
MfG/Sincerely
Toralf F=F6rster


=2D------------------------------------------------------

=2D-=20
MfG/Sincerely
Toralf F=F6rster

--nextPart13396758.Dg5YFjhAkk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEn6ZDhyrlCH22naMRAs8BAJ9MkeviwhwThRTMCMqBPUCMC/OiFACeI4+8
gPkgpGgVvgcuRMxIX6ALKRI=
=nH67
-----END PGP SIGNATURE-----

--nextPart13396758.Dg5YFjhAkk--
