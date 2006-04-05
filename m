Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWDEJjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWDEJjz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 05:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWDEJjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 05:39:55 -0400
Received: from posthamster.phnxsoft.com ([195.227.45.4]:7437 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S1751196AbWDEJjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 05:39:54 -0400
Message-ID: <44339024.4030907@imap.cc>
Date: Wed, 05 Apr 2006 11:38:44 +0200
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: hjlipp@web.de, gigaset307x-common@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, kkeil@suse.de,
       isdn4linux@listserv.isdn4linux.de
Subject: Re: [2.6 patch] drivers/isdn/gigaset/common.c: small cleanups
References: <20060404162915.GJ6529@stusta.de>
In-Reply-To: <20060404162915.GJ6529@stusta.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3C82C182B6E07D063D573AB0"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C82C182B6E07D063D573AB0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Adrian Bunk wrote:

> This patch contains the following cleanups:
> - makethe needlessly global gigaset_get_cs_by_tty() static
> - remove the unused EXPORT_SYMBOL_GPL(gigaset_debugdrivers)

Thanks for catching these.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-by: Tilman Schmidt <tilman@imap.cc>

>
> ---
>
>  drivers/isdn/gigaset/common.c  |   17 ++++++++---------
>  drivers/isdn/gigaset/gigaset.h |    1 -
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> --- linux-2.6.16-mm2-full/drivers/isdn/gigaset/gigaset.h.old	2006-04-04 00:15:36.000000000 +0200
> +++ linux-2.6.16-mm2-full/drivers/isdn/gigaset/gigaset.h	2006-04-04 00:15:42.000000000 +0200
> @@ -754,7 +754,6 @@
>  /* Deallocate driver structure. */
>  void gigaset_freedriver(struct gigaset_driver *drv);
>  void gigaset_debugdrivers(void);
> -struct cardstate *gigaset_get_cs_by_minor(unsigned minor);
>  struct cardstate *gigaset_get_cs_by_tty(struct tty_struct *tty);
>  struct cardstate *gigaset_get_cs_by_id(int id);
>
> --- linux-2.6.16-mm2-full/drivers/isdn/gigaset/common.c.old	2006-04-04 00:06:34.000000000 +0200
> +++ linux-2.6.16-mm2-full/drivers/isdn/gigaset/common.c	2006-04-04 00:16:45.000000000 +0200
> @@ -962,16 +962,8 @@
>  	}
>  	spin_unlock_irqrestore(&driver_lock, flags);
>  }
> -EXPORT_SYMBOL_GPL(gigaset_debugdrivers);
>
> -struct cardstate *gigaset_get_cs_by_tty(struct tty_struct *tty)
> -{
> -	if (tty->index < 0 || tty->index >= tty->driver->num)
> -		return NULL;
> -	return gigaset_get_cs_by_minor(tty->index + tty->driver->minor_start);
> -}
> -
> -struct cardstate *gigaset_get_cs_by_minor(unsigned minor)
> +static struct cardstate *gigaset_get_cs_by_minor(unsigned minor)
>  {
>  	unsigned long flags;
>  	static struct cardstate *ret = NULL;
> @@ -994,6 +986,13 @@
>  	return ret;
>  }
>
> +struct cardstate *gigaset_get_cs_by_tty(struct tty_struct *tty)
> +{
> +	if (tty->index < 0 || tty->index >= tty->driver->num)
> +		return NULL;
> +	return gigaset_get_cs_by_minor(tty->index + tty->driver->minor_start);
> +}
> +
>  void gigaset_freedriver(struct gigaset_driver *drv)
>  {
>  	unsigned long flags;
>


--
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)

--------------enig3C82C182B6E07D063D573AB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEM5AkMdB4Whm86/kRAhQ8AJ9s/VsX+pb7z2EG7cXx1dl3GwpYLwCfY7bL
ZdJveUREgiPfFO1yttipK9E=
=cAkn
-----END PGP SIGNATURE-----

--------------enig3C82C182B6E07D063D573AB0--
