Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbTKHVjx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 16:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTKHVjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 16:39:53 -0500
Received: from draal.physics.wisc.edu ([128.104.222.75]:1195 "EHLO
	moya.mcelrath.org") by vger.kernel.org with ESMTP id S262152AbTKHVjs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 16:39:48 -0500
Date: Sat, 8 Nov 2003 13:33:57 -0800
From: Bob McElrath <bob+linux-kernel@mcelrath.org>
To: linux-kernel@vger.kernel.org
Subject: /dev/rtc on alpha
Message-ID: <20031108213356.GD16295@mcelrath.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In a nutshell, the rtc driver on alpha does not work.  This is easily
verified with the small program in Documentation/rtc.txt -- all ioctl's
fail.  (I tried on an LX164 and a CS20)  That's the /dev/rtc driver
drivers/char/rtc.c.  I'd like to make it work but don't understand
what's going on with the rtc interrupt in arch/alpha/kernel/*.  So, can
some expert comment on this situation for me?

The /dev/rtc driver builds and loads fine but the define RTC_IRQ is not
set in include/asm-alpha/mc146818rtc.h.  Naievely setting it, the driver
still builds and loads, but is unable to grab the interrupt (IRQ 8)
because the code in arch/alpha/kernel grabbed it first.

Why is the alpha kernel code grabbing the rtc interrupt?  Is it possible
it share its use with a user program?  Would reprogramming the interrupt
rate by a user program do violence to some internel kernel timing?

Thanks,
Bob McElrath [Univ. of California at Davis, Department of Physics]

--ZARJHfwaSJQLOEUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/rWFEjwioWRGe9K0RAk2qAKDpJspZeFFEcXZxXUcvR4K/I6NVNACfeeAX
6RYN1Amohwqp6mQtydualHs=
=AS+O
-----END PGP SIGNATURE-----

--ZARJHfwaSJQLOEUz--
