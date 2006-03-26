Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWCZFpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWCZFpq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 00:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWCZFpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 00:45:46 -0500
Received: from mail.gmx.de ([213.165.64.20]:47750 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750715AbWCZFpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 00:45:46 -0500
X-Authenticated: #2308221
Date: Sun, 26 Mar 2006 07:45:42 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: snd-nm256: hard lockup on every second module load after powerup
Message-ID: <20060326054542.GA11961@hermes.uziel.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi folks,

I have this really old Dell Latitude CPiA here containing the dreaded
neomagic combined audio/video chipset, and observe some hard lockup
sometimes, which is not supposed to be anything special wrt. other
people with similar laptops having the same trouble. The only regularity
I noticed was that after completely removing power to the machine, the
sound driver can be loaded without locking the thing hard. Any further
attempt, eg. rmmod and insmod or reboot with alsasound startup script,
will result in a dead machine. Every time. Cut the power, and next time
it will survive - exactly once.

Now this chip is a NM2200 / 256AV, and I already did some reading in the
alsa driver source code, but adding printk()s all over the place just
showed that it does not lock up during init_chip() or poking at the
registers during ac97_reset(), but shortly after the latter, approx.
half a second or so - it might still be a consequence thereof.

My basic idea is, with the device being entirely undocumented (to hell
with all hardware vendors who don't even release specs after the devices
are not even sold anymore, by the way), that the code is missing a
proper device reset, and trying to re-init some parts just kill the
machine. Cutting the power really is not that nice as a workaround. I'd
love to try something along the lines of saving the device's state as a
whole, and before reloading the module, restore that state again. The
difference between before and after should somehow give a clue about the
proper reset procedure - or so I hope.

Unfortunately I failed with my previous attempts to modify the driver
appropriately. Now that it's basically back to formula, I wanted to ask
whether there is a possibility to read and write back whole parts of
memory directly from/to the device, or if I should rather store each and
every register somewhere I can later restore it from, one by one. I'd
even prefer userspace, and am currently experimenting with pcidump.


Any hints would be greatly appreciated! Thanks a bunch,

Chris

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRCYqhV2m8MprmeOlAQI4TxAAoUd38a07TkiFKREIu03tAsUeSecJWaRu
QIDh8ln0QdwKrJ4jBVmsc1zij3VyI6eXonADFyuHmDp9YgZ9JMWezXyldsqgrjv7
DF1infP+/sXHOrMjqPbKG6VKGVZhO/snznW1KZD/TbwNJzRCfLnFzGN/M67PeQUp
2tTwmXMvf2sPNbdWTVRu9vxD9lcc7QtpqzynMlvKYPhUupjzNXWHtfcVvqEVplY4
Ae6+2AtHnO7PN8utICOXuR1jiwTjiJw1LgmDPMpjqCwLQ99yDvjen0GVEFVELPQ4
Uf8L0dYHWe3fCR8S1Vzm1k5zYpoTIqS+9Y9PsHf47hkkrN30S6bfH1GkFULvPMeR
WYQPHg1MKvw5K3zJ2SCEDXes7DPN1XVVItQLF7v26Z83ba14Q6wa3v0ghffzV6bT
tpIGWwg8FCWG1UzZdDMudZuMgAivLVexhNhe/Vu6Urha0wHPfD0PeS9azXhAcUjF
I+43401KD9cp32UVGy1axCpxgJPRtOkUV2RDpbXtLEq0fBtB/OkSYDZwoNEECenC
YAsAvhk2NxtR8ZXiwgLtSijQbQwOFIWwzIoX3O6sTXEa4RbM1W7Ro2oT7qLeheAe
M4lmzq6bH0Wtd1Ar70hJZpws2py441BdUM7l8E9SAQMTURw5vE5m3LpdCPSYJ+os
T7Wi+i+J3CM=
=fuvh
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

