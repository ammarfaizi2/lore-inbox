Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbWATSOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWATSOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 13:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWATSOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 13:14:17 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45765 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751132AbWATSOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 13:14:16 -0500
Message-Id: <200601201813.k0KIDa6B003760@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Jiri Slaby <xslaby@fi.muni.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S.Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Iptables error [Was: 2.6.16-rc1-mm2] 
In-Reply-To: Your message of "Fri, 20 Jan 2006 17:23:18 +0100."
             <20060120162317.5F70722B383@anxur.fi.muni.cz> 
From: Valdis.Kletnieks@vt.edu
References: <20060120162317.5F70722B383@anxur.fi.muni.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1137780816_3397P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 20 Jan 2006 13:13:36 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1137780816_3397P
Content-Type: text/plain; charset=us-ascii

On Fri, 20 Jan 2006 17:23:18 +0100, Jiri Slaby said:
> Andrew Morton wrote:
> >Changes since 2.6.16-rc1-mm1:
> >
> >
> > linus.patch
> Hello,
> 
> Commit 4f2d7680cb1ac5c5a70f3ba2447d5aa5c0a1643a (Linus' 2.6 git tree) breaks my
> iptables (1.3.4):

> This is it:
> [NETFILTER] x_tables: Make XT_ALIGN align as strictly as necessary.
> 
> Or else we break on ppc32 and other 32-bit platforms.
> 
> Based upon a patch from Harald Welte.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> --- include/linux/netfilter/x_tables.h
> +++ include/linux/netfilter/x_tables.h
> @@ -19,7 +19,7 @@ struct xt_get_revision
> /* For standard target */
> #define XT_RETURN (-NF_REPEAT - 1)
> -#define XT_ALIGN(s) (((s) + (__alignof__(void *)-1)) & ~(__alignof__(void *)-1))
> +#define XT_ALIGN(s) (((s) + (__alignof__(u_int64_t)-1)) & ~(__alignof__(u_int64_t)-1))
> /* Standard return verdict, or do jump. */
> #define XT_STANDARD_TARGET ""

Confirmed here.  Backing out this one-liner makes iptables work for me.
i686 on a Pentium-4, gcc 4.1.0 from Fedora -devel tree.



--==_Exmh_1137780816_3397P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFD0ShQcC3lWbTT17ARAnKuAKCs5EHguSIMkw8ftiPDIc9O6dFq/ACeNfC2
Etku4gBUpJJ0GTpNSUWRJ3Y=
=lECb
-----END PGP SIGNATURE-----

--==_Exmh_1137780816_3397P--
