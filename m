Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265714AbUAPThh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265715AbUAPThg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:37:36 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:45696 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265714AbUAPThe (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:37:34 -0500
Message-Id: <200401161937.i0GJbJmv003365@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X 
In-Reply-To: Your message of "Fri, 16 Jan 2004 19:10:47 +0100."
             <20040116181047.GA1896@elf.ucw.cz> 
From: Valdis.Kletnieks@vt.edu
References: <20040116181047.GA1896@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_783661811P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 16 Jan 2004 14:37:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_783661811P
Content-Type: text/plain; charset=us-ascii

On Fri, 16 Jan 2004 19:10:47 +0100, Pavel Machek <pavel@ucw.cz>  said:
> I have some lingvistics application here that is pretty
> demanding... it eats a lot of memory, overloads disk, and basically
> makes system unusable for even as simple tasks as reading maillists.

> Where are lastest versions of disk-prio and sched-idle patches?

The most likely culprit here is "eats memory".  What's almost certainly
happening is that your application is using a lot of pages, and leaving the
system in thrashing mode.  Quite likely, "sched-idle" won't do what you want,
as all that will happen is that the application will dirty pages while the CPU
is otherwise idle (and cause the same problem you're seeing already).
Similarly, disk-prio doesn't do you any good, because it isn't the I/O of the
huge application that's the problem, it's the I/O for the processes that are
thrashing.

A better bet would be a patch that allowed you to set the maximum RSS size for
the process so it can basically thrash itself while leaving enough memory for
everybody else (and yes, I *know* how this can be self-defeating if the
thrashing app then increases the total I/O consumed to be higher than the I/O
bandwidth available - the point is that it's probably the high RSS value for
his application causing OTHER things to thrash that's the root cause of his
performance problem).


--==_Exmh_783661811P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFACD1ucC3lWbTT17ARAnutAKDCFBCRXQHPwZFZO8KyOC+Tt8wyggCgxcGZ
6qwed7DWNfbcyFA0s5GPZMQ=
=mbk5
-----END PGP SIGNATURE-----

--==_Exmh_783661811P--
