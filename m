Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVGYO5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVGYO5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGYO5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:57:23 -0400
Received: from h80ad251a.async.vt.edu ([128.173.37.26]:10412 "EHLO
	h80ad251a.async.vt.edu") by vger.kernel.org with ESMTP
	id S261273AbVGYO5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:57:22 -0400
Message-Id: <200507251457.j6PEv8Ts006937@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fault tolerance. . . 
In-Reply-To: Your message of "Sun, 24 Jul 2005 21:59:59 EDT."
             <42E4479F.90609@comcast.net> 
From: Valdis.Kletnieks@vt.edu
References: <42E4479F.90609@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1122303426_2774P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Jul 2005 10:57:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1122303426_2774P
Content-Type: text/plain; charset=us-ascii

On Sun, 24 Jul 2005 21:59:59 EDT, John Richard Moser said:

> I'm thinking of application level fault tolerance using roll-back states
> or something weird, to restore the system as affected by that
> application to a point before the error.  The obvious visual effect
> would be that if an application were to crash, it and potentially
> interrelated applications would suddenly reset to a state a few seconds
> to a few minutes earlier.

Google for "checkpoint-restart" - it's a big field in scientific
computing, where you don't want to lose the results of a 3 week run on a
supercomputer just because the system crashes 5 minutes before it's done.

(Just think - if they'd had a proper checkpointing scheme, most of the
Hitchhiker's trilogy wouldn't have happened... :)

> Maintaining the state is also easy:
> 
>  - When a file is changed, track the changes and attach them to the last
> state save
>  - When memory pages are written to, cache the old copies first
> (unfortunately each page has to be made CoW after every state save)

This is actually a lot harder than it looks - most of the real-life applications
of checkpoint-restart have been to programs that were designed to play nice
with checkpointing.  It's *really* hard to do it with a program that wasn't
designed to to be checkpointed, as you noticed yourself:

> This of course raises many questions and concerns that make this
> rediculous and probably not entirely possible:
> 
>  - What about huge modifications to files in a short time?  Make a new
> file, then write 10,000,000,000 bytes past the end and watch it crash.
>  - What about lost work in interrelated applications?
>  - Will the system state remain consistent?
>  - Will it crash over and over and over?
>  - Connecting to named pipes? (easily handled, not discussed here)
>  - Crashes are usually trappable, and then programs exit cleanly.  They
> won't care about this
>  - How does a process know to change course if it gets restored?

Exactly the sort of things that make it hard...

--==_Exmh_1122303426_2774P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFC5P3CcC3lWbTT17ARApcRAJ9vC5Uyl3I2yck4nV6GvJDxhSC4cwCg6Kya
LzU8Qr0pqiTWz97pydh8UUw=
=nd3y
-----END PGP SIGNATURE-----

--==_Exmh_1122303426_2774P--
