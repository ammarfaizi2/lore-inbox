Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269152AbUIRH4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269152AbUIRH4x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269158AbUIRH4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:56:52 -0400
Received: from S010600105aa6e9d5.gv.shawcable.net ([24.68.24.66]:46231 "EHLO
	spitfire.gotdns.org") by vger.kernel.org with ESMTP id S269152AbUIRH4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:56:49 -0400
From: Ryan Cumming <ryan@spitfire.gotdns.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Date: Sat, 18 Sep 2004 00:56:44 -0700
User-Agent: KMail/1.7
Cc: Stelian Pop <stelian@popies.net>, James R Bruce <bruce@andrew.cmu.edu>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Andrea Arcangeli <andrea@novell.com>, Andrew Morton <akpm@osdl.org>
References: <20040917154834.GA3180@crusoe.alcove-fr> <200409171529.52864.ryan@spitfire.gotdns.org> <A9B5AE4E-0924-11D9-B8B0-000393ACC76E@mac.com>
In-Reply-To: <A9B5AE4E-0924-11D9-B8B0-000393ACC76E@mac.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10269439.4Lf7k03ePG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200409180056.47152.ryan@spitfire.gotdns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10269439.4Lf7k03ePG
Content-Type: multipart/mixed;
  boundary="Boundary-01=_8o+SBQ52JvgrOHu"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_8o+SBQ52JvgrOHu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 17 September 2004 20:41, Kyle Moffett wrote:
> This should probably be __const__, which is a stricter class of
> __pure__.
> The "__pure__" attribute means it has no side effects, whereas the
> "__const__" attribute means that it also _only_ depends on its
> arguments,
> not on any global memory or the data at any pointers passed to it.

Good call. I was just copying the __pure__ from long_log2 function in=20
kernel.h, which looks like it should be __const__ too.

Here's a third try, with Andrew's and your suggestions.

=2DRyan

--Boundary-01=_8o+SBQ52JvgrOHu
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="roundup-pow-two.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="roundup-pow-two.diff"

=2D-- include/linux/kernel.h	2004-09-16 06:38:19.000000000 -0700
+++ include/linux/kernel.h	2004-09-17 15:12:20.598844004 -0700
@@ -12,6 +12,7 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/bitops.h>
 #include <asm/byteorder.h>
 #include <asm/bug.h>
=20
@@ -111,6 +112,10 @@
 	return r;
 }
=20
+static inline unsigned long __attribute_const__ roundup_pow_of_two(unsigne=
d long x)
+{
+	return (1UL << fls(x - 1));
+}
=20
 extern int printk_ratelimit(void);
 extern int __printk_ratelimit(int ratelimit_jiffies, int ratelimit_burst);

--Boundary-01=_8o+SBQ52JvgrOHu--

--nextPart10269439.4Lf7k03ePG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBS+o/W4yVCW5p+qYRAk1qAJ9DMoVB5NJcrMUionYllcskmempJwCfaqXX
OjiRJSJrcqgstErtnvjtrlc=
=21cI
-----END PGP SIGNATURE-----

--nextPart10269439.4Lf7k03ePG--
