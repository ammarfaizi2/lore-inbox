Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbWKCMBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbWKCMBF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 07:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbWKCMBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 07:01:05 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:31906 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751474AbWKCMBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 07:01:03 -0500
X-Sasl-enc: 5680/jtE2wfMYYpZSgYo/O8GTzHOfIDlp0pxKDea5bQV 1162555263
Message-ID: <454B300E.8040607@imap.cc>
Date: Fri, 03 Nov 2006 13:03:26 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       Hansjoerg Lipp <hjlipp@web.de>, Andrew Morton <akpm@osdl.org>,
       Karsten Keil <kkeil@suse.de>
Subject: Re: [PATCH] isdn/gigaset: avoid cs->dev null pointer dereference
References: <20061028184500.GE9973@localhost>
In-Reply-To: <20061028184500.GE9973@localhost>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig92FFFC24825C9F53EC7493FF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92FFFC24825C9F53EC7493FF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[Argh. Kaum ist man mal ein paar Tage weg ...]

Am 28.10.2006 20:45 schrieb Akinobu Mita:
> --- work-fault-inject.orig/drivers/isdn/gigaset/common.c
> +++ work-fault-inject/drivers/isdn/gigaset/common.c
> @@ -579,7 +579,7 @@ static struct bc_state *gigaset_initbcs(
>  	} else if ((bcs->skb =3D dev_alloc_skb(SBUFSIZE + HW_HDR_LEN)) !=3D N=
ULL)
>  		skb_reserve(bcs->skb, HW_HDR_LEN);
>  	else {
> -		dev_warn(cs->dev, "could not allocate skb\n");
> +		gig_dbg(DEBUG_INIT, "could not allocate skb\n");
>  		bcs->inputstate |=3D INS_skip_frame;
>  	}

I'm not quite happy with that patch. (Nor, for that matter, with the
speed it was pushed into mainline, without waiting even a few days
for comments from the maintainers of the code in question.)
Not being able to allocate that skb seriously impairs functionality
of the driver. It should be reported on production systems too, not
just on debug builds.

In short: NAK. Please revert, and replace by the following:

From: Tilman Schmidt <tilman@imap.cc>

Avoid usage of uninitialized cs->dev in gigaset_initbcs().

Signed-off-by: Tilman Schmidt <tilman@imap.cc>
Cc: Hansjoerg Lipp <hjlipp@web.de>
Cc: Karsten Keil <kkeil@suse.de>
Cc: Kai Germaschewski <kai.germaschewski@gmx.de>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>
---

 drivers/isdn/gigaset/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/isdn/gigaset/common.c
+++ b/drivers/isdn/gigaset/common.c
@@ -616,7 +616,7 @@ static struct bc_state *gigaset_initbcs(
 	} else if ((bcs->skb =3D dev_alloc_skb(SBUFSIZE + HW_HDR_LEN)) !=3D NUL=
L)
 		skb_reserve(bcs->skb, HW_HDR_LEN);
 	else {
-		dev_warn(cs->dev, "could not allocate skb\n");
+		warn("could not allocate skb");
 		bcs->inputstate |=3D INS_skip_frame;
 	}


--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enig92FFFC24825C9F53EC7493FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFSzAdMdB4Whm86/kRAjo3AJkB5fKjZ0AKSV8tV6GO7nvj63WQRACeJNUT
T4N8YB1bd9K6ItmdVeXD1H0=
=geZ3
-----END PGP SIGNATURE-----

--------------enig92FFFC24825C9F53EC7493FF--
