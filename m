Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266609AbUFWTDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266609AbUFWTDq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUFWTDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:03:45 -0400
Received: from mout1.freenet.de ([194.97.50.132]:10410 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S266609AbUFWTDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:03:18 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: dcn@sgi.com (Dean Nelson)
Subject: Re: [RFC] replace assorted ASSERT()s by something officially  sanctioned
Date: Wed, 23 Jun 2004 21:02:24 +0200
User-Agent: KMail/1.6.2
References: <40D9D09D.mailx49E1J10NF@aqua.americas.sgi.com>
In-Reply-To: <40D9D09D.mailx49E1J10NF@aqua.americas.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406232102.26678.mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> +#ifdef DEBUG
> +#define DBUG_ON(condition)	BUG_ON(condition)
> +#else
> +#define DBUG_ON(condition)
> +#endif

As condition is lost when DEBUG is not defined, what about that:

#else
# define DBUG_ON(condition)	do { if (condition) { /* nothing */ } } while (0)
#endif

letting the compiler optimize away all the stuff and removing
the risk of loosing an expression in ( ).

- --
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2dPAFGK1OIvVOP4RAuPrAJ9juu+dZLSt1QjsMQeko82n9OgLqgCeN0TQ
Fec6PgrBWBRwLxl6U65QVmw=
=l7+o
-----END PGP SIGNATURE-----
