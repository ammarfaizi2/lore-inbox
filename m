Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263629AbUEPPdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUEPPdF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 11:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263644AbUEPPdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 11:33:04 -0400
Received: from irulan.endorphin.org ([212.13.208.107]:7943 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S263629AbUEPPcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 11:32:36 -0400
Date: Sun, 16 May 2004 17:32:18 +0200
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Michal Ludvig <michal@logix.cz>, Andrew Morton <akpm@osdl.org>,
       jmorris@redhat.com, davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Support for VIA PadLock crypto engine
Message-ID: <20040516153218.GA9170@ghanima.endorphin.org>
References: <Xine.LNX.4.44.0405120933010.10943-100000@thoron.boston.redhat.com>
	<Pine.LNX.4.53.0405121546200.24118@maxipes.logix.cz>
	<40A37118.ED58E781@users.sourceforge.net>
	<20040513113028.085194a3.akpm@osdl.org>
	<40A3C639.4FD98046@users.sourceforge.net>
	<40A4CA28.4E575107@users.sourceforge.net>
	<20040514140958.GA8645@ghanima.endorphin.org>
	<40A4EE3C.A80D4B5B@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <40A4EE3C.A80D4B5B@users.sourceforge.net>
User-Agent: Mutt/1.5.6i
From: Fruhwirth Clemens <clemens-dated-1085585540.2c1d@endorphin.org>
X-Delivery-Agent: TMDA/0.92 (Kauai King)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-05-14 at 18:05, Jari Ruusu wrote:

> loop-AES wasn't born perfect. But I have plead quilty for each and every
> fuck-up that was there. And then went on and fixed the damn code.
> Countermeasures against optimized dictionary attacks was included in 2001,
> and stronger IV in 2003.

Your countermeasures to optimized dictionary attacks are suboptimal. The
following code is from your util-linux patch:

 aes_encrypt(&ctx, &loopinfo.lo_encrypt_key[ 0], &loopinfo.lo_encrypt_key[ =
0]);
 aes_encrypt(&ctx, &loopinfo.lo_encrypt_key[16], &loopinfo.lo_encrypt_key[1=
6]);
 /* exchange upper half of first block with lower half of second block */
 memcpy(&tempkey[0], &loopinfo.lo_encrypt_key[8], 8);
 memcpy(&loopinfo.lo_encrypt_key[8], &loopinfo.lo_encrypt_key[16], 8);
 memcpy(&loopinfo.lo_encrypt_key[16], &tempkey[0], 8);

Symmetric block ciphers can't be used as hashing per se. Neither seems the
swapping scheme you're using to be a standard hash construction for ciphers.
I suggest to read "Applied Cryptography", Bruce Schneier, "18.11 One-Way
hash functions using symmetric block algorithms" as an introduction to that
topic. To avoid this troubles all together, I recommend to use a standard
MAC instead.

Further, the iteration depth of 10^5 seems to be insufficient.

> > You have been campaigning with FUD
> > against cryptoloop/dm-crypt for too long now. There are NO exploitable
> > security holes in neither dm-crypt nor cryptoloop.
>=20
> In the past you, Fruhwirth, have demonstrated that you don't understand w=
hat
> the security holes are. The fact that you still don't seem to undertand,
> does not mean that the holes are not there.

Everyone attending a rhetoric seminar learns, "If you run out of
arguments, attack the person itself". The attacks, you're speaking of in
the next paragraph, apply to the key deduction. That's very different
=66rom IV deduction.

> Optimized dictionary attack is exploitable. Ok, it requires major governm=
ent
> size funding, but what do you think NSA guys get paid for?
>=20
> Watermark attack is exploitable using zero budget.

As I said, not cryptoloop's responsibility.=20

> You insisting that cryptoloop/dm-crypt do not have exploitable security
> issues does not increase confidence at all. Quite the contrary, as it
> implies that existing vulnerabilities won't be fixed.

Please read my mails carefully. See the following paragraph:

> > There is room for improving both IV deducation schemes, but it's a
> > theoretic weakness, one which should be corrected nonetheless.=20


> One cryptoloop developer
> somehow managed to convince util-linux maintaner to drop those
> countermeasures against optimized dictionary attacks. To protect the guil=
ty,
> I won't name his name here, but search linux-crypto archives for 14 Mar 2=
003
> 11:12:13 -0800 posting if you want know his name.=20

You are talking about util-linux again. Rusuu, don't try to fool the
audience by arguing for something totally different. Further if you try to
provide evidence for something, provide an URL to back your claims. I wasn't
able to find any mails in the archives dealing with that topic.

Best Regards, Clemens

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAp4mCW7sr9DEJLk4RAuiRAJ9nyPbD8ANTOgKdwGiNGzw1CycjnQCgi8hA
oJZdVW6g+Z6BTboln8oFRoY=
=FWex
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
