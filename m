Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWAPTu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWAPTu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 14:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWAPTu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 14:50:58 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:39374 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S1751169AbWAPTu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 14:50:57 -0500
Date: Mon, 16 Jan 2006 14:50:08 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Samuel Ortiz <samuel.ortiz@nokia.com>
Cc: Sam Leffler <sam@errno.com>, Jeff Garzik <jgarzik@pobox.com>,
       Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
Message-ID: <20060116195008.GB12748@shaftnet.org>
Mail-Followup-To: Samuel Ortiz <samuel.ortiz@nokia.com>,
	Sam Leffler <sam@errno.com>, Jeff Garzik <jgarzik@pobox.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org> <43CAA853.8020409@errno.com> <20060116172817.GB8596@shaftnet.org> <Pine.LNX.4.58.0601162056261.17348@irie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0601162056261.17348@irie>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Mon, 16 Jan 2006 14:50:08 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2006 at 09:07:52PM +0200, Samuel Ortiz wrote:
> That is true, thin MACs usually don't filter beacons on the same channel.
> But in some cases (mainly power saving), you really want to avoid
> receiving useless beacons and having the host woken up for each of them.
> You may even want to not receive all the useful ones (the ones coming from
> the AP you're joined with) if your softmac allows that.

BSSID filtering doesn't matter as far as 802.11 powersave is concerned
-- the power savings come from disabling the RF/BBP components.  In
other words, you can't receive or transmit traffic.

If you're respecting the AP's beacon interval/DTIM settings, you only=20
wake up every couple of beacon intervals and listen for a beacon.  IF=20
there's traffic waiting for you, then you wake up your transmitter, send=20
out a PSPOLL (or NULL/PSEnd) frame, get your traffic, then go back to=20
sleep again. =20

You may hear another beacon when the STA is awake, you may not.  BSSID=20
filtering has nothing to do with 802.11 power save, but rather is=20
intented to reduce the host load (interrupts, processing overhead) and=20
thus the host power consumption.

> This kind of beacon filtering is a big power saver, which is one of the
> most important requirement for some platforms (phones, PDA, etc...).

You need to be clear if you're talking about 802.11 powersave, versus=20
"power savings stemming from reducing the load on the host system",=20
which is where BSSID filtering is beneficial.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDy/jwPuLgii2759ARAkAmAKDaWvdZBiYlCZTEldQDQMYeaDRztgCfZvbj
fzqcNrsbY4DyI8IbwTZqauI=
=APT6
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--
