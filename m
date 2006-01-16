Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWAPR2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWAPR2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 12:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWAPR2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 12:28:52 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:5282 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S1750760AbWAPR2v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 12:28:51 -0500
Date: Mon, 16 Jan 2006 12:28:17 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Sam Leffler <sam@errno.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Johannes Berg <johannes@sipsolutions.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
Message-ID: <20060116172817.GB8596@shaftnet.org>
Mail-Followup-To: Sam Leffler <sam@errno.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org> <43CAA853.8020409@errno.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <43CAA853.8020409@errno.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Mon, 16 Jan 2006 12:28:18 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 15, 2006 at 11:53:55AM -0800, Sam Leffler wrote:
> The above is a great synopsis but there is more.  For example to support=
=20
> roaming (and sometimes for ap operation) you want to do background=20
> scanning; this ties in to power save mode if operating as a station.=20

Opportunistic roaming is one of those things that has many knobs to=20
twiddle, and depends a lot on the needs of the users.=20

But we're not actually in powersave mode -- the 802.11 stack can spit
out the NULL frames to tell the AP to buffer traffic for us. This is=20
trivial to do.

Scans should be specified as "non-distruptive" so the hardware driver
has to twiddle whatever bits are necessary to return the hardware to the
same state that it was in before the scan kicked in.  Beyond that, the
scanning smarts are all in the 802.11 stack.  The driver should be as
dumb as possible.  :)

Background scanning, yes -- but there are all sorts of different
thresholds and types of 'scanning' to be done, depending on how
disruptive you are willing to be, and how capable the hardware is.  Most
thin MACs don't filter out foreign BSSIDs on the same channel when
you're joined, which makes some things a lot easier.

> Further you want to order your channel list to hit the most likely=20
> channels first in case you are scanning for a specific ap--e.g. so you=20
> can stop the foreground scan and start to associate. =20

With my scenarios, the driver performs the sweep in the order it was=20
given -- if the hardware supports it, naturally.

> In terms of beacon miss processing some parts have a hardware beacon
> miss interrupt based on missed consecutive beacons but others require
> you to detect beacon miss in software.  Other times you need s/w bmiss
> detection because you're doing something like build a repeater when
> the station virtual device can't depend on the hardware to deliver a
> bmiss interrupt.

Of course.  The stack is going to need a set of timers regardless of the=20
hardware's capabilities, but having (sane) hardware beacon miss=20
detection capabilities makes it a bit more robust.
=20
> Scanning (and roaming) is really a big can 'o worms.

Oh, I know.  I've burned out many brain cells trying to build=20
supportable solutions for our customers.  =20

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDy9exPuLgii2759ARAqTTAKDCrL0V0RUN98p5VmCHz/OCn2kQxwCZAbVB
HTYySueDVuslKUtcY9u2WUM=
=gnRY
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
