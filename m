Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTIGNR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 09:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbTIGNR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 09:17:28 -0400
Received: from wooledge.org ([209.142.155.49]:16462 "HELO pegasus.wooledge.org")
	by vger.kernel.org with SMTP id S263262AbTIGNR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 09:17:26 -0400
Date: Sun, 7 Sep 2003 09:17:14 -0400
From: Greg Wooledge <greg@wooledge.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: moving a window makes the system 'hang' until button is released
Message-ID: <20030907131714.GB11333@pegasus.wooledge.org>
References: <20030906205320.GA21490@pegasus.wooledge.org> <3F5ACA93.6020302@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <3F5ACA93.6020302@cyberone.com.au>
User-Agent: Mutt/1.4.1i
X-Operating-System: OpenBSD 3.3
X-www.distributed.net: 95 packets (6131.54 stats units) [5.30 Mnodes/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nick Piggin (piggin@cyberone.com.au) wrote:

> Hi Greg,
> Can you give my scheduler a try if you have time?

After discussion with Paul Cassella and some more experimentation
on my side, I've concluded that this is not a Linux kernel issue
at all -- it's a "feature" of fvwm.  Specifically, fvwm grabs the
entire X server when it's doing a non-opaque move, and xmms only
keeps playing music until its buffer is drained.  The xmms buffer
size seems to be dramatically smaller under ALSA, which is why I
never saw the problem until I moved to 2.6.0-test4 and ALSA.

I've changed "OpaqueMoveSize" in my .fvwm2rc file to 90, so it will
only use outline-mode for moving windows which are 90% of the size
of the screen -- i.e. never, for me.  (Another workaround might be
to increase xmms's buffer size, but I haven't pursued that side yet.)

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D98091 is also
relevant here.

--=20
Greg Wooledge                  |   "Truth belongs to everybody."
greg@wooledge.org              |    - The Red Hot Chili Peppers
http://wooledge.org/~greg/     |

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (OpenBSD)

iD8DBQE/Wy/akAkqAYpL9t8RAtdEAJ9Wlp0zLntYROXvShRpOhnc7s20AACgop8p
3u7++g4ExNAMxHMyGp5CBsU=
=n+Z4
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
