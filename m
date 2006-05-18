Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWERADu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWERADu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 20:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWERADu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 20:03:50 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:2459 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750727AbWERADt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 20:03:49 -0400
X-Sasl-enc: VlEjyAWZmqboRnmScE3ROSUEdZfhvwnBlMsxGlXoy13P 1147910628
Message-ID: <446BB9F0.3050708@imap.cc>
Date: Thu, 18 May 2006 02:04:00 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Karsten Keil <kkeil@suse.de>
Subject: Re: 2.6.17-rc4-mm1
References: <6cGjz-1Io-9@gated-at.bofh.it> <6cPGb-7pP-31@gated-at.bofh.it>
In-Reply-To: <6cPGb-7pP-31@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig137E289C5A82D79D67674345"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig137E289C5A82D79D67674345
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 15.05.2006 20:10, Jesper Juhl wrote:
> In the=20
> isdn-unsafe-interaction-between-isdn_write-and-isdn_writebuf_stub.patch=
=20
> patch, which is currently in -mm there's a bug.
>=20
> This bit :
>  -       copy_from_user(skb_put(skb, len), buf, len);
>  +       if (!copy_from_user(skb_put(skb, len), buf, len))
> should really be :
>  -       copy_from_user(skb_put(skb, len), buf, len);
>  +       if (copy_from_user(skb_put(skb, len), buf, len))
> Somehow a stray "!" crept in there.

Ouch. I hadn't noticed that either. Sorry about that.

Strangely, I ran a system with that patch for quite some time, actually
doing all kinds of ISDN connections without ever noticing any ill
effects. I can only conclude that the affected codebranch was never
exercised, which makes me suspect it is dead, or at least pining for the
fjords. Looking closer, I can't help noticing that the only branch
calling the affected function isdn_writebuf_stub() starts out with:

	printk(KERN_WARNING "isdn_write minor %d obsolete!\n", minor);

So I guess it really doesn't make much difference one way or the other.
But it's certainly more correct that way, so:

> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Acked-by: Tilman Schmidt <tilman@imap.cc>

> --- linux-2.6.17-rc4-mm1-orig/drivers/isdn/i4l/isdn_common.c	2006-05-15=
 19:43:06.000000000 +0200
> +++ linux-2.6.17-rc4-mm1/drivers/isdn/i4l/isdn_common.c	2006-05-15 19:5=
8:26.000000000 +0200
> @@ -1952,7 +1952,7 @@ isdn_writebuf_stub(int drvidx, int chan,
>  	if (!skb)
>  		return -ENOMEM;
>  	skb_reserve(skb, hl);
> -	if (!copy_from_user(skb_put(skb, len), buf, len))
> +	if (copy_from_user(skb_put(skb, len), buf, len))
>  		return -EFAULT;
>  	ret =3D dev->drv[drvidx]->interface->writebuf_skb(drvidx, chan, 1, sk=
b);
>  	if (ret <=3D 0)

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig137E289C5A82D79D67674345
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEa7n8MdB4Whm86/kRAupBAJ9SbFEaJ1eE0J+1oc0ajk9msK732gCfYgSf
traYcjRM2kSUd7jGiuXg1yY=
=nliW
-----END PGP SIGNATURE-----

--------------enig137E289C5A82D79D67674345--
