Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031278AbWKUSen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031278AbWKUSen (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 13:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031279AbWKUSem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 13:34:42 -0500
Received: from crystal.sipsolutions.net ([195.210.38.204]:15799 "EHLO
	sipsolutions.net") by vger.kernel.org with ESMTP id S1031278AbWKUSem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 13:34:42 -0500
Subject: Re: RFC/T: Trial fix for the bcm43xx - wpa_supplicant -
	NetworkManager deadlock
From: Johannes Berg <johannes@sipsolutions.net>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Ray Lee <ray-lk@madrabbit.org>, Dan Williams <dcbw@redhat.com>,
       Broadcom Linux <bcm43xx-dev@lists.berlios.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <45633FF8.6010209@lwfinger.net>
References: <4561DBE0.2060908@lwfinger.net> <45628C05.405@madrabbit.org>
	 <45633FF8.6010209@lwfinger.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MJTypfeyva44t17NiCeJ"
Date: Tue, 21 Nov 2006 19:32:42 +0100
Message-Id: <1164133962.3631.14.camel@johannes.berg>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MJTypfeyva44t17NiCeJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-11-21 at 12:05 -0600, Larry Finger wrote:

> Although my understanding of locking has been shown to be deficient, it l=
ooks to me as if the
> deadlock involves a WX call while a scan is in progress. The following pa=
tch uses
> mutex_trylock rather than mutex_lock so that WX calls are rejected if the=
 lock is already held.
> Please try this patch with wpa_supplicant and NetworkManager both running=
. I have tested it with
> wpa_supplicant alone.

I don't think this is the right thing to do. This cannot be causing the
deadlock as for a deadlock you need (at least) two locks. Now, since any
calls from userspace to d80211 acquire the mutex first, they should be
fine. They also both acquire the rtnl lock first.

The deadlock must be somewhere deeper. Can we run this with lockdep
enabled? Might give us a hint before we dig out all the used locks
here...

johannes

--=-MJTypfeyva44t17NiCeJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFY0ZI/ETPhpq3jKURAq+DAKCY/nJiUTMh3ZXuz46Gz2PG3h6xEQCgmDoj
PWwxEJpBueqEETy0BEMd0oM=
=pRQH
-----END PGP SIGNATURE-----

--=-MJTypfeyva44t17NiCeJ--

