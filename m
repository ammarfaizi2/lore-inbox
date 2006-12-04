Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937064AbWLDQQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937064AbWLDQQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937067AbWLDQQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:16:56 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60139 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937065AbWLDQQz (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:16:55 -0500
Message-Id: <200612041615.kB4GF7lx031249@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Jan Glauber <jan.glauber@de.ibm.com>
Cc: linux-crypto <linux-crypto@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Pseudo-random number generator
In-Reply-To: Your message of "Fri, 01 Dec 2006 14:19:15 +0100."
             <1164979155.5882.23.camel@bender>
From: Valdis.Kletnieks@vt.edu
References: <1164979155.5882.23.camel@bender>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1165248906_15310P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Dec 2006 11:15:07 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1165248906_15310P
Content-Type: text/plain; charset=us-ascii

On Fri, 01 Dec 2006 14:19:15 +0100, Jan Glauber said:
> New s390 machines have hardware support for the generation of pseudo-random
> numbers. This patch implements a simple char driver that exports this numbers
> to user-space. Other possible implementations would have been:

> +	for (i = 0; i < 16; i++) {
> +		entropy[0] = get_clock();
> +		entropy[1] = get_clock();
> +		entropy[2] = get_clock();
> +		entropy[3] = get_clock();

By the time this loop completes, we'll have done 64 get_clock() - and if an
attacker has a good estimate of what the system clock has in it, they'll be
able to guess all 64 values, since each pass through the loop will have fairly
predictable timing.  So as a result, the pseudo-random stream will be a *lot*
less random than one would hope for...

> +		/*
> +		 * It shouldn't weaken the quality of the random numbers
> +		 * passing the full 16 bytes from STCKE to the generator.
> +		 */

As long as you realize that probably 12 or 13 or even more of those 16 bytes
are likely predictable (depending exactly how fast the hardware clock ticks),
and as a result the output stream will also be predictable.

I think this needs to either find a way to stir in entropy from sources other
than the clock, or make it clear that the returned data is pseudo-random but
likely predictable by a determined attacker.  As such, it's probably a bad
choice for many things that /dev/urandom is usable for, such as session keys
and the like.


--==_Exmh_1165248906_15310P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFdEmKcC3lWbTT17ARAtDOAKCyT6QBEvka6Mq5RO09eh/yjeI3cgCg/hBw
yA47YSNRwrBdDljzCNmaazY=
=OhHi
-----END PGP SIGNATURE-----

--==_Exmh_1165248906_15310P--
