Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWGRTTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWGRTTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 15:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWGRTTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 15:19:36 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:19337 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932324AbWGRTTg (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 15:19:36 -0400
Message-Id: <200607181919.k6IJJYfm032474@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Allison <fireflyblue@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: snapshot of physical memory
In-Reply-To: Your message of "Tue, 18 Jul 2006 12:16:16 EDT."
             <17d79880607180916h6c6d63ddo2f5a6d090fa53c7f@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <17d79880607180916h6c6d63ddo2f5a6d090fa53c7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153250373_3104P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Jul 2006 15:19:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153250373_3104P
Content-Type: text/plain; charset=us-ascii

On Tue, 18 Jul 2006 12:16:16 EDT, Allison said:

> 2. How do I make sure that no updates take place in memory from the
> time I initiate the snapshot till it is done.

Hint: If you're running a program to dump memory, it's going to be calling
I/O drivers and so on - and all this activity has to modify at least *some*
memory (unless you're on an architecture with a *really* deep register stack ;)
You can't ensure that *no* updates take place.  At best, you can minimize
the number of pages touched.

For an example of the kind of hoops you need to jump through, I suggest a
careful reading of the 'suspend' and/or 'suspend2' source code - a large part
of that code is basically taking a snapshot of memory.

Also, you'll need to make sure that whatever software is running that
you're trying to snapshot is fairly tolerant of pauses - if you have a
disk that manages 20MBytes/second and you have 256M of memory, you're going
to be sitting there for 10 seconds. This can come as a surprise to programs
that were sleeping on a timer interrupt.. :)




--==_Exmh_1153250373_3104P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEvTRFcC3lWbTT17ARApeDAJ0Yb2xkdF0hwNzlO/el5Ze+sw7RuACgg1f+
pjd8ShSl2yuHTdVhAsc+GLs=
=miKm
-----END PGP SIGNATURE-----

--==_Exmh_1153250373_3104P--
