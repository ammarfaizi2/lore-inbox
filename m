Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUGWSb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUGWSb6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267877AbUGWSb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 14:31:57 -0400
Received: from alhambra.mulix.org ([192.117.103.203]:7622 "EHLO
	granada.merseine.nu") by vger.kernel.org with ESMTP id S267872AbUGWSbf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 14:31:35 -0400
Date: Fri, 23 Jul 2004 21:31:07 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Robert Love <rml@ximian.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040723183107.GB4905@granada.merseine.nu>
References: <1090604517.13415.0.camel@lucy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
In-Reply-To: <1090604517.13415.0.camel@lucy>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 23, 2004 at 01:41:57PM -0400, Robert Love wrote:
> +void send_kmessage(int type, const char *object, const char *signal,
> +		   const char *fmt, ...)
> +{
> +	char *buffer;
> +	int len;
> +	int ret;
> +
> +	if (!object)
> +		return;
> +
> +	if (!signal)
> +		return;
> +
> +	if (strlen(object) > PAGE_SIZE)
> +		return;
> +
> +	buffer =3D (char *) get_zeroed_page(GFP_ATOMIC);
> +	if (!buffer)
> +		return;
> +
> +	len =3D sprintf(buffer, "From: %s\n", object);
> +	len +=3D sprintf(&buffer[len], "Signal: %s\n", signal);
> +
> +	/* possible anxiliary data */
> +	if (fmt) {
> +		va_list args;
> +
> +		va_start(args, fmt);
> +		len +=3D vscnprintf(&buffer[len], PAGE_SIZE-len-1, fmt, args);
> +		va_end(args);
> +	}
> +	buffer[len++] =3D '\0';
> +
> +	ret =3D netlink_send((1 << type), buffer, len);

Should we be ignoring the return value of netlink_send here, or
propogating a possible error to the callers?

> +	free_page((unsigned long) buffer);
> +}

Cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBAVlrKRs727/VN8sRAiZJAJ0ev1TeNZLyS0QODLQlbRUhU6IlggCffDst
GLzNIjOduodRn9+U3zYrjvI=
=kfv1
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
