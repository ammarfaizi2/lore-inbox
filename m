Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267068AbUBMPtG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 10:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267072AbUBMPtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 10:49:06 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:41104 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S267068AbUBMPtC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 10:49:02 -0500
Message-Id: <200402131548.i1DFmECc020354@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Angelo Dell'Aera" <buffer@antifork.org>
Cc: Giuliano Pochini <pochini@shiny.it>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Michael Frank <mhf@linuxmail.org>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle 
In-Reply-To: Your message of "Fri, 13 Feb 2004 15:35:42 +0100."
             <20040213153542.29686f0f.buffer@antifork.org> 
From: Valdis.Kletnieks@vt.edu
References: <20040213124232.B2871@pclin040.win.tue.nl> <XFMail.20040213145513.pochini@shiny.it>
            <20040213153542.29686f0f.buffer@antifork.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-975495688P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Feb 2004 10:48:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-975495688P
Content-Type: text/plain; charset=us-ascii

On Fri, 13 Feb 2004 15:35:42 +0100, "Angelo Dell'Aera" said:

> I think you're really wrong since "deeply nested" means exactly "unreadable 
> and badly structured" and you could easily realize it by simply spending ~10 
> hours per day coding and/or taking a look at the code written by someone 
> which is not you. A simple use of inline functions and a previous thinking 
> about what you're going to write could easily solve all problems. 

It might help, but a blind belief that "if I inline things it will all be
better" won't solve all the problems.  In particular, for the example you
replied to:

>>1 tab in the function, 1tab a switch, 1 if, 1 for, 1 if and you have already
>>lost half of the available space.

you may very well be advocating the inlining of a 3 or 4 line code segment,
and moving it to someplace far away in the .c file.  Certainly the compiler
can probably manage to generate the same code, but now you're condemning
the next person who reads this code to go flipping back and forth through
the file to find the only-used-once and unfamiliar function to see what
this for(;;) loop does.

Oh, and it gets very ugly if you have this:

	switch
		if (foo) {
			for (ptr=first; ptr->next!=NULL; prt->next) {
				if (!(ptr->somedata))
					goto have_to_drop_dead_now;
				/* more code that deals with ptr-> here */

Creating an inline function for that is going to be.. interesting. :)



--==_Exmh_-975495688P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFALPG+cC3lWbTT17ARAqYEAKDzZ/uDDjruTybCzakkRC3WB2szsACfVTm9
A/gjkaMTyQ+8XzBliytGQ3U=
=QmCE
-----END PGP SIGNATURE-----

--==_Exmh_-975495688P--
