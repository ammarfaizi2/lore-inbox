Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312161AbSCYVqJ>; Mon, 25 Mar 2002 16:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312163AbSCYVp7>; Mon, 25 Mar 2002 16:45:59 -0500
Received: from CPE00c0f0141dc1.cpe.net.cable.rogers.com ([24.42.47.5]:23246
	"EHLO mail.jukie.net") by vger.kernel.org with ESMTP
	id <S312161AbSCYVpu>; Mon, 25 Mar 2002 16:45:50 -0500
Date: Mon, 25 Mar 2002 16:45:35 -0500
From: Bart Trojanowski <bart@jukie.net>
To: Anthony Chee <anthony.chee@polyu.edu.hk>, linux-kernel@vger.kernel.org
Cc: kbuild-devel@vger.kernel.org, kernelnewbies@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: undefined reference
Message-ID: <20020325164535.A5144@jukie.net>
In-Reply-To: <004501c1d34f$32bda110$0100a8c0@winxp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Anthony Chee <anthony.chee@polyu.edu.hk> [020324 11:17]:
> I am now developing a module. This module need communicate with the kerne=
l.
> So I exported a function func(), by using EXPORT_SYMBOL(func). In the hea=
der
> file, I set "extern int func()".
<snip>

The problem you face is that the kernel needs to know where foo is to
generate a the bytecode that calls it.  Here is a better scenario...

You expose an interface in the kernel such as

	typedef void (*func_t)(int);
	void register_func ( func_t func );
	EXPORT_SYMBOL (register_func);

Then in your modules you call 'register_func' and that will pass the
function in question to the kernel.  The kernel can then do whatever it
wants to that pointer (like call it).

B.

--=20
				WebSig: http://www.jukie.net/~bart/sig/

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8n5p/kmD5p7UxHJcRAnGAAJ40wZDL2LLYMdSVQ+hmJe/FpsBvPQCfaB9q
Dw+WW7brhnzPPniFJeG/yKw=
=Keu5
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
