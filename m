Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWDUPYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWDUPYm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWDUPYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:24:41 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:21982 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932358AbWDUPYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:24:41 -0400
X-Sasl-enc: OZLiK1goDYi3jef808rjRIc6yjNSP7G547C1H7dCNlWw 1145633041
Message-ID: <4448F97D.5000205@imap.cc>
Date: Fri, 21 Apr 2006 17:25:49 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.12) Gecko/20050915
X-Accept-Language: de,en,fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
References: <63XWg-1IL-5@gated-at.bofh.it> <63YfP-26I-11@gated-at.bofh.it> <63ZEY-45n-27@gated-at.bofh.it>
In-Reply-To: <63ZEY-45n-27@gated-at.bofh.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig12AD26D3B3CB0AAAE54E74CD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig12AD26D3B3CB0AAAE54E74CD
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21.04.2006 11:00, Andrew Morton wrote:

> James Morris <jmorris@namei.org> wrote:
>=20
>>On Fri, 21 Apr 2006, Daniel Walker wrote:
>>
>>>	I included a patch , not like it's needed . Recently I've been
>>>evaluating likely/unlikely branch prediction .. One thing that I found=
=20
>>>is that the kfree function is often called with a NULL "objp" . In fac=
t
>>>it's so frequent that the "unlikely" branch predictor should be invert=
ed!
>>>Or at least on my configuration.=20
>>
>>It would be helpful to collect some stats on this so we can look at the=
=20
>>ratio.
>=20
> Yes, kfree(NULL) is supposed to be uncommon.

Not anymore, after the recent campaign to elliminate explicit NULL
checks before calls to kfree().

> If someone's doing it a lot then we should fix up the callers.

If that fixup amounts to re-adding the NULL check just elliminated
then that's no improvement. It would be better to drop the assumption
that kfree() calls with a NULL argument are uncommon, and consequently
remove the unlikely() predictor. Adding likely() instead may or may
not be a good idea.

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig12AD26D3B3CB0AAAE54E74CD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESPmEMdB4Whm86/kRAr0XAJ9bIcIIDi3JQpNLL3ICvHkya3RK9ACfSpoA
qpPUOJ8+6uodPxJ+YhYksis=
=vX8G
-----END PGP SIGNATURE-----

--------------enig12AD26D3B3CB0AAAE54E74CD--
