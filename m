Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318224AbSHDUkq>; Sun, 4 Aug 2002 16:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318225AbSHDUkq>; Sun, 4 Aug 2002 16:40:46 -0400
Received: from ppp-217-133-220-178.dialup.tiscali.it ([217.133.220.178]:42703
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318224AbSHDUkp>; Sun, 4 Aug 2002 16:40:45 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Luca Barbieri <ldb@ldb.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028498075.15200.29.camel@irongate.swansea.linux.org.uk>
References: <1028471237.1294.515.camel@ldb>  <20020804185952.GC1670@junk> 
	<1028492596.1293.535.camel@ldb> 
	<1028498075.15200.29.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ZIqX+Wv+3nph8wzv60Tk"
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Aug 2002 22:43:34 +0200
Message-Id: <1028493814.26332.9.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZIqX+Wv+3nph8wzv60Tk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2002-08-04 at 23:54, Alan Cox wrote:
> On Sun, 2002-08-04 at 21:23, Luca Barbieri wrote:
> > Added, with the exception that sfence is only used if CONFIG_X86_OOSTORE
> > is not defined (currently never).
> 
> Ok sorry I follow what you are doing. What I don't understand is why you
> are generating unneeded sfence/mfence instructions in the other cases ?
It was my fault: I explained it incorrectly. sfence is only used if both
CONFIG_X86_OOSTORE and CONFIG_MMXEXT are set, which currently never
happens with the existing processors.
 
> When we use MMX/SSE we need the view to be consistent anyway so the
> various copying routines already handle this internally. 
That's why sfence is not used unless CONFIG_X86_OOSTORE (and
CONFIG_X86_MMXEXT) is defined.
mfence and lfence instead replace the "lock; addl $0,0(%%esp)". Is this
wrong?


--=-ZIqX+Wv+3nph8wzv60Tk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9TZH2djkty3ft5+cRAoToAJ9cNPcdFzbL2ey+OH6mpNjgvnuUzACgr4bP
cdRy7ge1Rg47HdYfnVOpKi4=
=sCwe
-----END PGP SIGNATURE-----

--=-ZIqX+Wv+3nph8wzv60Tk--
