Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUD0JWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUD0JWH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 05:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263948AbUD0JWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 05:22:07 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:64186 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263943AbUD0JWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 05:22:00 -0400
Date: Tue, 27 Apr 2004 11:21:59 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040427092159.GC29503@lug-owl.de>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@osdl.org>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <408DC0E0.7090500@gmx.net> <Pine.LNX.4.58.0404262116510.19703@ppc970.osdl.org> <1083045844.2150.105.camel@bach>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <1083045844.2150.105.camel@bach>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-04-27 16:04:06 +1000, Rusty Russell <rusty@rustcorp.com.au>
wrote in message <1083045844.2150.105.camel@bach>:
> On Tue, 2004-04-27 at 14:31, Linus Torvalds wrote:
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/curr=
ent-dontdiff --minimal .31262-linux-2.6.6-rc2-bk4/include/linux/module.h .3=
1262-linux-2.6.6-rc2-bk4.updated/include/linux/module.h
> --- .31262-linux-2.6.6-rc2-bk4/include/linux/module.h	2004-04-22 08:03:55=
=2E000000000 +1000
> +++ .31262-linux-2.6.6-rc2-bk4.updated/include/linux/module.h	2004-04-27 =
15:52:19.000000000 +1000
> @@ -61,7 +64,14 @@ void sort_main_extable(void);
>  #ifdef MODULE
>  #define ___module_cat(a,b) __mod_ ## a ## b
>  #define __module_cat(a,b) ___module_cat(a,b)
> +/* Some sick fucks embeded NULs in MODULE_LICENSE to circumvent checks. =
*/
> +#define __MODULE_INFO_CHECK(info)					  \
> +	static void __init __attribute_used__				  \
> +	__module_cat(__mc_,__LINE__)(void) {				  \
> +		BUILD_BUG_ON(__builtin_strlen(info) + 1 !=3D sizeof(info)); \
> +	}
>  #define __MODULE_INFO(tag, name, info)					  \
> +__MODULE_INFO_CHECK(info);						  \
>  static const char __module_cat(name,__LINE__)[]				  \
>    __attribute_used__							  \
>    __attribute__((section(".modinfo"),unused)) =3D __stringify(tag) "=3D"=
 info

Erm, that's a pure compile-time check, which the companies can remove.
So they can still put their fucked up license string into the module,
customer's kernel won't detect it.

So I'm full for embedding the supplied string's size into the module, or
some compile-time generated checksum. We need something that can be
checked at module load time, not at compile time, or do I misread the
code?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAjiY3Hb1edYOZ4bsRArlqAJ0W7r1Md3PNdGP4gVlW+nnSdfD2zwCfdaSZ
+1ehGeIQynqxCNo4sSeX+K4=
=Ox7e
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
