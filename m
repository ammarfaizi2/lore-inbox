Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272045AbTG2T6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272054AbTG2T6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:58:13 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:57220 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S272045AbTG2T6G (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:58:06 -0400
Message-Id: <200307291958.h6TJw43o030219@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: jimis@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related) -- conclusion 
In-Reply-To: Your message of "Tue, 29 Jul 2003 22:28:50 +0300."
             <3F26CAF2.8070009@gmx.net> 
From: Valdis.Kletnieks@vt.edu
References: <3F26CAF2.8070009@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_220984052P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Jul 2003 15:58:04 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_220984052P
Content-Type: text/plain; charset=us-ascii

On Tue, 29 Jul 2003 22:28:50 +0300, jimis@gmx.net  said:

> great, I had no idea of this potential. But what I propose is scheduling the
> network traffic (at least the outgoing traffic that we can influence directly)
> according to the process priority, not according to the traffic type (which is
> important but different).

So you want to use a number that controls the CPU scheduling to force the network
scheduling to go along?  That's a bad idea waiting to happen.

(Hint - some program is getting CPU-starved for some reason, so you 'nice -2' it
to make it run tolerably.  Suddenly your icecast gets stomped on.  Whoops)

It's even worse if you're trying to use dynamic priorities - then your icecast
can get pushed to the bottom of the network pile because some other process
went super-interactive for a while...

Remember - you're trying to optimize the "network experience" for the
*connection*. Base it on the port numbers, or use the process's UID and run
your program under a seperate UID, or maybe a PID-based scheme, with an ioctl()
or /{proc,sys} based control....


--==_Exmh_220984052P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/JtHMcC3lWbTT17ARAnsjAJ4qOjxJwdXK7297ZcRtrx9zmDzweACgvpx9
Hg/PgYbUveuQi4Z+/NDpFE8=
=S0si
-----END PGP SIGNATURE-----

--==_Exmh_220984052P--
