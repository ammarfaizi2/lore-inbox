Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTKFLJW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 06:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTKFLJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 06:09:21 -0500
Received: from trantor.org.uk ([213.146.130.142]:15080 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S263369AbTKFLJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 06:09:09 -0500
Subject: Re: CONFIG_PACKET_MMAP revisited
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: odain2@mindspring.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <176730-2200310329491330@M2W026.mail2web.com>
References: <176730-2200310329491330@M2W026.mail2web.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OSfUzPhMAUiXbAdkoYDA"
Message-Id: <1068116914.6144.1410.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 12:08:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OSfUzPhMAUiXbAdkoYDA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-10-29 at 05:09, odain2@mindspring.com wrote:
> I believe that in normal operation each packet
> (or with NICs that do interrupt coalescing, every n packets) causes an
> interrupt which causes a context switch, the kernel then copies the data
> from the DMA buffer to the shared buffer and does a RETI.  That's fairly
> expensive.=20

The cost of handling that interrupt and doing an iret is unavoidable
(ignoring NAPI). The main point you are missing with the ring buffer is
that if packets come in at a fast enough rate, the usermode task never
context switches, because there is always data in the ring buffer, so it
loops in usermode forever.

The problem could be the packets are coming in just too slow to allow
the ring buffer to work properly and causing the application to sleep on
poll(2) every time. This would kill performance at pathelogical packet
rates I guess.

You could work around this by spinning for a few thousand spins before
calling poll(2) (or even indefinately for that matter, and allow the
kernel to preempt you if need be).

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-OSfUzPhMAUiXbAdkoYDA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qiuykbV2aYZGvn0RAjbiAJ4o0DQKkFq70A3I7tPHS4Iv48qejQCfZso2
NEplrahHzaJQNlmWSTAT3Ws=
=YF4C
-----END PGP SIGNATURE-----

--=-OSfUzPhMAUiXbAdkoYDA--

