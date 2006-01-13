Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423046AbWAMWcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423046AbWAMWcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 17:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423044AbWAMWcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 17:32:10 -0500
Received: from sipsolutions.net ([66.160.135.76]:37137 "EHLO sipsolutions.net")
	by vger.kernel.org with ESMTP id S1423041AbWAMWcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 17:32:08 -0500
Subject: Re: wireless: recap of current issues (configuration)
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060113221935.GJ16166@tuxdriver.com>
References: <20060113195723.GB16166@tuxdriver.com>
	 <20060113212605.GD16166@tuxdriver.com>
	 <20060113213011.GE16166@tuxdriver.com>
	 <20060113221935.GJ16166@tuxdriver.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RADtLkFmpaw1z7cysBCk"
Date: Fri, 13 Jan 2006 23:32:02 +0100
Message-Id: <1137191522.2520.63.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RADtLkFmpaw1z7cysBCk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

[since none our replies made it to the lists, here mine are again.
apologies to those who see it twice, just skip it, I only pasted my
previous replies]

> Virtual devices will have a mode (e.g. station, AP, WDS, ad-hoc, rfmon,
> raw?, other modes?) which defines its "on the air" behaviour.  Should
> this mode be fixed when the wlan device is created?  Or something
> that can be changed when the net_device is down?

IMHO there's not much point in allowing changes. I have a feeling that
might create icky issues you don't want to have to tackle when the
solution is easy by just not allowing it. Part of my thinking is that
different virtual types have different structures associated, so
changing it needs re-creating structures anyway. And different virtual
device types might even be provided by different kernel modules so you
don't carry around AP mode if you don't need it.

> Do "global" config requests go to any associated wlan device?
> Or must they be directed to the WiPHY device?  Does it matter?
> I think we should require "global" configuration to target the WiPHY
> device, while "local" configuration remains with the wlan device.
> (I'm not sure how important this point is?)

Right [global config targets wiphy]. I do think this is an important UI
issue that userspace will have to tackle, but I think the correct way
for the kernel is to surface this issue instead of creating workarounds.

> Either way, the WiPHY
> device will need some way to be able to reject configuration requests
> that are incompatible among its associated wlan devices.  Since the
> wlan interface implementations should not be device specific, perhaps
> the 802.11 stack can be smart enough to filter-out most conflicting
> config requests before they get to the WiPHY device?

I'm not sure this is worth it. While putting this into the WiPHY device
creates more logic there, putting knowledge like 'how many different
channels can this WiPHY device support' etc. into some representation
that can be used by the stack to decide is much more trouble than it is
worth.

johannes

--=-RADtLkFmpaw1z7cysBCk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQ8gqX6Vg1VMiehFYAQL+PRAAs7JIxUCwh+yw+O7t7KU0v2e6uwE+ZZem
fIqI+Z9DF/UH21lUhXqzfjueSZXJecZXEJk7XoWo8VHLCPmx0FOD0MJnUYJ3jqE+
BX/ZSWP1cVU9H1jbnC1gudh4LhGz1B+5Mpg1ntAbmaydDDSLidPTEeyD5i0D/iMR
Mr0m8qcD+Ld72pQ3ZarSi8rZM6Rgv7n4QSWpxUOE+mFsPdzC56OorIAfkvpPampT
qTCa0Z9EJFEvdHtC/fjBCpxe1C62bMCciJ5AwbSTjoaxw+sdhutSA8+GiisR2xiE
/m0X1qve5ST+mN5LivkU3KCVpufcQ52wQ4sX5kMrp1DGaqiu78RWXylVWWanerrf
GYtEQFlRxJVA/WpM1pQodRiHoQrK1deIY6d8p/kN7VbxHa8HcHkeDrSruRpyejyh
hbIrOmHoYll41UPa7RVlMmwEuDp1nRNYz0iK5BqIpMS3qgICn/rhDUVQ3140HwSQ
SxdTtVWKn7EOtbSeFf3Useq0Kq3+p1yEl4dRCKQcbePN7xpJNw0PbSOxS+gQWZzs
T4G6f7evWv6U7QE6VDKKdNpx/vcye8/YuPLsAsC7jULtQErxzvGtHDJyxKb9YI8k
7UDSJgjYJXmfymXkFyrQ8j3jQwR65Rm5aQSAwpnyD8SUgTUQtRxpxmFJz8UYycGg
kigqMqtZag8=
=nmN4
-----END PGP SIGNATURE-----

--=-RADtLkFmpaw1z7cysBCk--

