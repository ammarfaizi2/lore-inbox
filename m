Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbTLQTb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 14:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264528AbTLQTb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 14:31:29 -0500
Received: from [38.119.218.103] ([38.119.218.103]:5603 "HELO
	mail.bytehosting.com") by vger.kernel.org with SMTP id S264527AbTLQTb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 14:31:26 -0500
X-Qmail-Scanner-Mail-From: drunk@conwaycorp.net via digital.bytehosting.com
X-Qmail-Scanner: 1.20rc3 (Clear:RC:1:. Processed in 0.178685 secs)
Date: Wed, 17 Dec 2003 13:31:24 -0600
From: Nathan Poznick <kraken@drunkmonkey.org>
To: linux-kernel@vger.kernel.org
Cc: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] Handle R_ALPHA_REFLONG relocation on Alpha (2.6.0-test11)
Message-ID: <20031217193124.GA4837@wang-fu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Richard Henderson <rth@twiddle.net>
References: <20031213003841.GA5213@wang-fu.org> <20031217121010.GA11062@twiddle.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20031217121010.GA11062@twiddle.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake Richard Henderson:
> Which module?  This relocation should never EVER show up in kernel code.

Well, it was happening on anything I attempted to make a module.

> (It will show up in dwarf2 debug info, so make sure you're not looking at
> objects compiled with -g, but debug sections ought to be ignored by the
> module loading code.)

I think that may have been the root cause of this; I had
CONFIG_DEBUG_INFO enabled from debugging attempts related to a past
problem.  With that enabled, -g is used for the compile, so the
relocations were added, and module loading failed.  After disabling it,
R_ALPHA_REFLONG did not appear in any of the object files.  So I suppose
my next question is if this is a known/intended side effect -- enabling
CONFIG_DEBUG_INFO means that modules cannot be used?


--=20
Nathan Poznick <kraken@drunkmonkey.org>

My school colors were clear. We used to say, "I'm not naked, I'm in the
band." -Stephen Wright


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/4K8MYOn9JTETs+URAuViAJ0XhVhApOgUS/8kjQSU0/TtmPOAcQCeLix+
sZLxkcdUxYDQb6HHixO50H8=
=p8ph
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
