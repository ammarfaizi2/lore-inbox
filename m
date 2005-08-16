Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965165AbVHPJf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965165AbVHPJf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 05:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965168AbVHPJf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 05:35:58 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:27850 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965165AbVHPJf5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 05:35:57 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bolke de Bruin <bdbruin@aub.nl>
Subject: Re: [PATCH 2.6.13-rc6] remove dead reset function from cpqfcTS driver
Date: Tue, 16 Aug 2005 11:37:30 +0200
User-Agent: KMail/1.8.2
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508161111.08070@bilbo.math.uni-mannheim.de> <20050816091758.GA21378@infradead.org>
In-Reply-To: <20050816091758.GA21378@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7174845.1TegSEWkKF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508161137.37749@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7174845.1TegSEWkKF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Christoph Hellwig wrote:
>On Tue, Aug 16, 2005 at 11:11:06AM +0200, Rolf Eike Beer wrote:
>> cpqfcTS_reset() is never referenced from anywhere. By using the
>> nonexistent constant SCSI_RESET_ERROR it causes just another unneeded
>> compile error.
>
>That was the old reset handler.  Do you actually have this hardware?
>The driver is pretty much un-recoverable and mkp is working on a from
>scratch driver for this hardware - I don't think putting any work into the
>driver makes sense unless you have a very urgent need to use it.

No, I don't have (but maybe I'll get access to it soon). There was a reques=
t=20
on lkml last week for a working version of this driver. For the moment I tr=
y=20
to clean this up a bit before doing some real work. I found 4 major things=
=20
that should be done, for half of them I have patches in a proof-of-concept=
=20
state.

=2Dsplit the interrupt handler into a handler and a tasklet
=2Dremove the stack abuse
=2Duse Linux 2.6 hardware probing code (this would cause the most problems =
for=20
me, I'm not familiar with the preferred way of doing this for scsi drivers)
=2Dfix kernel thread stopping

After this some more error checking at different places can't hurt. And a b=
ig=20
Lindent run.

Eike

--nextPart7174845.1TegSEWkKF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDAbPhXKSJPmm5/E4RAgiaAJ9ADgZhpUJQw2qHuye6UegAdYR90ACfc7oT
5ozHVJeWjHRWci+5bh7ogFE=
=X7oV
-----END PGP SIGNATURE-----

--nextPart7174845.1TegSEWkKF--
