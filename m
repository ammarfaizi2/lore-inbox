Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUELVxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUELVxG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUELVxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:53:06 -0400
Received: from zlynx.org ([199.45.143.209]:35076 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S261991AbUELVvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:51:14 -0400
Subject: Re: MSEC_TO_JIFFIES is messed up...
From: Zan Lynx <zlynx@acm.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Davide Libenzi <davidel@xmailserver.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
In-Reply-To: <20040512211255.GA20800@elte.hu>
References: <20040512020700.6f6aa61f.akpm@osdl.org>
	 <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com>
	 <20040512193349.GA14936@elte.hu>
	 <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>
	 <20040512200305.GA16078@elte.hu>
	 <Pine.LNX.4.58.0405121400360.11950@bigblue.dev.mdolabs.com>
	 <20040512211255.GA20800@elte.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TSvOT4uBe9kejsl+Vsvr"
Message-Id: <1084398565.27252.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7jb) 
Date: Wed, 12 May 2004 15:49:25 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TSvOT4uBe9kejsl+Vsvr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-05-12 at 15:12, Ingo Molnar wrote:
> * Davide Libenzi <davidel@xmailserver.org> wrote:
>=20
> > int foo(int i) {
> >=20
> >=20
> >         return i * 1000 / 1000;
> > }
>=20
> try unsigned and you'll see:
>=20
>         pushl   %ebp
>         movl    %esp, %ebp
>         movl    8(%ebp), %edx
>         movl    %edx, %eax
>         sall    $2, %eax
>         addl    %edx, %eax
>         leal    0(,%eax,4), %edx
>         addl    %edx, %eax
>         leal    0(,%eax,4), %edx
>         addl    %edx, %eax
>         leal    0(,%eax,8), %edx
>         movl    $274877907, %eax
>         mull    %edx
>         movl    %edx, %eax
>         shrl    $6, %eax
>         leave
>         ret
>=20
>     Ingo

Being curious, I tried that and got the same results.  But this:

int f(unsigned int x)
{
        return x * (1000 / 1000);
}

creates this:
f:
        pushl   %ebp
        movl    %esp, %ebp
        movl    8(%ebp), %eax
        leave
        ret
        .size   f, .-f
        .section        .note.GNU-stack,"",@progbits
        .ident  "GCC: (GNU) 3.3.2 20031022 (Red Hat Linux 3.3.2-1)"

--=20
Zan Lynx <zlynx@acm.org>

--=-TSvOT4uBe9kejsl+Vsvr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAopvlG8fHaOLTWwgRAilYAJoCetflU/b9t1jCd3TTmt1pr8y1vgCgl3nl
iIZzbe7veMs6dG/SQTrHMxo=
=cMga
-----END PGP SIGNATURE-----

--=-TSvOT4uBe9kejsl+Vsvr--

