Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271940AbTG2RxB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 13:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271943AbTG2RxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 13:53:00 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:13697 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S271940AbTG2Rso (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 13:48:44 -0400
Message-Id: <200307291748.h6THma3o007162@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: Andries.Brouwer@cwi.nl, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] select fix 
In-Reply-To: Your message of "Tue, 29 Jul 2003 10:36:30 PDT."
             <20030729103630.7fb415cb.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <UTC200307291412.h6TECwA17034.aeb@smtp.cwi.nl>
            <20030729103630.7fb415cb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1531834568P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 29 Jul 2003 13:48:36 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1531834568P
Content-Type: text/plain; charset=us-ascii

On Tue, 29 Jul 2003 10:36:30 PDT, Andrew Morton said:

> > -	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
> > +	if (!tty->stopped && tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
> >  		mask |= POLLOUT | POLLWRNORM;
> 
> Manfred sent a patch through esterday which addresses it this way:
> 
> -	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
> +	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS &&
> +			tty->driver->write_room(tty) > 0)
> 
> Any preferences?

Would including all 3 conditions make sense?  Not sure if it should be A&B&C, or
A&(B|C) though, but it certainly smells like the write_room() and tty->stopped
checks are covering 2 different corner cases....

--==_Exmh_1531834568P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/JrN0cC3lWbTT17ARAs34AKDaBY+VvGHFEiB002eD82iM98X5bQCfahtx
vx5kJNJrSN936/yL+lm5oaI=
=bYrV
-----END PGP SIGNATURE-----

--==_Exmh_1531834568P--
