Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWGCCW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWGCCW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 22:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWGCCW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 22:22:27 -0400
Received: from pool-72-66-205-146.ronkva.east.verizon.net ([72.66.205.146]:62917
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1750738AbWGCCW1 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 22:22:27 -0400
Message-Id: <200607030220.k632KqmK027679@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Daniel Walker <dwalker@mvista.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, john stultz <johnstul@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: Your message of "Sun, 02 Jul 2006 18:56:22 PDT."
             <1151891783.5922.4.camel@c-67-180-134-207.hsd1.ca.comcast.net>
From: Valdis.Kletnieks@vt.edu
References: <20060624061914.202fbfb5.akpm@osdl.org> <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271212150.17704@scrub.home> <200606271643.k5RGh9ZQ004498@turing-police.cc.vt.edu> <Pine.LNX.4.64.0606271903320.12900@scrub.home> <Pine.LNX.4.64.0606271919450.17704@scrub.home> <200606271907.k5RJ7kdg003953@turing-police.cc.vt.edu> <1151453231.24656.49.camel@cog.beaverton.ibm.com> <Pine.LNX.4.64.0606281218130.12900@scrub.home> <Pine.LNX.4.64.0606281335380.17704@scrub.home> <200606292307.k5TN7MGD011615@turing-police.cc.vt.edu> <1151695569.5375.22.camel@localhost.localdomain> <200606302104.k5UL41vs004400@turing-police.cc.vt.edu> <Pine.LNX.4.64.0607030256581.17704@scrub.home>
            <1151891783.5922.4.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151893251_4949P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Jul 2006 22:20:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151893251_4949P
Content-Type: text/plain; charset=us-ascii

On Sun, 02 Jul 2006 18:56:22 PDT, Daniel Walker said:

> I was reviewing these new ntp adjustment functions, and it seems like it
> would be a lot easier to just switch to a better clocksource. These new
> functions seems to compensate for a clock that has a high rating but is
> actually quite poor..

It is indeed poor - a few -mm's ago I tripped over a bug that kept it from
recognizing the PM timer clocksource, and it refused to NTP sync because
the clock drift was well outside the 500 ppm that NTP wants.  All the same,
it's *one* thing for a clock to be drifting 10 seconds per hour.  It's
something else to totally explode when handed a drifting clock.

Currently, the kernel is build with CONFIG_RTC=m, and the clock starts
behaving as soom as rc.sysinit modprobes it.  Questions this raises:

1) What's up with *that*?
2) Anybody want to place bets that building with CONFIG_RTC=y will make
the clock work right off the bat?
3) Is that a fix, or just wallpaper? :)

--==_Exmh_1151893251_4949P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEqH8DcC3lWbTT17ARAhSaAKDSR7qGqgfg0+jipo7kvVthpAEODQCg3JHy
vtcpwQqvNrXHGkWfh0YZsSI=
=cM8E
-----END PGP SIGNATURE-----

--==_Exmh_1151893251_4949P--
