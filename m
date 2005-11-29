Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVK2U6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVK2U6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 15:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVK2U6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 15:58:10 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:6610 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932401AbVK2U6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 15:58:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:message-id:from;
        b=hQ6rIg5lVbuteYqMy8HKKJJkshjjfk3RCX+8sQgvTVfeiFTCFYIUD6TMqhPn8K13ENTS6zM+RQY+njyEmyO6+KmuAUEc6ktgo+eKAIvuLntPu9mNoXIwWBffYYK5a/sH3ZhvLEA3YGuIB49zZGEFF4J4McVDrcPV7qcPmCYa+5A=
To: Mateusz Berezecki <mateuszb@gmail.com>
Subject: Re: NIC irq nobody cared ? virtual to  physical  and DMA questions
Date: Tue, 29 Nov 2005 22:05:58 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       kernel-mentors@selenic.com
References: <745843498.20051129212851@gmail.com>
In-Reply-To: <745843498.20051129212851@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1976923.1UqfYTiUxi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511292206.02147.IvDoorn@gmail.com>
From: Ivo van Doorn <ivdoorn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1976923.1UqfYTiUxi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

> This time the questions are different.
>=20
> Given the following output could anyone please tell me what is wrong ?
> In explicit what does that mysterious "nobody cared" message mean?
> And another stupid question: should DMA for a network card be enabled bef=
ore or maybe
> _after_ interrupts get enabled? And... how to convert virtual address
> to physical one?

The nobody cared error message is reported when a device is raising interru=
pts while
the actual driver has not yet registered the interrupt handler.

The best way to handle this for network drivers (done in rt2x00, which work=
s fine) would be:

1 - Allocate DMA
2 - Registers interrupt handler
3 - Enable device interrupts.

IvD

--nextPart1976923.1UqfYTiUxi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDjMK6aqndE37Em0gRAof8AKDQSn0ouW6mO+u1dagQlOGxykKPZACfY9bI
DBzUqBjE1ExmoI+3e6FuUpQ=
=I2Tq
-----END PGP SIGNATURE-----

--nextPart1976923.1UqfYTiUxi--
