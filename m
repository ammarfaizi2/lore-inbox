Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVB1H7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVB1H7L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 02:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVB1H7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 02:59:11 -0500
Received: from dea.vocord.ru ([217.67.177.50]:35741 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261269AbVB1H7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 02:59:04 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>, kaigai@ak.jp.nec.com,
       marcelo.tosatti@cyclades.com, davem@redhat.com, jlan@sgi.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, elsa-devel@lists.sourceforge.net
In-Reply-To: <20050227233943.6cb89226.akpm@osdl.org>
References: <42168D9E.1010900@sgi.com>
	 <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com>
	 <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com>
	 <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com>
	 <20050224212839.7953167c.akpm@osdl.org> <20050227094949.GA22439@logos.cnet>
	 <4221E548.4000008@ak.jp.nec.com> <20050227140355.GA23055@logos.cnet>
	 <42227AEA.6050002@ak.jp.nec.com>
	 <1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	 <20050227233943.6cb89226.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FTo98wD54o5/gw974zAM"
Organization: MIPT
Date: Mon, 28 Feb 2005 11:04:36 +0300
Message-Id: <1109577876.28266.9.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 28 Feb 2005 10:58:19 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FTo98wD54o5/gw974zAM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2005-02-27 at 23:39 -0800, Andrew Morton wrote:
> Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> >
> >    Ok the protocol is maybe too "basic" but with this mechanism the use=
r
> >  space application that uses the fork connector can start and stop the
> >  send of messages. This implementation needs somme improvements because
> >  currently, if two application are using the fork connector one can
> >  enable it and the other don't know if it is enable or not, but the ide=
a
> >  is here I think.
>=20
> Yes.  But this problem can be solved in userspace, with a little library
> function and a bit of locking.
>=20
> IOW: use the library to enable/disable the fork connector rather than
> directly doing syscalls.
>=20
> It has the problem that if a client of that library crashes, the counter
> gets out of whack, but really, it's not all _that_ important, and to hand=
le
> this properly in-kernel each client would need an open fd against some
> object so we can do the close-on-exit thing properly.  You'd need to crea=
te
> a separate netlink socket for the purpose.

Why dont just extend protocol a bit?
Add header after cn_msg, which will have get/set field and that is all.
Properly using seq/ack fields userspace can avoid locks.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-FTo98wD54o5/gw974zAM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCItCUIKTPhE+8wY0RAjszAJ9EWkRLT5e/B2IsghRvFg/dWsYbMwCdGmoi
Gl6xamHltDiX087q/rr05hw=
=g7P/
-----END PGP SIGNATURE-----

--=-FTo98wD54o5/gw974zAM--

